import axios from 'axios';
import instance from '../../axios-infos';


// LoginGuard
export function authGuard(to) {

    let isAuth = 'false';

    if (localStorage.getItem('isConnected')) {
        isAuth = localStorage.getItem('isConnected');
    }

    // Si l'utilisateur n'est pas connecté on le redirige vers la page de login
    if (isAuth == 'false') {
        return true;
    }

    // Sinon on le redirige vers sa page de profil (car il est déjà connecté)
    // router.push({ name: 'ProfilUser' });
    window.location.href = '/MyAccount';
}



export function MyAccountGuard(to) {

    let isAuth = 'false';

    if (localStorage.getItem('isConnected')) {
        isAuth = localStorage.getItem('isConnected');
    }

    // Si l'utilisateur est connecté on le redirige vers sa page de profil
    if (isAuth == 'true') {
        return true;
    }

    // Sinon on le redirige vers la page de login
    window.location.href = '/Login';
}



export function AdminGuard(to) {

    if (localStorage.getItem('userInfos')) {
        let isAdmin = JSON.parse(localStorage.getItem('userInfos')).roles[0];

        // Si l'utilisateur est admin on le redirige vers la page admin
        if (isAdmin == 'ROLE_ADMIN') {
            return true;
        }

        // Sinon on le redirige vers la page Home
        alert('Hop hop hop, tu n\'es pas admin ! Allez ouste !');
        window.location.href = '/Home';
    }
    else {
        // Sinon on le redirige vers la page Home
        alert('Hop hop hop, tu n\'es pas admin ! Allez ouste !');
        window.location.href = '/Home';
    }

}



// Vérifie si l'ID de la page Comics existe dans la base de données
export function ComicsGuard(to) {

    let id = to.params.id;
    let URL = `${instance.baseURL}/api/comics/${id}`;

    axios.get(URL)
        .then((response) => {
            // Si l'ID existe on redirige vers la page Comics
            if (response.status == 200) {
                return true;
            }
        })
        .catch((error) => {
            // Si l'ID n'existe pas on redirige vers la page Home
            if (error.response.status == 404) {
                window.location.href = '/';
            }
            console.log(error);
        }
        );
}

// Vérifie si l'utilisateur est connecté pour accéder à la page de paiement et que il a choisi un nombre de crédits
export function PaymentGuard(to) {

    let isAuth = 'false';

    if (localStorage.getItem('isConnected')) {
        isAuth = localStorage.getItem('isConnected');
    }

    if (localStorage.getItem('nbCredits')) {
        let credits = localStorage.getItem('nbCredits');

        // Si l'utilisateur est connecté et qu'il a choisi un nombre de crédits on le redirige vers la page de paiement
        if (isAuth == 'true' && credits != '0') {
            return true;
        }
    }
    // Sinon on le redirige vers la page de login
    window.location.href = '/Login';
} 