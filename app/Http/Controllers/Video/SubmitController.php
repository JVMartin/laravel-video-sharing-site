<?php

namespace App\Http\Controllers\Video;

use Illuminate\Http\Request;
use App\Services\VideoManager;
use App\Http\Controllers\Controller;
use App\Repositories\VideoRepository;

class SubmitController extends Controller
{
	/**
	 * @var VideoManager
	 */
	protected $videoManager;

	/**
	 * @var VideoRepository
	 */
	protected $videoRepository;

	public function __construct(VideoManager $videoManager, VideoRepository $videoRepository)
	{
		$this->middleware('auth');

		$this->videoManager = $videoManager;
		$this->videoRepository = $videoRepository;
	}

	/**
	 * @return \Illuminate\Contracts\View\Factory|\Illuminate\View\View
	 */
	public function getSubmitUrl()
	{
		return view('video.submit.get-url');
	}

	/**
	 * @param Request $request
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function postSubmitUrl(Request $request)
	{
		$this->validate($request, [
			'youtube_url' => 'required|min:11'
		]);

		$youtube_id = $this->videoManager->extractYoutubeId($request->youtube_url);

		if (strlen($youtube_id) !== 11) {
			return redirect()->route('video.submit.url')
				->withErrors(['youtube_url' => 'This doesn\'t appear to be a valid YouTube url.']);
		}

		$video = $this->videoManager->importVideoIfNotExists($youtube_id);

		if ( ! $video) {
			return redirect()->route('video.submit.url')
				->withErrors(['youtube_url' => 'YouTube will not let us use this video at this time.']);
		}

		// Proceed on to get the details.
		return redirect()->route('video.submit.details', [$video->hash]);
	}

	/**
	 * @param string $hashId
	 */
	public function getSubmitDetails($hashId)
	{
		$video = $this->videoRepository->getByHashId($hashId);

		if ( ! $video) {
			return redirect()->route('video.submit.url');
		}

		dd($video);
	}
}
