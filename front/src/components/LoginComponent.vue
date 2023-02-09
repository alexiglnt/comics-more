<script>
import axios from 'axios';
import instance from '../../axios-infos';
import { accountService } from '../_services';

import Navbar from './Elements/Navbar.vue';

export default {
    name: 'LoginComponent',
    components: { Navbar },
    data() {
        return {
            mail: '',
            password: '',
            isConnected: false,
            token: '',
            usersData: [''],
            userInfos: '',
            visibilityMode: 'visibility_off',
            badRequest: false,
            cpt: 0,
            cpt_lib: 0,
        }
    },
    methods: {
        changeVisibility() {
            const password = document.getElementById('password');

            if (password.type === 'password') {
                password.type = 'text';
                this.visibilityMode = 'visibility';
            } else {
                password.type = 'password';
                this.visibilityMode = 'visibility_off';
            }
        },
        verifyBookmarkAndLibrary() {
            const URL = `${instance.baseURL}/api/bookmarks`;
            const URL_lib = `${instance.baseURL}/api/libraries`;

            axios.get(URL)
                .then(res => {
                    let bookmarks = res.data['hydra:member'];

                    bookmarks.forEach(bm => {
                        if (bm.userID === this.userInfos.id) {
                            this.cpt++;
                        }
                    });

                    if (this.cpt === 0) {
                        this.createBookmark();
                    }

                    return axios.get(URL_lib);
                })
                .then(res => {
                    let libraries = res.data['hydra:member'];

                    libraries.forEach(lib => {
                        if (lib.userID === this.userInfos.id) {
                            this.cpt_lib++;
                            console.log('LIB : ', lib);
                            localStorage.setItem('userLibrary', JSON.stringify(lib));
                            console.log('LIBRARY : ', localStorage.getItem('userLibrary'));
                        }
                    });

                    console.log('CPT LIB : ', this.cpt_lib);
                    if (this.cpt_lib === 0) {
                        this.createLibrary();
                    }

                    console.log('REDIRECTION');
                    this.$router.push({
                        name: 'ProfilUser',
                    });
                })
                .catch(err => {
                    console.error(err);
                });
        },
        createBookmark() {
            const URL = `${instance.baseURL}/api/bookmarks`;

            axios.post(URL, {
                userID: this.userInfos.id,
                comicsId: '/'
            })
                .then(res => {
                    console.log('BOOKMARK CREATED', res);
                })
                .catch(err => {
                    console.log('ERROR : ', err);
                })
        },
        createLibrary() {
            const URL_lib = `${instance.baseURL}/api/libraries`;

            axios.post(URL_lib,
                {
                    userID: this.userInfos.id,
                    comicsUserHas: "[]"
                },
                {
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + this.token
                    }
                })
                .then(res => {
                    console.log('LIBRARY CREATED', res);
                })
                .catch(err => {
                    console.log('ERROR : ', err);
                })
        },
        isBookmarkExist() {

            const URL = `${instance.baseURL}/api/bookmarks`;

            axios.get(URL)
                .then(res => {
                    let bookmarks = res.data['hydra:member'];
                    console.log('BOOKMARKS : ', bookmarks);

                    // Si l'utilisateur connecté n'a pas de bookmarks (on le sait avec son id), on en crée un
                    bookmarks.forEach(bm => {
                        if (bm.userID == this.userInfos.id) {
                            console.log('BOOKMARK EXIST');

                            // On incrémente le compteur pour savoir si l'utilisateur connecté a déjà un bookmark
                            this.cpt++;
                        }
                    });
                })
                .then(() => {
                    // Si l'utilisateur connecté n'a pas de bookmarks, on en crée un
                    console.log('CPT : ', this.cpt);
                    if (this.cpt == 0) {
                        this.createBookmark();
                    }
                })
                .then(() => {
                    // On redirige l'utilisateur vers la page de profil
                    // console.log('REDIRECTION');
                    // this.$router.push({
                    //     name: 'ProfilUser',
                    // });
                })
        },
        async getUserInformation() {
            const URL_users = `${instance.baseURL}/api/users`;

            // Requete GET pour récupérer les infos de tous les utilisateurs
            axios.get(URL_users, {
                headers: {
                    Authorization: `Bearer ${this.token}`
                }
            })
                .then(res => {

                    this.usersData = res.data['hydra:member'];
                    console.log('USERS : ', this.usersData);

                })
                .then(() => {
                    // Parcours de tous les utilisateurs pour trouver l'utilisateur connecté
                    for (let i = 0; i < this.usersData.length; i++) {
                        // Si l'utilisateur connecté est trouvé, on récupère ses infos
                        if (this.usersData[i].email == this.mail) {
                            // On stocke les infos de l'utilisateur connecté dans une variable userInfos
                            this.userInfos = this.usersData[i];
                            console.log('USER INFOS : ', this.userInfos);

                            // On enregistre les infos de l'utilisateur connecté dans le localStorage
                            localStorage.setItem('userInfos', JSON.stringify(this.userInfos));

                            // On vérifie si l'utilisateur connecté a déjà des bookmarks
                            this.verifyBookmarkAndLibrary();
                        }
                    }
                })
        },
        connectUser(e) {
            e.preventDefault();
            console.log('submit', this.mail, this.password);

            const URL = `${instance.baseURL}/api/login_check`;

            axios.post(URL, {
                username: this.mail,
                password: this.password,
            })
                .then(response => {

                    console.log('response', response);
                    this.isConnected = true;
                    this.token = response.data.token;

                    // On enregistre le token dans le localStorage
                    accountService.saveToken(this.token);
                    localStorage.setItem('isConnected', true);

                    this.getUserInformation();
                })
                .catch(error => {
                    console.log(error);
                    this.badRequest = true;
                });

        },
    }
}

