export default {
	path_absolute: '/',
	selector: 'textarea.tinymce',
	plugins: [
		'advlist autoresize codemirror image link lists paste'
	],
	toolbar: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | code',
	removed_menuitems: 'newdocument',
	paste_as_text: true,
	relative_urls: false,
	codemirror: {
		indentOnInit: true, // Whether or not to indent code on init.
		width: 800,
		height: 600,
	}
};
