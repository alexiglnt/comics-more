<script>

import axios from 'axios';
import instance from '../../../axios-infos';

export default {
    name: 'CommentItem',
    props: ['comment'],
    data() {
        return {
            userInfos: JSON.parse(localStorage.getItem('userInfos')),
            userIsOwner: false
        }
    },
    methods: {
        deleteThisComment() {
            console.log(this.comment);

            const URL = `${instance.baseURL}/api/comments/${this.comment.id}`;

            axios.delete(URL)
                .then((response) => {
                    console.log("response", response);

                    if (response.status === 204) {
                        // reload page
                        window.location.reload();
                    }
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        verifIfUserIsOwner() {
            let user = ""
            if (localStorage.getItem('userInfos')) {
                user = JSON.parse(localStorage.getItem('userInfos'));
            }

            if (this.comment.userId) {
                if (this.comment.userId === user.id) {
                    this.userIsOwner = true;
                } else {
                    this.userIsOwner = false;
                }
            }
        }
    },
    mounted() {
        this.verifIfUserIsOwner();
    }
}

</script>


<template>
    <div class="container-comment">
        <button type="button" v-if="userIsOwner" @click="deleteThisComment">
            <span class="material-symbols-outlined"> delete </span>
        </button>
        <p>{{ comment.content }}</p>
        <div>
            <p>{{ comment.userCommented }} </p>
            <p> • </p>
            <p> <span> {{ comment.createdAt }} </span> </p>
        </div>
        <!-- <p v-if="userIsOwner" @click="handleClick" > TRUE </p>
            <p v-else> FALSE </p> -->
    </div>
</template>


<style scoped >
.container-comment {
    border: none;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    margin: 10px;
    padding: 10px;
    text-align: center;
    width: 800px;

    overflow: auto;

    margin: 0 auto;
    position: relative;
}

.container-comment p {
    margin-inline: 7px;
    font-size: 1.2em;
}

.container-comment div {
    display: flex;
    justify-content: center;
}

.container-comment div p {
    font-weight: bold;
}

.container-comment span {
    color: royalblue;
}

.container-comment button {
    border: none;
    background-color: white;
    float: right;
    margin: 0;
    padding: 0;
    font-size: 1.2em;
    color: red;

    position: absolute;
    top: 15px;
    right: 15px;
}

.container-comment button:hover {
    cursor: pointer;
}

.container-comment button span {
    font-size: 1.5em;
    color: red;
}
</style>