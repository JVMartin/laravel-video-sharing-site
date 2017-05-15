<?php

namespace App\Http\Controllers\User;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Repositories\UserRepository;

class FollowController
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	public function __construct(
		UserRepository $userRepository
	)
	{
		$this->middleware('auth');

		$this->userRepository = $userRepository;
	}

	public function postFollow(Request $request, $hashid)
	{
		$user = $this->userRepository->getByHashId($hashid);

		if ( ! $user) {
			return new JsonResponse('That user no longer exists.', 422);
		}

		return new JsonResponse();
	}
}
