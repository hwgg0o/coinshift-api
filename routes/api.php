<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Nueva ruta para el Microservicio de tipos de cambio
Route::get('/exchange-rate', function () {
    return response()->json([
        'usd_to_mxn' => 18.60, // Valor base para las pruebas
        'mxn_to_usd' => 0.057
    ]);
});

// Ruta original (puedes mantenerla o comentarla)
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');