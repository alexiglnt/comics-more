<script>
import Navbar from '../../components/Elements/Navbar.vue';
import PagesLegalesVue from '../../components/PagesLegales.vue';

export default {
    name: 'MentionsLegales',
    components: {
        PagesLegalesVue,
        Navbar
    },
    data() {
        return {
            title: "Mentions légales",
            text: "Propriété intellectuelle: Tout le contenu présent sur le site, incluant les textes, images, illustrations, logos, marques, et autres éléments, est protégé par les lois sur la propriété intellectuelle. Toute reproduction, utilisation ou modification de ces éléments sans autorisation préalable est strictement interdite.\n\n Responsabilité: Comics More ne peut être tenu responsable des dommages directs ou indirects causés par l'utilisation de son site, incluant notamment les erreurs, omissions, interruptions, virus informatiques, défauts de fonctionnement, ou tout autre problème technique.\n\n Ventes en ligne: Comics More s'engage à décrire les produits proposés à la vente de manière précise et à garantir la conformité des produits livrés à la commande passée. En cas de non-conformité, le client peut renvoyer les produits et demander un remboursement ou un échange.\n\n Données personnelles: Comics More s'engage à protéger les données personnelles de ses clients conformément à la réglementation en vigueur sur la protection des données personnelles. Les informations collectées sur le site ne seront utilisées que pour les besoins de la vente et de la livraison des produits, ainsi que pour l'envoi d'informations relatives aux produits et aux offres de Comics More.\n\n Modification des mentions légales: Comics More se réserve le droit de modifier ces mentions légales à tout moment. Il est de la responsabilité des utilisateurs du site de se tenir informés des éventuelles modifications."
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
    margin: 120px 500px;
    line-height: 35px;
    text-align: justify;
}

</style>