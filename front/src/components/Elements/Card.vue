<script>
import instance from '../../../axios-infos';
import axios from 'axios';

export default {

    props: ['data', 'handleClick'],
    data() {
        return {
            comic: {},
            link: '',
            collection: {},
            isHovering: false,
            note: null
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
        initNote() {
            if (this.comic.note === null) {
                // this.comic.note = 0;
            } else {
                if (this.comic.note === 1) {
                    this.note = "⭐";
                } else if (this.comic.note === 2) {
                    this.note = '★★☆☆☆';
                } else if (this.comic.note === 3) {
                    this.note = '★★★☆☆';
                } else if (this.comic.note === 4) {
                    this.note = '★★★★☆';
                } else if (this.comic.note === 5) {
                    this.note = '★★★★★';
                }
            }
        }
    },

    async mounted() {
        this.comic = this.data;
        this.recupCollection();
        this.initNote();
        this.link = `https://comicsmore.s3.eu-west-3.amazonaws.com/${this.comic.name}/001.${this.comic.extension}`;
    }
}

</script>



<template>
    <div class="container">
      <div
        class="card"
        @click="clicked"
        @mouseover="isHovering = true"
        @mouseout="isHovering = false"
        :class="{ 'hovered': isHovering }"
      >
        <img :src="link" alt="" width="100%" :class="{ 'blurred': isHovering }" />
        <p>{{ comic.name }}</p>
        <p>
          <span> Collection : <b>{{ collection.name }}</b> </span>
        </p>
        <p class="note"> {{ note }} </p>
        <!-- <p class="note" v-if="isHovering">
          {{ comic.note }}
          <span class="material-symbols-outlined">star</span>
        </p> -->
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
  
  .card {
    position: relative;
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


  p .note {
    color: var(--secondary-color);
  }
  
  /* .note {
    position: absolute;
    top: 0;
    right: 0;
    display: none;
  }
  
  .card.hovered .note {
    display: block;
    background: #fff;
  } */
  
  
  </style>