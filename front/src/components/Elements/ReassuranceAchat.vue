<script>
export default {
    name: "Reassurance",
    data() {
        return {
            items: [
                {
                    icon: "local_shipping",
                    title: "Ajout instantanée de vos crédits",
                    description: "Une fois le paiement effectué, vos crédits sont ajoutés instantanément à votre compte",
                },
                {
                    icon: "lock",
                    title: "Paiement sécurisé",
                    description: "Paiement 100% sécurisé par Paypal",
                },
                {
                    icon: "support_agent",
                    title: "Support client",
                    description: "Besoin d'aide ? Contactez notre support client",
                },
            ],
        };
    },
};
</script>

<template>
    <div class="reassurance">
        <div v-for="(item, index) in items" :key="index" class="reassurance-item">
            <span class="material-symbols-outlined"> {{ item.icon }} </span>
            <h3>{{ item.title }}</h3>
            <p>{{ item.description }}</p>
        </div>
    </div>
</template>
  
  
<style scoped >

.reassurance {
    display: flex;
    justify-content: space-around;
    align-items: center;
    background-color: var(--secondary-color);
    padding: 20px;
    border-radius: 15px;
}

.reassurance-item {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 10px;
}

.reassurance-item span {
    font-size: 40px;
    margin: 10px;
}

.reassurance-item h3 {
    font-size: 16px;
    margin: 0;
}

.reassurance-item p {
    font-size: 14px;
    margin: 0;
    text-align: center;
    width: 400px;
}

</style>
  