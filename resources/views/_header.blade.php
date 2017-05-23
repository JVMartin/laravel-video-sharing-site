<section id="partialsHeader">
	<div class="title-bar" data-responsive-toggle="headerMenu" data-hide-for="medium">
		<button class="menu-icon" type="button" data-toggle></button>
		<div class="title-bar-title">Menu</div>
	</div>

	<div class="top-bar" id="headerMenu">
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
				<ul class="dropdown vertical medium-horizontal menu" data-dropdown-menu>
					@if (Auth::check())
						<li>
							<a href="{{ route('video.submit.url') }}">
								Submit Video
							</a>
						</li>
						<li>
							<a href="{{ route('notifications') }}">
								Notifications ({{ Auth::user()->unreadNotifications()->count() }})
							</a>
						</li>
						<li class="is-dropdown-submenu-parent">
							<a class="account">
								<div class="avatarWrap">
									<span class="avatar" style="background-image:url({{ Auth::user()->avatar_url }});"></span>
								</div>
								Account
							</a>
							<ul class="menu is-dropdown-submenu">
								<li>
									<a href="{{ route('user.profile', Auth::user()->username) }}">
										<i class="fa fa-user"></i>
										Profile
									</a>
								</li>
								<li>
									<a href="{{ route('account.basics') }}">
										<i class="fa fa-cog"></i>
										Settings
									</a>
								</li>
								<li>
									<a href="{{ route('sign-out') }}">
										<i class="fa fa-sign-out"></i>
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
