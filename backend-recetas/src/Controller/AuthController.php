<?php

namespace App\Controller;

use App\Entity\User;
use App\Entity\UserRole;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;

class AuthController extends AbstractController
{
    private EntityManagerInterface $em;
    private UserPasswordHasherInterface $passwordHasher;
    private string $privateKey;

    public function __construct(EntityManagerInterface $em, UserPasswordHasherInterface $passwordHasher)
    {
        $this->em = $em;
        $this->passwordHasher = $passwordHasher;
        $this->privateKey = file_get_contents(__DIR__ . '/../../config/jwt/private.pem');
    }

    #[Route('/api/login', name: 'api_login', methods: ['POST'])]
    public function login(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $email = $data['email'] ?? '';
        $password = $data['password'] ?? '';

        if (!$email || !$password) {
            return new JsonResponse(['error' => 'Email y contraseña requeridos'], 400);
        }

        $user = $this->em->getRepository(User::class)->findOneBy(['email' => $email]);

        if (!$user || !$this->passwordHasher->isPasswordValid($user, $password)) {
            return new JsonResponse(['error' => 'Credenciales incorrectas'], 401);
        }

        $roles = [];
        $userRoles = $this->em->getRepository(UserRole::class)->findBy(['usuario' => $user]);
        foreach ($userRoles as $userRole) {
            if ($userRole->getRole()) {
                $roles[] = $userRole->getRole()->getNombre();
            }
        }
        if (empty($roles)) {
            $roles[] = 'ROLE_USER';
        }

        $payload = [
            'sub' => $user->getId(),
            'email' => $user->getEmail(),
            'roles' => $roles,
            'iat' => time(),
            'exp' => time() + 3600, // 1 hora
        ];

        $jwt = $this->generateJwt($payload, $this->privateKey);

        return new JsonResponse([
            'token' => $jwt,
            'userId' => $user->getId(),
            'roles' => $roles
        ]);
    }

    private function generateJwt(array $payload, string $privateKey): string
    {
        $header = json_encode(['alg' => 'RS256', 'typ' => 'JWT']);
        $payload = json_encode($payload);

        $base64UrlHeader = rtrim(strtr(base64_encode($header), '+/', '-_'), '=');
        $base64UrlPayload = rtrim(strtr(base64_encode($payload), '+/', '-_'), '=');

        $data = $base64UrlHeader . '.' . $base64UrlPayload;
        openssl_sign($data, $signature, $privateKey, OPENSSL_ALGO_SHA256);
        $base64UrlSignature = rtrim(strtr(base64_encode($signature), '+/', '-_'), '=');

        return $data . '.' . $base64UrlSignature;
    }
}
