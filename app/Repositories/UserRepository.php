<?php

namespace App\Repositories;

use App\Models\User;
use App\Models\Model;
use Illuminate\Support\Facades\DB;

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
	 * @param array $attributes
	 * @return Model
	 */
	public function create(array $attributes = [])
	{
		DB::transaction(function() use (&$user, $attributes) {
			// Ensure that the username is unique.
			$username = null;
			if (array_key_exists('username', $attributes)) {
				$username = $attributes['username'];
			}
			// Use 'Anonymous-hash' if not.
			if ($username === null ||
					User::where('username', $username)->count()) {
				$id = DB::table('users')->max('id') + 1;
				$username = 'Anonymous-' . encodeHash($id);
			}
			$attributes['username'] = $username;

			// Create the user.
			$user = $this->model->create($attributes);
		});

		return $user;
	}

	/**
	 * @param Model $model
	 */
	public function flush(Model $model)
	{
		$this->cache->forget($this->resourceName . '.email.' . $model->email);
		parent::flush($model);
	}
}