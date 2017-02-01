<?php

namespace App\Http\Controllers\Video;

use Auth;
use Illuminate\Http\Request;
use App\Services\VideoManager;
use App\Http\Controllers\Controller;
use App\Repositories\VideoRepository;
use App\Repositories\SubmissionRepository;

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

	/**
	 * @var SubmissionRepository
	 */
	protected $submissionRepository;

	public function __construct(
		VideoManager $videoManager,
		VideoRepository $videoRepository,
		SubmissionRepository $submissionRepository
	)
	{
		$this->middleware('auth');

		$this->videoManager = $videoManager;
		$this->videoRepository = $videoRepository;
		$this->submissionRepository = $submissionRepository;
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
				->withInput()
				->withErrors(['youtube_url' => 'This doesn\'t appear to be a valid YouTube url.']);
		}

		$video = $this->videoManager->importVideoIfNotExists($youtube_id);

		if ( ! $video) {
			return redirect()->route('video.submit.url')
				->withInput()
				->withErrors(['youtube_url' => 'YouTube will not let us use this video at this time.']);
		}

		// Proceed on to get the details.
		return redirect()->route('video.submit.details', $video->hash);
	}

	/**
	 * @param string $hashId
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getSubmitDetails($hashId)
	{
		$video = $this->videoRepository->getByHashId($hashId);

		if ( ! $video) {
			return redirect()->route('video.submit.url');
		}

		return view('video.submit.get-details', [
			'video' => $video
		]);
	}

	/**
	 * @param Request $request
	 * @param string $hashId
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function postSubmitDetails(Request $request, $hashId)
	{
		$video = $this->videoRepository->getByHashId($hashId);

		if ( ! $video) {
			return redirect()->route('video.submit.url');
		}

		$this->validate($request, [
			'title' => 'required'
		]);

		// @TODO:
		// Ensure that users can't make duplicate submissions...
		// Perhaps just within a given time frame?

		$submission = $this->submissionRepository->create([
			'video_id' => $video->id,
			'user_id' => Auth::user()->id,
			'title' => strip_tags($request->title),
			'description' => $request->description
		]);

		dd($submission);
	}
}
