@extends('template')

@section('title', 'Videos')


@section('content')
	<section id="errorsBadVerificationLink">
		<div class="row">
			<div class="columns small-12">
				<div class="callout alert">
					{{ trans('auth.verify.failure') }}
				</div>
			</div>
		</div>
	</section>
@endsection
