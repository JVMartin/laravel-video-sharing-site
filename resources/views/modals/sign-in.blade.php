<section id="modalsSignIn" class="reveal-modal" data-reveal>
	<div class="row">
		<div class="small-12 columns text-center">
			<h1>
				Sign In
			</h1>
			<p>
				Not a member?
				<a href="#modalsRegister" id="registerButton">
					Join now.
				</a>
			</p>
			<div class="row socialWrap">
				<div class="small-12 medium-6 columns">
					<a class="facebook button radius" href="{{ url('login/facebook') }}">
						Sign in with Facebook
					</a>
				</div>
				<div class="small-12 medium-6 columns">
					<a class="google button radius" href="{{ url('login/google') }}">
						Sign in with Google
					</a>
				</div>
			</div>
			<p class="viaEmail">
				or via email
			</p>
			<form method="POST" action="/auth/login">
				{!! csrf_field() !!}
				<input type="hidden" name="continue" value="{!! urlencode(Request::path()) !!}" />
				<div>
					<input type="email" id="loginEmail" class="custom" name="email" value="{{ old('email') }}" placeholder="email address" />
				</div>
				<div>
					<input type="password" class="custom" name="password" id="password" placeholder="password">
				</div>
				<div class="text-left show-for-medium-up">
					<label>
						<input type="checkbox" name="remember">
						Remember Me
					</label>
				</div>
				<div class="row signInWrap">
					<div class="small-6 column">
						<button type="submit" class="alert radius">
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