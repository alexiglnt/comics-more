<script>
import Navbar from './Elements/Navbar.vue';
import Collection from './Elements/Collection.vue';

import gsap from 'gsap';
import AOS from 'aos';
import 'aos/dist/aos.css'; // importer les styles CSS

export default {
    name: 'OthersComicsComponent',
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
                duration: 0.3,
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
                <div class="logos">
                    <img class="logo-house" src="../assets/panini-comics.png" alt="">
                    <img class="logo-house2" src="../assets/image-comics.png" alt="">
                </div>
                <h1 class="title"> D'AUTRES COLLECTIONS DE COMICS TOUTES AUSSI PASSIONANTES </h1>
                <p>
                    <span class="material-symbols-outlined"> format_quote </span> <br>
                    Sur cette page, vous pourrez découvrir les collections de comics d'autres maisons d'éditions, telles que
                    Panini
                    Comics ou Image Comics. Bien que Marvel et DC Comics soient deux des plus grandes maisons d'éditions de
                    comics,
                    il existe de nombreuses autres maisons qui ont produit des œuvres fantastiques et populaires. Les comics
                    de
                    ces
                    autres maisons d'éditions peuvent souvent être plus difficiles à trouver que les grands titres de Marvel
                    et
                    DC
                    Comics, mais ils valent certainement la peine d'être recherchés pour leur qualité et leur originalité.

                    Panini Comics, par exemple, est une maison d'édition italienne qui publie des comics en France depuis
                    les
                    années
                    1990. Image Comics est une maison d'édition américaine fondée en 1992 par plusieurs artistes et
                    scénaristes
                    de comics,
                    tels que Todd McFarlane, Jim Lee, Rob Liefeld et Erik Larsen. Leur objectif était de créer des comics
                    qui
                    étaient libres de l'influence des grandes maisons d'éditions, comme Marvel et DC Comics, et de donner
                    aux
                    artistes et scénaristes un plus grand contrôle créatif sur leurs œuvres. Image Comics a publié des
                    séries
                    populaires telles que Spawn, The Walking Dead et Saga, qui ont toutes été acclamées par la critique et
                    ont
                    remporté de nombreux prix.

                    D'autres maisons d'éditions de comics notables incluent Dark Horse Comics, Boom! Studios, IDW Publishing
                    et
                    Valiant Comics, qui ont toutes publié des séries acclamées par la critique et qui ont de nombreux fans
                    dévoués.
                    En explorant les comics de ces maisons d'éditions, vous découvrirez des histoires captivantes et des
                    personnages
                    passionnants qui sont tout aussi intéressants que ceux de Marvel et DC Comics. Alors, n'hésitez pas à
                    explorer
                    cette page pour découvrir les merveilles que ces maisons d'éditions ont à offrir. <br>
                    <span class="material-symbols-outlined second"> format_quote </span> <br>
                </p>
            </div>


            <div class="collections-container" data-aos="fade-up" >
                <Collection name="The Boys" />
                <Collection name="Invincible" />
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
    margin: 50px auto;
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

.logos {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin-inline: 300px;
}

.logo-house {
    width: 300px;
    transform: scale(1.5);
}

.logo-house2 {
    width: 100px;
}

.title {
    font-weight: 300;
    font-size: 2.5em;
    margin-top: 50px;
    font-family: var(--secondary-font);
}</style>