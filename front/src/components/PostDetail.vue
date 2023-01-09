<script>
import { usePiniaStore } from '../stores/postsStore';
export default {
	props: ['id', 'postItem'],
	// Properties returned fsrom data() become reactive state
	// and will be exposed on `this`.
	data() {
		return {
			post: undefined,
		};
	},

	// Methods are functions that mutate state and trigger updates.
	// They can be bound as event listeners in templates.
	methods: {},

	// Lifecycle hooks are called at different stages
	// of a component's lifecycle.
	// This function will be called when the component is mounted.
	mounted() {
		const postStore = usePiniaStore();
		this.post = postStore.getPost(this.$route.params.id);
	},
};
</script>

<template>
	<h1 v-if="post">{{ post.title }}</h1>

	<p v-if="post">{{ post.body }}</p>
</template>

<style scoped>
.read-the-docs {
	color: #888;
}
</style>
