<?php

namespace Tests;

use Laravel\Dusk\TestCase as BaseTestCase;
use Facebook\WebDriver\Remote\RemoteWebDriver;
use Facebook\WebDriver\Remote\DesiredCapabilities;

abstract class DuskTestCase extends BaseTestCase
{
	use CreatesApplication;

	/**
	 * Prepare for Dusk test execution.
	 *
	 * @beforeClass
	 * @return void
	 */
	public static function prepare()
	{
		static::startChromeDriver();
	}

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
		exec('sudo git clean -fxd ' . storage_path('framework/cache'));
		exec('sudo git clean -fxd ' . storage_path('framework/sessions'));
	}

	/**
	 * Create the RemoteWebDriver instance.
	 *
	 * @return \Facebook\WebDriver\Remote\RemoteWebDriver
	 */
	protected function driver()
	{
		return RemoteWebDriver::create(
			'http://localhost:9515', DesiredCapabilities::chrome()
		);
	}
}
