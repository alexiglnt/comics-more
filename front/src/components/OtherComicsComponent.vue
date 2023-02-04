<script>
import Navbar from './Elements/Navbar.vue';
import Collection from './Elements/Collection.vue';

export default {
    name: 'OthersComicsComponent',
    components: { Navbar, Collection },
}
</script>



<template>


    <Navbar />

    <div class="container">
        <div class="logos">
            <img class="logo-house" src="../assets/panini-comics.png" alt="">
            <img class="logo-house2" src="../assets/image-comics.png" alt="">
        </div>
        <h1 class="title" > D'AUTRES COLLECTIONS DE COMICS TOUTES AUSSI PASSIONANTES </h1>
    </div>

    <div class="collections-container" >
        <Collection name="The Boys" />
        <Collection name="Invincible" />
    </div>


</template>



<style scoped >

.container {
    margin-top: 120px;
    text-align: center;
}

.logos {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin-inline: 300px;
}

.logo-house {
    width: 300px;
    transform: scale(1.5);
}
.logo-house2 {
    width: 100px;
}

.title {
    font-weight: 300;
    font-size: 2.5em;
    margin-top: 50px;
    font-family: var(--secondary-font);
}

</style>