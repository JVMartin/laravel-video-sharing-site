<section id="modalsForgotPassword" class="reveal" data-reveal>
	<div class="row">
		<div class="small-12 columns">
			<h2 class="text-center">
				Forgot Password
			</h2>
			<p>
				Enter your email below and we'll send you a link to reset your password.
			</p>
			<form method="POST" action="{{ route('forgot-password') }}" class="form-ajax" autocomplete="off">
				{!! csrf_field() !!}
				<div class="hideOnSuccess">
					<label for="email">
						email address
						<input type="email" name="email" placeholder="email address" />
					</label>
					<div class="row submitWrap">
						<div class="small-6 column">
							<button type="submit" class="button" data-ajax="Signing In...">
								Email Me
							</button>
						</div>
						<div class="small-6 column text-right">
							<p>
								<a data-open="modalsSignIn">
									nevermind
								</a>
							</p>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
  <button class="close-button" data-close aria-label="Close modal" type="button">
   <span aria-hidden="true">&times;</span>
  </button>
</section>