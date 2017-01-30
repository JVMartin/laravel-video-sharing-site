<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use Faker\Generator;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class AccountTest extends TestCase
{
	public function testAccountNormalUser()
	{
		$normalUser = User::where('email', 'user@test.com')->first();

		$generator = $this->app->make(Generator::class);

		$email = 'newemail@test.com';
		$firstName = $generator->firstName;
		$lastName = $generator->lastName;

		// Email is verified.
		$this->actingAs($normalUser)
			->visit(route('account.basics'))
			->see('<h3>Email</h3>')
			->see('user@test.com')
			->see('Your email has been verified.');

		// Updating the name.
		$this->type($firstName, 'first_name')
			->type($lastName, 'last_name')
			->press('Save')
			->seePageIs(route('account.basics'))
			->see('Your account has been updated.')
			->see($firstName)
			->see($lastName);

		// Updating the email.
		$this->type($email, 'email')
			->press('Save')
			->seePageIs(route('account.basics'))
			->see('Your account has been updated.')
			->see('Your email has not yet been verified.');
	}

	public function testAccountSocialUser()
	{
		$socialUser = User::where('email', 'social@test.com')->first();

		$this->actingAs($socialUser)
			->visit(route('account.basics'))
			->dontSee('<h3>Email</h3>')
			->dontSee('social@test.com');
	}

	public function testAccountUnverifiedUser()
	{
		$unverifiedUser = User::where('email', 'unverified@test.com')->first();

		// Email is unverified
		$this->actingAs($unverifiedUser)
			->visit(route('account.basics'))
			->see('<h3>Email</h3>')
			->see($unverifiedUser->email)
			->see('Your email has not yet been verified.');
	}
}
