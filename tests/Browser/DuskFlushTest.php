<?php

namespace Tests\Browser;

use Tests\DuskTestCase;
use App\Repositories\UserRepository;

class DuskFlushTest extends DuskTestCase
{
	// Let's ensure the fix command gets ran after all the tests are done.
	public function testRunFixAfter()
	{
		register_shutdown_function(function() {
			passthru(base_path('fix.sh'));
		});
	}

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
