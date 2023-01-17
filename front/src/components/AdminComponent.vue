<script>
import Navbar from '../components/Elements/Navbar.vue';

import axios from 'axios';
import instance from '../../axios-infos';

export default {
    name: 'AdminComponent',
    components: {
        Navbar
    },
    data() {
        return {
            userInfos: {},
            users: [],
            token: localStorage.getItem('token'),
        }
    },
    methods: {
        getAllUsers() {

            const URL = `${instance.baseURL}/api/users`;

            axios.get(URL, {
                headers: {
                    Authorization: `Bearer ${this.token}`
                }
            })
                .then((response) => {
                    this.users = response.data['hydra:member']
                })
                .catch((error) => {
                    console.log(error);
                });

        },
    },
    mounted() {
        this.userInfos = JSON.parse(localStorage.getItem('userInfos'));

        // On va chercher tout les utilisateurs
        this.getAllUsers();
    },
}

</script>



<template>

    <Navbar />

    <div class="container">
        <h1> Salut grand Admin <span> {{ userInfos.prenom }} </span> ⚔️ </h1>


        <!-- On va parcourir et afficher tout les utilisateurs -->

        <div class="table-container">
            <div class="table-title">
                <h2> Utilisateurs </h2>
            </div>
            <table>
                <thead>
                    <tr>
                        <th> Prénom </th>
                        <th> Nom </th>
                        <th> Email </th>
                        <th> Rôle </th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="user in users">
                        <td> <b> {{ user.prenom }} </b> </td>
                        <td>
                            <p> {{ user.nom }} </p>
                        </td>
                        <td> <b> {{ user.email }} </b> </td>
                        <td>
                            <p v-if="user.roles[0] == 'ROLE_ADMIN'">
                                <span class="material-symbols-outlined vip"> workspace_premium </span>
                            </p>
                            <p v-else>
                                <span class="material-symbols-outlined"> verified_user </span>
                            </p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>


    </div>

</template>



<style scoped >
.container {
    margin-top: 120px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

h1 {
    font-size: 2.5em;
    font-weight: 300;
}

h1 span {
    font-weight: 700;
    font-size: 1.5em;
    color: var(--secondary-color);
}

.vip {
    color: var(--main-color);
}

.grid-container {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-gap: 20px;
    margin-top: 20px;
}

.grid-item {
    display: flex;
    justify-content: center;
    align-items: center;
}

.card {
    width: 18rem;
    border: 1px solid var(--secondary-color);
    border-radius: 5px;
}

.table-container {
    margin-top: 50px;
    width: 900px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
    margin: 50px auto;
}

.table-title {
    background: var(--main-color);
    margin: 0;
    padding: 1px;
    position: relative;
    text-align: center;
    width: 100%;
}

table {
    font-family: Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

table thead th {
    background-color: var(--transparent-color);
    color : var(--bg-color);
}

table td,
table th {
    border: 1px solid #ddd;
    padding-inline: 30px;
    text-align: center;
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

td p {
    border: none;
    border-radius: 10px;
    padding: 10px;
    background-color: transparent;
    width: 100%;
    text-align: center;
    font-size: 1em;
    color: var(--font-color);
}

td span {
    font-size: 1.7em;
    padding-right: 25px;
}

td input:focus {
    border: 3px solid var(--main-color);
    outline: none;
}

td input:hover {
    color: #333;
}
</style>