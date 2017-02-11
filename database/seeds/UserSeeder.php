<?php

use Illuminate\Database\Seeder;
use App\Repositories\UserRepository;
use App\Repositories\VerificationRepository;

class UserSeeder extends Seeder
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	/**
	 * @var VerificationRepository
	 */
	protected $verificationRepository;

	public function __construct(
		UserRepository $userRepository,
		VerificationRepository $verificationRepository
	)
	{
		$this->userRepository = $userRepository;
		$this->verificationRepository = $verificationRepository;
	}

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		// "Normal" user.
		$this->userRepository->create([
			'email' => 'user@test.com',
			'password' => 'test12'
		]);

		// Another "normal" user.
		$this->userRepository->create([
			'email' => 'user2@test.com',
			'password' => 'test12'
		]);

		// Social authentication user.
		$this->userRepository->create([
			'email' => 'social@test.com'
		]);

		// "Normal" user with unverified email address.
		$user = $this->userRepository->create([
			'email' => 'unverified@test.com',
			'password' => 'test12'
		]);
		$this->verificationRepository->createOrRegenerate($user->id);
	}
}
