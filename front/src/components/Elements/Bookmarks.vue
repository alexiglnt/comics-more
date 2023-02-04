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
            comics: []
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
    },
    mounted() {
        this.getBookmarks();
    },
}
</script>



<template>

    <div class="bookmarks-container">

        <div class="grid-container">
                
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

</style>