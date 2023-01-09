// stores/counter.js
import { defineStore } from 'pinia';

export const usePiniaStore = defineStore('posts', {
	state: () => {
		return { posts: [] };
	},
	getters: {
		getPost: (state) => {
			return (postId) =>
				state.posts.find((post) => {
					return Number(post.id) === Number(postId);
				});
		},
	},
	// could also be defined as
	// state: () => ({ count: 0 })
	actions: {
		setPosts(data) {
			this.posts = data;
		},
	},
});
