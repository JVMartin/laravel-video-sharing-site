<?php

namespace App\Models;

class Comment extends Model
{
	/**
	 * Whether the logged in user has upvoted this comment.
	 *
	 * @var bool
	 */
	protected $userUp = false;

	/**
	 * Whether the logged in user has downvoted this comment.
	 *
	 * @var bool
	 */
	protected $userDown = false;

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

	public function getUserUpAttribute()
	{
		return $this->userUp;
	}

	public function getUserDownAttribute()
	{
		return $this->userDown;
	}

	public function setUserUp()
	{
		$this->userUp = true;
		$this->userDown = false;
	}

	public function setUserDown()
	{
		$this->userDown = true;
		$this->userUp = false;
	}
}
