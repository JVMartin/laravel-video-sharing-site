<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class ResetPasswordLinkEmail extends Mailable implements ShouldQueue
{
	use Queueable, SerializesModels;

	/**
	 * @var string
	 */
	public $hashid;

	/**
	 * @var string
	 */
	public $token;

	/**
	 * @var string
	 */
	public $link;

	public function __construct($hashid, $token)
	{
		$this->hashid = $hashid;
		$this->token = $token;
		$this->link = route('forgot-password.link', [$hashid, $token]);
	}

	/**
	 * Build the message.
	 *
	 * @return $this
	 */
	public function build()
	{
		return $this->subject('Password Reset Instructions')
			->view('emails.password-reset');
	}
}
