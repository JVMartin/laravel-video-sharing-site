@extends('template')

@section('title', 'Edit My Profile')

@section('content')
	<section id="pagesProfile">
		<div class="row">
			<div class="column small-12">
				<h3>
					Basic Information
				</h3>
				<div class="row">
					<div class="columns medium-6">
						<label for="">
							<input type="text" placeholder=" Name" name="_name">
						</label>
					</div>
					<div class="columns medium-6">
						<label for="">
							<input type="text" placeholder=" Name" name="_name">
						</label>
					</div>
				</div>
			</div>
		</div>
		@if ( ! Auth::user()->usesSocialAuthentication())
			<div class="row">
				<div class="column small-12">
					<h3>
						Change Password
					</h3>
					<div class="row">
						<div class="columns medium-6">
							<label for="">
								<input type="password" name="password">
							</label>
						</div>
						<div class="columns medium-6">
							<label for="">
								<input type="password" name="password_confirmation">
							</label>
						</div>
					</div>
				</div>
			</div>
		@endif
	</section>
@endsection
