<?php

namespace App\Models;

use Cartalyst\Tags\TaggableTrait;
use Cartalyst\Tags\TaggableInterface;

class Submission extends Model implements TaggableInterface
{
	use TaggableTrait;

	protected $with = ['video'];

	public function video()
	{
		return $this->belongsTo(Video::class);
	}
}
