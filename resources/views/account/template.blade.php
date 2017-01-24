@extends('template')

@section('content')
<section id="accountTemplate">
	<div class="row">
		<div class="columns medium-4 large-2">
			@include('account.partials.navigation')
		</div>
		<div class="columns medium-8 large-10">
			@yield('section')
		</div>
	</div>
</section>
@endsection
