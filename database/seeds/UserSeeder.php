<?php

use Illuminate\Database\Seeder;
use App\Repositories\UserRepository;

class UserSeeder extends Seeder
{
	/**
	 * @var UserRepository
	 */
	protected $userRepository;

	public function __construct(UserRepository $userRepository)
	{
		$this->userRepository = $userRepository;
	}

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		$this->userRepository->create([
			'email' => 'user@test.com',
			'password' => 'test12'
		]);

		$this->userRepository->create([
			'email' => 'social@test.com'
		]);
	}
}
