<?php

namespace App\Http\Controllers\User;

use App\Services\BrowseManager;
use App\Repositories\UserRepository;

class ProfileController
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	public function __construct(
		UserRepository $userRepository,
		BrowseManager $browseManager
	)
	{
		$this->userRepository = $userRepository;
		$this->browseManager = $browseManager;
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
		$user = $this->getUser($username);

		return view('users.browse', [
			'user' => $user,
			'submissions' => $this->browseManager->user($user)
		]);
	}
}
