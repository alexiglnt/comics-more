<script>
import instance from '../../../axios-infos';
import axios from 'axios';

export default {

    props: ['data', 'handleClick'],
    data() {
        return {
            comic: {},
            link: '',
            collection: {}
        }
    },

    methods: {
        clicked() {
            this.handleClick(this.data)
        },
        recupCollection() {
            const URL = `${instance.baseURL}${this.comic.comicsCollection}`;

            axios.get(URL)
                .then(response => {
                    this.collection = response.data;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        readTheComic(comic) {
            localStorage.setItem('currentComic', JSON.stringify(comic));
            this.$router.push({ path: `/Comics/${comic.id}` })
        },
    },

    async mounted() {
        this.comic = this.data;
        this.recupCollection();
        this.link = `https://comicsmore.s3.eu-west-3.amazonaws.com/${this.comic.name}/001.${this.comic.extension}`;
    }
}

</script>



<template>

    <div class="container">
        <div class="band-connect">
            <div class="band-connect-left">
                <div>
                    <h2 title="Nom du comics" > {{ comic.name }} </h2>
                    <!-- <p title="Nom de la collection" > Collection : <b> {{ collection.name }} </b> </p>
                    <p title="Nombre de pages" > Nombre de pages : <b> {{ comic.nbPage }} </b> </p> -->
                </div>
                <button type="button" class="btn" @click="() => this.readTheComic(comic) ">
                    Vous voulez le lire ?
                </button>
            </div>
            <img :src="this.link" alt="">
        </div>
    </div>

</template>



<style scoped>
.container {
    width: 8rem;
    height: 30rem;
    margin: 0 auto;
    display: flex;
    justify-content: center;
    align-items: center;
}

.band-connect {
    display: flex;
    justify-content: center;
    align-items: center;

    margin: 50px auto;
    width: 50rem;
    height: 65%;

    transform: scale(1.3);

    background: var(--main-color);
    margin: 0 auto;

    position: absolute;
}

.band-connect h2 {
    font-size: 1.8em;
    color: var(--bg-color);
    line-height: 30px;
    text-align: center;

    margin: 0 20px;
}

.band-connect img {
    width: 70%;
    height: 100%;
    object-fit: cover;
}

.band-connect-left {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 300px;
}

.band-connect-left div {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 100%;
    margin-bottom: 30px;
}

</style>