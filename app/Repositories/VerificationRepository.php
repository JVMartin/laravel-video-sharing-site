<?php

namespace App\Repositories;

use Carbon\Carbon;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class VerificationRepository extends BaseRepository
{
	public function create($userId)
	{
		DB::table('verifications')->insert([
			'user_id' => $userId,
			'token' => $this->generateToken(),
			'created_at' => Carbon::now()
		]);

		return $this->get($userId);
	}

	public function get($userId)
	{
		return DB::table('verifications')->where('user_id', $userId)->first();
	}

	private function generateToken()
	{
		return hash_hmac('sha256', Str::random(40), config('app.key'));
	}
}