<?php

namespace Tests\Feature\Auth;

use Tests\TestCase;
use App\Models\User;
use App\Mail\VerificationEmail;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class RegistrationTest extends TestCase
{
	public function testRegisterBadFields()
	{
		$this->postJson(route('register'), [
				'email' => '',
				'password' => 'abc'
			])
			->assertResponseStatus(422)
			->seeJson([
				'email' => [trans('validation.required', ['attribute' => 'email'])],
				'password' => [trans('validation.min.string', ['attribute' => 'password', 'min' => 6])],
			]);
	}

	public function testRegistrationAndVerificationFlow()
	{
		Mail::fake();

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
			->assertSee(trans('auth.verify.success'));

		// Ensure the user is now verified.
		$this->dontSeeInDatabase('verifications', [
			'user_id' => $user->id
		]);
	}
}
