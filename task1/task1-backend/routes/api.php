<?php

use App\Http\Controllers\FavoriteVideoController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\YoutubeController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::prefix('/user')->group(function () {
    Route::post('login', [UserController::class, 'login']);
    Route::post('register', [UserController::class, 'register']);

    // api untuk mendapatkan detail user
    Route::middleware('auth:api')
        ->get('auth', function (Request $request) {
            return $request->user();
        });

    Route::middleware('auth:api')
        ->post('update_profile', [UserController::class, 'update_profile']);
    Route::middleware('auth:api')
        ->get('logout', [UserController::class, 'logout']);
});


Route::prefix('/youtube')->group(function () {
    Route::middleware('auth:api')
        ->get('populars/list', [YoutubeController::class, 'getPopularsList']);
});

Route::middleware('auth:api')->prefix('/favorite')->group(function () {
    Route::get('check/{id}', [FavoriteVideoController::class, 'check']);

    Route::post('toggle', [FavoriteVideoController::class, 'toggle']);
    Route::get('list', [FavoriteVideoController::class, 'list']);
});
