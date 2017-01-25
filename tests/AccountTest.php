<?php

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

		$firstName = $generator->firstName;
		$lastName = $generator->lastName;

		$this->actingAs($normalUser)
			->visit(route('account.basics'))
			->see('<h3>Email</h3>')
			->see('user@test.com')
			->see('Your email has been verified.')
			->type($firstName, 'first_name')
			->type($lastName, 'last_name')
			->press('Save')
			->seePageIs(route('account.basics'))
			->see('Your account has been updated.')
			->see($firstName)
			->see($lastName);
	}

	public function testAccountSocialUser()
	{
		$socialUser = User::where('email', 'social@test.com')->first();

		$this->actingAs($socialUser)
			->visit(route('account.basics'))
			->dontSee('<h3>Email</h3>')
			->dontSee('social@test.com');
	}
}
