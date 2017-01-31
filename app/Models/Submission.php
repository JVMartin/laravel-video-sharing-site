<?php

namespace App\Models;

class Submission extends Model
{
	protected $with = ['video'];

	public function video()
	{
		return $this->belongsTo(Video::class);
	}
}
