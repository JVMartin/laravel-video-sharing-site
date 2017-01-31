<?php

namespace App\Repositories;

use DB;
use App\Models\User;
use Illuminate\Cache\Repository;
use Illuminate\Database\Eloquent\Model;
use App\Events\EmailRequiresVerification;

class UserRepository extends ModelRepository
{
	public function __construct(Repository $cache)
	{
		parent::__construct($cache, new User);
	}

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
	 * @param User $user
	 * @param array $attributes
	 * @return void
	 */
	public function update(User $user, array $attributes)
	{
		$emailRequiresVerification = false;

		if (array_key_exists('email', $attributes)) {
			$attributes['email'] = strtolower($attributes['email']);

			// If the user is updating their email, we will want to send them a verification email.
			if ($user->email !== $attributes['email']) {
				$emailRequiresVerification = true;
			}
		}
		if (array_key_exists('password', $attributes)) {
			$attributes['password'] = bcrypt($attributes['password']);
			$attributes['remember_token'] = str_random(60);
		}

		$user->update($attributes);
		$this->flush($user);

		if ($emailRequiresVerification) {
			event(new EmailRequiresVerification($user));
		}
	}

	/**
	 * @param array $attributes
	 * @return Model|User
	 */
	public function create(array $attributes = [])
	{
		// Hash their password.
		if (array_key_exists('password', $attributes)) {
			$attributes['password'] = bcrypt($attributes['password']);
		}

		// Ensure their email is lowercase.
		$attributes['email'] = strtolower($attributes['email']);

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
	 * @param Model|User $model
	 */
	public function flush(Model $model)
	{
		$this->cache->forget($this->resourceName . '.email.' . $model->email);
		parent::flush($model);
	}
}