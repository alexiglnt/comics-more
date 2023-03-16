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
            title: "NOUS CONTACTER",
            text: ""
        }
    },
}

</script>


<template>
    <Navbar />
    <div class="container">
        <div>
            <PagesLegalesVue :body="text" :title="title" />
            <div class="share-mail" >
                <a href="mailto:contact.comicsmore@gmail.com">contact.comicsmore@gmail.com</a>
            </div>
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

.share-mail {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 100px auto;
}

a {
    color: var(--main-color);
    text-decoration: underline var(--secondary-color) ;
    font-size: 30px;
    font-weight: bold;
    text-align: center;
}

</style>