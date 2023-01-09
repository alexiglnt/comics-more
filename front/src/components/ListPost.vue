<script>
import { usePiniaStore } from '../stores/postsStore';
import PostItem from './PostItem.vue';
export default {
	props: ['msg'],
	components: {
		PostItem,
	},
	// Properties returned fsrom data() become reactive state
	// and will be exposed on `this`.
	data() {
		return {
			posts: [],
		};
	},

	// Methods are functions that mutate state and trigger updates.
	// They can be bound as event listeners in templates.
	methods: {
		readArticle(data) {
			this.$router.push({
				name: 'Article',
				params: { id: data.id },
			});
			console.log(data.title);
		},
	},

	// Lifecycle hooks are called at different stages
	// of a component's lifecycle.
	// This function will be called when the component is mounted.
	mounted() {
		const posts = usePiniaStore();

		fetch('https://jsonplaceholder.typicode.com/posts')
			.then((res) => res.json())
			.then((res) => {
				this.posts = res;
				posts.setPosts(res);
			});
	},
};
</script>

<template>
	<h1>Mes articles</h1>

	<div v-for="post in posts">
		<PostItem :post="post" textButton="Lire l'article" :handleClick="this.readArticle" />
	</div>
</template>

<style scoped>
.read-the-docs {
	color: #888;
}
</style>
