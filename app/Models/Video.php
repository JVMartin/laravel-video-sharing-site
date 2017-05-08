<?php

namespace App\Models;

use Cartalyst\Tags\TaggableTrait;
use Cartalyst\Tags\TaggableInterface;

class Video extends Model implements TaggableInterface
{
	use TaggableTrait;

	/**
	 * The attributes that should be hidden for arrays.
	 *
	 * @var array
	 */
	protected $hidden = [
		'id'
	];

	public function topics()
	{
		return $this->belongsToMany(Topic::class, 'videos_topics');
	}
}
