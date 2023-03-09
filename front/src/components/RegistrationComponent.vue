<script>
import axios from 'axios';
import instance from '../../axios-infos';
import Navbar from './Elements/Navbar.vue';

import gsap from 'gsap';
import 'animate.css'

// Import des fonctions d'envoi d'email et du template HTML de l'email de bienvenue
import sendEmail from '../../smtp/smtp';
import { htmlEmailWelcome, htmlFacture } from '../../smtp/htmlMailTemplate';

export default {
    name: 'RegistrationComponent',
    components: { Navbar },
    data() {
        return {
            name: '',
            surname: '',
            mail: '',
            password: '',
            confirmPassword: '',
            visibilityMode: 'visibility_off',
            visibilityModeConfirm: 'visibility_off',
            errorEntry: '',
            isBlankInput: false,
            isConfirmedPassword: false,
            mailContent: {
                subject: 'Bienvenue sur Comics More !',
                body: ''
            }
        }
    },
    methods: {
        changeVisibility(idName) {
            const password = document.getElementById(idName);

            if (password.type === 'password') {
                password.type = 'text';

                if (idName === 'password') {
                    this.visibilityMode = 'visibility';
                } else {
                    this.visibilityModeConfirm = 'visibility';
                }
            }
            else {
                password.type = 'password';

                if (idName === 'password') {
                    this.visibilityMode = 'visibility_off';
                } else {
                    this.visibilityModeConfirm = 'visibility_off';
                }
            }
        },
        Register(e) {
            e.preventDefault();

            // On vérifie si tous les champs sont remplis et si les mots de passe correspondent
            if (this.mail == '' || this.password == '' || this.confirmPassword == '' || this.name == '' || this.surname == '') {
                this.errorEntry = 'Veuillez remplir tous les champs';
            }
            else if (this.password != this.confirmPassword) {
                this.errorEntry = 'Les mots de passe ne correspondent pas';
            }
            else {
                const URL = `${instance.baseURL}/api/users`;

                // On crée un nouvel utilisateur
                axios.post(URL, {
                    email: this.mail,
                    password: this.password,
                    prenom: this.name,
                    nom: this.surname,
                    credits: 10
                })
                    .then(response => {
                        console.log('response', response);

                        if (response.status == 201) {
                            const msgBody = htmlEmailWelcome(this.name);
                            sendEmail(this.mail, this.mailContent.subject, msgBody);
                        }

                        // On redirige vers la page de login
                        this.$router.push({
                            name: 'Login',
                        });
                    })
                    .catch(error => {
                        if (error.status == 500) {
                            this.errorEntry = 'Cette adresse mail est déja utilisée';
                        } else {
                            console.log(error);
                        }
                    });
            }
        },
        beforeEnter(el) {
            el.style.opacity = 0;
            el.style.transform = "translateY(-80px)";
        },
        enter(el) {
            gsap.to(el, {
                opacity: 1,
                y: 0,
                duration: 0.5,
                delay: el.dataset.index * 0.2,
            });
        }
    }
}
</script>


<template>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <Navbar />
    <div class="background"></div>

    <div class="center">

        
            <div class="container animate__animated animate__backInUp">

                <form @submit="Register">
                    <div class="name">
                        <div class="container-input">
                            <label for="prenomInput">Prénom</label>
                            <input type="text" name="prenomInput" placeholder="John" v-model="name">
                        </div>

                        <div class="container-input">
                            <label for="nomInput">Nom</label>
                            <input type="text" name="nomInput" placeholder="Doe" v-model="surname">
                        </div>
                    </div>

                    <div class="container-input">
                        <label for="mailInput">Mail</label>
                        <input type="email" name="mailInput" placeholder="johndoe@gmail.com"
                            pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" v-model="mail">
                    </div>

                    <div class="container-input">
                        <label for="passwordInput">Mot de passe</label>
                        <input type="password" id="password" name="passwordInput" placeholder="Entrez mot de passe"
                            v-model="password">
                        <button type="button" tabindex="-1" @click="() => { changeVisibility('password') }">
                            <span class="material-symbols-outlined "> {{ visibilityMode }} </span>
                        </button>
                    </div>

                    <div class="container-input">
                        <label for="confirmPasswordInput">Confirm Password</label>
                        <input type="password" id="confirmPass" name="confirmPasswordInput"
                            placeholder="Confirmez mot de passe" v-model="confirmPassword">
                        <button type="button" tabindex="-1" @click="() => { changeVisibility('confirmPass') }">
                            <span class="material-symbols-outlined "> {{ visibilityModeConfirm }} </span>
                        </button>
                    </div> <br>

                    <div v-if="errorEntry !== ''" class="form-error">
                        <p> {{ errorEntry }} </p>
                    </div>

                    <button type="submit" class="btn">S'inscrire</button>
                </form>

                <hr>

                <p> Vous avez deja un compte ? <a href="/Login"> Connectez-vous </a> </p>

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
    background-color: var(--secondary-color);
    background-image: linear-gradient(10deg, var(--bg-color) 50%, transparent 30%), linear-gradient(-60deg, var(--main-color) 30%, transparent 30%);
    z-index: -10;
}

.center {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 130px;
}

.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    justify-content: center;
    margin-top: 0px;
    border-radius: 0.5em;
    box-shadow: 0 0 1em #00000033;
    background: var(--bg-color);
    width: 500px;
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

.name {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}

.name .container-input {
    margin: 50px;
    margin-bottom: 0;
}

.name .container-input input {
    width: 150px;
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