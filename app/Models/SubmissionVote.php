<?php

namespace App\Models;

class SubmissionVote extends Model
{
	/**
	 * @var string
	 */
	protected $table = 'submissions_votes';

	/**
	 * @var bool
	 */
	public $timestamps = false;

	public function user()
	{
		return $this->belongsTo(User::class);
	}

	public function submission()
	{
		return $this->belongsTo(Submission::class);
	}

	public function value()
	{
		return ($this->up) ? 1 : -1;
	}
}
