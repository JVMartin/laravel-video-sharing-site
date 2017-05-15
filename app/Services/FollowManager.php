<?php

namespace App\Services;

use App\Models\User;
use App\Jobs\Notifications\Follow;

class FollowManager
{
	public function follow(User $leader, User $follower, $follow = true)
	{
		if ($follow) {
			$leader->followers()->attach($follower->id);
			dispatch(new Follow($leader, $follower));
		}
		else {
			$leader->followers()->detach($follower->id);
		}
	}
}
