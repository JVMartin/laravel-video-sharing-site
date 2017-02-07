<?php

namespace Tests\Browser\Auth;

use Mail;
use Tests\DuskTestCase;
use Laravel\Dusk\Browser;
use Tests\Browser\Pages\HomePage;
use App\Mail\ResetPasswordLinkEmail;
use App\Repositories\UserRepository;

class ForgotPasswordTest extends DuskTestCase
{
	/**
	 * @group test
	 */
	public function testForgotPasswordFlow()
	{
		Mail::fake();

		$repository = app(UserRepository::class);
		$user = $repository->getByEmail('user@test.com');

		// Use the forgot password form.
		$this->browse(function(Browser $browser) use ($user) {
			$browser->visit(new HomePage)
				->clickLink('Sign In')
				->clickLink('forgot password?')
				->type('@forgot-password-email', $user->email)
				->press('Email Me')
				->waitForText(trans('auth.forgot-pass'));
		});

		Mail::assertSent(ResetPasswordLinkEmail::class);
	}

	public function testSignInMissingFields()
	{
		$this->browse(function(Browser $browser) {
			$browser->visit(new HomePage)
				->clickLink('Sign In')
				->press('Sign In')
				->waitForText(trans('validation.required', ['attribute' => 'email']))
				->assertSee(trans('validation.required', ['attribute' => 'password']));
		});
	}

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
}
