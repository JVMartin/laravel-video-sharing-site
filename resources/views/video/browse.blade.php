@extends('template')

@section('title', 'Browse')

@section('content')
	<section id="videoBrowse">
		@if ( ! Auth::check() && Request::is('/') && ! Request::fullUrlIs('*?*'))
			<div class="text-center">
				<h2>Welcome to One More Video!</h2>
				<p>This is a video sharing community where we share and talk about our favorite videos.</p>
				<p>
					<a data-open="modalsSignIn">Sign in or register</a>
					to post some videos, or feel free to browse user submissions below!
				</p>
			</div>
		@endif
		@if (isset($tag))
			<div class="row column">
				<h4>Showing videos tagged "{{ $tag->name }}"...</h4>
			</div>
		@elseif (Auth::check())
			<ul class="menu topMenu">
				<li class="{{ Request::route()->getName() == 'home' ? 'active' : '' }}">
					<a href="{{ route('home') }}">
						The Unwashed Masses
					</a>
				</li>
				<li class="{{ Request::route()->getName() == 'feed' ? 'active' : '' }}">
					<a href="{{ route('feed') }}">
						My Personal Feed
					</a>
				</li>
			</ul>
		@endif
		@if ( ! $submissions->count())
			@if (Request::route()->getName() == 'feed')
				@if (Auth::user()->leaders()->count())
					<div class="row column">
						<div class="callout default">
							Nobody you are following has made any submissions.
						</div>
					</div>
				@else
					<div class="row column">
						<div class="callout default">
							You aren't following anybody yet.
						</div>
					</div>
				@endif
			@endif
		@endif
		<div class="row small-up-2 medium-up-3 large-up-4">
			@foreach ($submissions as $submission)
				@include('video._submission-thumb')
			@endforeach
		</div>
		<div class="row column text-center">
			{{ $submissions->links('pagination::foundation') }}
		</div>
	</section>
@endsection
