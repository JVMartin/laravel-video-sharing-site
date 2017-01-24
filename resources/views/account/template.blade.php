@extends('template')

@section('content')
<section id="accountTemplate">
	<div class="row">
		<div class="columns small-4">
			<h1>Test</h1>
			@include('account.partials.navigation')
		</div>
		<div class="columns small-8">
			@yield('section')
		</div>
	</div>
</section>
@endsection
