<?php

namespace App\Models;

class Submission extends Model
{
	public function video()
	{
		return $this->belongsTo(Video::class);
	}
}
