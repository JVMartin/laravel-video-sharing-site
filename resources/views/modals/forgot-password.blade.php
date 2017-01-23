<section id="modalsForgotPassword" class="reveal" data-reveal>
	<div class="row">
		<div class="small-12 columns">
			<h2 class="text-center">
				Reset Password
			</h2>
			<form method="POST" action="{{ route('sign-in.email') }}" class="form-ajax" autocomplete="off">
				{!! csrf_field() !!}
				<label for="email">
					email address
					<input type="email" name="email" placeholder="email address" autofocus />
				</label>
				<div class="row submitWrap">
					<div class="small-6 column">
						<button type="submit" class="button" data-ajax="Signing In...">
							Reset Password
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
			</form>
		</div>
	</div>
</section>