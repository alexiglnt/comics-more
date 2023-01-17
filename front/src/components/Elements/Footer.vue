<script>

export default {
    name: 'Footer',
    methods: {
        redirect(routeName) {
            this.$router.push({
                name: routeName,
            });
        },
    },
}

</script>



<template>

    <div class="container">
        <div class="line">
            <div class="logo">
                <img src="../../assets/logo_contour.png" alt="logo">
            </div>
            <!-- <div>
                <h2>© 2023 - Comic-Book</h2>
            </div> -->
            <div class="links">
                <div class="link">
                    <a @click="() => this.redirect('Home')" >Home</a>
                </div>
                <div class="link">
                    <a @click="() => this.redirect('Login')" >Login</a>
                </div>
                <div class="link">
                    <a @click="() => this.redirect('Registration')" >Registration</a>
                </div>
            </div>
        </div>
    </div>

</template>



<style>

body {
    margin: 0;
  padding: 0;
  box-sizing: border-box;
}

</style>

<style scoped >

.container {
    margin-inline: 5%;
    background: var(--secondary-color);

    bottom: 0;
    width: 100%;
    height: 250px;

    margin-top: 100px;
}

h2 {
    color: var(--bg-color);
    font-size: 25px;
    font-weight: 400;
    width: 300px;
    text-align: end;
}

.line {
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 100%;
}

.logo {
    width: 100px;
}

.logo img {
    width: 100%;
}

.links {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 300px;
}

.link {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.link a {
    color: var(--bg-color);
    font-size: 1.5em;
    text-decoration: none;
}


.links a {
    text-decoration: none;
    position: relative;
    cursor: pointer;
    color: var(--bg-color);
    font-size: 15px;
}

.links a::after {
    content: "";
    display: block;
    position: absolute;
    bottom: -3px;
    width: 100%;
    height: 1.5px;
    transform: scaleX(0);
    transform-origin: left;
    background: var(--main-color);
    transition: transform 0.3s ease-out;
}

.links a:hover::after {
    transform: scaleX(1)
}


</style>