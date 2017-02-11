<?php

namespace Tests\Feature\Auth;

use Mail;
use Tests\TestCase;
use App\Models\User;
use App\Mail\ResetPasswordLinkEmail;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class ForgotPasswordTest extends TestCase
{
	public function testForgotPasswordFlow()
	{
		Mail::fake();

		$user = User::where('email', 'user@test.com')->first();
		$newPass = 'testiepoo';

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

//		$this->visit($resetPasswordLink)
//			->seePageIs(route('account.password'))
//			->type($newPass, 'password')
//			->type($newPass, 'password_confirmation')
//			->press('Change Password')
//			->assertSee('Your password has been changed.');

		// Ensure that invalid links give a helpful message.
//		$this->visit($resetPasswordLink)
//			->seePageIs(route('home'))
//			->assertSee('The link you used is expired or malformed.');
	}
}
