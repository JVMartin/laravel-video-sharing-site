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
		$response->assertStatus(200);

		$this->assertDatabaseHas('password_resets', [
			'email' => $user->email
		]);

		Mail::assertSent(ResetPasswordLinkEmail::class, function ($mail) use (&$to, &$resetPasswordLink) {
			$to = $mail->to;
			$resetPasswordLink = $mail->link;
			return true;
		});

		$this->assertEquals($to[0]['address'], $user->email);

		$response = $this->get($resetPasswordLink);
		dd($response);
		$response->assertRedirect(route('account.password', [], false));

		$response = $this->get($resetPasswordLink);
		$response->assertStatus(200);

		$this->visit($resetPasswordLink)
			->seePageIs(route('account.password'))
			->type($newPass, 'password')
			->type($newPass, 'password_confirmation')
			->press('Change Password')
			->assertSee('Your password has been changed.');

		// Ensure the reset is "used up".
		$this->dontSeeInDatabase('password_resets', [
			'email' => $user->email
		]);

		// Test the new password.
		$this->postJson(route('sign-in.email'), [
				'email' => $user->email,
				'password' => $newPass
			])
			->assertResponseStatus(200)
			->seeJson([
				'refresh'
			]);

		// Sign out again.
		$this->visit(route('sign-out'));

		// Ensure that invalid links give a helpful message.
		$this->visit($resetPasswordLink)
			->seePageIs(route('home'))
			->assertSee('The link you used is expired or malformed.');
	}
}
