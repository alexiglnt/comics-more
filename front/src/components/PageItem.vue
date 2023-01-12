<script>
import ScrollToTop from './Elements/ScrollToUpBtn.vue';
import Navbar from './Elements/Navbar.vue';

import instance from '../../axios-infos.js'
import axios from 'axios';

export default {
    name: 'Home',
    components: {
        ScrollToTop, Navbar
    },
    data() {
        return {
            currentCollection: [],      // les infos de la collection courante
            currentComic: {},            // les infos du comics courant
            linkImages: [],
            readMode: 'scroll',         // mode de lecture (scroll ou onePage)
            currentPage: 1,             // page courante
            linkCurrentPage: '',
            optionPageValue: 1,
        }
    },
    methods: {
        // Récupération des liens des images du comics depuis la BDD liée à l'API
        async recupCollection() {
            // On sauvegarde les infos du comics actuel dans la variable currentComic
            this.currentComic = await JSON.parse(localStorage.getItem('currentComic'));

            // Requete GET pour récupérer le nom de la collection
            const URL = `${instance.baseURL}${this.currentComic.comicsCollection}`;
            axios.get(URL)
                .then(response => {
                    console.log(response.data);

                    // On récupère les infos de la collection actuelle
                    this.currentCollection = response.data;

                    // On lance cette fonction pour récupérer les infos du comics actuel
                    this.recupComic();
                })
                .catch(error => {
                    console.log(error)
                })
        },
        recupComic() {

            let numero = 0;
            for (let i = 1; i < this.currentComic.nbPage + 1; i++) {
                if (i <= 9) {
                    numero = '00' + i.toString();
                    this.linkImages.push({ numero: numero, url: `${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}` });
                }
                else if (i > 9 && i <= 99) {
                    numero = '0' + i.toString();
                    this.linkImages.push({ numero: numero, url: `${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}` });
                }
                else {
                    numero = i.toString();
                    this.linkImages.push({ numero: numero, url: `${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}` });
                }
            }

        },
        changePage(value) {

            let numeroPage;

            if (value === 'next') {
                this.currentPage++;

                if (this.currentPage <= 9) {
                    numeroPage = '00' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
                else if (this.currentPage > 9 && this.currentPage <= 99) {
                    numeroPage = '0' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
                else {
                    numeroPage = this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
            }
            else if (value === 'back') {
                this.currentPage--;

                if (this.currentpage < 1) {
                    this.currentPage = 1;
                    document.querySelector('.arrow-back').disabled = true;
                }
                else if (this.currentPage <= 9) {
                    numeroPage = '00' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
                else if (this.currentPage > 9 && this.currentPage <= 99) {
                    numeroPage = '0' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
                else {
                    numeroPage = this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
            }
            else {
                this.currentPage = value;
                console.log(this.currentPage);

                if (this.currentPage <= 9) {
                    numeroPage = '00' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
                else if (this.currentPage > 9 && this.currentPage <= 99) {
                    numeroPage = '0' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
                else {
                    numeroPage = this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
            }

        }
    },
    async mounted() {
        // Récupération de la collection
        await this.recupCollection();
        console.log('dlkdhuqsfsqvbfic', this.currentComic);

        this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/001.${this.currentComic.extension}`

        document.title = `Lecture - ${this.currentComic.name}`

        // On scroll en haut de la page (car spawn au milieu en arrivant sur la page)
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    }
}

</script>


<template>

    <div>
        <Navbar />

        <!-- On affiche le mode de lecture -->
        <div class="select-readMode">
            <!-- <label for="selectReadMode"> Mode de lecture : </label> -->
            <select name="selectReadMode" id="selectReadMode" v-model="this.readMode">
                <option value="scroll">Tout sur la même page</option>
                <option value="onePage">Page par Page</option>
            </select>

            <select name="selectPage" id="selectPage" v-if="this.readMode == 'onePage'" v-model="this.currentPage"
                @click="() => changePage(this.currentPage)">
                <option v-for="page in this.currentComic.nbPage" :value="page"> {{ page }}</option>
            </select>



        </div>

        <div class="container-infos">

            <div class="left-right">
                <div class="left">
                    <img v-if="linkImages[0]" :src="linkImages[0].url" width="1000px">
                </div>
                <div class="right">
                    <div>
                        <h1> Informations </h1>
                        <p> Nom du comics : <b> {{ this.currentComic.name }} </b> </p>
                        <p> Collection : <b> {{ this.currentCollection.name }} </b> </p>
                        <p> Nombre de pages : <b> {{ this.currentComic.nbPage }} </b> </p>
                    </div>
                </div>
            </div>

        </div>


        <h1> Bonne lecture 😀  </h1> <br>

        <!-- On affiche les images du comics -->
        <div v-if="this.readMode === 'scroll'">
            <div class="container-images-scroll">
                <div class="images" v-for="image in linkImages">
                    <img v-if="image" :src="image.url" :alt="`Page ${image.numero} - ${this.currentComic.name}`"
                        :title="`Page ${image.numero} - ${this.currentComic.name}`">
                </div>
            </div>
        </div>
        <div v-else>
            <div class="container-images-onePage">
                <button v-if="currentPage > 1" type="button" class="arrow-back" @click="() => changePage('back')"> &lt
                </button>
                <button v-else type="button" class="arrow-back" disabled> &lt </button>
                <img id="currentImg" :src="this.linkCurrentPage" @click="() => changePage('next')">
                <button type="button" class="arrow-next" @click="() => changePage('next')"> > </button>
            </div>
        </div>

        <p class="nbPage"> Pages : <b> {{ this.currentComic.nbPage }} </b> </p>
        <ScrollToTop />
    </div>

</template>


<style scoped >
h1 {
    text-align: center;
    font-size: 3em;
}

h2 {
    text-align: center;
}

.container-infos {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.left-right {
    max-width: 1000px;
    margin-bottom: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
}

.left {
    width: 100%;
    height: 100%;
}

.left img {
    width: 70%;
}

.left,
.right {
    display: block;
    justify-content: center;
    align-items: center;
    width: 50vw;
}

.right h1 {
    display: flex;
    justify-content: flex-start;
    padding-bottom: 20px;
    border-bottom: 5px solid var(--main-color);
    position: absolute;
    top: 0;
    width: 500px;
}

.right p {
    font-size: 1.5em;
}

.container-images-scroll img {
    max-width: 760px;
}

.container-images-onePage {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin-top: 220px;
}

.container-images-onePage button {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: var(--secondary-color);
    color: white;
    font-size: 2em;
    border: none;
    margin-inline: 30px;
}

.container-images-onePage button:hover {
    cursor: pointer;
    transform: scale(1.1);
}

.container-images-onePage img {
    max-width: 760px;
}

.select-readMode {
    position: fixed;
    left: 20px;
    top: var(--navbar-height);
    padding-top: 20px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: flex-start;
    z-index: 1;
}

.select-readMode p {
    margin: 0;
}

.images {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    flex-direction: column;
}

.nbPage {
    position: fixed;
    bottom: 30px;
    left: 30px;
    color: var(--transparent-color);
}

/* button disabled */
button:disabled {
    background-color: var(--transparent-color);
    color: var(--transparent-color);
    cursor: not-allowed;
}

button:disabled:hover {
    transform: scale(1);
    cursor: not-allowed;
}
</style>