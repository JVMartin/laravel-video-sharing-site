<?php

namespace Tests\Feature\Auth;

use Mail;
use Tests\TestCase;
use App\Models\User;
use App\Mail\VerificationEmail;

class RegistrationTest extends TestCase
{
	public function testRegisterBadFields()
	{
		$response = $this->postJson(route('register'), [
				'email' => '',
				'password' => 'abc'
			]);
		$response->assertStatus(422)
			->assertJson([
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
		$response = $this->postJson(route('register'), [
				'email' => $email,
				'password' => $pass
			]);
		$response->assertStatus(200);

		// Grab the new user from the database.
		$user = User::where('email', $email)->first();
		$this->assertNotEmpty($user);

		// Ensure the user is NOT verified.
		$this->assertDatabaseHas('verifications', [
			'user_id' => $user->id
		]);

		Mail::assertSent(VerificationEmail::class, function ($mail) use (&$user, &$verificationLink) {
			$this->assertEquals($mail->to[0]['address'], $user->email);
			$verificationLink = $mail->link;
			return true;
		});

		// Click the verification link from the email.
		$response = $this->get($verificationLink);
		$response->assertRedirect(route('home', [], false));

		$response = $this->get(route('home', [], false));
		$response->assertStatus(200)
			->assertSee(trans('auth.verify.success'));

		// Ensure the user is now verified.
		$this->assertDatabaseMissing('verifications', [
			'user_id' => $user->id
		]);
	}
}
