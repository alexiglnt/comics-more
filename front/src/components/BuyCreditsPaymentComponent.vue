<script>
import Payment from './Elements/Payment.vue';

export default {
    name: 'BuyCreditsPayment',
    components: {
        Payment
    },
    //emits: ['paymentSuccess'],
    data() {
        return {
            nbCredits: localStorage.getItem('nbCredits'),
            priceCredit: 0.01, // localStorage.getItem('priceCredit'),
            priceToPay: 0,
            isHide: false,
            paymentSuccess: localStorage.getItem('paymentSuccess')
        }
    },
    watch: {
        paymentSuccess(val) {
            localStorage.setItem('paymentSuccess', val);
        }
    },
    mounted() {
        this.priceToPay = this.nbCredits * this.priceCredit;

        // // mettre la valeur de paymentSuccess à true pour afficher le composant Payment
        // this.paymentSuccess = true;

        // changer la valeur de isHide avec onPaymentSuccess
        //  this.isHide = this.onPaymentSuccess;
    }
}

</script>


<template>

    <div class="container">
        <h1 v-if="nbCredits === 1" >  {{ nbCredits }} crédit = {{ priceToPay }} € </h1>
        <h1 v-else >  {{ nbCredits }} crédits = {{ priceToPay }} € </h1>
        <Payment :priceToPay="this.priceToPay" />
        <h3> Vous pouvez fermer cette page une fois la notification du paiement completé apparu </h3>
    </div>
    <!-- <div v-if="paymentSuccess == 'false'" class="container">
        <h1 v-if="nbCredits === 1" >  {{ nbCredits }} crédit = {{ priceToPay }} € </h1>
        <h1 v-else >  {{ nbCredits }} crédits = {{ priceToPay }} € </h1>
        <Payment :priceToPay="this.priceToPay" />
    </div>
    <div v-else >
        <h1> Paiement effectué, vous pouvez à présent fermer cette page </h1>
    </div> -->

</template>


<style scoped>

.container {
    margin-top: 150px;
    width: 40%;
}

</style>