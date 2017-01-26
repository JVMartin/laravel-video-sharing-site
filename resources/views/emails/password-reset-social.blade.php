@extends('emails.template')

@section('content')
	<p>
		You are receiving this email because we received a password reset request for your account.
	</p>
	<p>
		Your account uses social sign in, either through Google or Facebook.  Therefore, you do not need
		a password to sign in.  Simply use the social buttons at the top of the sign in form.
	</p>
	<p>
		Thank you.
	</p>
@stop
