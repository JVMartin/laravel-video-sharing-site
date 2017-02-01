<?php

namespace App\Models;

class Topic extends Model
{
	public function videos()
	{
		return $this->belongsToMany(Video::class, 'videos_topics');
	}
}
