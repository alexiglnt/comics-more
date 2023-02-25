<script>
import Navbar from './Elements/Navbar.vue';
import Card from './Elements/Card.vue';

import axios from 'axios';
import instance from '../../axios-infos';

export default {
    name: 'CollectionComponent',
    components: {
        Navbar, Card
    },
    data() {
        return {
            collection: {
                name: ''
            },
            comics: [],
            comicsID: []
        };
    },
    methods: {
        getComics(tab) {
            tab.forEach(id => {
                const URl = `${instance.baseURL}/api/comics/${id}`;

                axios.get(URl)
                    .then((response) => {

                        // Pour chaque comic, on remplace les + par des espaces
                        response.data.name = response.data.name.replaceAll('+', ' ');

                        this.comics.push(response.data);
                    })
                    .catch((error) => {
                        console.log(error);
                    });

                // Trier les comics par ordre alphabétique
                this.comics.sort();
            });
        },
        getCollection() {
            const URl = `${instance.baseURL}/api/comics_collections`;

            axios.get(URl)
                .then((response) => {
                    let tmp = response.data['hydra:member'].filter(collection => collection.name === this.$route.params.name);

                    // Si la collection n'existe pas, on redirige vers la page d'accueil
                    if (tmp.length === 0) {
                        this.$router.push('/');
                    }

                    this.collection = tmp[0];
                    this.comicsID = this.collection.comics;

                    this.comicsID = this.comicsID.map(comic => {
                        comic = comic.replace('/api/comics/', '');
                        return comic;
                    });

                    this.getComics(this.comicsID);
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
        this.collection.name = this.$route.params.name;
        await this.getCollection();
    }
}

</script>


<template>

    <Navbar />
    <div class="container">
        <h1> COLLECTION <span> {{ collection.name }} </span> </h1>

        <p v-if="collection.description" >
            <span class="material-symbols-outlined"> format_quote </span> 
            <br> {{ collection.description }} <br>
            <span class="material-symbols-outlined second"> format_quote </span> <br>
        </p>

        <div class="grid-container">
            <div v-for="comic in comics" :key="comic.id">
                <div class="card">
                    <Card :data="comic" :handle-click="() => this.readTheComic(comic)" />
                </div>
            </div>
        </div>

    </div>

</template>


<style scoped >
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    margin-top: 120px;

}

.container p {
    width: 70%;
    text-align: justify;
    margin: 50px auto;
    line-height: 2em;
    font-style: italic;
}

.container p span {
    font-size: 5em;
    color: var(--primary-color);
}

.container span:nth-child(1) {
    text-align: start;
    transform: rotate(180deg);
}
.container .second {
    float: right;
}

h1 {
    font-size: 3em;
    font-family: var(--secondary-font);
}

h1 span {
    color: var(--main-color);
    text-transform: uppercase;
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    grid-gap: 10px;
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
    max-width: 200px;

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

