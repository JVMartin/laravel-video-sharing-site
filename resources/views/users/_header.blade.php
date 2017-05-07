<section id="usersHeader">
	<h1>
		{{ $user->username }}
	</h1>
	<ul class="tabs" data-tabs id="example-tabs">
		<li class="tabs-title {{ Request::route()->getName() == 'user.profile.submissions' ? 'is-active' : '' }}">
			<a href="#panel1">
				Submissions
			</a>
		</li>
		<li class="tabs-title">
			<a href="#panel2">
				Comments
			</a>
		</li>
	</ul>
</section>
