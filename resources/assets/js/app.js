/**
 * First, load all of our dependencies.
 */

import './bootstrap';

$(document).foundation();

$('#modalsForgotPassword').bind('open.zf.reveal', function() {
	$(this).find('input[name="email"]').focus();
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
