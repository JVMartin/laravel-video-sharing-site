<?php

use App\Models\User;
use App\Mail\VerificationEmail;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class RegistrationTest extends TestCase
{
	public function testForgotPasswordFlow()
	{
		Mail::fake();

		$user = User::where('email', 'user@test.com')->first();

		$this->postJson(route('forgot-password'), [
				'email' => $user->email
			])
			->assertResponseStatus(200);

		$this->seeInDatabase('password_resets', [
			'email' => $user->email
		]);

		Mail::assertSentTo($user->email, Email);



		return;

		$email = 'mrnobody@nowhere.com';
		$pass = 'badpassword';

		// Hit the register route with the account details.
		$this->postJson(route('register'), [
				'email' => $email,
				'password' => $pass
			])
			->assertResponseStatus(200);

		// Grab the new user from the database.
		$user = User::where('email', $email)->first();
		$this->assertNotEmpty($user);

		// Ensure the user is NOT verified.
		$this->seeInDatabase('verifications', [
			'user_id' => $user->id
		]);

		Mail::assertSentTo($email, VerificationEmail::class);

		Mail::assertSent(VerificationEmail::class, function ($mail) use (&$verificationLink) {
			$verificationLink = $mail->link;
			return true;
		});

		// Click the verification link from the email.
		$this->visit($verificationLink)
			->seePageIs(route('home'))
			->see(trans('auth.verify.success'));

		// Ensure the user is now verified.
		$this->dontSeeInDatabase('verifications', [
			'user_id' => $user->id
		]);
	}
}
