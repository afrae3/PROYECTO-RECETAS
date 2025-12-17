<?php

namespace App\Controller;

use App\Entity\MenuSemanal;
use App\Entity\User;
use App\Entity\ObjetivosNutricionales;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/dashboard')]
class DashboardController extends AbstractController
{
    public function __construct(private EntityManagerInterface $em) {}

    #[Route('', name: 'dashboard_estadisticas', methods: ['GET'])]
    public function estadisticas(Request $request): JsonResponse
    {
        $usuarioId = $request->query->get('usuarioId');
        if (!$usuarioId) {
            return new JsonResponse(['error' => 'Falta usuarioId'], 400);
        }

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) {
            return new JsonResponse(['error' => 'Usuario no encontrado'], 404);
        }

        $menu = $this->em->getRepository(MenuSemanal::class)
            ->findOneBy(['usuario' => $user], ['fechaCreacion' => 'DESC']);

        if (!$menu) {
            return new JsonResponse(['error' => 'No hay menú semanal'], 404);
        }

        $datosPorDia = [];
        $totalesSemanales = [
            'calorias' => 0,
            'proteinas' => 0,
            'grasas' => 0,
            'carbohidratos' => 0,
            'fibra' => 0,
            'azucares' => 0
        ];

        foreach ($menu->getMenuRecetas() as $menuReceta) {
            $dia = ucfirst(strtolower($menuReceta->getDia()));
            $receta = $menuReceta->getReceta();
            if (!$receta) continue;

            if (!isset($datosPorDia[$dia])) {
                $datosPorDia[$dia] = [
                    'calorias' => 0,
                    'proteinas' => 0,
                    'grasas' => 0,
                    'carbohidratos' => 0,
                    'fibra' => 0,
                    'azucares' => 0,
                    'comidas' => []
                ];
            }

            $nutrientesReceta = $this->calcularNutrientesReceta($receta);

            $datosPorDia[$dia]['calorias'] += $nutrientesReceta['calorias'];
            $datosPorDia[$dia]['proteinas'] += $nutrientesReceta['proteinas'];
            $datosPorDia[$dia]['grasas'] += $nutrientesReceta['grasas'];
            $datosPorDia[$dia]['carbohidratos'] += $nutrientesReceta['carbohidratos'];
            $datosPorDia[$dia]['fibra'] += $nutrientesReceta['fibra'];
            $datosPorDia[$dia]['azucares'] += $nutrientesReceta['azucares'];

            $datosPorDia[$dia]['comidas'][] = [
                'nombre' => $receta->getNombre(),
                'tipo' => strtolower($menuReceta->getTipoComida()),
                'calorias' => round($nutrientesReceta['calorias']),
                'proteinas' => round($nutrientesReceta['proteinas'], 1),
                'grasas' => round($nutrientesReceta['grasas'], 1),
                'carbohidratos' => round($nutrientesReceta['carbohidratos'], 1)
            ];

            $totalesSemanales['calorias'] += $nutrientesReceta['calorias'];
            $totalesSemanales['proteinas'] += $nutrientesReceta['proteinas'];
            $totalesSemanales['grasas'] += $nutrientesReceta['grasas'];
            $totalesSemanales['carbohidratos'] += $nutrientesReceta['carbohidratos'];
            $totalesSemanales['fibra'] += $nutrientesReceta['fibra'];
            $totalesSemanales['azucares'] += $nutrientesReceta['azucares'];
        }

        foreach ($datosPorDia as $dia => $datos) {
            $datosPorDia[$dia]['calorias'] = round($datos['calorias']);
            $datosPorDia[$dia]['proteinas'] = round($datos['proteinas'], 1);
            $datosPorDia[$dia]['grasas'] = round($datos['grasas'], 1);
            $datosPorDia[$dia]['carbohidratos'] = round($datos['carbohidratos'], 1);
            $datosPorDia[$dia]['fibra'] = round($datos['fibra'], 1);
            $datosPorDia[$dia]['azucares'] = round($datos['azucares'], 1);
        }

        $numDias = count($datosPorDia);
        $promediosDiarios = [
            'calorias' => $numDias > 0 ? round($totalesSemanales['calorias'] / $numDias) : 0,
            'proteinas' => $numDias > 0 ? round($totalesSemanales['proteinas'] / $numDias, 1) : 0,
            'grasas' => $numDias > 0 ? round($totalesSemanales['grasas'] / $numDias, 1) : 0,
            'carbohidratos' => $numDias > 0 ? round($totalesSemanales['carbohidratos'] / $numDias, 1) : 0,
            'fibra' => $numDias > 0 ? round($totalesSemanales['fibra'] / $numDias, 1) : 0,
            'azucares' => $numDias > 0 ? round($totalesSemanales['azucares'] / $numDias, 1) : 0
        ];

        $objetivos = $this->em->getRepository(ObjetivosNutricionales::class)
            ->findOneBy(['usuario' => $user]);

        $response = [
            'fechaMenu' => $menu->getFechaCreacion()->format('Y-m-d'),
            'datosPorDia' => $datosPorDia,
            'totalesSemanales' => [
                'calorias' => round($totalesSemanales['calorias']),
                'proteinas' => round($totalesSemanales['proteinas'], 1),
                'grasas' => round($totalesSemanales['grasas'], 1),
                'carbohidratos' => round($totalesSemanales['carbohidratos'], 1),
                'fibra' => round($totalesSemanales['fibra'], 1),
                'azucares' => round($totalesSemanales['azucares'], 1)
            ],
            'promediosDiarios' => $promediosDiarios
        ];

        if ($objetivos) {
            $response['objetivos'] = [
                'calorias' => $objetivos->getCalorias(),
                'proteinas' => $objetivos->getProteinas(),
                'grasas' => $objetivos->getGrasas(),
                'carbohidratos' => $objetivos->getCarbohidratos(),
                'fibra' => $objetivos->getFibra()
            ];
        }

        return new JsonResponse($response);
    }

    private function calcularNutrientesReceta($receta): array
    {
        $calorias = $proteinas = $grasas = $carbohidratos = $fibra = $azucares = 0;

        foreach ($receta->getIngredientesRel() as $ri) {
            $ingrediente = $ri->getIngrediente();
            if (!$ingrediente) continue;

            $cantidad = $ri->getCantidad() ?? 0;
            $medida = strtolower(trim($ri->getMedida() ?? ''));

            $factor = match($medida) {
                'g', 'ml' => $cantidad / 100,
                'unidad' => $cantidad,
                'cucharada' => ($cantidad * 15) / 100,
                'taza' => ($cantidad * 240) / 100,
                default => $cantidad / 100
            };

            $calorias += $factor * ($ingrediente->getCalorias() ?? 0);
            $proteinas += $factor * ($ingrediente->getProteinas() ?? 0);
            $grasas += $factor * ($ingrediente->getGrasas() ?? 0);
            $carbohidratos += $factor * ($ingrediente->getCarbohidratos() ?? 0);
            $fibra += $factor * ($ingrediente->getFibra() ?? 0);
            $azucares += $factor * ($ingrediente->getAzucares() ?? 0);
        }

        return [
            'calorias' => $calorias,
            'proteinas' => $proteinas,
            'grasas' => $grasas,
            'carbohidratos' => $carbohidratos,
            'fibra' => $fibra,
            'azucares' => $azucares
        ];
    }
}