<?php

namespace App\Models;

class Notification extends Model
{
	/**
	 * @var array
	 */
	protected $with = ['notifiable'];

	public function notifiable()
	{
		return $this->morphTo();
	}
}
