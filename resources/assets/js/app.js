/**
 * First, load all of our dependencies.
 */

require('./bootstrap');

$(document).foundation();

//--------------------------------
// Sign in modals
//--------------------------------
$('#modalsSignIn').bind('open.zf.reveal', function() {
	$(this).find('input[name="email"]:first').focus();
});
$('#modalsForgotPassword').bind('open.zf.reveal', function() {
	$(this).find('input[name="email"]').focus();
});

//--------------------------------
// Sign in modals
//--------------------------------
tinymce.init({
	selector: 'textarea.tinymce',
	plugins: [
		'code image link autoresize'
	],
});

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the body of the page. From here, you may begin adding components to
 * the application, or feel free to tweak this setup for your needs.
 */

// Vue.component('example', require('./components/Example.vue'));
// const app = new Vue({
// 	el: '#app'
// });
