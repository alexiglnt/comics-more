<script>
import Navbar from './Elements/Navbar.vue'
import Payment from './Payment.vue';

export default {
    name: 'BuyCredits',
    components: {
        Navbar, Payment
    },
    data() {
        return {
            price: 0.01
        }
    },
}

</script>


<template>

    <Navbar />
    <div class="container">
        <h1> {{ price }} € </h1>
        <Payment />
    </div>

</template>


<style scoped>

.container {
    margin-top: 150px;
    width: 40%;
}

</style>