<?php

namespace App\Http\Controllers\Video;

use App\Services\BrowseManager;
use App\Http\Controllers\Controller;

class BrowseController extends Controller
{
	/**
	 * @var BrowseManager
	 */
	protected $browseManager;

	public function __construct(BrowseManager $browseManager)
	{
		$this->browseManager = $browseManager;
	}

	/**
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getHome()
	{
		return view('video.browse', [
			'submissions' => $this->browseManager->home()
		]);
	}

	public function getByTag($tagSlug)
	{
		dd($tagSlug);
	}
}
