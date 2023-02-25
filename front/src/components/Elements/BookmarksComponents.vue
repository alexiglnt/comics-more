<script>
import axios from 'axios';
import instance from '../../../axios-infos';
import { accountService } from '../../_services';

import Card from './Card.vue';

export default {
    name: 'Bookmarks',
    components: {
        Card
    },
    data() {
        return {
            bookmark: {},
            tabIDComics: [],
            comics: [],
            comicsByResearch: [],
            research: '',
            researchNotFound: false,
        }
    },
    methods: {
        getBookmarks() {

            const URl = `${instance.baseURL}/api/bookmarks`;

            axios.get(URl, {
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${localStorage.getItem('token')}`
                }
            })
                .then((response) => {

                    response.data['hydra:member'].forEach(bookmark => {
                        if (bookmark.userID === JSON.parse(localStorage.getItem('userInfos')).id) {
                            this.bookmark = bookmark;
                        }
                    });

                    // On récupère les id des comics et on les met dans un tableau
                    this.tabIDComics = this.bookmark.comicsId.split('/').filter((item) => item !== '');
                    console.log(this.tabIDComics);

                    // On récupère les infos des comics
                    this.getComics();

                })
                .catch((error) => {
                    accountService.tokenExpired(error);
                    console.log(error);
                });
        },
        getComics() {

            // Pour chaque id de comics, on récupère les infos du comic
            this.tabIDComics.forEach(idComic => {
                const URl = `${instance.baseURL}/api/comics/${idComic}`;

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
    },
    mounted() {
        this.getBookmarks();
    },
}
</script>



<template>
    <div class="bookmarks-container">

        <!-- RESEARCH BAR -->
        <div class="form">
            <form @submit.prevent="searchComics">
                <input type="text" placeholder="Vous cherchez quelque chose ?" v-model="this.research">
                <button type="submit">
                    <span class="material-symbols-outlined"> search </span>
                </button>
            </form>
        </div>

        <div v-if="comics.length == 0">
            <h2> Vous n'avez aucun favoris 😭 </h2>
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
.bookmarks-container {
    margin-top: 100px;
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    grid-gap: 20px;
    margin: 0 auto;
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

.form {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

form {
    width: 1400px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 50px;
    margin-top: 50px;
    position: relative;
}

.research-not-found {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

form input {
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

form input:focus {
    border: 5px solid var(--main-color);
}

form button {
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

form button span {
    font-size: 1.5em;
}

form button:hover {
    transform: scale(1.1);
    transition: 0.3s ease;
}
</style>