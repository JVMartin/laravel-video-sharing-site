<?php

namespace App\Models;

class Comment extends Model
{
	protected $with = ['user'];

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
	protected $appends = ['hash'];

	public function user()
	{
		return $this->belongsTo(User::class);
	}

	public function submission()
	{
		return $this->belongsTo(Submission::class);
	}
}
