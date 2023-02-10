<script>
import Navbar from '../components/Elements/Navbar.vue';

export default {
  name: 'Library',
  components: {
    Navbar
  }
};

</script>


<template>
    <Navbar />

    <div class="library">
        <h1> VOTRE BIBLIOTHEQUE </h1>
    </div>

</template>


<style scoped >

.library {
    margin-top: 150px;
    margin-inline: 10%;
}

.library h1 {
    font-family: var(--secondary-font);
    letter-spacing: 2px;
    font-size: 3em;

    text-align: center;
}

</style>