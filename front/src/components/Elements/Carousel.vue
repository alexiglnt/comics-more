<script>

import { Splide, SplideSlide } from '@splidejs/vue-splide';
import '@splidejs/vue-splide/css/skyblue';

export default {
    components: {
        Splide,
        SplideSlide,
    },
}
</script>


<template>
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
</template>



<style scoped >

.container {
    background: transparent;
    box-shadow: 0 0 1rem rgba(0, 0, 0, 0.2);
    border-radius: 0.5em;
    padding-top: 50px;
    padding-bottom: 50px;
}

.card {

    width: 20rem;
    height: 20rem;
    margin: 0 auto;
    background: #fff;
    border-radius: 0.5rem;
    box-shadow: 0 0 1rem rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 2rem;
    color: #333;

    display: flex;
    justify-content: center;
    font-size: 2rem;
}
</style>