</script>


<template>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <Navbar />
    <div class="background"></div>


    <div class="center">
        <div class="container">

            <h1> Connectez-vous ! </h1>

            <form @submit="connectUser">
                <!-- Email -->
                <div class="container-input">
                    <label for="mailInput">Mail</label>
                    <input type="email" name="mailInput" placeholder="Email" v-model="mail">
                </div>

                <!-- Password -->
                <div class="container-input">

                    <label for="passwordInput">Password</label>
                    <input type="password" id="password" name="passwordInput" placeholder="Mot de passe"
                        v-model="password">

                    <!-- Visibility Button -->
                    <button type="button" tabindex="-1" @click="changeVisibility">
                        <span class="material-symbols-outlined "> {{ visibilityMode }} </span>
                    </button>

                </div> <br>

                <!-- Si les données saisies sont invalides -->
                <div v-if="badRequest == true" class="form-error">
                    <p> Email ou mot de passe incorrect ! </p>
                </div>

                <button type="submit" class="btn"> Connection </button>
            </form>
            <hr>

            <p> Vous n'avez pas de compte ? <a href="/Registration"> Inscrivez-vous </a> </p>

        </div>
    </div>

</template>


<style scoped>
.background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: var(--main-color);
    background-image: linear-gradient(10deg, var(--bg-color) 50%, transparent 30%), linear-gradient(-60deg, var(--secondary-color) 30%, transparent 30%);
    z-index: -10;
}

.center {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 140px;
}

.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    justify-content: center;

    border-radius: 0.5em;
    box-shadow: 0 0 1em #00000033;
    width: 500px;
    background-color: var(--bg-color);
}

.container h1 {
    text-align: start;
    margin-top: 50px;
    margin-bottom: 0px;
    font-family: Verdana, Geneva, Tahoma, sans-serif;
    font-weight: 500;
}

.container-input {
    margin: 50px;
    position: relative;
}

.container-input button {
    background-color: transparent;
    border: none;
    cursor: pointer;
    position: absolute;
    right: 10px;
    bottom: 15px;
    padding: 0;
    margin: 0;
}

.container-input button span {
    color: var(--font-color);
    padding: 0;
    margin: 0;
}

form {
    margin-bottom: 40px;
}

label {
    font-weight: bold;
    display: flex;
    justify-content: flex-start;
    margin: 0;
    padding: 0;
}

input {
    width: 400px;
    height: 50px;
    background: transparent;
    border: none;
    border-bottom: 2px solid var(--font-color);
    padding: 5px;
    letter-spacing: 1px;
    font-size: 1.3em;
    margin-top: 0;
    color: var(--font-color);
}

input:focus {
    outline: none;
    border-bottom: 2px solid var(--main-color);
}

hr {
    width: 40px;
    margin: 0;
    padding: 0;
    border: none;
    border-bottom: 2px solid var(--font-color);
}

a {
    color: var(--main-color);
    text-decoration: none;
    cursor: pointer;
}

.form-error {
    color: red;
    margin-bottom: 20px;
    text-align: center;
}
</style>