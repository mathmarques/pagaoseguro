<?php

namespace App\Controller;

use App\Library\Security;
use Interop\Container\ContainerInterface;
use Slim\Http\Request;
use Slim\Http\Response;

class HomeController
{

    private $container;

    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
    }

    public function indexAction(Request $request, Response $response, $args)
    {
        return $this->container->get('view')->render($response, 'home.tpl');
    }


}