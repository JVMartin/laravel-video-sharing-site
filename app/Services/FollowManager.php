<?php

namespace App\Services;

use App\Models\User;
use App\Jobs\Notifications\Follow;

class FollowManager
{
	/**
	 * Have a user start or stop following another user.
	 *
	 * @param User $leader
	 * @param User $follower
	 * @param bool $follow
	 * @return void
	 */
	public function follow(User $leader, User $follower, $follow = true)
	{
		if ($leader->id == $follower->id) {
			// What is this fuckery?
			return;
		}

		if ($follow) {
			$leader->followers()->attach($follower->id);

			// Notify the leader of their new follower.
			dispatch(new Follow($leader, $follower));
		}
		else {
			$leader->followers()->detach($follower->id);
		}
	}
}
