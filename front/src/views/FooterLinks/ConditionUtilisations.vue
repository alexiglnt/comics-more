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
            title: "CONDITIONS GENERALES D'UTILISATION",
            text: "Objet: Les présentes conditions générales d'utilisation ont pour objet de définir les modalités et conditions d'utilisation du site Comics More par les utilisateurs. En utilisant ce site, vous acceptez de vous soumettre aux présentes conditions d'utilisation. \n\n Contenu: Le contenu présent sur le site Comics More, incluant les textes, images, illustrations, logos, marques, et autres éléments, est protégé par les lois sur la propriété intellectuelle. Toute reproduction, utilisation ou modification de ces éléments sans autorisation préalable est strictement interdite.\n\n Responsabilité: Comics More ne peut être tenu responsable des dommages directs ou indirects causés par l'utilisation de son site, incluant notamment les erreurs, omissions, interruptions, virus informatiques, défauts de fonctionnement, ou tout autre problème technique.\n\n Ventes en ligne: Les produits proposés à la vente sur le site Comics More sont décrits de manière précise et conformes à la commande passée. En cas de non-conformité, le client peut renvoyer les produits et demander un remboursement ou un échange.\n\n Données personnelles: Comics More s'engage à protéger les données personnelles de ses clients conformément à la réglementation en vigueur sur la protection des données personnelles. Les informations collectées sur le site ne seront utilisées que pour les besoins de la vente et de la livraison des produits, ainsi que pour l'envoi d'informations relatives aux produits et aux offres de Comics More.\n\n Modification des conditions d'utilisation: Comics More se réserve le droit de modifier les présentes conditions d'utilisation à tout moment. Il est de la responsabilité des utilisateurs du site de se tenir informés des éventuelles modifications.\n\n Loi applicable : Les présentes conditions d'utilisation sont régies et interprétées conformément aux lois de France."
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