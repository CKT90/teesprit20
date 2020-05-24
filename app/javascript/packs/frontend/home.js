import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm';
import Homey from '../../components/vue_components/home.vue';

Vue.use(TurbolinksAdapter)

Vue.component('app', Homey)

document.addEventListener('turbolinks:load', () => {

 	var element = document.getElementById('content')
	var app = new Vue({
	    el: element,
	    data: {
	         message: "Hola"
	     },
	    components: { Homey }
	})

})

