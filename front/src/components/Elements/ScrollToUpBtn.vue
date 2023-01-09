<script>
    export default {
        methods: {
            scrollToTop() {
                window.scrollTo({
                    top: 0,
                    behavior: "smooth"
                });
            },
        },
    }
</script>


<template>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    <button @click="scrollToTop">
        <span class="material-symbols-outlined"> keyboard_double_arrow_up </span>
    </button>
</template>


<style scoped>

    button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background-color: var(--main-color);
        border: none;
        border-radius: 50%;
        padding: 10px;
        color: var(--bg-color);
        cursor: pointer;
        transition: all 0.3s ease-in-out;
    }

    button:hover {
        background-color: var(--main-color-hover);
    }

    button:focus {
        outline: none;
    }

</style>