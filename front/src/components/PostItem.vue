<script>
	export default {
		props: ['post', 'handleClick', 'textButton'],
		// Properties returned from data() become reactive state
		// and will be exposed on `this`.
		data() {
			return {};
		},

		// Methods are functions that mutate state and trigger updates.
		// They can be bound as event listeners in templates.
		methods: {
			clicked() {
				this.handleClick(this.post);
			},
		},

		// Lifecycle hooks are called at different stages
		// of a component's lifecycle.
		// This function will be called when the component is mounted.
		mounted() {},
	};
</script>

<template>
	<div class="card">
		<h2>{{ post.title }}</h2>

		<p>{{ post.body }}</p>
		<button type="button" @click="clicked"> {{ textButton }} </button>
	</div>
</template>

<style scoped>
	


</style>
