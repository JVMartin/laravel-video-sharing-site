<?php

namespace App\Listeners;

use Mail;
use App\Mail\VerificationEmail;
use App\Events\EmailRequiresVerification;
use App\Repositories\VerificationRepository;

class SendVerificationEmail // Should NOT be queued, must create verification row same request!
{
	/**
	 * @var VerificationRepository
	 */
	protected $verificationRepository;

	public function __construct(VerificationRepository $verificationRepository)
	{
		$this->verificationRepository = $verificationRepository;
	}

	/**
	 * Handle the event.
	 *
	 * @param  EmailRequiresVerification  $event
	 * @return void
	 */
	public function handle(EmailRequiresVerification $event)
	{
		$user = $event->user;
		$verification = $this->verificationRepository->createOrRegenerate($user->id);
		Mail::to($user->email)
			->send(new VerificationEmail($user, $verification->token));
	}
}
