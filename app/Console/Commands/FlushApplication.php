<?php

namespace App\Console\Commands;

use Schema;
use Illuminate\Console\Command;

class FlushApplication extends Command
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'app:flush';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Flush the application (database, files, etc).';

	/**
	 * Execute the console command.
	 *
	 * @return mixed
	 */
	public function handle()
	{
		// IDE helper
		$this->call('clear-compiled');
		$this->call('ide-helper:generate');
		$this->call('optimize');

//		if (Schema::hasTable('migrations')) {
//			$this->call('migrate:reset');
//		}
//		$this->call('migrate');
//		$this->call('db:seed');
		$this->info('Reloading database...');
		$db = env('DB_DATABASE');

		passthru("sudo -u postgres psql -c \"DROP DATABASE $db;\"");
		passthru("sudo -u postgres psql -c \"CREATE DATABASE $db;\"");
		passthru("sudo -u postgres psql $db < " . base_path("assets/$db.sql"));

		passthru('sudo git clean -fxd ' . public_path());
		passthru('sudo git clean -fxd ' . storage_path());

		$this->call('storage:link');

		passthru('npm run dev');
	}
}
