<?php

namespace App\Jobs\Notifications;

use App\Models\User;

class Follow extends SendNotification
{
	/**
	 * @var User
	 */
	protected $leader;

	/**
	 * @var User
	 */
	protected $follower;

	public function __construct(User $leader, User $follower)
	{
		$this->leader = $leader;
		$this->follower = $follower;
	}

	/**
	 * Execute the job.
	 *
	 * @return void
	 */
	public function handle()
	{
		$leader = $this->leader;
		$follower = $this->follower;

		// Has this follower already followed this leader in the past?
		if ($this->alreadyNotified($leader, $follower, 'follow')) {

			// Well, let's not keep notifying them.
			return;
		}

		$notification = $this->getNotification($leader, $follower, 'follow');
		$notification->read_at = null;
		$notification->save();
	}
}
