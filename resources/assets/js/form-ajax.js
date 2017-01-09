/**
 * Plumbing for AJAX forms.
 */

$('.form-ajax').submit(function(e) {
	e.preventDefault();
	const $form = $(this);
	const $submitButton = $form.find(':submit');
	const origText = $submitButton.text().trim();
	const ajaxText = $submitButton.data('ajax');
	$submitButton.text(ajaxText);

	// Reset/remove the old errors.
	$form.find('.is-invalid-label').removeClass('is-invalid-label');
	$form.find('.is-invalid-input').removeClass('is-invalid-input');
	$form.find('.form-error').remove();

	$.post($form.attr('action'), $form.serialize(), function(data) {
		console.log('success');
		console.log(data);
	}).fail(function(data) {
		const errors = data.responseJSON;
		$submitButton.text(origText);
		console.log(errors);
		_.each(errors, function(errors, column) {
			const $label = $form.find('label[for="' + column + '"]');
			const $input = $label.children().first();
			$label.addClass('is-invalid-label');
			$input.addClass('is-invalid-input');
			_.each(errors, function(error) {
				$input.after('<span class="form-error is-visible">' + error + '</span>');
			});
		});
	});
});
