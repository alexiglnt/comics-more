<script>
    import Navbar from './Elements/Navbar.vue'

    export default {
        components: {
            Navbar
        },
    }

</script>

<template>

    <div class="container">
        <h1> HOME </h1>
        <a href="/PageItem"> CLICK </a> <br>

        <div class="grid-container" > 
            <div class="card">
                <a href="/PageItem"> Maestro </a>
            </div>
            <div class="card">
                <a href="/PageItem"> Maestro </a>
            </div>
            <div class="card">
                <a href="/PageItem"> Maestro </a>
            </div>
            <div class="card">
                <a href="/PageItem"> Maestro </a>
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
        background-color: #fff;
        color: #333;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        padding: 20px;
        font-size: 1.5em;
        text-align: center;

        width: 200px;
        height: 200px;
    }

</style>