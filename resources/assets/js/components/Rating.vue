<template>
	<div class="row">
		<div class="column small-5">
			<div class="vote">
				<span :class="'voteButton upvote' + ((submission.user_up) ? ' active' : '')" v-on:click.stop="vote(1)">
					<i class="fa fa-arrow-up"></i>
				</span>
			</div>
			<div class="vote">
				<span :class="'voteButton downvote' + ((submission.user_down) ? ' active' : '')" v-on:click.stop="vote(-1)">
					<i class="fa fa-arrow-down"></i>
				</span>
			</div>
		</div>
		<div class="column small-7">
			<div class="ratingWrap">
				<div class="rating">
					<div class="bar" :style="'width: ' + ratingPercent + '%'"></div>
					<div class="labels">
						<div class="up">
							{{ submission.num_up }}
						</div>
						<div class="down">
							{{ -1 * submission.num_down }}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		data() {
			return {
				// Data passed in from Laravel.
				data: window.data,

				// The submission.
				submission: window.submission,
			};
		},

		computed: {
			ratingPercent() {
				let totalVotes = this.submission.num_up + this.submission.num_down;
				let ratio = this.submission.num_up / totalVotes;
				return ratio * 100;
			},
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
