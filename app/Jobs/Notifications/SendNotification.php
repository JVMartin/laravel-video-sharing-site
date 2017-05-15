<?php

namespace App\Jobs\Notifications;

use App\Models\User;
use App\Models\Notification;
use Illuminate\Bus\Queueable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;

class SendNotification implements ShouldQueue
{
	use InteractsWithQueue, Queueable, SerializesModels;

	/**
	 * @param User $user
	 * @param $notifiable
	 * @param string $type
	 * @return Notification
	 */
	protected function getNotification($user, $notifiable, $type)
	{
		$notification = $user->notifications()
			->where('notifiable_id', $notifiable->id)
			->where('notifiable_type', get_class($notifiable))
			->where('type', $type)
			->first();

		if ( ! $notification) {
			$notification = $user->notifications()->create([
				'notifiable_id' => $notifiable->id,
				'notifiable_type' => get_class($notifiable),
				'type' => $type
			]);
		}

		return $notification;
	}
}
