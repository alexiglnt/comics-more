<script>
import Navbar from './Elements/Navbar.vue';
import ScrollToUpBtn from './Elements/ScrollToUpBtn.vue';
import Card from './Elements/Card.vue';

import axios from 'axios';
import instance from '../../axios-infos';

export default {
    components: {
        Navbar, ScrollToUpBtn, Card
    },
    data() {
        return {
            comics: [],
            comicsByResearch: [],
            research: ''
        }
    },
    methods: {
        goToComicPage(data) {
            this.$router.push({
                name: 'Comics',
                params: { id: data.id }
            });
        },
        readTheComic(comic) {
            localStorage.setItem('currentComic', JSON.stringify(comic));
            this.$router.push({ path: `/Comics/${comic.name}` })
        },
        ScrollTo(id) {
            const element = document.querySelector(id);
            element.scrollIntoView({ behavior: 'smooth' });
        },
        recupComics() {

            const URL = `${instance.baseURL}/api/comics`;

            axios.get(URL)
                .then((response) => {
                    this.comics = response.data['hydra:member'];
                    console.log(this.comics);

                    // Replace + by space in the name of the comics
                    this.comics.forEach(comic => {
                        comic.name = this.convertName(comic.name, '+', ' ');
                    });

                })
                .catch((error) => {
                    console.log(error);
                });

        },
        convertName(str, pattern, replacement) {
            str = str.replaceAll(pattern, replacement);
            return str;
        },
        searchComics() {
            this.comicsByResearch = [];
            // search comics by research
            this.comics.forEach(comic => {
                if (comic.name.toLowerCase().includes(this.research.toLowerCase())) {

                    this.comicsByResearch.push(comic);
                }
            });

        }
    },
    mounted() {
        this.recupComics();
    }
}

</script>

<template>

    <Navbar />

    <!-- HOMEPAGE -->
    <section id="homepage">

        <div class="accueil">
            <img src="../assets/wave.svg" class="fond-curvy" alt="">
        </div>

        <div class="presentation">
            <p>Bienvenue sur</p> <br>
            <h1> Comics More </h1> <br>
            <a id="btn-scroll" class="btn" @click="() => ScrollTo('#btn-scroll')">
                Découvrir
                <span class="material-symbols-outlined"> keyboard_double_arrow_down </span>
            </a>
        </div>
    </section>

    <div class="container">

        <div class="slogan">
            <h1> <span> C</span>hoisissez, <span>&nbspL</span>isez et<span>&nbsp P</span>rofitez ! </h1>
        </div>

        <!-- RESEARCH BAR -->
        <form @submit.prevent="searchComics">
            <input type="text" placeholder="Rechercher un comic" v-model="this.research">
            <button type="submit">
                <span class="material-symbols-outlined"> search </span>
            </button>
        </form>

        <!-- COMICS -->
        <div class="grid-container" v-if="this.comicsByResearch.length != 0">
            <div v-for="comic in comicsByResearch" :key="comic.id">
                <div class="card">
                    <Card :data="comic" :handle-click="this.readTheComic" />
                </div>
            </div>
        </div>
        <div class="grid-container" v-else>
            <div v-for="comic in comics" :key="comic.id">
                <div class="card">
                    <Card :data="comic" :handle-click="this.readTheComic" />
                </div>
            </div>
        </div>


        <ScrollToUpBtn />

    </div>

</template>

<style scoped >
#homepage {
    background-color: var(--background-color);
    height: 100vh;
    width: 100%;
}

.accueil,
.presentation {
    background-color: var(--background-color);
    width: 100%;
}

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    width: 100%;
}

.container form {
    width: 1500px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 50px;
    position: relative;
}

.container form input {
    width: 50%;
    height: 50px;
    border-radius: 10px;
    border: 3px solid var(--font-color);
    padding: 0 20px;
    font-size: 1.5em;
    outline: none;
    background-color: var(--background-color);
    color: var(--font-color);
}

.container form input:focus {
    border: 5px solid var(--main-color);
}

.container form button {
    width: 70px;
    height: 70px;
    border-radius: 1em;
    border: 0px solid var(--font-color);
    background-color: var(--main-color);
    color: var(--font-color);
    font-size: 1.5em;
    outline: none;
    cursor: pointer;
    margin: 0 0px;
    position: absolute;
    right: 300px;
    transition: 0.3s ease;
}

.container form button span {
    font-size: 1.5em;
}
.container form button:hover {
    transform: scale(1.1);
    transition: 0.3s ease;
}

h1 {
    font-size: 3em;
}

.slogan {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    width: 100%;
    margin-bottom: 50px;
}

.slogan h1 {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 50px;
    font-family: 'Verdana', sans-serif;
}

h1 span {
    color: #3D91C0;
}

a {
    text-decoration: none;
    font-size: 2em;
    margin-top: 20px;
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    grid-gap: 30px;
    width: 90%;
}

.card {
    background-color: transparent;
    color: var(--font-color);
    border-radius: 10px;
    /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); */
    padding: 20px;
    font-size: 1.5em;
    text-align: center;
    margin-bottom: 0px;

    width: 200px;

    transition: all 0.3s ease-in-out;
}

.card:hover {
    transform: scale(1.1);
    transition: all 0.3s ease-in-out;
}

.card img {
    width: 200px;
}


.fond-curvy {
    width: 100%;
    position: absolute;
    left: 0;
    bottom: 20%;
    display: block;
    z-index: -1;

    user-select: none;
    /* désactivé la surbrillance de texte sélectionné */
}

.accueil {
    height: 10vh;
    width: 100%;
    background-color: #FFA800;
    max-height: 60vh;
}

.presentation {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.presentation p {
    font-size: 25px;
    margin-bottom: 10px;
}



.presentation a span {
    transform: translateY(5px);
}

.presentation h1 {
    font-size: 100px;
    font-family: 'Dimis';
    font-weight: 900;
    margin: 50px;
    transform: skew(4deg, 4deg);
}
</style>