<?php

namespace App\Models;

use Cartalyst\Tags\TaggableTrait;
use Cartalyst\Tags\TaggableInterface;

class Video extends Model implements TaggableInterface
{
	use TaggableTrait;

	public function topics()
	{
		return $this->belongsToMany(Topic::class, 'videos_topics');
	}
}
