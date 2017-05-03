<template>
	<section id="comments">
		<div class="row column" v-for="comment in comments">
			{{ comment.contents }}
		</div>
		<div class="row column large-8">
			<h4>Leave a comment</h4>
			<div v-if="data.auth">
				<textarea class="tinymce" name="comment"></textarea>
				<div class="row column text-right">
					<p>
						<button type="submit" class="button">
							Post comment
						</button>
					</p>
				</div>
			</div>
			<button v-else class="button" data-open="modalsSignIn">
				Sign in to leave a comment
			</button>
		</div>
	</section>
</template>

<script>
	const data = window.data;

	export default {
		data() {
			return {
				data: data,
				comments: []
			};
		},
		mounted() {
			this.$http.get('/comments/submission/' + window.data.submissionHash).then(response => {
				console.log(response);
				this.comments = response.body;
			}, response => {

			});
		}
	};
</script>

<style lang="sass" rel="stylesheet/scss">
</style>
