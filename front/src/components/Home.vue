<script>
import Navbar from './Elements/Navbar.vue';
import ScrollToUpBtn from './Elements/ScrollToUpBtn.vue';
import Card from './Elements/Card.vue';

export default {
    components: {
        Navbar, ScrollToUpBtn, Card
    },
    data() {
        return {
            comics: [
                { id: 1, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 2, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 3, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 4, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 5, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 6, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 7, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 8, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 9, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
                { id: 10, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 },
            ]
        }
    },
    methods: {
        goToComicPage(data) {
            this.$router.push({
                name: 'Comics',
                params: { id: data.name }
            });
        },
        handleClick() {
            console.log('click');

            const test = { id: 1, collection_id: 1, name: 'Maestro', extension: 'jpeg', nb_pages: 129 }

            localStorage.setItem('currentComic', JSON.stringify(test));

            this.goToComicPage(test);
        },
        ScrollTo(id) {
            const element = document.querySelector(id);
            element.scrollIntoView({ behavior: 'smooth' });
        }
    },
    mounted() {

    }
}

</script>

<template>

    <Navbar />

    <!-- HOMEPAGE -->
    <section id="homepage">

        <div class="accueil">
            <img src="../assets/wave.svg" class="fond-curvy" alt="">
        </div>

        <div class="presentation">
            <p>Bienvenue sur</p> <br>
            <h1> Comics More </h1> <br>
            <a id="btn-scroll" @click="() => ScrollTo('#btn-scroll')" > 
                Découvrir
                <span class="material-symbols-outlined"> keyboard_double_arrow_down </span>
            </a>
        </div>
    </section>

    <div class="container">

        <div class="slogan">
            <h1> <span> C</span>hoisissez, <span>&nbspL</span>isez et<span>&nbsp P</span>rofitez ! </h1>
        </div>


        <div class="grid-container">

            <div v-for="comic in comics" :key="comic.id">
                <div class="card" @click="handleClick">
                    <Card :data="comic" />
                </div>
            </div>

        </div>

        <ScrollToUpBtn />

    </div>

</template>

<style scoped >
#homepage {
    background-color: var(--background-color);
    height: 100vh;
    width: 100%;
}

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

.slogan {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    width: 100%;
    margin-bottom: 50px;
}

.slogan h1 {
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 50px;
    font-family: 'Verdana', sans-serif;
}

h1 span {
    color: #3D91C0;
}

a {
    text-decoration: none;
    font-size: 2em;
    margin-top: 20px;
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    grid-gap: 30px;
    width: 90%;
}

.card {
    background-color: transparent;
    color: var(--font-color);
    border-radius: 10px;
    /* box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); */
    padding: 20px;
    font-size: 1.5em;
    text-align: center;
    margin-bottom: 0px;

    width: 200px;

    transition: all 0.3s ease-in-out;
}

.card:hover {
    transform: scale(1.1);
    transition: all 0.3s ease-in-out;
}

.card img {
    width: 200px;
}


.fond-curvy {
    width: 100%;
    position: absolute;
    left: 0;
    bottom: 20%;
    display: block;
    z-index: -1;

    user-select: none;
    /* désactivé la surbrillance de texte sélectionné */
}

.accueil {
    height: 10vh;
    width: 100%;
    background-color: #FFA800;
    max-height: 60vh;
}

.presentation {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.presentation p {
    font-size: 25px;
    margin-bottom: 10px;
}

.presentation a {
    background-color: #3D91C0;
    width: 220px;
    height: 50px;
    border-radius: 5px;
    color: white;
    font-size: 20px;
    border: none;
    box-shadow: 5px 5px 0px #003d61;
    transition: 0.4s ease;
    text-decoration: none;
    text-align: center;
    align-items: center;
    padding: 7px 0;
}

.presentation a:hover {
    background-color: #1e72a2;
    box-shadow: 0px 0px 0px rgba(51, 51, 51, 0);
    transition: 0.4s ease;
}

.presentation a span {
    transform: translateY(5px);
}

.presentation h1 {
    font-size: 100px;
    font-family: 'Dimis';
    font-weight: 900;
    margin: 50px;
}
</style>