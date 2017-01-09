<?php

namespace App\Console\Commands;

use Schema;
use Illuminate\Console\Command;

class ResetApplication extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:reset';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Reset the application (database, files, etc).';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
    	if (Schema::hasTable('migrations')) {
			$this->call('migrate:rollback');
		}
        $this->call('migrate');
    	$this->call('db:seed');
    	exec(base_path('fix.sh'));
    	exec('git clean -fxd ' . public_path('img/u'));
		exec('git clean -fxd ' . storage_path());
    }
}
