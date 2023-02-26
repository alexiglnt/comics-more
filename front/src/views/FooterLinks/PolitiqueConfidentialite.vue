<script>
import Navbar from '../../components/Elements/Navbar.vue';
import PagesLegalesVue from '../../components/PagesLegales.vue';

export default {
    name: 'PolitiqueConfidentialite',
    components: {
        PagesLegalesVue,
        Navbar
    },
    data() {
        return {
            title: "POLITIQUE DE CONFIDENTIALITE",
            text: "Collecte des données: Comics More collecte des données personnelles auprès de ses utilisateurs lors de l'inscription, de la commande de produits, ou de la participation à des enquêtes ou des sondages. Les données collectées peuvent inclure des informations telles que le nom, l'adresse e-mail, l'adresse postale, le numéro de téléphone, les informations de paiement, et les préférences en matière de produits ou de communications.\n\n Utilisation des données: Les données collectées sont utilisées pour les besoins de la vente et de la livraison des produits, pour l'envoi d'informations relatives aux produits et aux offres de Comics More, et pour améliorer les services proposés par le site. Les données peuvent également être utilisées pour des fins de recherche marketing et pour personnaliser les communications avec les utilisateurs.\n\n Partage des données: Les données collectées ne seront partagées avec aucun tiers, sauf dans les cas où cela est nécessaire pour la livraison des produits ou pour remplir les obligations légales ou réglementaires.\n\n Sécurité des données: Comics More prend des mesures de sécurité appropriées pour protéger les données collectées contre la perte, l'utilisation abusive, l'accès non autorisé, la divulgation, la modification ou la destruction.\n\n Droits des utilisateurs: Les utilisateurs peuvent accéder à leurs données personnelles enregistrées sur le site, les corriger ou les supprimer en contactant le service client de Comics More.\n\n Modification de la politique de confidentialité: Comics More se réserve le droit de modifier la présente politique de confidentialité à tout moment. Il est de la responsabilité des utilisateurs du site de se tenir informés des éventuelles modifications.\n\n Loi applicable : La présente politique de confidentialité estrégie et interprétée conformément aux lois de [votre pays] en matière de protection des données personnelles.\n\n Cookies: Comics More peut utiliser des cookies pour faciliter la navigation sur le site et pour personnaliser les contenus et les publicités. Les utilisateurs peuvent désactiver les cookies à partir des paramètres de leur navigateur.\n\n Liens vers des sites tiers: Le site Comics More peut contenir des liens vers des sites tiers. Nous ne sommes pas responsables de la confidentialité des données sur ces sites et nous vous encourageons à lire les politiques de confidentialité de ces sites avant de soumettre vos informations personnelles.\n\n "
        }
    },
}

</script>


<template>
    <Navbar />
    <div class="container">
        <div>
            <PagesLegalesVue :body="text" :title="title" />
        </div>
    </div>
</template>


<style scoped >

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 120px 300px;
    line-height: 35px;
    text-align: justify;
}

</style>