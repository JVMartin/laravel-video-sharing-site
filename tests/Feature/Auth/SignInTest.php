<?php

namespace Tests\Feature\Auth;

use Tests\TestCase;

class SignInTest extends TestCase
{
	public function testSignInMissingFields()
	{
		$response = $this->postJson(route('sign-in.email'), [
				'email' => '',
				'password' => ''
			]);
		$response->assertStatus(422)
			->assertJson([
				'email' => [trans('validation.required', ['attribute' => 'email'])],
				'password' => [trans('validation.required', ['attribute' => 'password'])],
			]);
	}

	public function testSignInInvalidCredentials()
	{
		$response = $this->postJson(route('sign-in.email'), [
				'email' => 'xxxx@xxx.com',
				'password' => 'xxxxx'
			]);
		$response->assertStatus(422)
			->assertJson([
				trans('auth.sign-in.failure')
			]);
	}

	public function testSignInValidCredentials()
	{
		$response = $this->postJson(route('sign-in.email'), [
				'email' => 'user@test.com',
				'password' => 'test12'
			]);
		$response->assertStatus(200)
			->assertExactJson([
				'refresh'
			]);
	}
}
