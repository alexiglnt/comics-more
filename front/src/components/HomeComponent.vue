<script>
import Navbar from './Elements/Navbar.vue';
import ScrollToUpBtn from './Elements/ScrollToUpBtn.vue';
import Card from './Elements/Card.vue';
import Footer from './Elements/Footer.vue';
import Carousel from './Elements/Carousel.vue';

import axios from 'axios';
import instance from '../../axios-infos';

export default {
    components: {
        Navbar, ScrollToUpBtn, Card, Footer, Carousel
    },
    data() {
        return {
            comics: [],
            comicsByResearch: [],
            research: '',
            researchNotFound: false,
            lastComics: [],
            isConnected: localStorage.getItem('isConnected'),
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
            this.$router.push({ path: `/Comics/${comic.id}` })
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

                    // convert name
                    this.comics.forEach(comic => {
                        comic.name = this.convertName(comic.name, '+', ' ');
                    });

                    this.recupLastComics(9);

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
            this.researchNotFound = false;
            // search comics by research
            this.comics.forEach(comic => {
                if (comic.name.toLowerCase().includes(this.research.toLowerCase())) {

                    this.comicsByResearch.push(comic);
                }
            });

            if (this.comicsByResearch.length == 0) {
                this.researchNotFound = true;
                document.querySelector('.grid-container').style.display = 'none';
            }
        },
        resetResearch() {
            this.comicsByResearch = [];
            this.research = '';
            this.researchNotFound = false;
            document.querySelector('.grid-container').style.display = 'grid';
        },
        recupLastComics(n) {

            // En dessous de 9, le carousel s'affiche mal
            if (n < 9) {
                n = 9;
            }

            // On recupere les n derniers comics
            let negatif = -n;
            for (let i = 0; i < n; i++) {

                this.lastComics.push(this.comics.at(negatif));
                negatif++;
            }

            console.log('les n derniers', this.lastComics);

        },
    },
    async mounted() {
        await this.recupComics();
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
            <h1 class="bienvenue" >BIENVENUE SUR</h1> <br>
            <h1> Comics More </h1> <br>
            <button type="button" class="btn" @click="() => ScrollTo('.slogan')">
                Choisissez votre comics !
            </button> <br> <br>
            <p v-if="isConnected == 'false'" > 10 crédits gratuits à votre première inscription ! </p>
        </div>
    </section>



    <!-- CAROUSEL -->
    <div class="slogan">
        <h1> <span>&nbsp N</span>OS <span>&nbsp D</span>ERNIERS<span>&nbsp A</span>JOUTS @ </h1>
        <!-- <h1> $ £ @ # % & </h1> -->
    </div>
    <div class="carousel-container">
        <Carousel :data="lastComics" />
    </div>



    <!-- CONTAINER Searchbar + Comics -->
    <div class="container">

        <div class="slogan">
            <h1> <span> C</span>HOISISSEZ, <span>&nbspL</span>ISEZ ET<span>&nbsp P</span>ROFITEZ ! </h1>
        </div>


        <!-- RESEARCH BAR -->
        <form @submit.prevent="searchComics">
            <input type="text" placeholder="Vous cherchez quelque chose ?" v-model="this.research">
            <button type="submit">
                <span class="material-symbols-outlined"> search </span>
            </button>
        </form>


        <!-- COMICS -->
        <div class="research-not-found" v-if="this.researchNotFound == true">
            <h2> Aucun résultat trouvé 😔 </h2>
            <button type="button" class="btn" @click="resetResearch">
                Réinitialiser la recherche
            </button>
        </div>
        <div class="grid-container" v-else-if="this.comicsByResearch.length != 0">
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
        <!-- <Footer /> -->

    </div>

</template>



<style scoped >
#homepage {
    background-color: var(--background-color);
    height: 100vh;
    width: 100%;
}

.presentation {
    background-color: var(--background-color);
    width: 100%;
}

.presentation .bienvenue {
    font-family: var(--secondary-font);
    font-size: 3.5em;
    color: #333;
    margin-bottom: 10px;
}

.presentation button {
    background-color: var(--secondary-color);
    color: var(--bg-color);
    font-size: 1.5em;
}

.presentation button span {
    transform: translateY(5px);
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
    margin-top: 50px;
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

.carousel-container {
    width: 50%;
    height: 50%;
    margin: 0px auto;
    margin-top: 0;
    margin-bottom: 100px;
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
}

.slogan h1 {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 80px;
    font-family: var(--secondary-font);
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
    background-color: var(--main-color);
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

.research-not-found {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
</style>