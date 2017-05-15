<?php

namespace App\Services;

use App\Models\User;

class FollowManager
{
	public function follow(User $leader, User $follower, $follow = true)
	{
		if ($follow) {
			$leader->followers()->attach($follower->id);
		}
		else {
			$leader->followers()->detach($follower->id);
		}
	}
}
