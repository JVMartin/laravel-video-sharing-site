@extends('emails.template')

@section('content')
	<p>
		Welcome to Site!
	</p>
	<p>
		Please verify your email.
	</p>
	<p>
		@include('emails.partials.button', [
			'link' => $link,
			'text' => 'Verify'
		])
	</p>
	<p>
		Or copy and paste this link into your browser:
	</p>
	<p>
		{!! $link !!}
	</p>
	<p>
		Thank you.
	</p>
@stop