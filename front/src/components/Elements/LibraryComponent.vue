<script>
import Navbar from './Navbar.vue';
import Card from './Card.vue';

import axios from 'axios';
import instance from '../../../axios-infos';

export default {
    name: 'LibraryComponent',
    components: {
        Navbar, Card
    },
    data() {
        return {
            tabLibrary: [],
            comics: [],
            isAdmin: JSON.parse(localStorage.getItem('userInfos')).roles[0] === 'ROLE_ADMIN' ? true : false,
            comicsByResearch: [],
            research: '',
            researchNotFound: false,
        };
    },
    methods: {
        getLibrary() {
            if (localStorage.getItem('userLibrary')) {
                let library = localStorage.getItem('userLibrary');

                this.tabLibrary = JSON.parse(library).comicsUserHas.split(',');

                // On enleve le 1er element du tableau (0)
                this.tabLibrary.shift();

                console.log(this.tabLibrary);

                this.getComics(this.tabLibrary);

            }
        },
        getComics(tabIDComics) {

            // Pour chaque id de comics, on récupère les infos du comic
            tabIDComics.forEach(idComic => {
                const URl = `${instance.baseURL}/api/comics/${idComic}`;
                console.log(URl);

                axios.get(URl)
                    .then((response) => {

                        let tmp = response.data;
                        tmp.name = tmp.name.replaceAll('+', ' ');
                        this.comics.push(tmp);
                    })
                    .catch((error) => {
                        console.log(error);
                    });
            });

            console.log(this.comics);
        },
        getAllComics() {
            const URl = `${instance.baseURL}/api/comics`;

            axios.get(URl)
                .then((response) => {
                    response.data['hydra:member'].forEach(comic => {
                        comic.name = comic.name.replaceAll('+', ' ');
                        this.comics.push(comic);
                    });
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        readTheComic(comic) {
            localStorage.setItem('currentComic', JSON.stringify(comic));
            this.$router.push({ path: `/Comics/${comic.id}` })
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
        showSuggestions() {
            const searchInput = document.getElementById('searchInput');
            const input = searchInput.value;
            const result = this.comics.filter(item => item.name.toLowerCase().includes(input.toLowerCase()));
            let suggestion = '';
            const inputSizeToBegin = 0;
            let nbSuggestions = result.length > 4 ? 5 : result.length;
            if (input.length > inputSizeToBegin) {
                for (let i = 0; i < nbSuggestions; i++) {
                    suggestion += `<a class="suggestion" href="/Comics/${result[i].id}"><p id="suggestion-item">${result[i].name}</p></a>`;
                    console.log(result);
                }
                document.getElementById('suggestions').innerHTML = suggestion;
            }
            else {
                document.getElementById('suggestions').innerHTML = '';
            }
        },
    },
    async mounted() {
        console.log(this.isAdmin);

        if (!this.isAdmin) {
            await this.getLibrary();
        }
        else {
            await this.getAllComics();
        }
    }
};

</script>


<template>
    <Navbar />

    <div class="library">
        <h1> VOTRE BIBLIOTHEQUE </h1> <br> <br>

        <!-- RESEARCH BAR -->
        <div class="form">
            <form @submit.prevent="searchComics" @keyup=showSuggestions>
                <div class="box-searchBar">
                    <input id="searchInput" type="text" placeholder="Vous cherchez quelque chose ?" v-model="this.research">
                    <button type="submit">
                        <span class="material-symbols-outlined"> search </span>
                    </button>
                    <div id="suggestions"></div>
                </div>
            </form>
        </div>

        <div v-if="comics.length == 0">
            <h2> Vous n'avez aucun comics dans votre bibliotheque 😭 </h2>
        </div>
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

    </div>
</template>


<style scoped >
.library {
    margin-top: 150px;
    margin-left: 100px;
}

.library h1 {
    font-family: var(--secondary-font);
    letter-spacing: 2px;
    font-size: 3em;
    padding-right: 100px;

    text-align: center;
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    grid-gap: 10px;
    width: 100%;
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

h2 {
    text-align: center;
    font-size: 2em;
    letter-spacing: 2px;
}

.research-not-found {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.form {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

form {
    width: 1500px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 50px;
    margin-top: 50px;
    position: relative;
}

form input {
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

form input:focus {
    border: 5px solid var(--main-color);
}

form button {
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
    transform: translateY(-6px);
}

form button span {
    font-size: 1.5em;
}

form button:hover {
    transform: scale(1.1) translateY(-6px);
    transition: 0.3s ease;
}
</style>