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

			$newEmail = 'newemail@test.com';
			$firstName = $generator->firstName;
			$lastName = $generator->lastName;

			// Email is verified.
			$browser->loginAs($user)
				->visit(route('account.basics'))
				->assertSee('Email')
				->assertInputValue('email', 'user@test.com')
				->assertSee('Your email has been verified.');

			// Updating the name works.
			$browser->type('first_name', $firstName)
				->type('last_name', $lastName)
				->press('Save')
				->assertPathIs(route('account.basics', [], false))
				->assertSee('Your account has been updated.')
				->assertInputValue('first_name', $firstName)
				->assertInputValue('last_name', $lastName);

			// Updating the email works.
			$browser->type('email', $newEmail)
				->press('Save')
				->assertPathIs(route('account.basics', [], false))
				->assertSee('Your account has been updated.')
				->assertSee('Your email has not yet been verified.');
		});
	}

	public function testAccountSocialUser()
	{
		$this->browse(function(Browser $browser) {
			$userRepository = $this->app->make(UserRepository::class);

			$user = $userRepository->getByEmail('social@test.com');

			$generator = $this->app->make(Generator::class);

			$newEmail = 'newemail@test.com';
			$firstName = $generator->firstName;
			$lastName = $generator->lastName;

			$browser->loginAs($user)
				->visit(route('account.basics'))
				->assertDontSee('Email')
				->assertDontSee('social@test.com');
		});
	}
}
