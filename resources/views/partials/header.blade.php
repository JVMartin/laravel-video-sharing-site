<section id="partialsHeader">
	<div class="title-bar" data-responsive-toggle="realEstateMenu" data-hide-for="small">
		<button class="menu-icon" type="button" data-toggle></button>
		<div class="title-bar-title">Menu</div>
	</div>

	<div class="top-bar" id="realEstateMenu">
		<div class="top-bar-left">
			<ul class="menu" data-responsive-menu="accordion">
				<li class="menu-text">Videos</li>
			</ul>
		</div>
		<div class="top-bar-right">
			<ul class="menu">
				<li>
					@if (Auth::check())
						<a class="button" href="{{ route('sign-out') }}">
							Sign Out
						</a>
					@else
						<a class="button" data-open="modalsSignIn">
							Sign In
						</a>
					@endif
				</li>
			</ul>
		</div>
	</div>
</section>
