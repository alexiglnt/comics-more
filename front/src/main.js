import { createApp } from 'vue';
import { createPinia } from 'pinia';
import './style.css';
import App from './App.vue';
import { createRouter, createWebHistory } from 'vue-router';
// import PostDetail from './components/PostDetail.vue';
// import ListPost from './components/ListPost.vue';
import Home from './components/Home.vue';
import PageItem from './components/PageItem.vue';
import OldPageItem from './components/OldPageItem.vue';

const routes = [
	{ path: '/', component: Home, name: 'Home' },
	{ path: '/PageItem', component: OldPageItem, name: 'Comics' }, // ATTENTIION CHANGERT LE NOM DE LA ROUTE
	// { path: '/articles/:id', component: PostDetail, name: 'Article', props: true },
];

const router = createRouter({
	// 4. Provide the history implementation to use. We are using the hash history for simplicity here.
	history: createWebHistory(),
	routes, // short for `routes: routes`
});
const pinia = createPinia();

// Pour nomer la page selon le nom de la route
router.beforeEach((to, from, next) => {
	document.title = to.name;
	next();
});

const app = createApp(App);

app.use(router);
app.use(pinia);

app.mount('#app');
