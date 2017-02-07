<?php

namespace Tests\Browser;

use App\Models\User;
use Faker\Generator;
use Tests\DuskTestCase;
use Laravel\Dusk\Browser;
use App\Repositories\UserRepository;

class AccountTest extends DuskTestCase
{
	public function testAccountNormalUser()
	{
		$this->browse(function(Browser $browser) {
			$userRepository = $this->app->make(UserRepository::class);

			$user = $userRepository->getByEmail('user@test.com');

			$generator = $this->app->make(Generator::class);

			$email = 'newemail@test.com';
			$firstName = $generator->firstName;
			$lastName = $generator->lastName;

			$browser->loginAs($user)
				->visit(route('account.basics'))
				->assertSee('Email')
				->assertInputValue('email', 'user@test.com')
				->assertSee('Your email has been verified.');
		});
	}
}
