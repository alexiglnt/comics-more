<script>
import ScrollToTop from './Elements/ScrollToUpBtn.vue';
import Navbar from './Elements/Navbar.vue';

import instance from '../../axios-infos.js'
import axios from 'axios';
import { accountService } from '../_services';

import NoteComics from './Elements/NoteComics.vue';
import CommentList from './Elements/CommentList.vue';
import AddComment from './Elements/AddComment.vue';

export default {
    name: 'Home',
    components: {
        ScrollToTop, Navbar, NoteComics, CommentList, AddComment
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
            readMode: 'onePage',         // mode de lecture (scroll ou onePage)
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
            },
            isInLibrary: false,
            tabLibrary: [],
            isAdmin: false,
            notifText: 'NO TEXT',
            copied: false,
            isButtonDisabled: false,
        }
    },
    methods: {
        redirect(routeName) {
            this.$router.push({ name: routeName });
        },
        goToCollection(collectionName) {
            this.$router.push({ name: 'Collection', params: { name: collectionName } });
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

                    console.log('CURRENT COMICS MOTHER FUCKER', this.currentComic);

                    // On lance cette fonction pour récupérer les liens des images du comics depuis la BDD liée à l'API
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
            console.log('current page', this.currentPage);
            console.log('nbpage', this.currentComic.nbPage);

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
            return `${str.replace(`${number}/`, '')}`;
        },
        // Change la couleur/icone du bouton bookmark
        changeDesignBookmark() {
            const bookmarkBtn = document.querySelector('.bookmark-span');

            bookmarkBtn.classList.toggle('added');
            this.bookmark.state = this.bookmark.state === 'bookmark_add' ? 'bookmark' : 'bookmark_add';
        },
        handleBookmarked() {
            // On vérifie si l'utilisateur est connecté
            if (localStorage.getItem('isConnected') === 'true') {

                // On vérifie si le comic est déjà bookmarké
                if (this.bookmark.isChecked === false) {
                    console.log('add');
                    this.addToBookmarks();
                } else {
                    console.log('remove');
                    this.removeFromBookmarks();
                }
            } else {
                this.$router.push('/Login');
            }

            // isButtonDisabled = true;
            // setTimeout(() => {
            //     isButtonDisabled = false;
            // }, 2000);
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

            // On vérifie si le comic est déjà dans la base de données avec une requête GET
            axios.get(URL,
                {
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                })
                .then((response) => {
                    console.log(response);

                    // On parcours la liste des comics du bookmark
                    if (!response.data.comicsId.includes(`/${this.$route.params.id}/`)) {
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

                                if (response.status == 200) {
                                    // alert(`${this.currentComic.name.replaceAll('+', ' ')} ajouté aux favoris `);
                                    this.notify(`Comics ajouté aux favoris `)

                                    this.bookmark.isChecked = !this.bookmark.isChecked;
                                    this.changeDesignBookmark();

                                    // On désactive le bouton pendant 2 secondes pour eviter les spams
                                    this.isButtonDisabled = true;
                                    setTimeout(() => {
                                        this.isButtonDisabled = false;
                                    }, 2000);
                                }

                            })
                            .catch((error) => {
                                accountService.tokenExpired(error);
                                console.log(error);

                                alert('Une erreur est survenue, veuillez réessayer ultérieurement');

                            });
                    }
                })
                .catch((error) => {
                    console.log(error);
                });
        },
        removeFromBookmarks() {
            console.log('------- REMOVE FROM BOOKMARKS -------');
            const URL = `${instance.baseURL}/api/bookmarks/${this.bookmark.data.id}`;

            // On récupère le contenu de comicsId du bookmark
            const comicsID = this.bookmark.data.comicsId;
            console.log('comicsID', comicsID);

            // On supprime l'id du comic du contenu de comicsId
            const comicsIDUpdated = this.splitAndReplace(comicsID, this.$route.params.id);
            console.log('comicsIDUpdated', comicsIDUpdated);


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

                    if (response.status == 200) {
                        // alert(`${this.currentComic.name.replaceAll('+', ' ')} retiré des favoris `);
                        this.notify(`Comics retiré des favoris `)
                        this.bookmark.isChecked = !this.bookmark.isChecked;
                        this.changeDesignBookmark();

                        // On désactive le bouton pendant 2 secondes pour eviter les spams
                        this.isButtonDisabled = true;
                        setTimeout(() => {
                            this.isButtonDisabled = false;
                        }, 2000);
                    }

                })
                .catch((error) => {
                    accountService.tokenExpired(error);
                    console.log(error);
                    alert('Une erreur est survenue, veuillez réessayer ultérieurement');
                });
        },
        verifyIfComicIsInLibrary() {
            
            if (localStorage.getItem('userLibrary')) {
                let cpt = 0;
                let library = JSON.parse(localStorage.getItem('userLibrary'));
                let str = library.comicsUserHas;

                // transform str in array after removing the first and last character
                // let tabLib = str.substring(1, str.length - 1).split(',');
                // this.tabLibrary = tabLib;

                let tabLib = str.split(',');
                this.tabLibrary = tabLib;

                // On vérifie si le comic est déjà dans la librairie
                tabLib.forEach((comic) => {
                    if (comic == this.$route.params.id) {
                        cpt++;
                    }
                });

                if (cpt > 0) {
                    this.isInLibrary = true;
                }
            }
        },
        spendCredits() {
            const URL = `${instance.baseURL}/api/users/${JSON.parse(localStorage.getItem('userInfos')).id}`;

            if (JSON.parse(localStorage.getItem('userInfos')).credits - this.currentComic.credits < 0) {
                alert('Vous n\'avez pas assez de crédits pour acheter ce comic. Vous allez être redirigé vers la page de recharge de crédits.');
                this.$router.push('/BuyCredits');
            } else {
                // Modification du nombre de credits de l'utilisateur
                axios.put(URL,
                    {
                        credits: JSON.parse(localStorage.getItem('userInfos')).credits - this.currentComic.credits,
                    },
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': `Bearer ${localStorage.getItem('token')}`
                        }
                    })
                    .then((response) => {
                        console.log(response);

                        if (response.status == 200) {
                            // On modifie le nombre de crédits dans le localStorage
                            let userInfos = JSON.parse(localStorage.getItem('userInfos'));
                            userInfos.credits = userInfos.credits - this.currentComic.credits;
                            localStorage.setItem('userInfos', JSON.stringify(userInfos));

                            // On ajoute le comic à la librairie
                            this.addComicToUserLibrary(this.$route.params.id);
                        }
                    })
                    .catch((error) => {
                        accountService.tokenExpired(error);
                        alert('L\'opération n\'a pas fonctionnée. Vous n\'avez pas été débité de vos crédits. Veuillez réessayer ultérieurement.')
                        console.log(error);
                    });
            }
        },
        addComicToUserLibrary(comicID) {

            // On récupère la librairie de l'utilisateur
            let libraryID = JSON.parse(localStorage.getItem('userLibrary')).id;
            let tabLib = this.tabLibrary;

            // On ajoute l'id du comic à la librairie
            tabLib.push(comicID.toString());

            // On transforme le tableau en string
            tabLib = tabLib.join(',');

            // On transforme dans le localStorage
            let library = JSON.parse(localStorage.getItem('userLibrary'));
            library.comicsUserHas = tabLib;
            localStorage.setItem('userLibrary', JSON.stringify(library));

            // On ajoute le comic à la librairie de l'utilisateur
            const URL = `${instance.baseURL}/api/libraries/${libraryID}`;

            axios.put(URL,
                {
                    comicsUserHas: tabLib,
                },
                {
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${localStorage.getItem('token')}`
                    }
                })
                .then((response) => {
                    console.log(response);

                    if (response.status == 200) {
                        alert('Vous pouvez désormais lire ce comic ! Bonne lecture !');
                        this.isInLibrary = true;
                    }
                })
                .catch((error) => {
                    accountService.tokenExpired(error);
                    console.log(error);
                });
        },
        notify(text) {
            this.notifText = text;
            this.copied = true;

            setTimeout(() => {
                this.copied = false;
            }, 2000);
        }
    },
    directives: {
        canva: {
            inserted: function (el, binding) {
                const canvas = el;
                const context = canvas.getContext('2d');
                const image = new Image();

                image.onload = function () {
                    canvas.width = image.width;
                    canvas.height = image.height;
                    context.drawImage(image, 0, 0);
                };

                image.src = binding.value;
            }
        }
    },
    async mounted() {
        // Récupération de la collection
        await this.recupCollection();

        if (this.isConnected == 'true') {
            // On vérifie si l'utilisateur est admin
            if (JSON.parse(localStorage.getItem('userInfos')).roles[0] == 'ROLE_ADMIN') {
                this.isAdmin = true;
            }

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

        // On vérifie si le comics de la page est contenu dans userLibrary
        this.verifyIfComicIsInLibrary();

    }
}

</script>


<template>
    <div id="container">
        <div v-if="!navbar.isNavbarHidden" id="navbar">
            <Navbar />
        </div>

        <!-- On affiche le mode de lecture -->
        <div class="select-readMode" v-if="isConnected == 'true' && isInLibrary == true || isAdmin === true">
            <label for="selectReadMode"> Mode de lecture </label>
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
                    <div class="rt">
                        <div>
                            <h1> Informations </h1>

                            <!-- BOOKMARK BUTTON -->
                            <button :disabled="this.isButtonDisabled" title="Ajouter aux favoris" type="button"
                                class="bookmark-btn" v-if="this.isConnected == 'true'" @click="handleBookmarked">
                                <span class="material-symbols-outlined bookmark-span"> {{ bookmark.state }} </span>
                            </button>

                        </div>
                        <div class="rt">
                            <NoteComics :comic="this.currentComic"
                                v-if="isConnected == 'true' && isInLibrary == true || isAdmin === true" />
                            <h3> <b> {{ this.currentComicName }} </b> </h3>
                            <p>
                                Collection :
                                <span id="span-collection" @click="() => goToCollection(this.currentCollection.name)">
                                    <b> {{ this.currentCollection.name }} </b>
                                    <span class="material-symbols-outlined"> open_in_new </span>
                                </span>
                            </p>
                            <p> Nombre de pages : <b> {{ this.currentComic.nbPage }} </b> </p>
                            <p v-if="this.currentHouse.name == 'MARVEL'">
                                Maison d'édition : <img @click="() => redirect('MarvelPage')" id="house-logo-marvel"
                                    src="../assets/Marvel_Logo.svg" title="MARVEL" alt="">
                            </p>
                            <p v-else-if="this.currentHouse.name == 'DC COMICS'">
                                Maison d'édition : <img @click="() => redirect('DC-Comics')" id="house-logo-dc"
                                    src="../assets/DC_Comics_logo.png" title="DC COMICS" alt="">
                            </p>
                            <p v-else>
                                Maison d'édition : <b @click="() => redirect('OtherComics')"> {{
                                    this.currentHouse.name
                                }} </b>
                            </p>
                            <p v-if="this.currentComic.note" class="note-star">
                                Note : <b> {{ this.currentComic.note }} <span class="material-symbols-outlined"> star
                                    </span> </b>
                            </p>
                            <p class="creditPrice">
                                Crédits : <b> {{ this.currentComic.credits }} </b>
                                <span class="material-symbols-outlined"> monetization_on </span>
                            </p>
                            <p class="redArrow">
                                <span class="material-symbols-outlined "> south </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <h1> Bonne lecture 😀 </h1> <br>

        <!-- On affiche les images du comics -->
        <div v-if="isConnected == 'true' && isInLibrary == true || isAdmin === true">
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
                    <!-- Bouton gauche -->
                    <button v-if="currentPage > 1" type="button" class="arrow-back" @click="() => changePage('back')">
                        &lt
                    </button>
                    <button v-else type="button" class="arrow-back" disabled> &lt </button>

                    <img id="currentImg" :src="this.linkCurrentPage" @click="() => changePage('next')">

                    <!-- Bouton droit -->
                    <button v-if="currentPage < this.currentComic.nbPage" type="button" class="arrow-next"
                        @click="() => changePage('next')">
                        >
                    </button>
                    <button v-else type="button" class="arrow-next" disabled> > </button>
                </div>
            </div>
        </div>
        <div v-else-if="isConnected == 'true' && isInLibrary == false">
            <div class="band-connect">
                <div class="band-connect-left">
                    <h2> Ce comics coute {{ this.currentComic.credits }} crédits </h2>
                    <button type="button" class="btn" @click="() => this.spendCredits()">
                        Acheter ce comics : {{ this.currentComic.credits }}
                        <span class="material-symbols-outlined">
                            monetization_on
                        </span>
                    </button>
                </div>
                <img :src="this.linkCurrentPage" alt="">
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


        <!-- SECTION COMMENTAIRES -->
        <section id="comment-section">
            <h1> Section commentaires </h1>
            <AddComment v-if="isConnected == 'true' && isInLibrary == true || isAdmin === true" />


            <CommentList :comic="this.currentComic" />
        </section>


        <ScrollToTop />

        <span v-if="copied == true" class="copyFeedback notif"> {{ notifText }} </span>
    </div>
</template>


<style scoped >
#comment-section {
    margin-top: 100px;
}


h1 {
    font-family: var(--secondary-font);
}

.bookmark-btn:disabled {
    cursor: not-allowed;
    background: transparent;
}

.copyFeedback {
    position: absolute;
    bottom: 15px;
    right: 15px;

    width: 300px;
    height: 50px;

    background-color: #333;
    color: #fff;
    border-radius: 0.3em;
    border-left: 5px solid var(--main-color);

    text-align: center;

    padding-top: 15px;

    animation: fadeOut 3s linear forwards;
}

@keyframes fadeOut {
    0% {
        opacity: 1;
    }

    100% {
        opacity: 0;
        display: none;
    }
}

.creditPrice span {
    margin-left: 5px;
    transform: translateY(5px);
    color: #efc000;
}

#span-collection {
    cursor: pointer;
    color: var(--main-color);
}

#span-collection span {
    transform: translateY(5px);
    margin-left: 5px;
}

#span-collection:hover {
    color: var(--secondary-color);
}

#span-collection span:hover {
    color: var(--secondary-color);
}

#span-collection:hover {
    color: var(--secondary-color);
}

.rt {
    height: 100%;
}

.redArrow {
    display: flex;
    justify-content: flex-end;
    align-items: flex-end;
    margin-top: 0px;
}

.redArrow span {
    width: 50px;
    margin-left: 10px;
    color: var(--main-color);
    font-size: 50px;
    animation: upDown 1s infinite;
}

.redArrow span:hover {
    color: var(--main-color);
}

@keyframes upDown {
    0% {
        transform: translateY(0);
    }

    50% {
        transform: translateY(20px);
    }

    100% {
        transform: translateY(0);
    }
}




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
    height: 100%;
}

.right {
    margin-top: 100px;
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

.container {
    position: relative;
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
    margin-bottom: 300px;
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
    color: var(--bg-color);
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

.band-connect-left .material-symbols-outlined {
    transform: translateY(5px);
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

.select-readMode label {
    font-size: 1.2em;
    margin-left: 10px;
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

.note-star span {
    transform: translateY(2px);
    font-size: 26px;
    color: #efbf00;
    font-variation-settings:
        'FILL' 1,
        'wght' 400,
        'GRAD' 0,
        'opsz' 48
}
</style>