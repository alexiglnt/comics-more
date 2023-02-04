<script>

export default {
    name: 'PagesLégales',
    props: ['body', 'title'],
}

</script>


<template>

    <div>
        <h1> {{ title }} </h1>
        <p> {{ body }} </p>
    </div>

</template>


<style scoped >

h1 {
    text-align: center;
    font-size: 60px;
    font-weight: bold;
    margin-bottom: 50px;
    font-family: var(--secondary-font);
}

p {
    font-size: 20px;
    letter-spacing: 1px;
    word-spacing: 5px;
}

</style>