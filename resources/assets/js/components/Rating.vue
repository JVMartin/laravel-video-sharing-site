<template>
	<div class="vote">
		<span :class="'voteButton upvote' + ((comment.user_up) ? ' active' : '')" v-on:click.stop="vote(comment, 1)">
			<i class="fa fa-arrow-up"></i>
			{{ comment.num_up }}
		</span>
	</div>
	<div class="vote">
		<span :class="'voteButton downvote' + ((comment.user_down) ? ' active' : '')" v-on:click.stop="vote(comment, -1)">
			<i class="fa fa-arrow-down"></i>
			{{ -1 * comment.num_down }}
		</span>
	</div>
</template>

<script>
	import tinymceConfig from '../tinymce-config';

	const data = window.data;
	const user_comments = window.user_comments;

	export default {
		props: [
			// The hashid of the submission being watched.
			'submission_hashid',

			// The comment being replied to, or null if this is the root (submission) comments.
			'parent_comment',
		],

		data() {
			return {
				// Data passed in from Laravel.
				data: data,

				// The list of comments.
				comments: [],

				loading: true,

				// Are we on a user's profile instead of a submission?
				on_profile: false,
			};
		},

		computed: {
			action() {
				return (this.parent_comment) ? 'reply' : 'comment';
			},

			commentRoute() {
				let route = '/comments/submission/' + this.submission_hashid;

				if (this.parent_comment) {
					route += '/' + this.parent_comment.hash;
				}

				return route;
			},

			wysiwygId() {
				let id = 'wysiwyg';
				if (this.parent_comment) {
					id += '-' + this.parent_comment.hash;
				}
				return id;
			}
		},

		mounted() {
			let self = this;

			// If we're on a user's profile page viewing their comments.
			if (user_comments) {
				this.on_profile = true;
				this.comments = user_comments;
			}
			// If we're on a submission.
			else {
				axios.get(this.commentRoute).then(function(response) {
					let comments = response.data;

					_.forEach(comments, function(comment) {
						self.initComment(comment);
					});

					self.comments = response.data;
					self.loading = false;
				});

				let tConfig = tinymceConfig();
				tConfig.selector = '#' + this.wysiwygId;
				tinymce.init(tConfig);
				tinymce.execCommand('mceFocus', false, this.wysiwygId);
			}
		},

		methods: {
			/**
			 * Submitting a comment.
			 */
			submitComment() {
				let self = this;
				let comment = tinymce.get(this.wysiwygId).getContent();

				if ( ! comment.length) {
					alert('You gotta say something first!');
					return;
				}

				tinymce.get(this.wysiwygId).setContent('');

				axios.post(this.commentRoute, {
					comment: comment,
				}).then(function(response) {
					let comment = response.data;
					self.initComment(comment);
					self.comments.push(comment);
					self.$emit('newReply');
				});
			},

			/**
			 * Vote on a comment.
			 *
			 * @param comment
			 * @param value
			 */
			vote(comment, value) {
				// They must be signed in.
				if ( ! this.data.user) {
					$('#modalsSignIn').foundation('open');
					return;
				}

				// If we're on a user's profile, just send them to the submission.
				if (this.on_profile) {
					window.location = comment.submission.url;
					return;
				}

				if (value == 1) {
					// You already voted up, ya dingus.
					if (comment.user_up) return;

					if (comment.user_down) {
						comment.user_down = false;
						comment.num_down--;
					}
					comment.user_up = true;
					comment.num_up++;
				}
				else {
					// You already voted down, ya dingus.
					if (comment.user_down) return;

					if (comment.user_up) {
						comment.user_up = false;
						comment.num_up--;
					}
					comment.user_down = true;
					comment.num_down++;
				}

				axios.post('/comments/vote/' + comment.hash, {
					value: value,
				}).then(function(response) {
					//
				});
			},

			/**
			 * Handle a new reply propagating up from the nested reply field.
			 *
			 * @param comment - The comment being replied to.
			 */
			handleNewReply(comment) {
				comment.num_replies++;
				comment.replying = false;
				comment.expanded = true;
			},

			/**
			 * Add extra data to the comment just for usage in this Vue component.
			 *
			 * @param comment
			 */
			initComment(comment) {
				comment.componentLoaded = false;
				comment.expanded = false;
				comment.replying = false;
			},

			/**
			 * Expand or unexpand a given comment's replies.
			 *
			 * @param comment
			 */
			toggleReplies(comment) {
				// If we're on a user's profile, just send them to the submission.
				if (this.on_profile) {
					window.location = comment.submission.url;
					return;
				}

				comment.componentLoaded = true;

				if (comment.expanded) {
					comment.expanded = false;
				}
				else {
					comment.expanded = true;

					// We also need to hide the reply box.
					comment.replying = false;
				}
			},

			/**
			 * Reply to a given comment.
			 *
			 * @param comment
			 */
			replyTo(comment) {
				// They must be signed in.
				if ( ! this.data.user) {
					$('#modalsSignIn').foundation('open');
					return;
				}

				comment.componentLoaded = true;

				comment.expanded = false;
				comment.replying = true;
			},
		},
	};
</script>
