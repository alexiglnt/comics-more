<script>

import Navbar from './Navbar.vue';
import axios from 'axios';
import instance from '../../../axios-infos';
import { accountService } from '../../_services';

export default {
    name: 'Payment',
    props: ['priceToPay'],
    components: {
        Navbar
    },
    data() {
        return {
            paypalClientID: {
                comicsmore: 'ATjCHaek_6rqoEng4TxjkS3wl1qJNpEsYeFrK3lHr1dBkAoa4fvmSHb_ZW9--t_yvev_B97X5DOov3hp',
                sandbox: 'AQAGI0HHRE73sMq9Len_EiJMezpO2LFJ9qgvo2z8GusisdzqHc8ri1aAaEUpM6jTaR4n0xw7WRLlCUr0'
            },
            paymentSuccess: false
        }
    },
    methods: {
        initPaypal(price) {
            paypal.Buttons({
                style: {
                    shape: 'pill', // effet arrondi des boutons
                    color: 'blue',
                    layout: 'vertical',
                    label: 'buynow',
                },

                createOrder: (data, actions) => {
                    return actions.order.create({
                        purchase_units: [{
                            amount: {
                                value: price
                            }
                        }]
                    });
                },
                onApprove: (data, actions) => {
                    return actions.order.capture().then(function (orderData) {

                        console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                        const transaction = orderData.purchase_units[0].payments.captures[0];
                        localStorage.setItem('paypalOrder', JSON.stringify(orderData, null, 2));
                        
                        alert(`Transaction ${transaction.status} ! Vos crédits ont été ajoutés. Vous pouvez maintenant fermer cette fenêtre. Merci de votre confiance !`);

                        // Si la transaction est validée on ajoute les crédits
                        if (transaction.status === 'COMPLETED') {
                            // Requete d'ajout des crédits
                            let userId = JSON.parse(localStorage.getItem('userInfos')).id;
                            let userCredits = parseInt(JSON.parse(localStorage.getItem('userInfos')).credits, 10);
                            let creditsToAdd = parseInt(localStorage.getItem('nbCredits'), 10);

                            axios.put(`${instance.baseURL}/api/users/${userId}`,
                                {
                                    credits: userCredits + creditsToAdd
                                },
                                {
                                    headers: {
                                        'Content-Type': 'application/json',
                                        'Authorization': 'Bearer ' + localStorage.getItem('token')
                                    },
                                })
                                .then(response => {
                                    console.log(response);

                                    // Requete de mise a jour des informations de l'utilisateur
                                    axios.get(`${instance.baseURL}/api/users/${userId}`,
                                        {
                                            headers: {
                                                'Content-Type': 'application/json',
                                                'Authorization': 'Bearer ' + localStorage.getItem('token')
                                            }
                                        })
                                        .then(response => {
                                            console.log(response.data);

                                            let tpmUserInfos = JSON.parse(localStorage.getItem('userInfos'));
                                            tpmUserInfos.credits = response.data.credits;
                                            localStorage.setItem('userInfos', JSON.stringify(tpmUserInfos));
                                        })
                                        .catch(error => {
                                            accountService.tokenExpired(error);
                                            console.log(error);
                                        });
                                })
                                .catch(error => {
                                    accountService.tokenExpired(error);
                                    console.log(error);
                                });
                        } else {
                            alert('Transaction annulée, vous n\'avez pas été débité de votre compte');
                        }

                    });
                }
            }).render('#paypal-button-container');
        }
    },
    mounted() {
        // Chargement du script paypal
        let paypalSDK = document.createElement('script')
        paypalSDK.setAttribute('src', `https://www.paypal.com/sdk/js?client-id=${this.paypalClientID.comicsmore}&currency=EUR`)
        document.head.appendChild(paypalSDK)

        // Initialisation du bouton paypal
        paypalSDK.onload = () => {
            this.initPaypal(this.priceToPay)
        }
    }
}

</script>


<template>

    <Navbar />
    <div class="container">
        <div id="paypal-button-container"></div>
        <p v-if="paymentSuccess"> Paiement effectué, vous pouvez à présent fermer cette page </p>
    </div>
</template>



<style scoped>
#paypal-button-container {
    background: var(--bg-color);
}
</style>