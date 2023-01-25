<script>
import ScrollToTop from './Elements/ScrollToUpBtn.vue';
import Navbar from './Elements/Navbar.vue';

import instance from '../../axios-infos.js'
import axios from 'axios';
import { accountService } from '../_services';

export default {
    name: 'Home',
    components: {
        ScrollToTop, Navbar
    },
    props: {
        id: Number
    },
    data() {
        return {
            currentCollection: [],      // les infos de la collection courante
            currentComic: {},            // les infos du comics courant
            currentComicName: '',       // le nom du comics courant
            comic: [],                  // les infos du comics
            currentHouse: [],        // les infos de la maison d'édition
            linkImages: [],
            readMode: 'scroll',         // mode de lecture (scroll ou onePage)
            currentPage: 1,             // page courante
            linkCurrentPage: '',
            optionPageValue: 1,
            navbar: {
                isNavbarHidden: false,
                navbarState: 'expand_less',
            },
            isConnected: localStorage.getItem('isConnected'),
            bookmark: {
                state: 'bookmark_add',
                data: {},
                isChecked: false,
            }
        }
    },
    methods: {
        redirect(routeName) {
            this.$router.push({ name: routeName });
        },
        // Récupération des liens des images du comics depuis la BDD liée à l'API
        async recupCollection() {
            // On sauvegarde les infos du comics actuel dans la variable currentComic
            this.currentComic = await JSON.parse(localStorage.getItem('currentComic'));

            // Requete GET pour récupérer le nom de la collection
            const URL = `${instance.baseURL}${this.currentComic.comicsCollection}`;
            axios.get(URL)
                .then(response => {
                    // On récupère les infos de la collection actuelle
                    this.currentCollection = response.data;

                    // On récupère les infos de la maison d'édition
                    this.currentHouse = this.currentCollection.house;

                    // On lance cette fonction pour récupérer les infos du comics actuel
                    this.recupCurrentComic();
                })
                .catch(error => {
                    console.log(error)
                })
        },
        // Récupération des infos du comics actuel en fonction de l'id contenu dans l'url
        recupCurrentComic() {
            let paramsID = this.$route.params.id;

            // Requete GET pour récupérer le comics actuel
            const URL = `${instance.baseURL}/api/comics/${paramsID}`;

            axios.get(URL)
                .then(response => {
                    // On récupère les infos du comics actuel
                    this.currentComic = response.data;

                    // convert name
                    this.currentComicName = this.currentComic.name.replaceAll('+', ' ');

                    console.log('CURRENT COMICS MOTHER FICKER', this.currentComic);

                    // On lance cette fonction pour récupérer les infos du comics actuel
                    this.recupComic();
                })
                .catch(error => {
                    console.log(error)
                })
        },
        // Récupération des liens des images du comics depuis la BDD liée à l'API
        recupComic() {

            let numero = 0;
            for (let i = 1; i < this.currentComic.nbPage + 1; i++) {
                if (i <= 9) {
                    numero = '00' + i.toString();
                    this.linkImages.push({ numero: numero, url: `${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}` });
                } else if (i > 9 && i <= 99) {
                    numero = '0' + i.toString();
                    this.linkImages.push({ numero: numero, url: `${instance.AWS_URL}/${this.currentComic.name}/${numero}.${this.currentComic.extension}` });
                } else {
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
                } else if (this.currentPage > 9 && this.currentPage <= 99) {
                    numeroPage = '0' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                } else {
                    numeroPage = this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
            } else if (value === 'back') {
                this.currentPage--;

                if (this.currentpage < 1) {
                    this.currentPage = 1;
                    document.querySelector('.arrow-back').disabled = true;
                } else if (this.currentPage <= 9) {
                    numeroPage = '00' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                } else if (this.currentPage > 9 && this.currentPage <= 99) {
                    numeroPage = '0' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                } else {
                    numeroPage = this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
            } else {
                this.currentPage = value;

                if (this.currentPage <= 9) {
                    numeroPage = '00' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                } else if (this.currentPage > 9 && this.currentPage <= 99) {
                    numeroPage = '0' + this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                } else {
                    numeroPage = this.currentPage.toString();
                    this.linkCurrentPage = `${instance.AWS_URL}/${this.currentComic.name}/${numeroPage}.${this.currentComic.extension}`;
                }
            }

        },
        hideNavbar() {
            this.navbar.isNavbarHidden = !this.navbar.isNavbarHidden;

            if (this.navbar.navbarState === 'expand_more') {
                this.navbar.navbarState = 'expand_less';
            } else {
                this.navbar.navbarState = 'expand_more';
            }

            // document.querySelector('.select-readMode').style.top = "-var(--navbar-height)";

        },
        ScrollEventListener() {
            var prevScrollpos = window.pageYOffset;

            window.addEventListener('scroll', function () {
                var currentScrollPos = window.pageYOffset;

                console.log('scroll', prevScrollpos, currentScrollPos);

                if (prevScrollpos > currentScrollPos) {
                    document.getElementById("navbar").style.top = "0px";
                    document.querySelector('.select-readMode').style.top = "var(--navbar-height)";
                } else {
                    document.getElementById("navbar").style.top = "-50px";
                    document.querySelector('.select-readMode').style.top = "-var(--navbar-height)";
                }

                prevScrollpos = currentScrollPos;
            });
        },
        splitAndReplace(str, number) {
            return `/${str.split('/').filter((item) => item !== '').join('/').replace(`${number}/`, '')}/`;
        },
        // Change la couleur/icone du bouton bookmark
        changeDesignBookmark() {
            const bookmarkBtn = document.querySelector('.bookmark-span');

            bookmarkBtn.classList.toggle('added');
            this.bookmark.state = this.bookmark.state === 'bookmark_add' ? 'bookmark' : 'bookmark_add';
        },
        handleBookmarked() {
            this.changeDesignBookmark();

            // On vérifie si l'utilisateur est connecté
            if (localStorage.getItem('isConnected') === 'true') {

                // On vérifie si le comic est déjà bookmarké
                if (this.bookmark.isChecked === false) {
                    this.addToBookmarks();
                } else {
                    this.removeFromBookmarks();
                }
            } else {
                this.$router.push('/Login');
            }
        },
        createBookmark() {

            const URL = `${instance.baseURL}/api/bookmarks`;

            axios.get(URL)
                .then((response) => {
                    let bookmarks = response.data['hydra:member'];

                    bookmarks.forEach((bookmark) => {
                        if (bookmark.userID === JSON.parse(localStorage.getItem('userInfos')).id) {
                            // this.bookmark.data = bookmark;
                            return;
                        }
                    });

                    // Si l'utilisateur n'a pas de bookmark on en crée un
                    axios.post(URL,
                        {
                            comicsId: `/`,
                            userID: JSON.parse(localStorage.getItem('userInfos')).id
                        },
                        {
                            headers: {
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ' + localStorage.getItem('token')
                            }
                        })
                        .then((response) => {
                            // this.bookmark.data = response.data;
                            console.log('createBookmark', response);

                            this.recupBookmarkInfos();
                        })
                        .catch((error) => {
                            accountService.tokenExpired(error);
                        })

                })

        },
        recupBookmarkInfos() {
            const URL = `${instance.baseURL}/api/bookmarks`;

            axios.get(URL, {
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + localStorage.getItem('token')
                }
            })
                .then((response) => {
                    const bookmarks = response.data['hydra:member'];

                    // On vérifie si l'utilisateur est connecté
                    if (localStorage.getItem('isConnected') == 'true') {
                        bookmarks.forEach((bookmark) => {
                            console.log('ICI', bookmark.userID, JSON.parse(localStorage.getItem('userInfos')).id);

                            // On vérifie si le bookmark contient l'id du comic et si l'id du bookmark correspond à l'id de l'utilisateur connecté
                            if (bookmark.userID === JSON.parse(localStorage.getItem('userInfos')).id) {

                                // On récupère les données du bookmark et on le stocke dans une variable
                                this.bookmark.data = bookmark;
                                console.log(this.bookmark.data);
                            }
                        });
                        console.log('this.bookmark.data', this.bookmark.data);
                    }
                })
                .then(() => {
                    // si l'utilisateur na pas de bookmark on en crée un
                    // if (this.bookmark.data[0] == undefined) {
                    //     this.createBookmark();
                    //     console.log('pas de bookmark');
                    // } else {
                    //     // On vérifie si le comic est déjà bookmarké
                    //     if (this.bookmark.data.comicsId.includes(`/${this.$route.params.id}/`)) {
                    //         this.bookmark.isChecked = true;
                    //         this.changeDesignBookmark();
                    //     }
                    // }

                    if (this.bookmark.data.comicsId.includes(`/${this.$route.params.id}/`)) {
                        this.bookmark.isChecked = true;
                        this.changeDesignBookmark();
                    }

                })
                .catch((error) => {
                    if (error.status == 401) {
                        accountService.tokenExpired(error);
                    }
                })
        },
        addToBookmarks() {

            const URL = `${instance.baseURL}/api/bookmarks/${this.bookmark.data.id}`;

            if (this.bookmark.data.comicsId) {
                // On récupère le contenu de comicsId du bookmark (ex: /1/2/3/)
                var comicsID = this.bookmark.data.comicsId;

                // Si le 1er caractere en'est pas un / on l'ajoute
                if (comicsID.charAt(0) !== '/') {
                    comicsID = `/${this.bookmark.data.comicsId}`;
                }
            }

            axios.put(URL, {
                // On ajoute l'id du comic au contenu de comicsId
                comicsId: `${comicsID}${this.$route.params.id}/`,
            },
                {
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                })
                .then((response) => {
                    console.log(response);
                })
                .catch((error) => {
                    accountService.tokenExpired(error);
                    console.log(error);
                });

        },
        removeFromBookmarks() {

            const URL = `${instance.baseURL}/api/bookmarks/${this.bookmark.data.id}`;

            // On récupère le contenu de comicsId du bookmark
            const comicsID = this.bookmark.data.comicsId;

            // On supprime l'id du comic du contenu de comicsId
            const comicsIDUpdated = this.splitAndReplace(comicsID, this.$route.params.id);
            console.log(comicsIDUpdated);


            axios.put(URL, {
                comicsId: comicsIDUpdated,
            },
                {
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                })
                .then((response) => {
                    console.log(response);
                })
                .catch((error) => {
                    accountService.tokenExpired(error);
                    console.log(error);
                });
        },
    },
    async mounted() {

        console.log(this.$route.params.id);

        // Récupération de la collection
        await this.recupCollection();

        if (this.isConnected == 'true') {
            // Récupération des bookmarks
            await this.recupBookmarkInfos();
        }

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

    <div id="container">
        <div v-if="!navbar.isNavbarHidden" id="navbar">
            <Navbar />
        </div>

        <!-- On affiche le mode de lecture -->
        <div class="select-readMode" v-if="isConnected == 'true'">
            <!-- <label for="selectReadMode"> Mode de lecture : </label> -->
            <select name="selectReadMode" id="selectReadMode" v-model="this.readMode">
                <option value="scroll">Tout sur la même page</option>
                <option value="onePage">Page par Page</option>
            </select>

            <select name="selectPage" id="selectPage" v-if="this.readMode == 'onePage'" v-model="this.currentPage"
                @click="() => changePage(this.currentPage)">
                <option v-for="page in this.currentComic.nbPage" :value="page">
                    <i class="fa fa-arrows-h" aria-hidden="true"></i> Page {{ page }}
                </option>
            </select>
        </div>

        <!-- On affiche les infos du comics -->
        <div class="container-infos">

            <div class="left-right">
                <div class="left">
                    <img v-if="linkImages[0]" :src="linkImages[0].url" width="1000px">
                </div>
                <div class="right">
                    <div>
                        <div>
                            <h1> Informations </h1>

                            <!-- BOOKMARK BUTTON -->
                            <button title="Ajouter aux favoris" type="button" class="bookmark-btn"
                                v-if="this.isConnected == 'true'" @click="handleBookmarked">
                                <span class="material-symbols-outlined bookmark-span"> {{ bookmark.state }} </span>
                            </button>

                        </div>
                        <h3> <b> {{ this.currentComicName }} </b> </h3>
                        <p> Collection : <b> {{ this.currentCollection.name }} </b> </p>
                        <p> Nombre de pages : <b> {{ this.currentComic.nbPage }} </b> </p>
                        <p v-if="this.currentHouse.name == 'MARVEL'">
                            Maison d'édition : <img @click="() => redirect('MarvelPage')" id="house-logo-marvel"
                                src="../assets/Marvel_Logo.svg" title="MARVEL" alt="">
                        </p>
                        <p v-else-if="this.currentHouse.name == 'DC COMICS'">
                            Maison d'édition : <img @click="() => redirect('DC-Comics')" id="house-logo-dc"
                                src="../assets/DC_Comics_logo.png" title="DC COMICS" alt="">
                        </p>
                    </div>
                </div>
            </div>

        </div>


        <h1> Bonne lecture 😀 </h1> <br>

        <!-- On affiche les images du comics -->
        <div v-if="isConnected == 'true'">
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
                    <button v-if="currentPage > 1" type="button" class="arrow-back" @click="() => changePage('back')">
                        &lt
                    </button>
                    <button v-else type="button" class="arrow-back" disabled> &lt </button>
                    <img id="currentImg" :src="this.linkCurrentPage" @click="() => changePage('next')">
                    <button type="button" class="arrow-next" @click="() => changePage('next')"> > </button>
                </div>
            </div>
        </div>
        <div v-else>
            <div class="band-connect">
                <div class="band-connect-left">
                    <h2> Vous voulez lire ce comics ? </h2>
                    <button type="button" class="btn" @click="() => this.redirect('Login')">
                        Connectez-vous
                    </button>
                </div>
                <img :src="this.linkCurrentPage" alt="">
            </div>
        </div>

        <button class="nbPage hideNavbar" type="button" @click="hideNavbar">
            <span class="textBtnHideNavbar" v-if="navbar.isNavbarHidden"> Afficher la navbar </span>
            <span class="material-symbols-outlined"> {{ navbar.navbarState }} </span>
        </button>


        <ScrollToTop />

    </div>



</template>


<style scoped >
#navbar {
    position: fixed;
    top: 0;
    width: 100%;
    display: block;
    transition: top 0.3s;
    z-index: 1000000000000;
}

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
    margin-top: 120px;
}

.bookmark-btn {
    background-color: transparent;
    border: none;
    color: var(--font-color);
    padding: 0;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 20px 2px;
    cursor: pointer;

    position: absolute;
    top: 10px;
    right: 10px;
    user-select: none;
}

.bookmark-span {
    font-size: 2em;
}

.material-symbols-outlined:hover {
    color: #efc000;
}

.added {
    color: #efc000;
    font-variation-settings:
        'FILL' 1,
        'wght' 700,
        'GRAD' 0,
        'opsz' 48
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
    font-family: Dimis;
    letter-spacing: 1px;
}

.right h3 {
    font-size: 2em;
}

.right p {
    font-size: 1.5em;
}

.right img {
    cursor: pointer;
}

#house-logo-marvel {
    width: 75px;
    transform: translateY(5px);
}

#house-logo-dc {
    width: 50px;
    transform: translateY(10px);
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

.band-connect {
    display: flex;
    justify-content: center;
    align-items: center;

    margin: 50px auto;
    width: 80%;
    height: 400px;

    background: var(--main-color);
}

.band-connect h2 {
    font-size: 2em;
    color: var(--font-color);
    line-height: 40px;
    margin-inline: 50px;
}

.band-connect img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.band-connect-left {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 50%;
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



.hideNavbar {
    background: transparent;
    color: #000;
    border: none;
    cursor: pointer;
    position: fixed;
    top: 30px;
    right: 30px;
    z-index: 100000000000000000000;
}

.hideNavbar span {
    font-size: 3em;
}

.hideNavbar span.textBtnHideNavbar {
    font-size: 1.5em;
    position: fixed;
    top: 38px;
    right: 100px;
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

.footer {
    bottom: 0;
    left: 0;
    width: 100%;
}
</style>