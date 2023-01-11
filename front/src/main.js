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
import Login from './components/Login.vue';
import Registration from './components/Registration.vue';


const routes = [
	{ path: '/', component: Home, name: 'Home' },
	{ path: '/OldPageItem', component: OldPageItem, name: 'OldPage' }, 
	{ path: '/PageItem', component: PageItem, name: 'Comics' }, 
	{ path: '/PageItem/:id', component: PageItem, name: 'Comicss', props: true }, 
	{ path: '/Login', component: Login, name: 'Login'}, 
	{ path: '/Registration', component: Registration, name: 'Registration'}, 
];






const router = createRouter({
	// 4. Provide the history implementation to use. We are using the hash history for simplicity here.
	history: createWebHistory(),
	routes, // short for `routes: routes`
});
const pinia = createPinia();

// Pour nomer la page selon le nom de la route
router.beforeEach((to, from, next) => {
	document.title = `${to.name} | Comics More`;
	next();
});

const app = createApp(App);

app.use(router);
app.use(pinia);

app.mount('#app');
