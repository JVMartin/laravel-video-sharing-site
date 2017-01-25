<?php

namespace App\Events;

use App\Models\User;
use Illuminate\Queue\SerializesModels;

class EmailRequiresVerification
{
    use SerializesModels;

	/**
	 * @var User
	 */
    public $user;

    public function __construct(User $user)
    {
        $this->user = $user;
    }
}
