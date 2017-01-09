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
	$.post($form.attr('action'), $form.serialize(), function(data) {
		console.log('success');
		console.log(data);
	}).fail(function(data) {
		const errors = data.responseJSON;
		$submitButton.text(origText);
		_.each(errors, function(errors, column) {
			const $label = $form.find('label[for="' + column + '"]');
			const $input = $label.children().first();
			$label.addClass('is-invalid-label');
			$input.addClass('is-invalid-input');
		});
	});
});
