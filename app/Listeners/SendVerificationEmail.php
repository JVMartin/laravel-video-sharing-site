<?php

namespace App\Listeners;

use Mail;
use Illuminate\Auth\Events\Registered;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendVerificationEmail
{
	/**
	 * Handle the event.
	 *
	 * @param  Registered  $event
	 * @return void
	 */
	public function handle(Registered $event)
	{
		Mail::to($event->user->email)
			->send();
	}
}
