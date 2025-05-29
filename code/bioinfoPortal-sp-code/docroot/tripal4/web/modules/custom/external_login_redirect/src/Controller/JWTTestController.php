<?php

namespace Drupal\external_login_redirect\Controller;

use Drupal\Core\Controller\ControllerBase;
use Firebase\JWT\JWT;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class JWTTestController extends ControllerBase {

  public function generate() {
    $current_user = \Drupal::currentUser();

    if ($current_user->isAnonymous()) {
      return new JsonResponse(['error' => 'User is not logged in'], Response::HTTP_FORBIDDEN);
    }

    // Load full user entity for more fields
    $user = \Drupal\user\Entity\User::load($current_user->id());

    // Path to private key
    $privateKeyPath = '/var/www/private_keys/private.key';

    if (!file_exists($privateKeyPath)) {
      return new JsonResponse(['error' => 'Private key not found'], Response::HTTP_INTERNAL_SERVER_ERROR);
    }

    $privateKey = file_get_contents($privateKeyPath);

    // Create JWT payload
    $payload = [
      'sub' => $user->id(),
      'name' => $user->getDisplayName(),
      'email' => $user->getEmail(),
      'iat' => time(),
      'exp' => time() + 300,
      'iss' => getenv('DOMAIN_ADD') . ':8080',
      'aud' => getenv('DOMAIN_ADD') . ':8081',
    ];

    try {
      $jwt = JWT::encode($payload, $privateKey, 'RS256');
      return new JsonResponse(['jwt' => $jwt]);
    }
    catch (\Exception $e) {
      return new JsonResponse(['error' => $e->getMessage()], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
  }
}