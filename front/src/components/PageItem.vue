<script>
    import ScrollToTop from './Elements/ScrollToUpBtn.vue'

    import instance from '../../axios-infos.js'
    import axios from 'axios';

    export default {
        name: 'Home',
        components: {
            ScrollToTop
        },
        data() {
            return {
                tabImages: [],
                links: []
            }
        },
        methods: {
            // Récupération des liens des images du comics depuis la BDD liée à l'API
            recupImage() {
                const URL = `${instance}/api/comics_collections`;

                axios.get(URL)
                .then(response => {
                    console.log(response.data["hydra:member"]);
                })
                .catch(error => {
                    console.log(error)
                })
            },
        },
        async mounted() {
            //await this.recupImageWithPagination('/api/stock_images?page=1')
            await this.recupImage();
        }
    }

</script>


<template>

    <h1> Comics </h1>

    <p class="nbPage" > Total Pages : <b> {{ tabImages.length }} </b> </p>

    <!-- On affiche les images du comics -->
    <div class="container-images">
        <div class="images" v-for="image in tabImages" >
            <img :src="image.link" alt="page">
        </div>
    </div>

    <ScrollToTop />

</template>


<style scoped >

    h1 {
        text-align: center;
        font-size: 3em;
    } 

    .container-images img {
        max-width: 1000px;
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