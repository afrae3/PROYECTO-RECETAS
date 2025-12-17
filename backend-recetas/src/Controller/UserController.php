<?php 

namespace App\Controller;

use App\Entity\User;
use App\Entity\UserRole;
use App\Entity\Role;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;

class UserController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $em,
        private UserPasswordHasherInterface $hasher
    ) {}

    #[Route('/api/register', name: 'api_register', methods: ['POST'])]
    public function register(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $email = $data['email'] ?? '';
        $password = $data['password'] ?? '';
        $requestedRole = $data['role'] ?? 'ROLE_USER';

        if (!$email || !$password) {
            return new JsonResponse(['error' => 'Email y contraseña requeridos'], 400);
        }

        $existingUser = $this->em->getRepository(User::class)->findOneBy(['email' => $email]);
        if ($existingUser) {
            return new JsonResponse(['error' => 'El usuario ya existe'], 400);
        }

        $user = new User();
        $user->setEmail($email);
        $user->setPassword($this->hasher->hashPassword($user, $password));

        $this->em->persist($user);

        $roleRepo = $this->em->getRepository(Role::class);
        $role = $roleRepo->findOneBy(['nombre' => $requestedRole]);

        if (!$role) {
            $role = new Role();
            $role->setNombre($requestedRole);
            $this->em->persist($role);
        }

        $userRole = new UserRole();
        $userRole->setUsuario($user);
        $userRole->setRole($role);
        $this->em->persist($userRole);

        $this->em->flush();

        return new JsonResponse([
            'message' => 'Usuario registrado correctamente',
            'role_asignado' => $requestedRole
        ], 201);
    }

    #[Route('/api/users', name: 'api_users_list', methods: ['GET'])]
    public function listUsers(): JsonResponse
    {
        $users = $this->em->getRepository(User::class)->findAll();
        $data = [];

        foreach ($users as $user) {
            $roles = $this->em->getRepository(UserRole::class)->findBy(['usuario' => $user]);
            $roleNames = array_map(fn($ur) => $ur->getRole()?->getNombre(), $roles);

            $data[] = [
                'id' => $user->getId(),
                'email' => $user->getEmail(),
                'roles' => $roleNames
            ];
        }

        return new JsonResponse($data);
    }

    #[Route('/api/users/{id}', name: 'api_users_delete', methods: ['DELETE'])]
    public function deleteUser(int $id): JsonResponse
    {
        $user = $this->em->getRepository(User::class)->find($id);

        if (!$user) {
            return new JsonResponse(['error' => 'Usuario no encontrado'], 404);
        }

        $this->em->remove($user);
        $this->em->flush();

        return new JsonResponse(['message' => 'Usuario eliminado correctamente']);
    }

    #[Route('/api/users/{id}', name: 'api_users_update', methods: ['PUT'])]
    public function updateUser(int $id, Request $request): JsonResponse
    {
        $user = $this->em->getRepository(User::class)->find($id);

        if (!$user) {
            return new JsonResponse(['error' => 'Usuario no encontrado'], 404);
        }

        $data = json_decode($request->getContent(), true);

        if (isset($data['email'])) {
            $user->setEmail($data['email']);
        }

        if (isset($data['roles']) && is_array($data['roles'])) {
            $currentRoles = $this->em->getRepository(UserRole::class)->findBy(['usuario' => $user]);
            foreach ($currentRoles as $cr) {
                $this->em->remove($cr);
            }

            $roleRepo = $this->em->getRepository(Role::class);
            foreach ($data['roles'] as $roleName) {
                $role = $roleRepo->findOneBy(['nombre' => $roleName]);
                if ($role) {
                    $userRole = new UserRole();
                    $userRole->setUsuario($user);
                    $userRole->setRole($role);
                    $this->em->persist($userRole);
                }
            }
        }

        $this->em->flush();

        return new JsonResponse(['message' => 'Usuario actualizado correctamente']);
    }
}
