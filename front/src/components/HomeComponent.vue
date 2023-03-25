<script>
import Navbar from './Elements/Navbar.vue';
import ScrollToUpBtn from './Elements/ScrollToUpBtn.vue';
import Card from './Elements/Card.vue';
import Footer from './Elements/Footer.vue';
import Carousel from './Elements/Carousel.vue';
import BandeDefilante from './Elements/BandeDefilante.vue';

import axios from 'axios';
import instance from '../../axios-infos';

import gsap from "gsap";
import AOS from 'aos';
import 'aos/dist/aos.css'; // importer les styles CSS de AOS
import 'animate.css';

export default {
    components: {
        Navbar, ScrollToUpBtn, Card, Footer, Carousel, BandeDefilante
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

            // inverser l'ordre du tableau
            this.lastComics.reverse();

            console.log('les n derniers', this.lastComics);

        },
        beforeEnter(el) {
            el.style.opacity = 0;
            el.style.transform = "translateY(-80px)";
        },
        showSuggestions(){
            const searchInput = document.getElementById('searchInput');
            const input = searchInput.value;
            const result = this.comics.filter(item => item.name.toLowerCase().includes(input.toLowerCase()));

            let suggestion = '';
            const inputSizeToBegin = 2;
            let nbSuggestions = result.length > 4 ? 5 : result.length;

            if(input.length > inputSizeToBegin){
                for(let i = 0 ; i < nbSuggestions ; i++){
                    suggestion += `<a class="suggestion" href="/Comics/${result[i].id}"><div id="suggestions">${result[i].name}</div></a>`;
                    console.log(result);
                }
                document.getElementById('suggestions').innerHTML = suggestion;
            }
            else{
                document.getElementById('suggestions').innerHTML = '';
            }           
},

        enter(el) {
            gsap.to(el, {
                opacity: 1,
                y: 0,
                duration: 0.5,
                delay: el.dataset.index * 0.2,
            });
        },
    },
    async mounted() {
        await this.recupComics();

        AOS.init();
    }
}

</script>

<template>
    <!-- HOMEPAGE -->

    <section class="bg-home" >
        <Navbar />
            <div class="home-container" >
                <h1 class="animate__animated animate__backInDown" > Comics More </h1>
                <button type="button" class="btn callAction" @click="() => ScrollTo('.slogan')"> Choisissez votre BD </button>
            </div>
        </section>



    <!-- CAROUSEL -->
    <div class="slogan" data-aos="fade-up">
        <h1> <span>&nbsp N</span>OS <span>&nbsp D</span>ERNIERS<span>&nbsp A</span>JOUTS </h1>
        <!-- <h1> $ £ @ # % & </h1> -->
    </div>
    <div class="carousel-container" data-aos="flip-left">
        <Carousel :data="lastComics" />
    </div>

    <!-- CONTAINER Searchbar + Comics -->
    <div class="container">

        <div class="slogan" data-aos="fade-up">
            <h1> <span> C</span>HOISISSEZ, <span>&nbspL</span>ISEZ ET<span>&nbspP</span>ROFITEZ ! </h1>
        </div>


        <!-- RESEARCH BAR -->
        <form @submit.prevent="searchComics" @keyup=showSuggestions>
            <div class="box-searchBar">
                <input id="searchInput" type="text" placeholder="Vous cherchez quelque chose ?" v-model="this.research">
                <button type="submit">
                    <span class="material-symbols-outlined"> search </span>
                </button>
                <div id="suggestions"></div>
            </div>
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
                <div class="card" data-aos="flip-left">
                    <Card :data="comic" :handle-click="this.readTheComic" />
                </div>
            </div>
        </div>
        <div class="grid-container" v-else>
            <div v-for="comic in comics" :key="comic.id">
                <div class="card" data-aos="flip-left">
                    <Card :data="comic" :handle-click="this.readTheComic" />
                </div>
            </div>
        </div>


        <ScrollToUpBtn />
        <!-- <Footer /> -->

    </div>
</template>



<style scoped >
.callAction {
    animation-name: pulse;
    animation-duration: 1s;
    animation-iteration-count: infinite;
}

@keyframes pulse {
    0% {
        transform: scale(1);
    }

    50% {
        transform: scale(1.1);
    }

    100% {
        transform: scale(1);
    }
}

.bg-home {
    background-image: url('../assets/HomeBackground2.png');
    background-size: cover;
    background-attachment: fixed;
    height: 100vh;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;

    margin-bottom: 100px;
}


.bg-home h1 {
    font-family: var(--font-full);
    font-size: calc(6vw + 6vh);
    color: var(--yellow);
    text-align: center;
    margin-top: 10%;
    padding-bottom: 120px;
    -webkit-text-stroke: 10px #000;
    text-shadow: 0 0 50px #000;
    margin: 0;
}

.home-container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.home-container button {
    font-size: 1.5em;
    margin-bottom: 20px;
}

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
    width: 800px;
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
    color: var(--bg-color);
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
    font-size: 60px;
    font-family: var(--secondary-font);
}

h1 span {
    color: var(--secondary-color);
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


/* Cassé wtf */
a.suggestion {
  color: inherit;
  text-decoration: none;
}
a.suggestion:hover {
  background-color: #e0e0e0;
  color: black;
}
</style>