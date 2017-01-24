@extends('template')

@section('title', 'Videos')

@section('content')
	<section id="pagesHome">
		@if (Auth::check())
			<div class="row">
				<div class="column small-12">
					<h3>
						Hello, {{ Auth::user()->first_name }}.
					</h3>
				</div>
			</div>
		@endif
	</section>
@endsection
