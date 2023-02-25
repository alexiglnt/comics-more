<script>
import Navbar from './Elements/Navbar.vue'
import ReassuranceAchat from './Elements/ReassuranceAchat.vue'

import instance from '../../axios-infos'
import axios from 'axios'

export default {
    name: 'BuyCredits',
    components: {
        Navbar, ReassuranceAchat
    },
    data() {
        return {
            nbCredits: 1,
            priceCredit: 0.01 // Valeur changée par la requête axios dans la méthode initCreditPrice() lancée dans mounted()
        }
    },
    methods: {
        handleSubmit() {
            let priceToPay = this.nbCredits * this.priceCredit;
            localStorage.setItem('nbCredits', this.nbCredits);
            localStorage.setItem('priceCredit', this.priceCredit);

            // Afficher un message d'alerte différent selon le nombre de crédits choisi
            if (this.nbCredits == 1) {
                alert(`Vous avez choisi de payer ${priceToPay} € pour ${this.nbCredits} crédit. Vous allez être redirigé vers la page de paiement.`);
            } else {
                alert(`Vous avez choisi de payer ${priceToPay} € pour ${this.nbCredits} crédits. Vous allez être redirigé vers la page de paiement.`);
            }

            // Redirige vers la page de paiement dans une nouvelle fenêtre
            window.open(`${instance.frontURL}/BuyCredits/Payment`, '_blank');
        },
        // Récupère le prix d'un crédit à l'unité depuis l'API
        initCreditPrice() {
            axios.get(`${instance.baseURL}/api/credits`,
                { headers: { Authorization: `Bearer ${localStorage.getItem('token')}` } })
                .then(res => {
                    // this.priceCredit = res.data['hydra:member'][0].price;
                })
                .catch(err => {
                    console.log(err);
                })
        }
    },
    mounted() {
        this.initCreditPrice();

        localStorage.setItem('paymentSuccess', 'false');
    }
}

</script>


<template>

    <Navbar />
    <div class="container">
        <h1> VENEZ ACHETER DES CREDITS </h1>

        <h2> Le prix du crédit à l'unité est à <b> 2 € </b> </h2>

        <form @submit="handleSubmit">
            <div>
                <label for="nbCredits"> Nombre de crédits : </label>
                <input type="number" name="nbCredits" id="nbCredits" min="1" max="100" v-model="nbCredits">
            </div>
            <h3 v-if="nbCredits == ''"> Choisissez un nombre correcte de crédits </h3>
            <h3 v-else-if="nbCredits == 1">
                Vous voulez acheter <b>{{ nbCredits }}</b> crédit pour un total de <b>{{ nbCredits * priceCredit }}</b>
                € ?
            </h3>
            <h3 v-else>
                Vous voulez acheter <b>{{ nbCredits }}</b> crédits pour un total de <b>{{ nbCredits * priceCredit }}</b>
                € ?
            </h3>
            <button type="submit" class="btn"> Oui </button>
        </form>

    </div>
    <ReassuranceAchat />

</template>


<style scoped >
.container {
    margin-top: 120px;
    margin-bottom: 100px;
    text-align: center;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.container h1 {
    font-family: var(--secondary-font);
    font-size: 3rem;
}

.container form {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    margin-top: 20px;
    border-radius: 0.5em;
    box-shadow: 0 0 1em #00000033;
    width: 600px;
    height: 300px;
}

.container form input {
    margin-top: 10px;
    margin-bottom: 10px;
    width: 120px;
    height: 50px;
    outline: 1px solid #aaa;
    border: none;
    border-radius: 5px;
    text-align: center;
    background: var(--bg-color);
    color: var(--font-color);
    padding: 10px;
    font-size: 30px;
}

.container form input:focus {
    outline: 3px solid var(--secondary-color);
    border: none;
}

.container form label {
    font-size: 20px;
    color: var(--font-color);
    padding: 10px;
}
</style> 