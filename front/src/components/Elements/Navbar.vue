<script></script>

<template>

    <div class="big-container">
        <div class="container">
            <nav>
                <a href="/">Comics More</a>
                <a href="">Account</a>
            </nav>
        </div>
    </div>

</template>

<style scoped >

.big-container {
    margin-top: 90px;
}
.container {
    margin: 0;
    padding: 0;
    background: var(--main-color);
    width: 100%;
    height: 80px;
    position: fixed;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
}

nav {
    width: 100%;
    display: flex;
    justify-content: space-around;
    align-items: center;
    align-self: center;
}

a {
    color: var(--font-color);
    text-decoration: none;
    font-size: 2em;
}
</style>