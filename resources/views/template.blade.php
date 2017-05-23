<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="/favicon.ico">

	@yield('meta')
	<meta property="og:title" content="@yield('title')">
	<meta property="og:url" content="{{ Request::url() }}">

	<title>@yield('title') | {{ config('app.name') }}</title>

	<link href="{{ mix('css/app.css') }}" rel="stylesheet">
	@yield('css')
</head>
<body>
	@include('_header')
	<div id="master" class="row column">
		@include('_messages')
		@yield('content')
	</div>
	@if (Auth::guest())
		@include('modals.sign-in')
		@include('modals.forgot-password')
	@endif
	<script>
		window.data = {
			csrfToken: '{{ csrf_token() }}',
			user: {!! (Auth::check()) ? json_encode(Auth::user()->toArray()) : 'null' !!},
		};

		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
				(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
			m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

		ga('create', 'UA-99773341-1', 'auto');
		ga('send', 'pageview');
	</script>
	@yield('js')
	<script src="{{ mix('js/app.js') }}"></script>
</body>
</html>
