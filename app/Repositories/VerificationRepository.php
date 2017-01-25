<?php

namespace App\Repositories;

use Carbon\Carbon;
use Illuminate\Cache\Repository;
use Illuminate\Database\Connection;

class VerificationRepository extends BaseRepository
{
	/**
	 * @var Connection
	 */
	protected $db;

	public function __construct(Repository $cache, Connection $db)
	{
		parent::__construct($cache);

		$this->db = $db;
	}

	/**
	 * @param int $userId The user's id.
	 * @return array|null|\stdClass The verification object.
	 */
	public function createOrRegenerate($userId)
	{
		$verification = $this->get($userId);

		if ($verification) {
			$this->db->table('verifications')->where('user_id', $userId)
				->update([
					'token' => $this->generateToken(),
					'created_at' => Carbon::now()
				]);
		}
		else {
			$this->db->table('verifications')->insert([
				'user_id' => $userId,
				'token' => $this->generateToken(),
				'created_at' => Carbon::now()
			]);
		}

		return $this->get($userId);
	}

	/**
	 * @param int $userId The user's id.
	 * @return array|null|\stdClass The verification object.
	 */
	public function get($userId)
	{
		return $this->db->table('verifications')->where('user_id', $userId)->first();
	}

	/**
	 * @param string $token The token.
	 * @return array|null|\stdClass The verification object.
	 */
	public function getByToken($token)
	{
		return $this->db->table('verifications')->where('token', $token)->first();
	}

	/**
	 * @param $token
	 */
	public function deleteByToken($token)
	{
		$this->db->table('verifications')->where('token', $token)->delete();
	}

	private function generateToken()
	{
		return hash_hmac('sha256', str_random(40), config('app.key'));
	}

	/**
	 * @param \stdClass $verification The verification object.
	 */
	public function timeUntilDeletion($verification)
	{
		dd($verification->created_at);
	}
}