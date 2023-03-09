<script>
import Navbar from './Elements/Navbar.vue';
import Collection from './Elements/Collection.vue';

import gsap from 'gsap';
import AOS from 'aos';
import 'aos/dist/aos.css'; // importer les styles CSS
import 'animate.css'

export default {
    name: 'DCComponent',
    components: { Navbar, Collection },
    methods: {
        beforeEnter(el) {
            el.style.opacity = 0;
            el.style.transform = "translateY(-80px)";
        },
        enter(el) {
            gsap.to(el, {
                opacity: 1,
                y: 0,
                duration: 0.5,
                delay: el.dataset.index * 0.2,
            });
        },
    },
    mounted() {
        AOS.init();
    }
}

</script>



<template>
    <Navbar />

    <transition-group appear @before-enter="beforeEnter" @enter="enter">
        <div :data-index="index" :key="1">
            <div class="container">
                <img class="logo-house animate__animated animate__rubberBand animate__delay-1s"
                    src="../assets/DC_Comics_logo.png" alt="logo marvel">
                <h1 class="title"> DECOUVREZ LES COLLECTIONS DE <b> DC COMICS </b> </h1>
                <details>
                    <summary> Voir la description de DC Comics </summary>
                    <p>
                        <span class="material-symbols-outlined"> format_quote </span> <br>
                        DC Comics est une maison d'édition américaine de bandes dessinées, qui a été fondée en 1934 sous le
                        nom
                        de
                        National Allied Publications. Elle est surtout connue pour ses personnages de super-héros iconiques
                        tels
                        que
                        Batman, Superman, Wonder Woman, The Flash, Green Lantern, Aquaman, et bien d'autres encore.

                        L'univers de DC Comics est peuplé de héros qui protègent la Terre contre les forces du mal, ainsi
                        que
                        d'anti-héros et de vilains qui cherchent à la détruire. Les personnages de DC Comics sont souvent
                        confrontés
                        à
                        des menaces cosmiques et à des adversaires extrêmement puissants, mais leur sens de la justice et
                        leur
                        courage
                        leur permettent de triompher dans la plupart des cas.

                        DC Comics a créé certains des personnages les plus emblématiques de l'histoire des bandes dessinées,
                        ainsi
                        que
                        de nombreux univers et réalités alternatives fascinants. Les histoires de DC Comics ont inspiré de
                        nombreux
                        films, séries télévisées, jeux vidéo et autres produits dérivés.

                        DC Comics est également connu pour ses univers partagés, dans lesquels différents personnages et
                        histoires
                        se
                        croisent et interagissent, ce qui permet des histoires épiques et des moments mémorables pour les
                        fans.

                        DC Comics est une entreprise pionnière dans le monde des bandes dessinées, avec une riche histoire
                        et
                        une
                        influence culturelle durable. Elle continue à inspirer de nouvelles générations de fans avec ses
                        histoires
                        captivantes et ses personnages emblématiques. <br>
                        <span class="material-symbols-outlined second"> format_quote </span>
                    </p>
                </details>
            </div>


            <div class="collections-container" data-aos="fade-up">
                <Collection name="Batman" house="dc" />
                <Collection name="Flash" house="dc" />
            </div>
        </div>
    </transition-group>
</template>



<style scoped >
.container {
    margin-top: 120px;
    text-align: center;
}

.container p {
    width: 70%;
    text-align: justify;
    margin: 0px auto;
    line-height: 2em;
    font-style: italic;
}

.container span {
    font-size: 5em;
    color: var(--primary-color);
}

.container span:nth-child(1) {
    text-align: start;
    transform: rotate(180deg);
}

.container .second {
    float: right;
}

.logo-house {
    width: 250px;
}

.title {
    font-weight: 300;
    font-size: 2.5em;
    margin-top: 30px;
    font-family: var(--secondary-font);
}</style>