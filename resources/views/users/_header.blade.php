<section id="usersHeader">
	<h1>
		{{ $user->username }}
	</h1>
	<ul class="menu">
		<li class="{{ Request::route()->getName() == 'user.profile.submissions' ? 'active' : '' }}">
			<a href="{{ route('user.profile.submissions', $user->username) }}">
				Submissions
			</a>
		</li>
		<li class="{{ Request::route()->getName() == 'user.profile.comments' ? 'is-active' : '' }}">
			<a href="{{ route('user.profile.comments', $user->username) }}">
				Comments
			</a>
		</li>
	</ul>
</section>
