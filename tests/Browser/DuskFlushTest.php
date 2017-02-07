<?php

namespace Tests\Browser;

use Tests\DuskTestCase;
use App\Repositories\UserRepository;

class DuskFlushTest extends DuskTestCase
{
	// These tests ensure that the cache is flushed after each test.

	public function testCreateUser()
	{
		$repository = app(UserRepository::class);
		$repository->create([
			'email' => 'blah@blah.com'
		]);

		$this->assertNotEmpty($repository->getByEmail('blah@blah.com'));
	}

	public function testNotCreateUser()
	{
		$repository = app(UserRepository::class);

		$this->assertEmpty($repository->getByEmail('blah@blah.com'));
	}
}
