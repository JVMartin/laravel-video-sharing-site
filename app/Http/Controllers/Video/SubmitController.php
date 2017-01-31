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
		$video_id = $request->v;

		if (strlen($video_id) !== 11) {
			return view('video.submit.get-code');
		}

		return view('video.submit.get-details');
	}

	public function postSubmitCode(Request $request)
	{
		$this->validate($request, [
			'youtube_url' => 'required|min:11'
		]);

		$video_id = $this->videoManager->extractVideoId($request->youtube_url);

		if (strlen($video_id) !== 11) {
			return redirect()->back()
				->withErrors(['youtube_url' => 'This doesn\'t appear to be a valid YouTube url.']);
		}

		return redirect()->route('video.submit', ['v' => $video_id]);
	}

	public function getDetails(Request $request)
	{

	}
}
