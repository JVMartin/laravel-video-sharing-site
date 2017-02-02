<?php

namespace Tests\Unit;

use Tests\TestCase;
use App\Models\User;
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

		// Make sure the user does not get returned.
		$this->assertNull($repo->getByEmail($email));

		// Create the user and ensure that they do get returned.
		$repo->create([
			'email' => $email
		]);
		$user = $repo->getByEmail($email);
		$this->assertInstanceOf(User::class, $user);
		$this->assertEquals($user->email, $email);

		// Delete the user and ensure that they do not get returned.
		$repo->delete($user);
		$this->assertNull($repo->getByEmail($email));
	}
}
