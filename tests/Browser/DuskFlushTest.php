<?php

namespace Tests\Browser;

use Tests\DuskTestCase;
use App\Repositories\UserRepository;

class DuskFlushTest extends DuskTestCase
{
	public function testCreateUser()
	{
		$repository = $this->app->make(UserRepository::class);
		$repository->create([
			'email' => 'blah@blah.com'
		]);

		$this->assertNotEmpty($repository->getByEmail('blah@blah.com'));
	}

	public function testNotCreateUser()
	{
		$repository = $this->app->make(UserRepository::class);

		$this->assertEmpty($repository->getByEmail('blah@blah.com'));
	}
}
