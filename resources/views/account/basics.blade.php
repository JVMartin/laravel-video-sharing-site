@extends('account.template')

@section('title', 'Basics')

@section('section')
	<form action="{{ route('account.basics.process') }}" method="POST">
		{!! csrf_field() !!}
		<h3>Username</h3>
		<p>Must contain only letters, numbers, and dashes.</p>
		<div class="row">
			<div class="columns medium-6 end">
				<label for="username" class="{{ ($errors->has('username')) ? 'is-invalid-label' : '' }}">
					Username
					<input type="text" placeholder="Username" name="username" value="{{ old('username', Auth::user()->username) }}" class="{{ ($errors->has('username')) ? 'is-invalid-input' : '' }}" required>
					@foreach ($errors->get('username') as $error)
		        <span class="form-error is-visible">
			        {!! $error !!}
		        </span>
		      @endforeach
				</label>
			</div>
		</div>
		<hr />
		@if ( ! Auth::user()->usesSocialAuthentication())
			<h3>Email</h3>
			@if ($verified)
				<div class="callout success">
					Your email has been verified.
				</div>
			@else
				<div class="callout alert">
					Your email has not yet been verified.<br />
					If you do not verify your email, your account will be deleted
					@if ($daysUntilDeletion > 0)
						in {{ $daysUntilDeletion }} days!
					@else
						later today!
					@endif<br />
					<a href="{!! route('account.resend-verification') !!}" class="button">
						Resend Verification Email
					</a>
				</div>
			@endif
			<div class="row">
				<div class="columns medium-6 end">
					<label for="email" class="{{ ($errors->has('email')) ? 'is-invalid-label' : '' }}">
						Email
						<input type="email" placeholder="Email" name="email" value="{{ old('email', Auth::user()->email) }}" class="{{ ($errors->has('email')) ? 'is-invalid-input' : '' }}" required>
						@foreach ($errors->get('email') as $error)
			        <span class="form-error is-visible">
				        {!! $error !!}
			        </span>
			      @endforeach
					</label>
				</div>
			</div>
			<hr />
		@endif
		<h3>Name</h3>
		<p>Your name will never appear on the site - it is used only to address you in emails.</p>
		<div class="row">
			<div class="columns medium-6">
				<label for="first_name" class="{{ ($errors->has('first_name')) ? 'is-invalid-label' : '' }}">
					First Name
					<input type="text" placeholder="First Name" name="first_name" value="{{ old('first_name', Auth::user()->first_name) }}" class="{{ ($errors->has('first_name')) ? 'is-invalid-input' : '' }}">
					@foreach ($errors->get('first_name') as $error)
		        <span class="form-error is-visible">
			        {!! $error !!}
		        </span>
		      @endforeach
				</label>
			</div>
			<div class="columns medium-6">
				<label for="last_name" class="{{ ($errors->has('last_name')) ? 'is-invalid-label' : '' }}">
					Last Name
					<input type="text" placeholder="Last Name" name="last_name" value="{{ old('last_name', Auth::user()->last_name) }}" class="{{ ($errors->has('last_name')) ? 'is-invalid-input' : '' }}">
					@foreach ($errors->get('last_name') as $error)
		        <span class="form-error is-visible">
			        {!! $error !!}
		        </span>
		      @endforeach
				</label>
			</div>
		</div>
		<hr />
		<button type="submit" class="button">
			Save
		</button>
	</form>
@endsection
