<?php

namespace App\Models;

class CommentVote extends Model
{
	public function user()
	{
		return $this->belongsTo(User::class);
	}

	public function comment()
	{
		return $this->belongsTo(Comment::class);
	}

	public function value()
	{
		return ($this->up) ? 1 : -1;
	}
}
