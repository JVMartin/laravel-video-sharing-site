<template>
	<div>
		<button class="button">
			Follow
		</button>
	</div>
</template>

<script>
	export default {
		props: [
			'leader_id'
		],
		data() {
			return {
				// The signed-in user.
				user: window.data.user,
			};
		},

		computed: {
		},

		mounted() {
		},

		methods: {

		},
	};
</script>
