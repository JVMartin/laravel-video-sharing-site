<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MyModel extends Model
{
	protected $guarded = ['id'];

	public function getHashAttribute()
	{
		return encodeHash($this->id);
	}
}
