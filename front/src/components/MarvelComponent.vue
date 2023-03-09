<script>
import Navbar from './Elements/Navbar.vue';
import Collection from './Elements/Collection.vue';

import gsap from 'gsap';
import AOS from 'aos';
import 'aos/dist/aos.css'; // importer les styles CSS
import 'animate.css'

export default {
    name: 'MarvelComponent',
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
                    src="../assets/Marvel_Logo.svg" alt="logo marvel">
                <h1 class="title"> DECOUVREZ LES COLLECTIONS DE <b> MARVEL </b> </h1>
                <details>
                    <summary> Voir la description de MARVEL </summary>
                    <p>
                        <span class="material-symbols-outlined"> format_quote </span> <br>
                        Marvel Comics est une maison d'édition américaine de bandes dessinées, qui a été fondée en 1939.
                        Elle
                        est
                        connue
                        pour ses nombreux personnages de super-héros emblématiques tels que Spider-Man, les X-Men, les
                        Avengers,
                        Iron
                        Man, Hulk, Captain America, Thor, Black Panther et bien d'autres encore.

                        L'univers de Marvel Comics est peuplé de super-héros avec des pouvoirs extraordinaires, qui luttent
                        contre
                        les
                        forces du mal pour protéger le monde. Ces héros sont souvent confrontés à des adversaires puissants
                        et
                        des
                        menaces à l'échelle mondiale, et sont souvent obligés de travailler en équipe pour vaincre ces
                        ennemis.

                        Au fil des ans, Marvel Comics a créé une richesse de personnages colorés, avec des histoires
                        complexes
                        et
                        fascinantes qui ont captivé les lecteurs de tous âges. Les bandes dessinées Marvel ont été adaptées
                        dans
                        de
                        nombreuses autres formes de médias, notamment des films, des séries télévisées, des jeux vidéo et
                        plus
                        encore,
                        ce qui a contribué à leur popularité durable.

                        Marvel Comics est reconnu pour son engagement en faveur de la diversité, de l'inclusion et de la
                        représentation
                        dans ses histoires, en créant des personnages forts et inspirants de toutes les origines et de
                        toutes
                        les
                        orientations sexuelles. C'est une entreprise innovante qui a marqué l'histoire des bandes dessinées,
                        de
                        la
                        culture populaire et de la fiction de super-héros en général. <br>
                        <span class="material-symbols-outlined second"> format_quote </span> <br>
                    </p>
                </details>
            </div>


            <div class="collections-container" data-aos="fade-up">
                <Collection name="Wolverine" house="marvel" />
                <Collection name="Spider-Man" house="marvel" />
                <Collection name="Ghost Rider" house="marvel" />
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
    width: 300px;
}

.title {
    font-weight: 300;
    font-size: 2.5em;
    margin-top: 50px;
    font-family: var(--secondary-font);
}

pre {
    font-size: 1.2em;
    width: 20%;
    margin: 0 auto;
}</style>