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
		exec(base_path('fix.sh'));
		exec('git clean -fxd ' . public_path('img/u'));
		exec('git clean -fxd ' . storage_path());

		// IDE helper
		$this->call('clear-compiled');
		$this->call('ide-helper:generate');
		$this->call('optimize');

		if (Schema::hasTable('migrations')) {
			$this->call('migrate:rollback');
		}
		$this->call('migrate');
		$this->call('db:seed');
		$this->call('testing:flush');
	}
}
