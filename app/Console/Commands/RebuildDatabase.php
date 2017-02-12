<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class RebuildDatabase extends Command
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'db:rebuild';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Rebuild the database.';

	/**
	 * Execute the console command.
	 *
	 * @return mixed
	 */
	public function handle()
	{
		$db = env('DB_DATABASE');

		passthru("sudo -u postgres psql -c \"DROP DATABASE $db;\"");
		passthru("sudo -u postgres psql -c \"CREATE DATABASE $db;\"");
		$this->call('migrate');
		$this->call('db:seed');

		passthru("sudo -u postgres pg_dump -c $db > assets/$db.sql");
	}
}
