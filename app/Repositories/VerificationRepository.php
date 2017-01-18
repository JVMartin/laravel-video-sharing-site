<?php

namespace App\Repositories;

use Carbon\Carbon;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class VerificationRepository extends BaseRepository
{
	public function create($userId)
	{
		return DB::table('verifications')->insert([
			'user_id' => $userId,
			'token' => $this->generateToken(),
			'created_at' => Carbon::now()
		]);
	}

	private function generateToken()
	{
		return hash_hmac('sha256', Str::random(40), config('app.key'));
	}
}