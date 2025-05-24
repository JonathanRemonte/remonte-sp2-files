<?php
namespace Drupal\email_test\Controller;

use Drupal\Core\Controller\ControllerBase;
use Symfony\Component\HttpFoundation\JsonResponse;
use Drupal\Core\Mail\MailManagerInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

class EmailTestController extends ControllerBase {

  protected $mailManager;

  public function __construct(MailManagerInterface $mailManager) {
    $this->mailManager = $mailManager;
  }

  public static function create(ContainerInterface $container) {
    return new static(
      $container->get('plugin.manager.mail')
    );
  }

  public function send() {
    $params['subject'] = 'Performance Test';
    $params['message'] = 'This is a test email.';

    $result = $this->mailManager->mail('email_test', 'test_mail', 'jonathanremonte@gmail.com', 'en', $params);

    if ($result['result'] !== true) {
      return new JsonResponse(['status' => 'fail', 'message' => 'Email not sent']);
    } else {
      return new JsonResponse(['status' => 'success', 'message' => 'Email sent']);
    }
  }
}
