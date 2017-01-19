<?php

namespace App\Mail;

use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class VerificationEmail extends Mailable implements ShouldQueue
{
	use Queueable, SerializesModels;

	/**
	 * @var User
	 */
	public $user;

	/**
	 * @var string
	 */
	public $token;

	/**
	 * @var string
	 */
	public $link;

	public function __construct(User $user, $token)
	{
		$this->user = $user;
		$this->token = $token;

		$this->link = route('verify', ['token' => $token]);
	}

	/**
	 * Build the message.
	 *
	 * @return $this
	 */
	public function build()
	{
		return $this->subject('Verify Your Email')
			->view('emails.verify');
	}
}
