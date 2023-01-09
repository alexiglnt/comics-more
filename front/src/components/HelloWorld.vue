<script>
export default {
	props: ['msg'],
	// Properties returned from data() become reactive state
	// and will be exposed on `this`.
	data() {
		return {
			count: 0,
		};
	},

	// Methods are functions that mutate state and trigger updates.
	// They can be bound as event listeners in templates.
	methods: {
		increment() {
			this.count++;
		},
	},

	// Lifecycle hooks are called at different stages
	// of a component's lifecycle.
	// This function will be called when the component is mounted.
	mounted() {
		console.log(`The initial count is ${this.count}.`);
	},
};
</script>

<template>
	<h1>{{ this.msg }}</h1>

	<div class="card">
		<button type="button" @click="increment">count is {{ count }}</button>
		<p>
			Edit
			<code>components/HelloWorld.vue</code> to test HMsR
		</p>
	</div>

	<p>
		Check out
		<a href="https://vuejs.org/guide/quick-start.html#local" target="_blank">create-vue</a>, the
		official Vue + Vite starter
	</p>
	<p>
		Install
		<a href="https://github.com/johnsoncodehk/volar" target="_blank">Volar</a>
		in your IDE for a better DX
	</p>
	<p class="read-the-docs">Click on the Vite and Vue logos to learn more</p>
</template>

<style scoped>
.read-the-docs {
	color: #888;
}
</style>
