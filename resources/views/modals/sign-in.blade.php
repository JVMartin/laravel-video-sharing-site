<section id="modalsSignIn" class="reveal" data-reveal>
	<div class="row">
		<div class="small-12 columns text-center">
			<h1>
				Sign In
			</h1>
			<div class="row socialWrap">
				<div class="small-12 medium-6 columns">
					<a class="facebook button" href="{{ route('sign-in.social.facebook') }}">
						Sign in with Facebook
					</a>
				</div>
				<div class="small-12 medium-6 columns">
					<a class="google button" href="{{ route('sign-in.social.google') }}">
						Sign in with Google
					</a>
				</div>
			</div>
			<p class="viaEmail">
				or via email
			</p>
			<form method="POST" action="{{ route('sign-in.email') }}" class="form-ajax">
				{!! csrf_field() !!}
				<input type="hidden" name="continue" value="{!! urlencode(Request::path()) !!}" />
				<label for="email">
					email address
					<input type="email" id="loginEmail" class="custom" name="email" value="{{ old('email') }}" placeholder="email address" />
				</label>
				<label for="password">
					password
					<input type="password" class="custom" name="password" id="password" placeholder="password">
				</label>
				<div class="text-left">
					<input id="rememberMeCheckbox" type="checkbox" name="remember">
					<label for="rememberMeCheckbox">
						Remember Me
					</label>
				</div>
				<div class="row signInWrap">
					<div class="small-6 column">
						<button type="submit" class="button" data-ajax="Signing In...">
							Sign In
						</button>
					</div>
					<div class="small-6 column text-right">
						<p>
							<a href="#modalsPassword" id="passwordButton">
								forgot password?
							</a>
						</p>
					</div>
				</div>
			</form>
		</div>
	</div>
</section>