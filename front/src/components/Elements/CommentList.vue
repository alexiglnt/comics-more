<script>

import axios from 'axios';
import instance from '../../../axios-infos';

import Comment from './CommentItem.vue';

export default {
    name: 'CommentList',
    props: ['comic'],
    components: {
        Comment
    },
    data() {
        return {
            comments: [],
            isConnected: false,
            library: [],
            isInLibrary: false
        }
    },
    methods: {
        getComments() {
            axios.get(`${instance.baseURL}/api/comments?expand=comicsId,userId`)

                .then(response => {
                    console.log(response.data['hydra:member']);

                    // On tri les commentaires par rapport à l'id du comic
                    this.comments = response.data['hydra:member'].filter(comment => comment.comicId === this.comic.id);
                })
                .catch(error => {
                    console.log(error);
                })
        },
        test() {
            let date = new Date().toLocaleString('fr-FR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' });
            console.log(date)
        },
    },
    mounted() {
        this.getComments();

        this.isConnected = localStorage.getItem('isConnected');


        if (localStorage.getItem('userLibrary')) {
            this.library = JSON.parse(localStorage.getItem('userLibrary')).comicsUserHas;

            this.library = this.library.split(',');

            this.library.forEach(comic => {
                if (comic == this.comic.id) {
                    this.isInLibrary = true;
                }
            })
        }

        console.log(this.library);
    }
}

</script>


<template>
    <div>
        <h2 v-if="comments.length !== 0"> Ce que les utilisateurs ont pensés de ce comics ! </h2>
        <div v-else-if="comments.length === 0 && this.isInLibrary == true" class="arrow-container">
            <h2>
                Soyez le premier à ajouter un commentaire !
            </h2>
            <p class="redArrow">
                <span class="material-symbols-outlined "> north </span>
            </p>
        </div>
        <div v-else>
            <h2> Il n'y a aucun commentaires pour le moment </h2>
        </div>
        <div v-for="comment in comments" :key="comment.id">
            <Comment :comment="comment" /> <br>
        </div>
    </div>
</template>


<style scoped >
div {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.arrow-container {
    display: flex;
    align-items: center;
    flex-direction: row;
}

h2 {
    font-weight: 200;
    font-family: var(--secondary-font);
}

span {
    font-weight: 900;
}


.redArrow {
    display: flex;
    justify-content: flex-end;
    align-items: flex-end;
    margin-top: 0px;
}

.redArrow span {
    width: 50px;
    margin-left: 10px;
    color: var(--main-color);
    font-size: 50px;
    animation: upDown 1s infinite;
}

.redArrow span:hover {
    color: var(--main-color);
}

@keyframes upDown {
    0% {
        transform: translateY(0);
    }

    50% {
        transform: translateY(20px);
    }

    100% {
        transform: translateY(0);
    }
}
</style>