<?php

namespace App\Http\Controllers\Video;

use App\Services\BrowseManager;
use Cartalyst\Tags\IlluminateTag;
use App\Http\Controllers\Controller;

class BrowseController extends Controller
{
	/**
	 * @var BrowseManager
	 */
	protected $browseManager;

	public function __construct(BrowseManager $browseManager)
	{
		$this->middleware('auth', [
			'only' => ['getMyFeed'],
		]);

		$this->browseManager = $browseManager;
	}

	/**
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getHome()
	{
		return view('video.browse', [
			'submissions' => $this->browseManager->home(),
		]);
	}

	/**
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getMyFeed()
	{
		return view('video.browse', [
			'submissions' => $this->browseManager->feed(),
		]);
	}

	/**
	 * @param string $tagSlug
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getByTag($tagSlug)
	{
		$tag = IlluminateTag::where('slug', $tagSlug)->first();

		if ( ! $tag) {
			abort(404);
		}

		return view('video.browse', [
			'submissions' => $this->browseManager->byTag($tagSlug),
			'tag' => $tag,
		]);
	}
}
