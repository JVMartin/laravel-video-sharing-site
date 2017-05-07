<?php

namespace App\Http\Controllers\User;

use App\Services\BrowseManager;
use App\Repositories\UserRepository;
use App\Repositories\CommentRepository;

class ProfileController
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	/**
	 * @var CommentRepository
	 */
	protected $commentRepository;

	public function __construct(
		UserRepository $userRepository,
		BrowseManager $browseManager,
		CommentRepository $commentRepository
	)
	{
		$this->userRepository = $userRepository;
		$this->browseManager = $browseManager;
		$this->commentRepository = $commentRepository;
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

	public function getComments($username)
	{
		$user = $this->getUser($username);

		return view('users.comments', [
			'user' => $user,
			'comments' => $this->commentRepository->getCommentsProfile($user)
		]);
	}
}
