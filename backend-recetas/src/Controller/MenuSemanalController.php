<?php

namespace App\Controller;

use App\Entity\MenuSemanal;
use App\Entity\MenuReceta;
use App\Entity\Receta;
use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/menu-semanal')]
class MenuSemanalController extends AbstractController
{
    public function __construct(private EntityManagerInterface $em) {}

    private function calcularFechaInicio(): \DateTime
    {
        $ahora = new \DateTime();
        $hora = (int)$ahora->format('H');
        
        if ($hora >= 16) {
            $fechaInicio = (clone $ahora)->modify('+1 day');
        } else {
            $fechaInicio = clone $ahora;
        }
        
        $fechaInicio->setTime(0, 0, 0);
        return $fechaInicio;
    }

    private function calcularFechaFin(\DateTime $fechaInicio): \DateTime
    {
        $fechaFin = clone $fechaInicio;
        $fechaFin->modify('+6 days');
        $fechaFin->setTime(23, 59, 59);
        return $fechaFin;
    }
    
    private function obtenerNombreDia(\DateTime $fecha): string
    {
        $nombresDias = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
        $diaSemana = (int)$fecha->format('w');
        return $nombresDias[$diaSemana];
    }

    private function existeMenuVigente(User $user, \DateTime $fechaInicioNueva): ?MenuSemanal
    {
        $menus = $this->em->getRepository(MenuSemanal::class)
            ->findBy(['usuario' => $user], ['fechaCreacion' => 'DESC']);

        $hoy = new \DateTime();
        $hoy->setTime(0, 0, 0);

        foreach ($menus as $menu) {
            $fechaCreacion = $menu->getFechaCreacion();
            if ($fechaCreacion) {
                $fechaFin = $this->calcularFechaFin($fechaCreacion);
                
                if ($fechaCreacion <= $fechaInicioNueva && $fechaFin >= $hoy) {
                    return $menu;
                }
            }
        }

        return null;
    }

    #[Route('', name: 'menu_semanal_get', methods: ['GET'])]
    public function getMenu(Request $request): JsonResponse
    {
        $usuarioId = $request->query->get('usuarioId');
        if (!$usuarioId) return new JsonResponse(['menu' => []]);

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) return new JsonResponse(['menu' => []]);

        $menuSemanal = $this->em->getRepository(MenuSemanal::class)
            ->findOneBy(['usuario' => $user], ['fechaCreacion' => 'DESC']);

        if (!$menuSemanal) return new JsonResponse(['menu' => []]);

        $menuArray = [];
        foreach ($menuSemanal->getMenuRecetas() as $menuReceta) {
            $menuArray[] = [
                'dia' => ucfirst(strtolower($menuReceta->getDia())),
                'tipo' => strtolower($menuReceta->getTipoComida()),
                'recetaId' => $menuReceta->getReceta()?->getId()
            ];
        }

