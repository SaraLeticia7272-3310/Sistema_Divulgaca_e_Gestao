<?php

declare(strict_types=1);

namespace App\Core;

class App
{
    public function run(): void
{
    $router = new Router();

    require_once __DIR__ . '/../../routes/web.php';
    
    $router->dispatch(
        $_SERVER['REQUEST_URI']
    );
}
}