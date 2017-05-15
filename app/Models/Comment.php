<?php

namespace App\Models;

class Comment extends Model
{
	use Votable;

	/**
	 * The attributes that should be hidden for arrays.
	 *
	 * @var array
	 */
	protected $hidden = [
		'id', 'submission_id', 'user_id'
	];

	/**
	 * The accessors to append to the model's array form.
	 *
	 * @var array
	 */
	protected $appends = ['hash', 'user_up', 'user_down'];

	public function user()
	{
		return $this->belongsTo(User::class);
	}

	public function submission()
	{
		return $this->belongsTo(Submission::class);
	}

	public function votes()
	{
		return $this->hasMany(CommentVote::class);
	}

	public function replies()
	{
		return $this->hasMany(Comment::class, 'parent_id');
	}
}
