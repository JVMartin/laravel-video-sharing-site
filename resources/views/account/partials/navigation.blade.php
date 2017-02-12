<section id="accountPartialsNavigation">
	<ul class="menu vertical">
		<li {!! Route::currentRouteNamed('account.basics') ? 'class="active"' : '' !!}>
			<a href="{{ route('account.basics') }}">
				Basics
			</a>
		</li>
		<li {!! Route::currentRouteNamed('account.picture') ? 'class="active"' : '' !!}>
			<a href="{{ route('account.picture') }}">
				Picture
			</a>
		</li>
		@if ( ! Auth::user()->usesSocialAuthentication())
			<li {!! Route::currentRouteNamed('account.password') ? 'class="active"' : '' !!}>
				<a href="{{ route('account.password') }}">
					Password
				</a>
			</li>
		@endif
	</ul>
</section>
