<?php

namespace App\Controller;

use App\Entity\ObjetivosNutricionales;
use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/objetivos')]
class ObjetivosController extends AbstractController
{
    public function __construct(private EntityManagerInterface $em) {}

    #[Route('', name: 'objetivos_get', methods: ['GET'])]
    public function obtener(Request $request): JsonResponse
    {
        $usuarioId = $request->query->get('usuarioId');
        if (!$usuarioId) {
            return new JsonResponse(['error' => 'Falta usuarioId'], 400);
        }

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) {
            return new JsonResponse(['error' => 'Usuario no encontrado'], 404);
        }

        $objetivos = $this->em->getRepository(ObjetivosNutricionales::class)
            ->findOneBy(['usuario' => $user]);

        if (!$objetivos) {
            return new JsonResponse(['error' => 'No hay objetivos definidos'], 404);
        }

        return new JsonResponse([
            'sexo' => $objetivos->getSexo(),
            'edad' => $objetivos->getEdad(),
            'peso' => $objetivos->getPeso(),
            'altura' => $objetivos->getAltura(),
            'nivelActividad' => $objetivos->getNivelActividad(),
            'objetivo' => $objetivos->getObjetivo(),
            'calorias' => $objetivos->getCalorias(),
            'proteinas' => $objetivos->getProteinas(),
            'grasas' => $objetivos->getGrasas(),
            'carbohidratos' => $objetivos->getCarbohidratos(),
            'fibra' => $objetivos->getFibra()
        ]);
    }

    #[Route('', name: 'objetivos_guardar', methods: ['POST'])]
    public function guardar(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $usuarioId = $data['usuarioId'] ?? null;

        if (!$usuarioId) {
            return new JsonResponse(['error' => 'Falta usuarioId'], 400);
        }

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) {
            return new JsonResponse(['error' => 'Usuario no encontrado'], 404);
        }

        $objetivos = $this->em->getRepository(ObjetivosNutricionales::class)
            ->findOneBy(['usuario' => $user]);

        if (!$objetivos) {
            $objetivos = new ObjetivosNutricionales();
            $objetivos->setUsuario($user);
        } else {
            $objetivos->setFechaActualizacion(new \DateTime());
        }

        if (isset($data['sexo'])) $objetivos->setSexo($data['sexo']);
        if (isset($data['edad'])) $objetivos->setEdad((int)$data['edad']);
        if (isset($data['peso'])) $objetivos->setPeso((float)$data['peso']);
        if (isset($data['altura'])) $objetivos->setAltura((int)$data['altura']);
        if (isset($data['nivelActividad'])) $objetivos->setNivelActividad($data['nivelActividad']);
        if (isset($data['objetivo'])) $objetivos->setObjetivo($data['objetivo']);

        $nutrientes = $this->calcularObjetivosNutricionales(
            $data['sexo'],
            (int)$data['edad'],
            (float)$data['peso'],
            (int)$data['altura'],
            $data['nivelActividad'],
            $data['objetivo']
        );

        $objetivos->setCalorias($nutrientes['calorias']);
        $objetivos->setProteinas($nutrientes['proteinas']);
        $objetivos->setGrasas($nutrientes['grasas']);
        $objetivos->setCarbohidratos($nutrientes['carbohidratos']);
        $objetivos->setFibra($nutrientes['fibra']);

        $this->em->persist($objetivos);
        $this->em->flush();

        return new JsonResponse([
            'message' => 'Objetivos calculados y guardados correctamente',
            'objetivos' => $nutrientes
        ]);
    }

    #[Route('', name: 'objetivos_eliminar', methods: ['DELETE'])]
    public function eliminar(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $usuarioId = $data['usuarioId'] ?? null;

        if (!$usuarioId) {
            return new JsonResponse(['error' => 'Falta usuarioId'], 400);
        }

        $user = $this->em->getRepository(User::class)->find($usuarioId);
        if (!$user) {
            return new JsonResponse(['error' => 'Usuario no encontrado'], 404);
        }

        $objetivos = $this->em->getRepository(ObjetivosNutricionales::class)
            ->findOneBy(['usuario' => $user]);

        if (!$objetivos) {
            return new JsonResponse(['error' => 'No hay objetivos para eliminar'], 404);
        }

        $this->em->remove($objetivos);
        $this->em->flush();

        return new JsonResponse(['message' => 'Objetivos eliminados correctamente']);
    }

    private function calcularObjetivosNutricionales(
        string $sexo,
        int $edad,
        float $peso,
        int $altura,
        string $nivelActividad,
        string $objetivo
    ): array {
        // 1. Calcular TMB (Tasa Metabólica Basal) con Mifflin-St Jeor
        if ($sexo === 'masculino') {
            $tmb = (10 * $peso) + (6.25 * $altura) - (5 * $edad) + 5;
        } else {
            $tmb = (10 * $peso) + (6.25 * $altura) - (5 * $edad) - 161;
        }

        // 2. Aplicar factor de actividad
        $factorActividad = match($nivelActividad) {
            'sedentario' => 1.2,    // Poco o ningún ejercicio
            'ligero' => 1.375,      // Ejercicio ligero 1-3 días/semana
            'moderado' => 1.55,     // Ejercicio moderado 3-5 días/semana
            'activo' => 1.725,      // Ejercicio intenso 6-7 días/semana
            'muy_activo' => 1.9,    // Ejercicio muy intenso, trabajo físico
            default => 1.2
        };

        $caloriasMantenimiento = $tmb * $factorActividad;

        // 3. Ajustar según objetivo
        $calorias = match($objetivo) {
            'perder_peso' => $caloriasMantenimiento - 500,  // Déficit de 500 kcal
            'mantener' => $caloriasMantenimiento,
            'ganar_musculo' => $caloriasMantenimiento + 300, // Superávit de 300 kcal
            default => $caloriasMantenimiento
        };

        // 4. Calcular macronutrientes
        // Proteínas: 2g por kg de peso corporal (alto para preservar/ganar músculo)
        $proteinas = $peso * 2;

        // Grasas: 25-30% de las calorías totales
        $grasas = ($calorias * 0.27) / 9; // 9 kcal por gramo de grasa

        // Carbohidratos: el resto de las calorías
        $caloriasRestantes = $calorias - ($proteinas * 4) - ($grasas * 9);
        $carbohidratos = $caloriasRestantes / 4; // 4 kcal por gramo

        // Fibra: 14g por cada 1000 kcal (recomendación dietética)
        $fibra = ($calorias / 1000) * 14;

        return [
            'calorias' => round($calorias),
            'proteinas' => round($proteinas, 1),
            'grasas' => round($grasas, 1),
            'carbohidratos' => round($carbohidratos, 1),
            'fibra' => round($fibra, 1)
        ];
    }
}