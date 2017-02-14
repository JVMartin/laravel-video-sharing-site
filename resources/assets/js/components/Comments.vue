<template>
	<section id="comments">
		<div class="row column">
			<button class="button">
				Leave Comment
			</button>
		</div>
	</section>
</template>

<script>
	export default {
		mounted() {
			this.$http.get('/comments/submission/' + window.data.submissionHash).then(response => {
				console.log(response);
			}, response => {

			});
		}
	};
</script>
