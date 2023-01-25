<script>

export default {
    data() {
        return {
            isAdmin: false,
        }
    },
    methods: {
        scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });
        },
        redirect(routeName) {
            this.$router.push({
                name: routeName,
            });
        },
    },
    mounted() {
        // Logo redirection to home
        document.getElementById("imgCM").addEventListener("click", () => this.redirect('Home'));


        // Navbar links redirection
        const navLinks = document.querySelectorAll('.nav-links');
        navLinks[0].addEventListener('click', () => {
            this.redirect('MarvelPage')
        });
        navLinks[1].addEventListener('click', () => {
            this.redirect('DC-Comics')
        });
        navLinks[2].addEventListener('click', () => {
            this.redirect('Home')
        });


        // Check if user is admin
        const userInfos = JSON.parse(localStorage.getItem('userInfos'));
        if (userInfos) {
            if (userInfos.roles[0] === 'ROLE_ADMIN') {
                this.isAdmin = true;
            }
        }

    },
}

</script>

<template>

    <div class="big-container">

        <div class="container">
            <nav id="nav-container">
                <img id="imgCM" src="../../assets/logo.png" width="5%">
                <div class="anchor-pack">
                    <a class="nav-links"> Marvel </a>
                    <a class="nav-links"> DC Comics </a>
                    <a class="nav-links"> Autres </a>
                </div>
                <div>
                    <a @click="() => redirect('Login')" class="btn">
                        <span class="material-symbols-outlined">
                            person
                        </span>
                    </a>
                    <a v-if="isAdmin === true"  @click="() => redirect('Admin')" class="btn">
                        <span class="material-symbols-outlined">
                            admin_panel_settings
                        </span>
                    </a>
                </div>
            </nav>
        </div>

    </div>

</template>

<style scoped >

.anchor-pack a {
    text-decoration: none;
    position: relative;
    cursor: pointer;
    color: #333;
    font-size: 20px;
}

.anchor-pack a::after {
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

.anchor-pack a:hover::after {
    transform: scaleX(1)
}

.material-symbols-outlined {
    font-size: 30px;
    font-variation-settings:
        'FILL' 0,
        'wght' 300,
        'GRAD' 0,
        'opsz' 48
}

.big-container {
    margin-top: 90px;
}

.container {
    margin: 0;
    padding: 0;
    background: var(--bg-color);
    width: 100%;
    height: 0px;
    position: fixed;
    top: 0;
    left: 0;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    align-items: center;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.9);
    z-index: 100000;
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
    margin-inline: 0.2em;
}

a:hover {
    cursor: pointer;
}

a span {
    color: var(--bg-color);
}

#nav-container {
    top: 0;
    left: 0;
    position: fixed;
    display: flex;
    justify-content: space-around;
    align-items: center;
    width: 100%;
    height: var(--navbar-height);
    max-height: 120px;
    box-shadow: 3px 3px 5px rgba(51, 51, 51, 0.418);
    background-color: #f1f1f1b6;
    backdrop-filter: blur(8px);

    z-index: 1000;
}

#nav-container img {
    user-select: none;
    transition: 0.5s ease;
}

#nav-container img:hover {
    transform: skew(10deg, 10deg);
    transition: 0.5s ease;
}

#nav-container .anchor-pack {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 400px;
}

a#btn-contact {
    background-color: #3D91C0;
    width: 80px;
    border-radius: 5px;
    color: white;
    font-size: 20px;
    border: none;
    box-shadow: 5px 5px 0px #003d61;
    transition: 0.4s ease;
    text-decoration: none;
    text-align: center;
    padding: 7px 0;
    align-items: center;
}

a#btn-contact:hover {
    background-color: #1e72a2;
    box-shadow: 0px 0px 0px rgba(51, 51, 51, 0);
    text-decoration: none;
    cursor: pointer;
    color: white;
    transition: 0.2s ease;
}
</style>