<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="shortcut icon" href="/favicon.ico">
	<link rel="apple-touch-icon" sizes="57x57" href="/img/icons/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="/img/icons/apple-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="72x72" href="/img/icons/apple-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="76x76" href="/img/icons/apple-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="114x114" href="/img/icons/apple-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="120x120" href="/img/icons/apple-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="144x144" href="/img/icons/apple-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="152x152" href="/img/icons/apple-icon-152x152.png">
	<link rel="apple-touch-icon" sizes="180x180" href="/img/icons/apple-icon-180x180.png">
	<link rel="icon" type="image/png" sizes="192x192" href="/img/icons/android-icon-192x192.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/img/icons/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="96x96" href="/img/icons/favicon-96x96.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/img/icons/favicon-16x16.png">

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
