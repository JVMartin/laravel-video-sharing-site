<?php

namespace Tests\Browser\Auth;

use Mail;
use Faker\Generator;
use Tests\DuskTestCase;
use Laravel\Dusk\Browser;
use Tests\Browser\Pages\HomePage;
use App\Repositories\UserRepository;

class SignInTest extends DuskTestCase
{
	/**
	 * @group test
	 */
	public function testSignInMissingFields()
	{
		$this->browse(function(Browser $browser) {
			$browser->visit(new HomePage)
				->clickLink('Sign In')
				->press('Sign In')
				->waitForText(trans('validation.required', ['attribute' => 'email']))
				->assertSee(trans('validation.required', ['attribute' => 'password']));
//			->type('@sign-in-email', 'user@test.com')
//				->type('@sign-in-password', 'test12')
		});
	}

	/**
	 * @group test
	 */
	public function testSignInInvalidCredentials()
	{
		$this->browse(function(Browser $browser) {
			$browser->visit(new HomePage)
				->clickLink('Sign In')
				->type('@sign-in-email', 'xxxx@xxx.com')
				->type('@sign-in-password', 'xxxxx')
				->press('Sign In')
				->waitForText(trans('auth.sign-in.failure'));
		});
	}

	/**
	 * @group test
	 */
	public function testSignInValidCredentials()
	{
		$this->browse(function(Browser $browser) {
			$browser->visit(new HomePage)
				->clickLink('Sign In')
				->type('@sign-in-email', 'user@test.com')
				->type('@sign-in-password', 'test12')
				->press('Sign In')
				->waitForText(trans('auth.sign-in.success'));
		});
	}

	public function testAccountNormalUser()
	{
		$this->browse(function(Browser $browser) {
			$userRepository = $this->app->make(UserRepository::class);

			$normalUser = $userRepository->getByEmail('user@test.com');

			$generator = $this->app->make(Generator::class);

			$newEmail = 'newemail@test.com';
			$firstName = $generator->firstName;
			$lastName = $generator->lastName;

			// Email is verified.
			$browser->loginAs($normalUser)
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

			$socialUser = $userRepository->getByEmail('social@test.com');

			$browser->loginAs($socialUser)
				->visit(route('account.basics'))
				->assertDontSee('Email')
				->assertDontSee('social@test.com');
		});
	}

	public function testAccountUnverifiedUser()
	{
		$this->browse(function(Browser $browser) {
			$userRepository = $this->app->make(UserRepository::class);

			$unverifiedUser = $userRepository->getByEmail('unverified@test.com');

			$browser->loginAs($unverifiedUser)
				->visit(route('account.basics'))
				->assertSee('Email')
				->assertInputValue('email', $unverifiedUser->email)
				->assertSee('Your email has not yet been verified.');
		});
	}
}
