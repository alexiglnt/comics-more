<script>
import Payment from './Elements/Payment.vue';
import ReassuranceAchatVue from './Elements/ReassuranceAchat.vue';

export default {
    name: 'BuyCreditsPayment',
    components: {
        Payment, ReassuranceAchatVue
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
        <h1 class="title" > VOUS-Y ETES PRESQUE </h1>
        <div class="payment">
            <h1 v-if="nbCredits === 1"> Vous allez acheter <b>{{ nbCredits }}</b> pour un total de <b>{{ priceToPay }} € </b> </h1>
            <h1 v-else> Vous allez acheter <b>{{ nbCredits }} crédits </b> pour un total de <b>{{ priceToPay }} € </b> </h1>
            <Payment :priceToPay="this.priceToPay" />
            <h3> Vous pouvez fermer cette page une fois la notification du paiement completé apparu </h3>
        </div>
    </div>
    <ReassuranceAchatVue />
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
    width: 100%;

    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.title {
    font-family: var(--secondary-font);
    font-size: 3em;
    font-weight: 400;
    margin-bottom: 0px;
}

.payment {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 1000px;
    height: 400px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    margin: 50px auto;
}

.payment h1 {
    font-size: 2em;
    font-weight: 400;
    margin-bottom: 0px;
    margin-top: 50px;
}

.payment h3 {
    font-weight: 400;
    margin: 40px auto;
}

</style>