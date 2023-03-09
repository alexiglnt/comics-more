<script>
import Navbar from './Elements/Navbar.vue';
import Bookmarks from './Elements/BookmarksComponents.vue';

import axios from 'axios';
import instance from '../../axios-infos';
import { accountService } from '../_services';

import gsap from 'gsap';
import AOS from 'aos';
import 'aos/dist/aos.css'; // importer les styles CSS
import 'animate.css'

export default {
    components: { Navbar, Bookmarks },
    data() {
        return {
            isConnected: false,
            token: '',
            user: {},
            modifiedUser: {
                prenom: '',
                nom: '',
                mail: '',
                role: '',
                credits: null
            },
            editBtnMode: 'edit_square',
        }
    },
    methods: {
        redirect(route) {
            this.$router.push({
                name: route,
            });
        },
        initUserInfos() {
            this.user = JSON.parse(localStorage.getItem('userInfos'));

            this.modifiedUser.prenom = this.user.prenom;
            this.modifiedUser.nom = this.user.nom;
            this.modifiedUser.mail = this.user.email;
            this.modifiedUser.role = this.user.roles;
            this.modifiedUser.credits = this.user.credits;
        },
        logout() {
            // On vide le localStorage
            localStorage.removeItem('token');
            localStorage.removeItem('userInfos');
            localStorage.removeItem('userLibrary');

            localStorage.setItem('isConnected', false);
            this.isConnected = localStorage.getItem('isConnected');

            // On redirige vers la page d'accueil
            this.redirect('Login');
        },
        editProfil() {
            const inputs = document.querySelectorAll('input');
            const saveBtn = document.getElementById('save-btn');

            // On parcourt tous les inputs
            inputs.forEach(input => {
                // On vérifie si l'input est disabled
                if (input.disabled === true) {
                    // Si oui, on le rend editable
                    input.disabled = false;
                    saveBtn.disabled = false;
                    input.classList.add('input-editable');
                    this.editBtnMode = 'close';
                }
                else {
                    // Sinon, on le rend non editable
                    input.disabled = true;
                    saveBtn.disabled = true;
                    input.classList.remove('input-editable');
                    this.editBtnMode = 'edit_square';
                }
            });
        },
        saveModifications() {
            console.log("Nom : " + this.modifiedUser.nom + " Prenom : " + this.modifiedUser.prenom + " Mail : " + this.modifiedUser.mail);

            const URL = `${instance.baseURL}/api/users/${this.user.id}`;
            console.log(URL);

            axios.put(URL, {
                email: this.modifiedUser.mail,
                nom: this.modifiedUser.nom,
                prenom: this.modifiedUser.prenom,
            },
                {
                    headers: {
                        Authorization: `Bearer ${this.token}`
                    }
                })
                .then(response => {
                    console.log(response);
                    alert("Vos modifications ont bien été enregistrées ! Veuillez vous reconnecter pour les voir apparaitre.");
                    this.logout();
                })
                .catch(error => {
                    console.log(error);

                    // Si le token a expiré, on redirige vers la page de login
                    accountService.tokenExpired(error);
                });
        },
        openModal2() {
            const modal = document.getElementById('modal');
            const bigContainer = document.querySelector('.big-container');

            bigContainer.classList.add('blur');
            modal.style.display = 'flex';
        },
        openModal() {
            // prompt
            const confirmation = prompt("Voulez vous modifier vos informations ? (Tapez 'oui' pour confirmer)");

            if (confirmation === "oui") {
                this.saveModifications();
            }
            else {
                alert("Vos informations n'ont pas été modifiées !");
            }
        },
        closeModal() {
            const modal = document.getElementById('modal');
            const bigContainer = document.querySelector('.big-container');

            bigContainer.classList.remove('blur');
            modal.style.display = 'none';

            // On réinitialise les champs aux valeurs non modifiées (visuellement seulement)
            this.nouvNom = this.nom;
            this.nouvPrenom = this.prenom;
            this.nouvMail = this.mail;
        },
        handleClickDeleteBtn() {
            // prompt pour demander la confirmation de la suppression du compte
            const confirmation = prompt("Voulez-vous vraiment supprimer votre compte ? (Tapez 'supprimer' pour confirmer)");

            if (confirmation === "supprimer") {
                this.deleteUserAccount();
            }
            else {
                alert("Votre compte n'a pas été supprimé !");
            }
        },
        deleteUserAccount() {
            const URL = `${instance.baseURL}/api/users/${this.user.id}`;

            axios.delete(URL, {
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${this.token}`
                }
            })
                .then((response) => {
                    if (response.status === 204) {
                        alert('Toutes vos données ont bien été supprimées ! Revenez nous voir bientôt !');
                        this.logout();
                    }
                })
                .catch(error => {
                    console.log(error);
                    accountService.tokenExpired(error);
                });
        },
        beforeEnter(el) {
            el.style.opacity = 0;
            el.style.transform = "translateY(-80px)";
        },
        enter(el) {
            gsap.to(el, {
                opacity: 1,
                y: 0,
                duration: 0.3,
                delay: el.dataset.index * 0.2,
            });
        },
    },
    mounted() {
        this.isConnected = localStorage.getItem('isConnected');
        this.token = localStorage.getItem('token');

        this.initUserInfos();

        AOS.init();
    },
}
</script>


<template>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <Navbar /> <br> <br>

    <!-- MODALE de confirmation de l'envoie des données -->
    <!-- <div id="modal">
                <div class="modal-content">
                    <h2>Confirmation</h2>
                    <button type="button" class="btn-close-modal" @click="closeModal">
                        <span class="material-symbols-outlined"> close </span>
                    </button>
                    <p> Are you sure you want to change your information ? <br> You will be redirect to login page </p>
                    <div class="modal-btn">
                        <button type="button" class="btn" @click="saveModifications"> Yes </button>
                    </div>
                </div>
            </div> -->

    <div class="big-container animate__animated animate__backInUp">


        <!-- Si l'utilisateurs est connecté on affiche ça -->
        <transition-group appear @before-enter="beforeEnter" @enter="enter">
            <div v-if="isConnected == 'true'" :data-index="index" :key="1">
                <div>
                    <div class="title-logout">
                        <h1 v-if="user.prenom"> Bonjour <span> {{ user.prenom }} | </span> </h1>
                        <button type="button" id="btn-logout" @click="logout">
                            Déconnexion
                            <span class="material-symbols-outlined"> logout </span>
                        </button>
                    </div>

                    <!-- TABLEAU des informations -->
                    <div class="container">
                        <div class="table-title">
                            <h2> Vos informations </h2>
                            <button type="button" class="edit-btn" @click="editProfil">
                                <span class="material-symbols-outlined"> {{ editBtnMode }} </span>
                            </button>
                        </div>
                        <table>
                            <tbody>
                                <tr>
                                    <td> <b> Prénom </b> </td>
                                    <td> <input type="text" id="inputNom" v-model="modifiedUser.prenom" disabled> </td>
                                </tr>
                                <tr>
                                    <td> <b> Nom </b> </td>
                                    <td> <input type="text" id="inputPrenom" v-model="modifiedUser.nom" disabled> </td>
                                </tr>
                                <tr>
                                    <td> <b> Mail </b> </td>
                                    <td> <input type="text" id="inputMail" v-model="modifiedUser.mail" disabled> </td>
                                </tr>
                                <tr>
                                    <td> <b> Crédits </b> </td>
                                    <td>
                                        <p> {{ modifiedUser.credits }} </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td> <b> Statut </b> </td>
                                    <td>
                                        <p id="inputRole"> {{ modifiedUser.role[0] }} </p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <br>
                    <button id="save-btn" @click="openModal" disabled>Enregistrez les modifications</button>

                </div>
            </div>
        </transition-group>

        <div class="separation"> </div>


        <div class="blocs-container">
            <div class="bloc" @click="() => redirect('Library')" data-aos="fade-up-right" >
                <h2> Votre bibliothèque </h2>
                <span class="material-symbols-outlined"> library_books </span>
            </div>
            <div class="bloc" @click="() => redirect('Bookmarks')" data-aos="fade-up-left">
                <h2> Vos favoris </h2>
                <span class="material-symbols-outlined"> bookmark </span>
            </div>
        </div> <br>


        <button class="cubeBtn" @click="handleClickDeleteBtn" >
            Supprimer mon compte et mes informations &nbsp;
            <span class="material-symbols-outlined"> delete </span>
        </button>

    </div>
</template>


<style scoped>
.blocs-container {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin-top: 50px;
    width: 70%;
}

.bloc {
    width: 400px;
    height: 300px;
    background-color: var(--font-color);
    border-radius: 20px;
    box-shadow: 10px 10px 2px 1px var(--secondary-color);
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 1.5em;
    font-family: var(--font-family);
    color: var(--bg-color);
    font-family: var(--font);
    letter-spacing: 1px;

    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;

    transition: 0.3s ease;
}

.bloc:hover {
    transform: translateY(-10px);
    cursor: pointer;
    transition: 0.3s ease;
}

.bloc span {
    font-size: 5em;
    margin-top: 20px;
    color: var(--secondary-color);
}

#modal {
    display: none;
    /** None car Caché de base **/
    justify-content: center;
    align-items: center;
    position: absolute;
    top: 40%;
    left: 23%;
    z-index: 100;
    transform: translate(65px, -150px);
}

.modal-content {
    width: 700px;
    height: 350px;

    background: var(--font-color);
    color: var(--bg-color);


    border-top: 10px solid var(--main-color);
    font-size: 1.5em;
    border-radius: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.8);
}

.modal-content h2 {
    padding-top: 20px;
    margin-bottom: 70px;
    font-family: var(--font-title);
    letter-spacing: 3px;
}

.modal-content p {
    margin-bottom: 70px;
}

.modal-content .btn-close-modal {
    background-color: var(--font-color);
    border: none;
    color: var(--font-color);
    border-radius: 5px;
    cursor: pointer;
    padding: 0;
    margin: 0;

    position: absolute;
    top: 55px;
    right: 55px;
}

.modal-content .btn-close-modal span {
    font-size: 1.5em;
}

.modal-content .btn-close-modal span:hover {
    color: var(--main-color);
}

.modal-content .modal-btn {
    font-size: 0.8em;
}

.modal-content {
    width: 400px;
    height: 200px;
    background: white;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
    padding: 20px;
}

.blur {
    filter: blur(8px);
}

h1 span {
    font-family: var(--font-title);
    font-size: 1.4em;
    letter-spacing: 2px;
}

.title-logout {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin: 0 20px;
}

.big-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: 20px 20px;
}

.container {
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
}

.table-title {
    background: var(--main-color);
    color: var(--bg-color);
    margin: 0;
    padding: 1px;
    position: relative;
    text-align: center;
}

#btn-logout {
    background: transparent;
    border: none;
    font-size: 1.2em;
    cursor: pointer;
    margin: 0;
    color: red;
}

#btn-logout span {
    color: red;
    transform: translateY(5.5px);
}

.edit-btn {
    background-color: var(--main-color);
    border: none;
    font-size: 1.2em;
    padding: 0.5em 1em;
    border-radius: 5px;
    cursor: pointer;
    float: right;

    position: absolute;
    top: 10px;
    right: 10px;
}

.edit-btn span {
    color: var(--bg-color);
}

table {
    font-family: Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

table td,
table th {
    border: 1px solid #ddd;
    padding: 30px;
    padding-inline: 70px;
}

table tr:hover {
    background-color: #ddd;
    color: var(--main-color);
}

table tr p {
    text-align: center;
    color: #000;
}

table th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: center;
    background-color: #04AA6D;
    color: white;
}

td input {
    border: none;
    border-radius: 10px;
    padding: 10px;
    background-color: transparent;
    width: 100%;
    text-align: center;
    font-size: 1em;
    color: var(--font-color);
}

td input:focus {
    border: 3px solid var(--main-color);
    outline: none;
}

td input:hover {
    color: #333;
}

.input-editable {
    background-color: #ccc;
    border: 3px solid #aaa;
}

#modal {
    display: none;
    /** None car Caché de base **/
    justify-content: center;
    align-items: center;
    position: absolute;
    top: 40%;
    left: 23%;
    z-index: 100;
    transform: translate(65px, -150px);
}

.modal-content {
    width: 700px;
    height: 350px;

    background: var(--font-color);
    color: var(--bg-color);


    border-top: 10px solid var(--main-color);
    font-size: 1.5em;
    border-radius: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.8);
}

.modal-content h2 {
    padding-top: 20px;
    margin-bottom: 70px;
    font-family: var(--font-title);
    letter-spacing: 3px;
}

.modal-content p {
    margin-bottom: 70px;
}

.modal-content .btn-close-modal {
    background-color: var(--font-color);
    border: none;
    color: var(--font-color);
    border-radius: 5px;
    cursor: pointer;
    padding: 0;
    margin: 0;

    position: absolute;
    top: 55px;
    right: 55px;
}

.modal-content .btn-close-modal span {
    font-size: 1.5em;
}

.modal-content .btn-close-modal span:hover {
    color: var(--main-color);
}

.modal-content .modal-btn {
    font-size: 0.8em;
}

#save-btn {
    background-color: var(--main-color);
    border: none;
    color: var(--bg-color);
    font-size: 1.2em;
    padding: 0.5em 1em;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
    display: flex;
    justify-content: center;
    margin: 0 auto
}

#save-btn:hover {
    background: var(--main-color-hover);
}

#save-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
    color: var(--bg-color);
}


.cubeBtn {
    background-color: var(--main-color);
    border: none;
    color: var(--bg-color);
    font-size: 1.2em;
    padding: 0.5em 1em;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
    display: flex;
    justify-content: center;
    margin: 0 auto;
    margin-top: 100px;
}

.cubeBtn:hover {
    box-shadow: 0 0 5px var(--main-color);
}

.bookmarks {
    margin-top: 70px;
}

.bookmarks h1 {
    font-family: var(--font-title);
    letter-spacing: 2px;
    font-size: 2.5em;

    text-align: center;
}

.separation {
    margin-top: 40px;
    background: var(--font-color);
    width: 70%;
    height: 3px;
}
</style>