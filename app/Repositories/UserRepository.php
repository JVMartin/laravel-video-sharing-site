<?php

namespace App\Repositories;

use App\Models\User;
use App\Models\MyModel;

class UserRepository extends ModelRepository
{
	/**
	 * @param string $email
	 * @return User|null
	 */
	public function getByEmail($email)
	{
		$key = $this->resourceName . '.email.' . $email;
		$query = $this->model->newQuery();

		return $this->cache->remember($key, 10, function() use ($query, $email) {
			return $query->where('email', $email)->first();
		});
	}

	/**
	 * @param MyModel $model
	 */
	public function flush(MyModel $model)
	{
		$this->cache->forget($this->resourceName . '.email.' . $model->email);
		parent::flush($model);
	}
}