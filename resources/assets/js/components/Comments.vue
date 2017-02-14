<template>
	<section id="comments">
		<div class="row column">
			<button class="button">
				Leave Comment
			</button>
		</div>
		<div class="row column" v-for="comment in comments">
			{{ comment.contents }}
		</div>
	</section>
</template>

<script>
	export default {
		data() {
			return {
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
