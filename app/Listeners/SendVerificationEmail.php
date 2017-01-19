<?php

namespace App\Listeners;

use Mail;
use App\Mail\VerificationEmail;
use Illuminate\Auth\Events\Registered;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use App\Repositories\VerificationRepository;

class SendVerificationEmail
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
	 * @param  Registered $event
	 * @return void
	 */
	public function handle(Registered $event)
	{
		// Create the verification.
		$verification = $this->verificationRepository->createOrRegenerate($event->user->id);

		Mail::to($event->user->email)
			->send(new VerificationEmail($event->user, $verification->token));
	}
}
