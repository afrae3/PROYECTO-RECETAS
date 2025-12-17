<?php

namespace App\Controller;

use App\Entity\Favorito;
use App\Entity\Receta;
use App\Entity\User;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/favoritos')]
class FavoritoController extends AbstractController
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('', name: 'favoritos_list', methods: ['GET'])]
    public function listar(Request $request): JsonResponse
    {
        $usuarioId = $request->query->get('usuarioId');

        if (!$usuarioId) {
            return new JsonResponse(['error' => 'Falta usuarioId'], 400);
        }

        $usuario = $this->entityManager->getRepository(User::class)->find($usuarioId);
        if (!$usuario) {
            return new JsonResponse(['error' => 'Usuario no encontrado'], 404);
        }

        $favoritos = $this->entityManager->getRepository(Favorito::class)
            ->findBy(['usuario' => $usuario]);

        $data = [];
        foreach ($favoritos as $fav) {
            $receta = $fav->getReceta();
            if ($receta) {
                $data[] = [
                    'id' => $receta->getId(),
                    'nombre' => $receta->getNombre(),
                    'descripcion' => $receta->getDescripcion(),
                    'imagen' => $receta->getImagen(),
                    'usuarioId' => $usuario->getId()
                ];
            }
        }

        return $this->json($data);
    }

    #[Route('', name: 'favorito_add', methods: ['POST'])]
    public function agregar(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $recetaId = $data['recetaId'] ?? null;
        $usuarioId = $data['usuarioId'] ?? null;

        if (!$recetaId || !$usuarioId) {
            return new JsonResponse(['error' => 'Faltan datos: recetaId o usuarioId'], 400);
        }

        $receta = $this->entityManager->getRepository(Receta::class)->find($recetaId);
        $usuario = $this->entityManager->getRepository(User::class)->find($usuarioId);

        if (!$receta || !$usuario) {
            return new JsonResponse(['error' => 'Receta o usuario no encontrados'], 404);
        }

        $existe = $this->entityManager->getRepository(Favorito::class)
            ->findOneBy(['usuario' => $usuario, 'receta' => $receta]);

        if ($existe) {
            return new JsonResponse(['message' => 'Ya está en favoritos'], 200);
        }

        $favorito = new Favorito();
        $favorito->setUsuario($usuario);
        $favorito->setReceta($receta);

        $this->entityManager->persist($favorito);
        $this->entityManager->flush();

        return new JsonResponse(['message' => 'Receta agregada a favoritos'], 201);
    }

    #[Route('/delete', name: 'favorito_delete', methods: ['POST'])]
    public function eliminar(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $recetaId = $data['recetaId'] ?? null;
        $usuarioId = $data['usuarioId'] ?? null;

        if (!$recetaId || !$usuarioId) {
            return new JsonResponse(['error' => 'Faltan datos: recetaId o usuarioId'], 400);
        }

        $receta = $this->entityManager->getRepository(Receta::class)->find($recetaId);
        $usuario = $this->entityManager->getRepository(User::class)->find($usuarioId);

        if (!$receta || !$usuario) {
            return new JsonResponse(['error' => 'Receta o usuario no encontrados'], 404);
        }

        $favorito = $this->entityManager->getRepository(Favorito::class)
            ->findOneBy(['usuario' => $usuario, 'receta' => $receta]);

        if (!$favorito) {
            return new JsonResponse(['error' => 'No está en favoritos'], 404);
        }

        $this->entityManager->remove($favorito);
        $this->entityManager->flush();

        return new JsonResponse(['message' => 'Favorito eliminado']);
    }
}
