<template>  
	<div id="componentA">
	  <p> I am rendered from another component </p>
	  <p v-if="betul"> I am correct </p>
	  <p v-if="salah"> I am wrong, sorry. </p>
	  <p> I am rendered from another component </p>
	  <ComponentB :fruits = "fruits" @delete="deleteFruit"> </ComponentB>
	</div>
</template>

<script>
	import ComponentB from './componentB.vue'

	export default {
	  name: 'ComponentA',
	  components: {
	  	ComponentB  //if not same name, will be "(different name): ComponentB "
	  },
	  data: function () {
	    return {
         betul: true,
         salah: false,
         fruits: [
         	{ name: 'apple', delicious: true},
         	{ name: 'orange', delicious: false}
         	]
	    }
	  },
	  methods: {
	  	deleteFruit(nameFromCompB) {
	  		console.log(nameFromCompB)
	  		this.fruits = this.fruits.filter(fruit => {
	  			return fruit.name !== nameFromCompB.name
	  		})
	  	}
	  }
	}
</script>
