<script>
import Navbar from './Elements/Navbar.vue';
import Collection from './Elements/Collection.vue';

export default {
    name: 'DCComponent',
    components: { Navbar, Collection },
}

</script>



<template>


    <Navbar />

    <div class="container">
        <img class="logo-house" src="../assets/DC_Comics_logo.png" alt="logo marvel" >
        <h1 class="title" > Découvrez les collections de <b>  DC Comics </b> ! </h1>
    </div>

    <div class="collections-container" >
        <Collection name="Batman" house="dc" />
    </div>


</template>



<style scoped >

.container {
    margin-top: 120px;
    text-align: center;
}

.logo-house {
    width: 250px;
}

.title {
    font-weight: 300;
    font-size: 2.5em;
    margin-top: 30px;
}

</style>