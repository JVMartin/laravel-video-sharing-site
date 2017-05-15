<?php

namespace App\Models;

class Notification extends Model
{
	public function notifiable()
	{
		return $this->morphTo();
	}
}
