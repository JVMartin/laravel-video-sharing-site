<?php

namespace Tests\Feature\Auth;

use Mail;
use Tests\TestCase;
use App\Models\User;
use App\Mail\ResetPasswordLinkEmail;

class ForgotPasswordTest extends TestCase
{
	public function testForgotPasswordFlow()
	{
		Mail::fake();

		$user = User::where('email', 'user@test.com')->first();

		$response = $this->postJson(route('forgot-password'), [
				'email' => $user->email
			]);
		$response->assertStatus(200)
			->assertSee(trans('auth.forgot-pass.email-sent'));

		$this->assertDatabaseHas('password_resets', [
			'email' => $user->email
		]);

		Mail::assertSent(ResetPasswordLinkEmail::class, function ($mail) use (&$to, &$resetPasswordLink) {
			$to = $mail->to;
			$resetPasswordLink = $mail->link;
			return true;
		});

		$this->assertEquals($to[0]['address'], $user->email);

		$this->assertDatabaseHas('password_resets', [
			'email' => $user->email
		]);

		// Visit the reset link pulled from the email.
		$response = $this->get($resetPasswordLink);
		$response->assertRedirect(route('account.password', [], false));

		// Follow the redirect.
		$response = $this->get(route('account.password', [], false));
		$response->assertStatus(200)
			->assertSee(trans('auth.forgot-pass.email-used'));

		// Ensure the reset is "used up".
		$this->assertDatabaseMissing('password_resets', [
			'email' => $user->email
		]);

		// Sign out.
		$this->get(route('sign-out', [], false));

		// Try the link again.
		$response = $this->get($resetPasswordLink);
		$response->assertRedirect(route('home', [], false));

		$response = $this->get(route('home', [], false));
		$response->assertStatus(200)
			->assertSee(trans('auth.forgot-pass.invalid-link'));
	}
}
