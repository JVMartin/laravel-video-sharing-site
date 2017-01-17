<?php

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class SignInTest extends TestCase
{
	public function testSignInMissingFields()
	{
		$this->postJson(route('sign-in.email'), [
				'email' => '',
				'password' => ''
			])
			->assertResponseStatus(422)
			->seeJson([
				'email' => [trans('validation.required', ['attribute' => 'email'])],
				'password' => [trans('validation.required', ['attribute' => 'password'])],
			]);
	}

	public function testSignInInvalidCredentials()
	{
		$this->postJson(route('sign-in.email'), [
				'email' => 'xxxx@xxx.com',
				'password' => 'xxxxx'
			])
			->assertResponseStatus(422)
			->seeJson([
				trans('auth.sign-in.failure')
			]);
	}
}
