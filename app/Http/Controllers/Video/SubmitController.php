<?php

namespace App\Http\Controllers\Video;

use Auth;
use Illuminate\Http\Request;
use App\Services\VideoManager;
use App\Http\Controllers\Controller;
use App\Repositories\VideoRepository;
use App\Repositories\SubmissionRepository;
use App\Http\RequestValidators\VideoSubmissionDetailsValidator;

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

	/**
	 * @var VideoSubmissionDetailsValidator
	 */
	protected $submissionValidator;

	public function __construct(
		VideoManager $videoManager,
		VideoRepository $videoRepository,
		SubmissionRepository $submissionRepository,
		VideoSubmissionDetailsValidator $submissionValidator
	)
	{
		$this->middleware('auth');

		$this->videoManager = $videoManager;
		$this->videoRepository = $videoRepository;
		$this->submissionRepository = $submissionRepository;
		$this->submissionValidator = $submissionValidator;
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
	 * @param string $hashid
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function getSubmitDetails($hashid)
	{
		$video = $this->videoRepository->getByHashId($hashid);

		if ( ! $video) {
			return redirect()->route('video.submit.url');
		}

		return view('video.submit.get-details', [
			'video' => $video
		]);
	}

	/**
	 * @param Request $request
	 * @param string $hashid
	 * @return \Illuminate\Http\RedirectResponse
	 */
	public function postSubmitDetails(Request $request, $hashid)
	{
		$video = $this->videoRepository->getByHashId($hashid);

		if ( ! $video) {
			return redirect()->route('video.submit.url');
		}

		$this->submissionValidator->validateRequest($request);

		// @TODO:
		// Ensure that users can't make duplicate submissions...
		// Perhaps just within a given time frame?

		$submission = $this->submissionRepository->create([
			'video_id' => $video->id,
			'user_id' => Auth::user()->id,
			'title' => $request->title,
			'tags' => $request->tags,
			'description' => $request->description
		]);

		// Automatically updoot our own submission.
		$submission->votes()->create([
			'user_id' => Auth::user()->id,
			'up' => 1,
		]);

		successMessage('Nice - your submission is now live!');
		return redirect($submission->url());
	}
}
