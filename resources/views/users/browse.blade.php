@extends('template')

@section('title', 'Site')

@section('content')
	<section id="usersProfile">
		<h1>
			{{ $user->username }}
		</h1>
		<ul class="tabs" data-tabs id="example-tabs">
			<li class="tabs-title is-active">
				<a href="#panel1" aria-selected="true">
					Submissions
				</a>
			</li>
			<li class="tabs-title">
				<a href="#panel2">
					Comments
				</a>
			</li>
		</ul>
	</section>
	<section id="videoBrowse">
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
