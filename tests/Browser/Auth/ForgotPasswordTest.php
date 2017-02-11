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
				->waitForText(trans('auth.forgot-pass.email-sent'));
		});

		Mail::assertSent(ResetPasswordLinkEmail::class);
	}
}
