import TurbolinksFixer from '../src/turbolinks-fixer';
import Vue from 'vue/dist/vue.esm';

import ComponentA from '../components/vue_components/componentA.vue';
import Homey from '../components/vue_components/home.vue';
import Vuemat from '../components/vue_components/vuemat.vue';

import VueMaterial from 'vue-material';


Vue.use(VueMaterial)
Vue.use(TurbolinksFixer)

Vue.component('app', Homey)
Vue.component('app1', Vuemat)

window.addEventListener('turbolinks:load', () => {
 	var element1 = document.getElementById('content')
	var app1 = new Vue({
	    el: element1,
	    data: {
	        title: "Area of Coverage",
	        area: "Malaysia",
	        postcode: 56000,
	        url: "http://www.youtube.com",
	        quantity: 0,
	        count: 0,
	         coords: {
	        	x: 0,
	         	y: 0
	        },
	        items: ["chicken", "lembu"],
	        betul: true,
	        salah: false
	     },
	    methods: {
	     	subtitle(shopName){
	     		return `by the ${shopName} team. (${this.area}), (${this.postcode}).`
	     	},
	     	changeCount(amount){
	     		this.count += amount
	     	},
	     	logEvent(e){
	     		console.log(e);
	     	},
	     	logCoords(e){
	     		this.coords.x = e.offsetX
	     		this.coords.y = e.offsetY
	     	},
	     	updateArea(e){
	     		this.area = e.target.value
	     	}
	    },
	})

	var element2 = document.getElementById('home_vue')
	var app2 = new Vue({
	    el: element2,
	    data: {
	         message: "Hola"
	     },
	    components: { Homey, Vuemat }
	})

	var element3 = document.getElementById('componentA')
	if(element3 != null){
		const app3 = new Vue({
		 el: element3,
		 render: h => h(ComponentA)
		})
	}
  
})

