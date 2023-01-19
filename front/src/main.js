import './style.css';

import { createApp } from 'vue';
import { createPinia } from 'pinia';
import { createRouter, createWebHistory } from 'vue-router';
import { authGuard, MyAccountGuard, AdminGuard, ComicsGuard } from './_helpers/guards.js';

import App from './App.vue';
import * as Page from './views/route-import.js';


const routes = [
	{ path: '/', component: Page.Home, name: 'Home' },
	{ path: '/Registration', component: Page.Registration, name: 'Registration'}, 
	{ 
		path: '/Comics/:id(\\d+)', component: Page.Comics, name: 'Comics', props: true, beforeEnter: ComicsGuard
	}, 
	{ 
		path: '/Login', component: Page.Login, name: 'Login', beforeEnter: authGuard
	}, 
	{ 
		path: '/MyAccount', component: Page.ProfilUser, name: 'ProfilUser', beforeEnter: MyAccountGuard
	}, 
	{ 
		path: '/Marvel', component: Page.MarvelPage, name: 'MarvelPage'
	}, 
	{ 
		path: '/DC-Comics', component: Page.DcComics, name: 'DC-Comics'
	}, 
	{ 
		path: '/Admin', component: Page.Admin, name: 'Admin', beforeEnter: AdminGuard
	}, 
	{ path: '/:pathMatch(.*)*', redirect: '/' }
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
