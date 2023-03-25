<script>
import 'animate.css';

export default {
    data() {
        return {
            isAdmin: false,
            isConnected: localStorage.getItem('isConnected'),
            credits: 0,
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
        document.getElementById("imgCM").addEventListener("click", () => {
            this.redirect('Home')
        });


        // Navbar links redirection
        const navLinks = document.querySelectorAll('.nav-links');
        navLinks[0].addEventListener('click', () => {
            this.redirect('MarvelPage')
        });
        navLinks[1].addEventListener('click', () => {
            this.redirect('DC-Comics')
        });
        navLinks[2].addEventListener('click', () => {
            this.redirect('OtherComics')
        });


        // Check if user is admin
        const userInfos = JSON.parse(localStorage.getItem('userInfos'));
        if (userInfos) {
            this.credits = JSON.parse(localStorage.getItem('userInfos')).credits;
            if (userInfos.roles[0] === 'ROLE_ADMIN') {
                this.isAdmin = true;
            }
        }


        if (window.location.pathname === '/Marvel') {
            document.querySelectorAll('.nav-links')[0].classList.add('active');
        }
        if (window.location.pathname === '/DC-Comics') {
            document.querySelectorAll('.nav-links')[1].classList.add('active');
        }
        if (window.location.pathname === '/OtherComics') {
            document.querySelectorAll('.nav-links')[2].classList.add('active');
        }
    },
}

</script>

<template>
    <div class="big-container">

        <div class="container animate__animated animate__backInLeft">
            <nav id="nav-container">
                <span id="imgCM">
                    <img src="../../assets/logo.png" width="5%"
                    class="animate__animated animate__rubberBand animate__delay-1s">
                </span>
                <div class="anchor-pack">
                    <a class="nav-links"> Marvel </a>
                    <a class="nav-links"> DC Comics </a>
                    <a class="nav-links"> D'autres univers </a>
                </div>
                <div>
                    <a v-if="isConnected == 'true'" @click="() => redirect('BuyCredits')" class="coin" title="Vos crédits">
                        <span class="material-symbols-outlined">
                            monetization_on
                        </span>
                        {{ credits }}
                    </a>
                    <!-- BUTTONS -->
                    <a v-if="isConnected == 'false'" @click="() => redirect('Login')" class="btn navBtn">
                        <span class="material-symbols-outlined">
                            person
                        </span>
                    </a>
                    <a v-else @click="() => redirect('Login')" class="btn navBtn">
                        <span class="material-symbols-outlined">
                            settings_account_box
                        </span>
                    </a>
                    <a v-if="isAdmin === true" @click="() => redirect('Admin')" class="btn navBtn">
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
span.material-symbols-outlined {
    color: var(--font-color);
    font-variation-settings:
        'FILL' 1,
        'wght' 500,
        'GRAD' 0,
        'opsz' 48
}

a.coin {
    text-decoration: none;
    cursor: pointer;
    color: var(--font-color);
    font-size: 20px;
    margin-right: 20px;
}

a.coin>span.material-symbols-outlined {
    color: var(--main-color);
    transform: translateY(10px);
    transition: 0.5s ease;
    font-variation-settings:
        'FILL' 1,
        'wght' 300,
        'GRAD' 0,
        'opsz' 48
}

a.coin>span.material-symbols-outlined:hover {
    color: var(--font-color);
    transition: 0.5s ease;
}

.anchor-pack a {
    text-decoration: none;
    position: relative;
    cursor: pointer;
    color: #333;
    font-size: 20px;
}

.anchor-pack a::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: -5px;
    width: 100%;
    height: 2px;
    background-color: var(--main-color);
    transform: scaleX(0);
    transform-origin: bottom left;
    transition: transform 0.25s ease-out;
}

.anchor-pack .active {
    color: var(--main-color);
    font-weight: 700;
}

.anchor-pack a:hover::after {
    transform: scaleX(1)
}

.material-symbols-outlined {
    transform: translateY(5px);
    font-size: 35px;
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
    backdrop-filter: blur(3px);

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

#imgCM {
    cursor: pointer;
    width: 100px;
}

#imgCM img {
    width: 90%;
}
</style>