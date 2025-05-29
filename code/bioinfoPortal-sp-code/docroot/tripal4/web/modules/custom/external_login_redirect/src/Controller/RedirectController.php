<?php

namespace Drupal\external_login_redirect\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Firebase\JWT\JWT;

class RedirectController extends ControllerBase {

  private function generateJwtForUser($user) {
    $privateKeyPath = '/var/www/private_keys/private.key';
    $privateKey = file_get_contents($privateKeyPath);
    $account = \Drupal\user\Entity\User::load($user->id());

    $payload = [
      'sub' => $user->id(),
      'name' => $user->getDisplayName(),
      'email' => $account->getEmail(),
      'exp' => time() + 300,
      'iat' => time(),
      'iss' => getenv('DOMAIN_ADD') . ':8080',
      'aud' => 'https://snpseek-mern.vercel.app',
    ];

    return JWT::encode($payload, $privateKey, 'RS256');
  }

  public function handleRedirect() {
    $user = $this->currentUser();

    if ($user->isAnonymous()) {
      return $this->redirect('<front>');
    }

    $account = \Drupal\user\Entity\User::load($user->id());
    $jwt = $this->generateJwtForUser($user);

    $externalUrl = 'https://snpseek-mern.vercel.app';

    $html = <<<HTML
    <html><body>
    <form id="redirectForm" action="$externalUrl" method="post">
        <input type="hidden" name="token" value="$jwt">
        <input type="hidden" name="name" value="{$user->getDisplayName()}">
        <input type="hidden" name="email" value="{$account->getEmail()}">
    </form>
    <script>document.getElementById('redirectForm').submit();</script>
    </body></html>
    HTML;

    return new Response($html);
  }

  public function getIframeJwt() {
    $user = $this->currentUser();

    if ($user->isAnonymous()) {
      return new JsonResponse(['error' => 'Unauthorized'], 403);
    }

    try {
      $jwt = $this->generateJwtForUser($user);
      return new JsonResponse(['token' => $jwt]);
    }
    catch (\Exception $e) {
      return new JsonResponse(['error' => 'Token generation failed', 'message' => $e->getMessage()], 500);
    }
  }
}