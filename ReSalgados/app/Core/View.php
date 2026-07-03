<?php

declare(strict_types=1);

namespace App\Core;

class View
{
    public static function render(string $view): void
    {
        $content = __DIR__ . "/../Views/{$view}.php";

        require_once __DIR__ . "/../Views/layouts/main.php";
    }
}