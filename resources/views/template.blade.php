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

	<link href="{{ elixir("css/app.css") }}" rel="stylesheet">
	@yield('css')
</head>
<body>
	@include('partials.header')
	<div id="master" class="row column">
		@include('partials.messages')
		@yield('content')
	</div>
	@if (Auth::guest())
		@include('modals.sign-in')
		@include('modals.forgot-password')
	@endif
	<script src="{{ elixir("js/app.js") }}"></script>
	@yield('js')
</body>
</html>
