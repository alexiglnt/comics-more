// This file contains all the functions that are used to interact with token


function saveToken(token) {
    localStorage.setItem('token', token);
}

function getToken() {
    return localStorage.getItem('token');
}

function removeToken() {
    localStorage.removeItem('token');
}

// Returns true if the user is logged in, false otherwise
function isLoggedIn() {
    return !!getToken();
}

function reconnect() {

    alert('Votre session a expiré, veuillez vous reconnecter');
    removeToken();
    localStorage.setItem('isConnected', false);
    window.location = '/Login';
}

function tokenExpired(error) {


    if (error.status == 401) {
        alert('Votre session a expiré, veuillez vous reconnecter');
        removeToken();
        localStorage.setItem('isConnected', false);
        window.location = '/Login';
    }
}

// function getUser() {
//     return jwtDecode(getToken());
// }


// Export the functions
export const accountService = {
    saveToken,
    getToken,
    removeToken,
    isLoggedIn,
    reconnect,
    tokenExpired
};