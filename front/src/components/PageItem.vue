<script>
import ScrollToTop from './Elements/ScrollToUpBtn.vue';
import Navbar from './Elements/Navbar.vue';

import instance from '../../axios-infos.js'
import axios from 'axios';

export default {
    name: 'Home',
    components: {
        ScrollToTop, Navbar
    },
    data() {
        return {
            currentCollection: [],      // les infos de la collection courante
            currentComic: {},            // les infos du comics courant
            linkImages: []
        }
    },
    methods: {
        // Récupération des liens des images du comics depuis la BDD liée à l'API
        async recupCollection() {
            // On sauvegarde les infos du comics actuel dans la variable currentComic
            this.currentComic = await JSON.parse(localStorage.getItem('currentComic'));

            // Requete GET pour récupérer le nom de la collection
            const URL = `${instance.baseURL}/api/comics_collections/${this.currentComic.collection_id}`;
            axios.get(URL)
                .then(response => {
                    console.log(response.data);

                    // On récupère les infos de la collection actuelle
                    this.currentCollection = response.data;

                    // On lance cette fonction pour récupérer les infos du comics actuel
                    this.recupComic();
                })
                .catch(error => {
                    console.log(error)
                })
        },
        recupComic() {

            let numero = 0;
            for (let i = 1; i < this.currentComic.nb_pages + 1; i++) {
                if (i <= 9) {
                    numero = '00' + i.toString();
                    this.linkImages.push(`${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}`);
                }
                else if (i > 9 && i <= 99) {
                    numero = '0' + i.toString();
                    this.linkImages.push(`${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}`);
                }
                else {
                    numero = i.toString();
                    this.linkImages.push(`${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}`);
                }
            }

        }
    },
    async mounted() {
        await this.recupCollection();
    }
}

</script>


<template>

    <Navbar />

    <div class="container-infos">

        <div class="left-right">
            <div class="left">
                <img :src="linkImages[0]" width="1000px">
            </div>
            <div class="right">
                <div>
                    <h1> {{ this.currentComic.name }} </h1>
                    <h2> Collection : {{ this.currentCollection.name }} </h2>
                    <h2> Nombre de pages : <b> {{ this.currentComic.nb_pages }} </b> </h2>
                </div>
            </div>
        </div>

    </div>


    <p class="nbPage"> Total Pages : <b> {{ this.currentComic.nb_pages }} </b> </p>


    <h1> Lecture </h1> <br>

    <!-- On affiche les images du comics -->
    <div class="container-images">
        <div class="images" v-for="image in linkImages">
            <img :src="image" alt="page">
        </div>
    </div>

    <ScrollToTop />

</template>


<style scoped >
h1 {
    text-align: center;
    font-size: 3em;
}

h2 {
    text-align: center;
}

.container-infos {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.left-right {
    max-width: 1000px;
    margin-bottom: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.left {
    width: 100%;
    height: 100%;
}

.left img {
    width: 70%;
}

.left,
.right {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50vw;
}

.container-images img {
    max-width: 760px;
}

.images {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    flex-direction: column;
}

.nbPage {
    position: fixed;
    bottom: 30px;
    left: 30px;
    color: rgba(255, 255, 255, 0.6);
}
</style>