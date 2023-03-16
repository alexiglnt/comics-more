<script>

import axios from 'axios';
import instance from '../../../axios-infos';

export default {
    name: 'CommentItem',
    props: ['comment'],
}

</script>


<template>
    <div class="container-comment">
        <p>{{ comment.content }}</p>
        <div>
            <p>{{ comment.userCommented }} </p> 
            <p> • </p>
            <p> <span> {{ comment.createdAt }} </span> </p>
        </div>
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

    overflow:auto;

    margin: 0 auto;
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

</style>