<?php

namespace App\Models;

trait Votable
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
