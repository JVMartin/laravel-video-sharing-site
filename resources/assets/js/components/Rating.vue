<template>
	<div>
		<div class="vote">
			<span :class="'voteButton upvote' + ((submission.user_up) ? ' active' : '')" v-on:click.stop="vote(1)">
				<i class="fa fa-arrow-up"></i>
				{{ submission.num_up }}
			</span>
		</div>
		<div class="vote">
			<span :class="'voteButton downvote' + ((submission.user_down) ? ' active' : '')" v-on:click.stop="vote(-1)">
				<i class="fa fa-arrow-down"></i>
				{{ -1 * submission.num_down }}
			</span>
		</div>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				// Data passed in from Laravel.
				submission: window.submission,
			};
		},

		computed: {
		},

		mounted() {
		},

		methods: {
			/**
			 * Vote on the submission.
			 *
			 * @param value
			 */
			vote(value) {
				// They must be signed in.
				if ( ! this.data.user) {
					$('#modalsSignIn').foundation('open');
					return;
				}

				if (value == 1) {
					// You already voted up, ya dingus.
					if (submission.user_up) return;

					if (submission.user_down) {
						submission.user_down = false;
						submission.num_down--;
					}
					submission.user_up = true;
					submission.num_up++;
				}
				else {
					// You already voted down, ya dingus.
					if (submission.user_down) return;

					if (submission.user_up) {
						submission.user_up = false;
						submission.num_up--;
					}
					submission.user_down = true;
					submission.num_down++;
				}

				axios.post('/submissions/vote/' + submission.hash, {
					value: value,
				}).then(function(response) {
					//
				});
			},
		},
	};
</script>
