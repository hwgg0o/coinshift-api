<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ExchangeController extends Controller
{
    /**
     * Obtiene la tasa de cambio protegida en el entorno (.env)
     * Evitamos "hardcodear" datos sensibles directamente en el código.
     */
    public function getRate()
    {
        // Recuperamos la variable del .env, con un valor por defecto de 0.00
        $rate = env('COINSHIFT_DEFAULT_RATE', 0.00);

        return response()->json([
            'rate' => (float) $rate,
            'currency' => 'MXN',
            'status' => 'success'
        ]);
    }
}