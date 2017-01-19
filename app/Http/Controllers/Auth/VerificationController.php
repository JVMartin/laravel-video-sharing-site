<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Services\AuthManager;
use App\Http\Controllers\Controller;

class VerificationController extends Controller
{
	/**
	 * @var AuthManager
	 */
	protected $authManager;

	public function __construct(AuthManager $authManager)
	{
		$this->authManager = $authManager;
	}

	public function getVerify(Request $request)
	{
		return $request->token;
	}
}
