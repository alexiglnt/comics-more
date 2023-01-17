<script>
import Card from './Card.vue';

import axios from 'axios';
import instance from '../../../axios-infos';

export default {
    name: 'Collection',
    components: { Card },
    props: ['name', 'house'],
    data() {
        return {
            comics: [],
            comicsLinks: [],
            collections: [],
        }
    },
    methods: {
        readTheComic(comic) {
            localStorage.setItem('currentComic', JSON.stringify(comic));
            this.$router.push({ path: `/Comics/${comic.id}` })
        },
        getCollection() {
            const URL = `${instance.baseURL}/api/comics_collections`;

            axios.get(URL)
                .then((response) => {

                    //const tpmCollections = response.data['hydra:member'];

                    // Filter the collections to get the one with the name passed in props
                    this.collections = response.data['hydra:member'].filter(collection => collection.name == this.name);
                    this.comicsLinks = this.collections[0].comics;

                    this.getComics();
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        async getComics() {
            await this.comicsLinks.forEach(comicLink => {
                axios.get(`${instance.baseURL}${comicLink}`)
                    .then((response) => {

                        // Replace + by space in the name of the comics
                        let tmp = response.data;
                        tmp.name = tmp.name.replaceAll('+', ' ');


                        // Add the comic to the comics array
                        this.comics.push(tmp);
                    })
                    .catch((error) => {
                        console.log(error);
                    });
            });

            // Replace + by space in the name of the comics
            this.comics.forEach(comic => {
                comic.name = comic.name.replaceAll('+', ' ');
            });

        },
    },
    mounted() {
        this.getCollection();
    },
}

</script>




<template>

    <div class="container">
        <div class="line">
            <div v-if="this.house == 'marvel'" >
                <h1> Collection <span style="color: var(--marvel-color);" > {{ name }} </span> </h1>
            </div>
            <div v-else-if="this.house == 'dc'" >
                <h1> Collection <span style="color: var(--dc-color);" > {{ name }} </span> </h1>
            </div>
            <div v-else >
                <h1> Collection <span style="color: var(--main-color);" > {{ name }} </span> </h1>
            </div>
        </div>
        <div class="grid-collection">
            <div v-for="comic in comics">
                <div class="card">
                    <Card :data="comic" :handleClick="this.readTheComic" />
                </div>
            </div>
        </div>
    </div>


</template>




<style scoped >
.container {
    margin-inline: 5%;
}

.line h1 {
    text-align: start;
}

.grid-collection {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    grid-gap: 20px;
    margin-top: 20px;
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