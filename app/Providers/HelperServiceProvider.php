<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class HelperServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register()
    {
        // Load all of the helper function files.
        foreach (glob(app_path() . '/Helpers/*.php') as $fileName) {
            require_once($fileName);
        }
    }
}
