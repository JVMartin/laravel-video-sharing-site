<template>
	<div>
		<button :class="'button followButton ' + (followingBoolean ? 'disabledFake' : '')" v-text="followingText" v-on:click="follow">
		</button>
	</div>
</template>

<script>
	export default {
		props: [
			'leader_hash',
			'following',
		],

		data() {
			return {
				// The signed-in user.
				user: window.data.user,

				// Whether the user is following.
				followingBoolean: false,
			};
		},

		computed: {
			followingText() {
				return (this.followingBoolean) ? 'Following' : 'Follow';
			}
		},

		mounted() {
			this.followingBoolean = (this.following == 'true');
		},

		methods: {
			follow() {
				// They must be signed in.
				if ( ! this.user) {
					$('#modalsSignIn').foundation('open');
					return;
				}

				this.followingBoolean = ! this.followingBoolean;

				axios.post('/user/vote/' + submission.hash, {
					value: value,
				}).then(function(response) {
					//
				});
			},
		},
	};
</script>
