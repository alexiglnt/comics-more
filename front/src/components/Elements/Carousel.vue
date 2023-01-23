<script>

import { Splide, SplideSlide } from '@splidejs/vue-splide';
import '@splidejs/vue-splide/css/skyblue';

import Card from './Card.vue';
import CarouselCard from './CarouselCard.vue';

export default {
    components: {
        Splide,
        SplideSlide,
        Card,
        CarouselCard
    },
    props: ['data'],
    data() {
        return {
            comics: [],
        }
    },
    methods: {
        readTheComic(comic) {
            localStorage.setItem('currentComic', JSON.stringify(comic));
            this.$router.push({ path: `/Comics/${comic.id}` })
        },
    },
}
</script>

<template>
    <div class="container">
        <Splide :options="{ rewind: true }" aria-label="My Favorite Images">

            <SplideSlide v-for="comic in data" :key="comic.id">
                
                    <CarouselCard :data="comic" />
                
            </SplideSlide>

        </Splide>
    </div>
</template>

<!-- <template>
    <div class="container">
        <Splide :options="{ rewind: true }" aria-label="My Favorite Images">

            <SplideSlide v-for="comic in data" :key="comic.id">
                <div class="card" >
                    <Card :data="comic" :handle-click="this.readTheComic" />
                </div>
            </SplideSlide>

        </Splide>
    </div>
</template> -->

<!-- <template>
    <div class="container">
        <Splide :options="{ rewind: true }" aria-label="My Favorite Images">

            <SplideSlide>
                <div class="card">
                    <p> Spider man </p>
                </div>
            </SplideSlide>

            <SplideSlide>
                <div class="card">
                    <p> Batman </p>
                </div>
            </SplideSlide>

            <SplideSlide>
                <div class="card">
                    <p> Green Lantern </p>
                </div>
            </SplideSlide>

            <SplideSlide>
                <div class="card">
                    <p> Ghost Rider </p>
                </div>
            </SplideSlide>

        </Splide>
    </div>
</template> -->



<style scoped >

.container {
    background: transparent;
    /* box-shadow: 0 0 1rem rgba(0, 0, 0, 0.2); */
    border-radius: 0.5em;
    padding-top: 50px;
    padding-bottom: 50px;
}

.card {
    background-color: var(--background-color);
  
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    transition: all 0.3s ease-in-out;

    transform: scale(1.3) translateY(0px);

    width: 100px;
    margin: 0 auto;
}

.card:hover {
    transform: scale(1.3);
    transition: all 0.3s ease-in-out;
}

.card img {
    width: 500px;
}


</style>