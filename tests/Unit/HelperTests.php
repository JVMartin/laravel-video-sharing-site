<?php

namespace Tests\Unit;

use Tests\TestCase;
use Illuminate\Foundation\Testing\DatabaseMigrations;
use Illuminate\Foundation\Testing\DatabaseTransactions;

class HelperTests extends TestCase
{
	public function testStripUnsafeTags()
	{
		// Make sure good tags remain.
		$before = '<p>Hello!</p>';

		$after = stripUnsafeTags($before);

		$this->assertContains('<p>Hello!</p>', $after);

		// Make sure bad tags do not remain.
		$before = '<p>Hello!</p><script>badness</script>';

		$after = stripUnsafeTags($before);

		$this->assertContains('<p>Hello!</p>', $after);
		$this->assertNotContains('<script>', $after);
	}
}
