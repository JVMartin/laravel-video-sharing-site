@extends('emails.template')

@section('content')
	<p>
		You are receiving this email because we received a password reset request for your account.
	</p>
	<p>
		Use the button below to reset your password.
	</p>
	<p>
		@include('emails.partials.button', [
			'link' => $link,
			'text' => 'Reset My Password'
		])
	</p>
	<p>
		Or copy and paste this link into your browser:
	</p>
	<p>
		{!! $link !!}
	</p>
	<p>
		If you did not request a password reset, no further action is required.
	</p>
	<p>
		Thank you.
	</p>
@stop