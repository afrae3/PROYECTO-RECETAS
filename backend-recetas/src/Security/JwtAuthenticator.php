<?php

namespace App\Security;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Security\Http\Authenticator\AbstractAuthenticator;
use Symfony\Component\Security\Http\Authenticator\Passport\Passport;
use Symfony\Component\Security\Http\Authenticator\Passport\SelfValidatingPassport;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Core\Exception\AuthenticationException;

class JwtAuthenticator extends AbstractAuthenticator
{
    private $publicKey;

    public function __construct()
    {
        $this->publicKey = file_get_contents(__DIR__ . '/../../config/jwt/public.pem');
    }

    public function supports(Request $request): ?bool
    {
        return $request->headers->has('Authorization') &&
               str_starts_with($request->headers->get('Authorization'), 'Bearer ');
    }

    public function authenticate(Request $request): Passport
    {
        $jwt = str_replace('Bearer ', '', $request->headers->get('Authorization'));
        if (!$jwt) throw new AuthenticationException('JWT no proporcionado');

        $payload = $this->decodeJwt($jwt);
        if (!$payload) throw new AuthenticationException('JWT inválido');

        return new SelfValidatingPassport(new UserBadge($payload['sub']));
    }

    public function onAuthenticationSuccess(Request $request, $token, string $firewallName): ?JsonResponse
    {
        return null;
    }

    public function onAuthenticationFailure(Request $request, AuthenticationException $exception): ?JsonResponse
    {
        return new JsonResponse(['error' => 'Autenticación fallida: ' . $exception->getMessage()], 401);
    }

    private function decodeJwt(string $jwt): ?array
    {
        $parts = explode('.', $jwt);
        if (count($parts) !== 3) return null;

        [$header, $payload, $signature] = $parts;
        $payloadDecoded = json_decode(base64_decode(strtr($payload, '-_', '+/')), true);
        $signatureDecoded = base64_decode(strtr($signature, '-_', '+/'));

        $data = $header . '.' . $payload;
        $verified = openssl_verify($data, $signatureDecoded, $this->publicKey, OPENSSL_ALGO_SHA256);

        return $verified === 1 ? $payloadDecoded : null;
    }
}
