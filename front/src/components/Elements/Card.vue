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
        <div class="card" @click="clicked">
            <img :src="link" alt="" width="100%">
            <p> {{ comic.name }} </p>
            <p> <span> Collection : <b> {{ collection.name }} </b> </span> </p>
        </div>
    </div>

</template>



<style scoped>
.container {
    display: flex;
    justify-content: center;
    align-items: center;
}

img {
    width: 100%;
}

.card p {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    text-align: start;
    font-size: 0.8em;
    margin: 5px;
    margin-inline: 0;
}

.card p span {
    font-size: 0.8em;
    margin: 3px;
    margin-inline: 0;
}


</style>