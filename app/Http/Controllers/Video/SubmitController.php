<?php

namespace App\Http\Controllers\Video;

use Illuminate\Http\Request;
use App\Services\VideoManager;
use App\Http\Controllers\Controller;

class SubmitController extends Controller
{
	/**
	 * @var VideoManager
	 */
	protected $videoManager;

	public function __construct(VideoManager $videoManager)
	{
		$this->middleware('auth');

		$this->videoManager = $videoManager;
	}

	public function getSubmit(Request $request)
	{
		$youtube_id = $request->v;

		if (strlen($youtube_id) !== 11) {
			return view('video.submit.get-code');
		}

		return view('video.submit.get-details');
	}

	public function postSubmitCode(Request $request)
	{
		$this->validate($request, [
			'youtube_url' => 'required|min:11'
		]);

		$youtube_id = $this->videoManager->extractYoutubeId($request->youtube_url);

		if (strlen($youtube_id) !== 11) {
			return redirect()->route('video.submit')
				->withErrors(['youtube_url' => 'This doesn\'t appear to be a valid YouTube url.']);
		}

		$video = $this->videoManager->importVideoIfNotExists($youtube_id);

		if ( ! $video) {
			return redirect()->route('video.submit')
				->withErrors(['youtube_url' => 'This video does not allow embedding.  :(']);
		}

		return redirect()->route('video.submit', ['v' => $youtube_id]);
	}

	public function getDetails(Request $request)
	{

	}
}
