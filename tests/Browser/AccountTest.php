<?php

namespace Tests\Browser;

use App\Models\User;
use App\Repositories\UserRepository;
use Faker\Generator;
use Tests\DuskTestCase;

class AccountTest extends DuskTestCase
{
	/**
	 * A basic browser test example.
	 *
	 * @return void
	 */
	public function testBasicExample()
	{
		$repository = $this->app->make(UserRepository::class);
		$repository->create([
			'email' => 'blah@blah.com'
		]);

		$this->assertNotEmpty($repository->getByEmail('blah@blah.com'));
	}

	public function testAccountNormalUser()
	{
		$this->browse(function($browser) {
			$normalUser = User::where('email', 'user@test.com')->first();

			$generator = $this->app->make(Generator::class);

			$email = 'newemail@test.com';
			$firstName = $generator->firstName;
			$lastName = $generator->lastName;

//			$browser->loginAs();
		});
	}
}
