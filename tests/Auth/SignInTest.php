<?php

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class SignInTest extends TestCase
{
	public function testLoginMissingFields()
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

	public function testLoginInvalidCredentials()
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
