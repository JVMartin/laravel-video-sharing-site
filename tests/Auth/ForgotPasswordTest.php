<?php

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

		$this->postJson(route('forgot-password'), [
				'email' => $user->email
			])
			->assertResponseStatus(200);

		$this->seeInDatabase('password_resets', [
			'email' => $user->email
		]);

		Mail::assertSentTo($user->email, ResetPasswordLinkEmail::class);

		Mail::assertSent(ResetPasswordLinkEmail::class, function ($mail) use (&$resetPasswordLink) {
			$resetPasswordLink = $mail->link;
			return true;
		});

		$this->visit($resetPasswordLink)
			->seePageIs(route('account.password'))
			->type($newPass, 'password')
			->type($newPass, 'password_confirmation')
			->press('Change Password')
			->see('Your password has been changed.');

		$this->dontSeeInDatabase('password_resets', [
			'email' => $user->email
		]);
	}
}
