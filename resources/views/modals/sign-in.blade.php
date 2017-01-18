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
			<form method="POST" action="{{ route('sign-in.email') }}" class="form-ajax">
				{!! csrf_field() !!}
				<label>
					email address
					<input type="email" name="email" placeholder="email address" />
				</label>
				<label>
					password
					<input type="password" name="password" placeholder="password" />
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
							<a href="#modalsPassword" id="passwordButton">
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
			<form method="POST" action="{{ route('sign-in.email') }}" class="form-ajax">
				{!! csrf_field() !!}
				<label>
					email address
					<input type="email" name="email" placeholder="email address" />
				</label>
				<label>
					password
					<input type="password" name="password" placeholder="password" />
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
</section>