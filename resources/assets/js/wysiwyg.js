require('tinymce/themes/modern/theme');
require('tinymce/plugins/advlist');
require('tinymce/plugins/autoresize');
require('tinymce/plugins/code');
require('tinymce/plugins/image');
require('tinymce/plugins/link');
require('tinymce/plugins/lists');
require('tinymce/plugins/paste');

//--------------------------------
// WYSIWYG editors
//--------------------------------
tinymce.init({
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
});
