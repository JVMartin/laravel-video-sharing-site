@extends('account.template')

@section('title', 'Password')

@section('section')
	<form action="{{ route('account.password.process') }}" method="POST">
		{!! csrf_field() !!}
		<h3>Change Password</h3>
		<div class="row">
			<div class="columns medium-6 end">
				<label for="password" class="{{ ($errors->has('password')) ? 'is-invalid-label' : '' }}">
					Password
					<input type="password" name="password" placeholder="New Password" class="{{ ($errors->has('password')) ? 'is-invalid-input' : '' }}" autofocus required>
					@foreach ($errors->get('password') as $error)
		        <span class="form-error is-visible">
			        {!! $error !!}
		        </span>
		      @endforeach
				</label>
				<label for="password_confirmation" class="{{ ($errors->has('password_confirmation')) ? 'is-invalid-label' : '' }}">
					Confirm New Password
					<input type="password" name="password_confirmation" placeholder="Confirm New Password" class="{{ ($errors->has('password_confirmation')) ? 'is-invalid-input' : '' }}" required>
					@foreach ($errors->get('password_confirmation') as $error)
		        <span class="form-error is-visible">
			        {!! $error !!}
		        </span>
		      @endforeach
				</label>
			</div>
		</div>
		<button type="submit" class="button">
			Change Password
		</button>
	</form>
@endsection
