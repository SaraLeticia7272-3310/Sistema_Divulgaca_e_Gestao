<?php

declare(strict_types=1);

namespace App\Controllers;

use App\Core\View;
use App\Repositories\ProductRepository;

class HomeController
{
    public function index(): void
    {
        $repository = new ProductRepository();

        if ($repository->testConnection()) {
            View::render('home');
        }
    }
}