<?php

namespace App\Http\Controllers\User;

use Auth;
use Illuminate\Http\Request;
use App\Services\FollowManager;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use App\Repositories\UserRepository;

class FollowController extends Controller
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	/**
	 * @var FollowManager
	 */
	protected $followManager;

	public function __construct(
		UserRepository $userRepository,
		FollowManager $followManager
	)
	{
		$this->middleware('auth');

		$this->userRepository = $userRepository;
		$this->followManager = $followManager;
	}

	public function postFollow(Request $request, $hashid)
	{
		$leader = $this->userRepository->getByHashId($hashid);

		if ( ! $leader) {
			return new JsonResponse('That user no longer exists.', 422);
		}

		if ($leader->id == Auth::user()->id) {
			return new JsonResponse('What the heck are you doin?', 422);
		}

		$this->followManager->follow($leader, Auth::user(), $request->follow);
		return new JsonResponse();
	}
}
