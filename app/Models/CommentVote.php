<?php

namespace App\Models;

class CommentVote extends Model
{
	/**
	 * @var string
	 */
	protected $table = 'comments_votes';

	/**
	 * @var bool
	 */
	public $timestamps = false;

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
