<script>
    import Navbar from './Elements/Navbar.vue';

    export default {
        components: {
            Navbar
        },
        methods: {
            goTo(routeName)
            {
                this.$router.push({
                    name: routeName,
                });
            },
            handleClick() {
                console.log('click');

                const test = {collection_id: 1 , name: 'Maestro', extension: 'jpeg', nb_pages: 129}

                localStorage.setItem('currentComic', JSON.stringify(test));

                this.goTo('Comics');
            }
        },
        mounted() {

        }
    }

</script>

<template>

    <div class="container">

        <Navbar />

        <h1> HOME </h1> <br>

        <div class="grid-container" > 

            <div class="card" @click="handleClick" >
                <img src="https://comicsmore.s3.eu-west-3.amazonaws.com/Maestro/001.jpeg" alt="" width="100%">
            </div>

            <div class="card" @click="handleClick" >
                <img src="https://comicsmore.s3.eu-west-3.amazonaws.com/Maestro/001.jpeg" alt="" width="100%">
            </div>

            <div class="card" @click="handleClick" >
                <img src="https://comicsmore.s3.eu-west-3.amazonaws.com/Maestro/001.jpeg" alt="" width="100%">
            </div>

            <div class="card" @click="handleClick" >
                <img src="https://comicsmore.s3.eu-west-3.amazonaws.com/Maestro/001.jpeg" alt="" width="100%">
            </div>

            <div class="card" @click="handleClick" >
                <img src="https://comicsmore.s3.eu-west-3.amazonaws.com/Maestro/001.jpeg" alt="" width="100%">
            </div>

            <div class="card" @click="handleClick" >
                <img src="https://comicsmore.s3.eu-west-3.amazonaws.com/Maestro/001.jpeg" alt="" width="100%">
            </div>
        </div>

    </div>

</template>

<style scoped >

    .container {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        width: 100%;
    }

    h1 {
        font-size: 3em;
    }

    a {
        text-decoration: none;
        font-size: 2em;
        margin-top: 20px;
    }

    .grid-container {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-gap: 50px;
        grid-auto-rows: minmax(100px, auto);
    }
    
    .card {
        background-color: transparent;
        color: #333;
        border-radius: 10px;
        /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); */
        padding: 20px;
        font-size: 1.5em;
        text-align: center;
        margin-bottom: 100px;

        width: 200px;
        height: 200px;
    }

    .card img {
        width: 200px;
    }

</style>