<section id="modalsSignIn" class="reveal" data-reveal>
	<div class="row">
		<div class="small-12 columns text-center">
			<h2>
				Sign In
			</h2>
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
			<form id="signInForm" method="POST" action="{{ route('sign-in.email') }}" class="form-ajax" autocomplete="off">
				{!! csrf_field() !!}
				<label for="email">
					email address
					<input type="email" name="email" placeholder="email address" required />
				</label>
				<label for="password">
					password
					<input type="password" name="password" placeholder="password" required />
				</label>
				<div class="text-left">
					<input id="rememberMeCheckbox" type="checkbox" name="remember" />
					<label for="rememberMeCheckbox">
						Remember Me
					</label>
				</div>
				<div class="row submitWrap">
					<div class="small-6 column">
						<button type="submit" class="button" data-ajax="Signing In...">
							Sign In
						</button>
					</div>
					<div class="small-6 column text-right">
						<p>
							<a data-open="modalsForgotPassword">
								forgot password?
							</a>
						</p>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="row">
		<div class="small-12 columns text-center">
			<hr />
			<h2>
				Register
			</h2>
			<form id="registerForm" method="POST" action="{{ route('register') }}" class="form-ajax" autocomplete="off">
				{!! csrf_field() !!}
				<label for="email">
					email address
					<input type="email" name="email" placeholder="email address" required />
				</label>
				<label for="password">
					password
					<input type="password" name="password" placeholder="password" required />
				</label>
				<div class="row submitWrap">
					<div class="small-6 column">
						<button type="submit" class="button" data-ajax="Registering...">
							Register
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
  <button class="close-button" data-close aria-label="Close modal" type="button">
	  <i class="fa fa-close"></i>
  </button>
</section>
