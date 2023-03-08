<script>
    export default {
        data() {
            return {
                show: false,
            }
        },
        methods: {
            scrollToTop() {
                window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                });
            },
            handleScroll() {
                const scrollY = window.scrollY;
                if (scrollY > 800) {
                    this.show = true;
                } else {
                    this.show = false;
                }
            },
        },
        mounted() {
            window.addEventListener('scroll', this.handleScroll);
        },
    }
</script>


<template>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <button v-if="show === true" @click="scrollToTop">
        <span class="material-symbols-outlined"> keyboard_double_arrow_up </span>
    </button>
</template>


<style scoped>

    button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background-color: var(--secondary-color);
        border: none;
        border-radius: 50%;
        padding: 10px;
        color: var(--font-color);
        cursor: pointer;
        transition: all 0.3s ease-in-out;
    }

    button:hover {
        /* background-color: var(--main-color-hover); */
        transform: rotate(360deg);
        transition: all 0.3s ease-in-out;
    }

    button:focus {
        outline: none;
    }

</style>