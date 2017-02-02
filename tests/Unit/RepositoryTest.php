<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Repositories\UserRepository;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class RepositoryTest extends TestCase
{
	public function testRepository()
	{
		$repo = app(UserRepository::class);
		$email = 'jack@test.com';

		$this->assertInstanceOf(UserRepository::class, $repo);

		$this->assertNull($repo->getByEmail($email));
		$repo->create([
			'email' => $email
		]);

		$user = $repo->getByEmail($email);
		$this->assertEquals($user->email, $email);
	}
}
