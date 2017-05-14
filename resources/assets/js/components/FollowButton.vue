<template>
	<div>
		<button class="button" :disabled="followingBoolean" v-text="followingText">
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

		},
	};
</script>
