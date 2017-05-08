<section id="partialsHeader">
	<div class="title-bar" data-responsive-toggle="realEstateMenu" data-hide-for="small">
		<button class="menu-icon" type="button" data-toggle></button>
		<div class="title-bar-title">Menu</div>
	</div>

	<div class="top-bar">
		<div class="row column">
			<div class="top-bar-left">
				<ul class="menu" data-responsive-menu="accordion">
					<li>
						<a href="{{ route('home') }}" class="brand">
							OneMore <span>Video</span>
						</a>
					</li>
				</ul>
			</div>
			<div class="top-bar-right">
				<ul class="dropdown menu" data-dropdown-menu>
					@if (Auth::check())
						<li>
							<a href="{{ route('video.submit.url') }}">
								Submit Video
							</a>
						</li>
					@endif
					@if (Auth::check())
						<li class="is-dropdown-submenu-parent">
						<a>Account</a>
						<ul class="menu is-dropdown-submenu">
							<li>
								<a href="{{ route('user.profile', Auth::user()->username) }}">
									Profile
								</a>
							</li>
							<li>
								<a href="{{ route('account.basics') }}">
									Settings
								</a>
							</li>
							<li>
								<a href="{{ route('sign-out') }}">
									Sign Out
								</a>
							</li>
						</ul>
						</li>
					@else
						<li>
							<a class="button" data-open="modalsSignIn">
								Sign In
							</a>
						</li>
					@endif
				</ul>
			</div>
		</div>
	</div>
</section>
