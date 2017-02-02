<?php

namespace App\Console\Commands;

use Carbon\Carbon;
use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Database\Connection;

class DeleteUnverifiedUsers extends Command
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'users:delete-unverified';

	/**
	 * The console command description.
	 *
	 * @var string
	 */
	protected $description = 'Delete all unverified users older than a certain number of days.';

	/**
	 * @var Connection
	 */
	protected $db;

	public function __construct(Connection $db)
	{
		parent::__construct();

		$this->db = $db;
	}

	/**
	 * Execute the console command.
	 *
	 * @return void
	 */
	public function handle()
	{
		$verbose = $this->getOutput()->isVerbose();

		$days = config('auth.verifications.expire');
		$olderThan = Carbon::now()->subDays($days);

		// Delete all users who have not verified their emails in time.
		$this->db->table('verifications')
			->where('created_at', '<', $olderThan)
			->orderBy('created_at')
			->chunk(100, function($verifications) use ($verbose) {
				foreach ($verifications as $verification) {
					$user = User::find($verification->user_id);
					if ($user) {
						if ($verbose) {
							$this->info('Deleting user with email ' . $user->email);
						}
						$user->delete();
					}
				}
			});

		// Delete the verification rows as well.
		$this->db->table('verifications')->where('created_at', '<', $olderThan)
			->delete();
	}
}
