<?php

namespace App\Providers;

use App\Services\SyncDatabaseDataService;
use Illuminate\Foundation\Application;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->singleton(SyncDatabaseDataService::class, function (Application $app) {
           return new SyncDatabaseDataService();
        });
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
