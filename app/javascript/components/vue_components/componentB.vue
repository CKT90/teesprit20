<template>  
	<div id="componentB">
	  <p> I am component B, nested inside component A </p>
	  <ul>
    	<li v-for="(fruit, index) in fruits" @click = "unFruit(fruit.name)" > {{index+1}}. {{ fruit.name }} </li>
  	  </ul>
	</div>
</template>

<script>
	export default {
	  name: 'ComponentB',
	  props: ['fruits'], //declare props from component A
	  data: function () {
	    return {
	    }
	  },
	  methods: {
	  	unFruit(name){
	  		this.$emit('delete', { name })
	  	}
	  }
	}
</script>
