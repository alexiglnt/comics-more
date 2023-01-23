<script>
import Navbar from './Elements/Navbar.vue';
import Collection from './Elements/Collection.vue';

export default {
    name: 'MarvelComponent',
    components: { Navbar, Collection },
}

</script>



<template>


    <Navbar />

    <div class="container">
        <img class="logo-house" src="../assets/Marvel_Logo.svg" alt="logo marvel" >
        <h1 class="title" > Découvrez les collections de <b> Marvel </b> ! </h1>
    </div>

    <div class="collections-container" >
        <Collection name="Wolverine" house="marvel" />
        <Collection name="Ghost Rider" house="marvel" />
        <Collection name="Spider-Man" house="marvel" />
    </div>


</template>



<style scoped >

.container {
    margin-top: 120px;
    text-align: center;
}

.logo-house {
    width: 300px;
}

.title {
    font-weight: 300;
    font-size: 2.5em;
    margin-top: 50px;
}

</style>