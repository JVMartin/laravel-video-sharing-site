@extends('template')

@section('title', 'Site')

@section('content')
	<section id="videoBrowse">
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
				<li class="{{ Request::route()->getName() == 'my-feed' ? 'active' : '' }}">
					<a href="{{ route('feed') }}">
						My Feed
					</a>
				</li>
			</ul>
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
