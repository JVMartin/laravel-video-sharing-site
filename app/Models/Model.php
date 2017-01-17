<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as EloquentModel;

class Model extends EloquentModel
{
	protected $guarded = ['id'];

	public function getHashAttribute()
	{
		return encodeHash($this->id);
	}
}
