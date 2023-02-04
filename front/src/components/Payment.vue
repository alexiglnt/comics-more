<script>

import Navbar from './Elements/Navbar.vue';

export default {
    name: 'Payment',
    components: {
        Navbar
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
                        alert(`Transaction ${transaction.status}: ${transaction.id}\n\nSee console for all available details`);
                    });
                }
            }).render('#paypal-button-container');
        }
    },
    mounted() {
        // Chargement du script paypal
        let paypalSDK = document.createElement('script')
        paypalSDK.setAttribute('src', 'https://www.paypal.com/sdk/js?client-id=ATjCHaek_6rqoEng4TxjkS3wl1qJNpEsYeFrK3lHr1dBkAoa4fvmSHb_ZW9--t_yvev_B97X5DOov3hp&currency=EUR')
        document.head.appendChild(paypalSDK)

        // Initialisation du bouton paypal
        paypalSDK.onload = () => {
            this.initPaypal(0.01)
        }
    }
}

</script>


<template>

    <Navbar />
    <div class="container">
        <div id="paypal-button-container"></div>
    </div>
</template>



<style scoped>

#paypal-button-container {
    background: var(--bg-color);
}


</style>