        return new JsonResponse(['menu' => $menuArray]);
    }

    #[Route('/generar', name: 'menu_semanal_generar', methods: ['POST'])]
    public function generar(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $usuarioId = $data['usuarioId'] ?? null;
        $menu = $data['menu'] ?? [];

        if (!$usuarioId) return new JsonResponse(['error' => 'Falta usuarioId'], 400);
        if (empty($menu)) return new JsonResponse(['error' => 'Menú vacío'], 400);

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) return new JsonResponse(['error' => 'Usuario no encontrado'], 404);

        $fechaInicio = $this->calcularFechaInicio();
        $fechaFin = $this->calcularFechaFin($fechaInicio);

        $menuExistente = $this->existeMenuVigente($user, $fechaInicio);
        
        if ($menuExistente) {
            $fechaCreacionExistente = $menuExistente->getFechaCreacion();
            $fechaFinExistente = $this->calcularFechaFin($fechaCreacionExistente);
            
            return new JsonResponse([
                'error' => 'Ya existe un menú vigente que cubre estas fechas',
                'menuExistenteId' => $menuExistente->getId(),
                'fechaInicio' => $fechaCreacionExistente->format('Y-m-d'),
                'fechaFin' => $fechaFinExistente->format('Y-m-d')
            ], 400);
        }

        $menuSemanal = new MenuSemanal();
        $menuSemanal->setUsuario($user);
        $menuSemanal->setFechaCreacion($fechaInicio);

        foreach ($menu as $item) {
            $dia = ucfirst(strtolower($item['dia'] ?? ''));
            $tipo = strtolower($item['tipo'] ?? '');
            $recetaId = $item['recetaId'] ?? null;

            if (!in_array($tipo, ['desayuno', 'comida', 'cena'])) continue;
            if (!$dia || !$recetaId) continue;

            $receta = $this->em->getRepository(Receta::class)->find($recetaId);
            if (!$receta) continue;

            $menuReceta = new MenuReceta();
            $menuReceta->setMenuSemanal($menuSemanal)
                       ->setReceta($receta)
                       ->setDia($dia)
                       ->setTipoComida($tipo);

            $menuSemanal->addMenuReceta($menuReceta);
        }

        $this->em->persist($menuSemanal);
        $this->em->flush();

        return new JsonResponse([
            'message' => 'Menú semanal guardado correctamente',
            'fechaInicio' => $fechaInicio->format('Y-m-d'),
            'fechaFin' => $fechaFin->format('Y-m-d')
        ]);
    }

    #[Route('/usuario', name: 'menu_semanal_usuario', methods: ['GET'])]
    public function obtenerMenuUsuario(Request $request): JsonResponse
    {
        $usuarioId = $request->query->get('usuarioId');
        if (!$usuarioId) return new JsonResponse(['error' => 'Falta usuarioId'], 400);

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) return new JsonResponse(['error' => 'Usuario no encontrado'], 404);

        $fechaBusqueda = $this->calcularFechaInicio();
        $fechaBusquedaStr = $fechaBusqueda->format('Y-m-d');
        
        $menus = $this->em->getRepository(MenuSemanal::class)
            ->findBy(['usuario' => $user], ['fechaCreacion' => 'DESC']);

        $menuSemanalVigente = null;
        foreach ($menus as $menu) {
            $fechaCreacion = $menu->getFechaCreacion();
            if ($fechaCreacion) {
                $fechaCreacionStr = $fechaCreacion->format('Y-m-d');
                $fechaFin = $this->calcularFechaFin($fechaCreacion);
                $fechaFinStr = $fechaFin->format('Y-m-d');
                
                if ($fechaBusquedaStr >= $fechaCreacionStr && $fechaBusquedaStr <= $fechaFinStr) {
                    $menuSemanalVigente = $menu;
                    break;
                }
            }
        }

        if (!$menuSemanalVigente) {
            return new JsonResponse(['error' => 'No hay menú semanal vigente'], 404);
        }

        $fechaCreacion = $menuSemanalVigente->getFechaCreacion();
        $fechaFin = $this->calcularFechaFin($fechaCreacion);
        
        $fechaActualMostrar = $this->calcularFechaInicio();
        
        $diasValidos = [];
        /** @var \DateTime $fechaActual */
        $fechaActual = clone $fechaCreacion;
        $fechaActual->setTime(0, 0, 0);
        
        while ($fechaActual->format('Y-m-d') <= $fechaFin->format('Y-m-d')) {
            if ($fechaActual->format('Y-m-d') >= $fechaActualMostrar->format('Y-m-d')) {
                $nombreDia = $this->obtenerNombreDia($fechaActual);
                $diasValidos[strtolower($nombreDia)] = true;
            }
            $fechaActual->modify('+1 day');
        }
        
        $menuArray = [];
        foreach ($menuSemanalVigente->getMenuRecetas() as $menuReceta) {
            $dia = strtolower($menuReceta->getDia());
            
            if (!isset($diasValidos[$dia])) {
                continue;
            }
            
            if (!isset($menuArray[$dia])) {
                $menuArray[$dia] = [];
            }
            
            $receta = $menuReceta->getReceta();
            if ($receta) {
                $menuArray[$dia][] = [
                    'id' => $receta->getId(),
                    'nombre' => $receta->getNombre(),
                    'imagen' => $receta->getImagen(),
                    'tiempoPreparacion' => $receta->getTiempoPreparacion(),
                    'porciones' => $receta->getPorciones(),
                    'tipo' => strtolower($menuReceta->getTipoComida())
                ];
            }
        }

        $fechaInicioMostrar = max($fechaActualMostrar, $fechaCreacion);

        return new JsonResponse([
            'menuId' => $menuSemanalVigente->getId(),
            'fechaCreacion' => $fechaCreacion->format('Y-m-d'),
            'fechaInicio' => $fechaInicioMostrar->format('Y-m-d'),
            'fechaFin' => $fechaFin->format('Y-m-d'),
            'recetasPorDia' => $menuArray
        ]);
    }

    #[Route('/borrar', name: 'menu_semanal_borrar', methods: ['DELETE'])]
    public function borrarMenu(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $usuarioId = $data['usuarioId'] ?? null;

        if (!$usuarioId) return new JsonResponse(['error' => 'Falta usuarioId'], 400);

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) return new JsonResponse(['error' => 'Usuario no encontrado'], 404);

        $fechaBusqueda = $this->calcularFechaInicio();
        
        $menus = $this->em->getRepository(MenuSemanal::class)
            ->findBy(['usuario' => $user], ['fechaCreacion' => 'DESC']);

        $menuSemanalVigente = null;
        foreach ($menus as $menu) {
            $fechaCreacion = $menu->getFechaCreacion();
            if ($fechaCreacion) {
                $fechaFin = $this->calcularFechaFin($fechaCreacion);
                
                if ($fechaBusqueda >= $fechaCreacion && $fechaBusqueda <= $fechaFin) {
                    $menuSemanalVigente = $menu;
                    break;
                }
            }
        }

        if (!$menuSemanalVigente) {
            return new JsonResponse(['error' => 'No hay menú vigente para borrar'], 404);
        }

        foreach ($menuSemanalVigente->getMenuRecetas() as $menuReceta) {
            $this->em->remove($menuReceta);
        }

        $this->em->remove($menuSemanalVigente);
        $this->em->flush();

        return new JsonResponse(['message' => 'Menú semanal borrado correctamente']);
    }
}