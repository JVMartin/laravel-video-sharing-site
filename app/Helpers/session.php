<?php

use Illuminate\Support\MessageBag;

/**
 * @param string|array $messages
 */
function successMessage($messages)
{
	// Handle an array of messages.
	if (is_array($messages)) {
		foreach ($messages as $message) {
			successMessage($message);
		}
		return;
	}

	// Must be a single message.
	$message = $messages;

	$bag = session()->get('successes');
	if ( ! $bag instanceof MessageBag) {
		$bag = new MessageBag();
	}

	$bag->add('messages', $message);

	session()->flash('successes', $bag);
}