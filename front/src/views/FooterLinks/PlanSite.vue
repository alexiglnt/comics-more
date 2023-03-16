<script>

import Navbar from '../../components/Elements/Navbar.vue';

export default {
    name: 'PlanSite',
    components: { Navbar },
}

</script>


<template>
    <Navbar />
    <div class="container">
        <h1>PLAN DU SITE</h1>
        <ul>
            <li><router-link to="/">Accueil</router-link></li>
            <li><router-link to="/Registration">Inscription</router-link></li>
            <li><router-link to="/Login">Connexion</router-link></li>
            <li>
                <router-link to="/MyAccount">Mon compte</router-link>
                <ul>
                    <li><router-link to="/MyAccount/Bookmarks">Mes favoris</router-link></li>
                    <li><router-link to="/MyAccount/Library">Ma bibliothèque</router-link></li>
                    <li><router-link to="/BuyCredits">Acheter des crédits</router-link></li>
                </ul>
            </li>
            <li>
                <p> Les différents univers de comics </p>
                <ul>
                    <li><router-link to="/Marvel">Univers Marvel</router-link></li>
                    <li><router-link to="/DC-Comics">Univers DC Comics</router-link></li>
                    <li><router-link to="/OtherComics">Autres Comics</router-link></li>
                </ul>
            </li>
            <li><router-link to="/MentionsLegales">Mentions légales</router-link></li>
            <li>
                <router-link to="/PolitiqueConfidentialite">Politique de confidentialité</router-link>
            </li>
            <li>
                <router-link to="/ConditionsGeneralesUtilisations">Conditions générales d'utilisation
                </router-link>
            </li>
            <li><router-link to="/ContactUs"> Nous contacter </router-link></li>
            <li><router-link to="/PlanSite">Plan du site</router-link></li>
        </ul>
    </div>
</template>
  


<style scoped>
.container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-color: var(--bg-color);
    color: var(--main-color);
    padding: 1em;
    margin-top: 0px;
}

h1 {
    text-align: center;
    font-size: 50px;
    line-height: 50px;
    font-weight: bold;
    margin-bottom: 50px;
    font-family: var(--secondary-font);
}

p {
    font-size: 20px;
}

a {
    color: var(--main-color);
    text-decoration: none;
    font-size: 20px;
    line-height: 40px;
}

a:hover {
    text-decoration: underline var(--secondary-color);
}
</style>