<?php

namespace App\Models;

class Notification extends Model
{
    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = [
        'created_at',
        'updated_at',
        'read_at',
    ];

	/**
	 * @var array
	 */
	protected $with = ['notifiable'];

	public function notifiable()
	{
		return $this->morphTo();
	}
}
