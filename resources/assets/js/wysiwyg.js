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
tinymce.init(require('./tinymce-config'));
