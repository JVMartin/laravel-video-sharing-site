<?php

abstract class TestCase extends Illuminate\Foundation\Testing\TestCase
{
	/**
	 * The base URL to use while testing the application.
	 *
	 * @var string
	 */
	protected $baseUrl = 'http://localhost';

	/**
	 * Set up our testing environment
	 *
	 * @return void
	 */
	public function setUp()
	{
		parent::setUp();

		// Reset the sqlite testing database
		// http://www.chrisduell.com/blog/development/speeding-up-unit-tests-in-php/
		copy(database_path('prepared.sqlite'), database_path('database.sqlite'));
	}

	/**
	 * Creates the application.
	 *
	 * @return \Illuminate\Foundation\Application
	 */
	public function createApplication()
	{
		$app = require __DIR__.'/../bootstrap/app.php';

		$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

		return $app;
	}
}
