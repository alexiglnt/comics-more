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
            isAdmin: JSON.parse(localStorage.getItem('userInfos')).roles[0] === 'ROLE_ADMIN' ? true : false
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
    },
    async mounted() {
        console.log(this.isAdmin);
        
        if(!this.isAdmin) {
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

        <div v-if="comics.length == 0" >
            <h2> Vous n'avez aucun favoris 😭 </h2>
        </div>
        <div v-else class="grid-container">
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

</style>