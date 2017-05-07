<?php

namespace App\Http\Controllers\User;

use App\Repositories\UserRepository;

class ProfileController
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	public function __construct(UserRepository $userRepository)
	{
		$this->userRepository = $userRepository;
	}

	protected function getUser($username)
	{
		$user = $this->userRepository->getByUsername($username);

		if ( ! $user) {
			abort(404);
		}

		return $user;
	}

	public function getIndex($username)
	{
		return redirect()->route('user.profile.submissions', $username);
	}

	public function getSubmissions($username)
	{
		$this->getUser($username);
	}
}
