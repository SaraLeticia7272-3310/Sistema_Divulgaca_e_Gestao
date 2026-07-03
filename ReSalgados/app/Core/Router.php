<?php

declare(strict_types=1);

namespace App\Core;

class Router
{
    private array $routes = [];

    public function get(string $uri, callable|array $action): void
    {
        $this->routes['GET'][$this->normalizeUri($uri)] = $action;
    }

    public function dispatch(string $uri): void
    {
        $uri = $this->normalizeUri($uri);

        if (!isset($this->routes['GET'][$uri])) {
            echo "<h1>404</h1>";
            echo "<p>Página não encontrada.</p>";
            return;
        }

        $action = $this->routes['GET'][$uri];

        if (is_callable($action)) {
            $action();
            return;
        }

        [$controller, $method] = $action;

        $controller = new $controller();

        $controller->$method();
    }

    private function normalizeUri(string $uri): string
    {
        $uri = str_replace('/ReSalgados/public', '', $uri);

        $uri = rtrim($uri, '/');

        return $uri === '' ? '/' : $uri;
    }
}