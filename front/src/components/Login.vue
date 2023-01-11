<script>
import axios from 'axios';
import instance from '../../axios-infos';
import Navbar from './Elements/Navbar.vue';

export default {
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
        Login(e) {
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

                    //localStorage.setItem('token', this.token);

                    this.$router.push({
                        name: 'Home',
                    });
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


    <div class="center">
        <div class="container">

            <h1> Connectez-vous ! </h1>

            <form @submit="Login">
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
                    <button type="button" @click="changeVisibility">
                        <span class="material-symbols-outlined "> {{ visibilityMode }} </span>
                    </button>

                </div> <br>

                <!-- Si les données saisies sont invalides -->
                <div v-if="badRequest == true" class="form-error">
                    <p> Email ou mot de passe incorrect ! </p>
                </div>

                <button type="submit"> Connection </button>
            </form>
            <hr>

            <p> Vous n'avez pas de compte ? <a href="/Registration"> Cliquez ici </a> </p>

        </div>
    </div>


</template>


<style scoped>

.center {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 200px;
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