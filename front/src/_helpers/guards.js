export function authGuard(to) {

    let isAuth = localStorage.getItem('isConnected');

    // Si l'utilisateur n'est pas connecté on le redirige vers la page de login
    if (isAuth == 'false') {
        return true;
    }

    // Sinon on le redirige vers sa page de profil (car il est déjà connecté)
    // router.push({ name: 'ProfilUser' });
    window.location.href = '/MyAccount';
}

export function MyAccountGuard(to) {

    let isAuth = localStorage.getItem('isConnected');

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

    // Sinon on le redirige vers la page Home
    alert('Hop hop hop, tu n\'es pas admin ! Allez ouste !');
    window.location.href = '/Home';
}