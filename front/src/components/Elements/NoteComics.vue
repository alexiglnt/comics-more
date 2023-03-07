<script>
import axios from 'axios';
import instance from '../../../axios-infos';
import { accountService } from '../../_services';

export default {
    name: 'NoteComics',
    props: ['comic'],
    data() {
        return {
            note: 1,
            noteIDs: "",
            tabIDs: [],
            hasNote: false,
            comicID: this.comic.id,
            userInfos: JSON.parse(localStorage.getItem('userInfos')),
        }
    },
    methods: {
        noteThisComics() {
            if (this.comic.note) {
                this.averageNote()
            } else {
                this.addFirstNote()
            }
        },
        addFirstNote() {
            // si usersWhoNoted n'est pas vide alors on ajoute l'id de l'utilisateur en plus
            if (this.comic.usersWhoNoted.length > 0) {
                axios.put(`${instance.baseURL}/api/comics/${this.comic.id}`, {
                    note: this.note,
                    usersWhoNoted: this.comic.usersWhoNoted + ',' + this.userInfos.id.toString()
                },
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ' + localStorage.getItem('token')
                        }
                    })
                    .then(response => {
                        console.log(response)

                        this.hasNote = true;
                    })
                    .catch(error => {
                        console.log(error)
                        accountService.tokenExpired(error);
                    })
            } else {
                // sinon on ajoute l'id de l'utilisateur
                axios.put(`${instance.baseURL}/api/comics/${this.comic.id}`, {
                    note: this.note,
                    usersWhoNoted: this.userInfos.id.toString()
                },
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ' + localStorage.getItem('token')
                        }
                    })
                    .then(response => {
                        console.log(response)

                        this.hasNote = true;
                    })
                    .catch(error => {
                        console.log(error)
                        accountService.tokenExpired(error);
                    })
            }
        },
        averageNote() {
            let actualNote = this.comic.note
            let newNote = this.note

            let average = (actualNote + newNote) / 2


            if (this.comic.usersWhoNoted.length > 0) {
                axios.put(`${instance.baseURL}/api/comics/${this.comic.id}`, {
                    note: average,
                    usersWhoNoted: this.comic.usersWhoNoted + ',' + this.userInfos.id.toString()
                },
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ' + localStorage.getItem('token')
                        }
                    })
                    .then(response => {
                        console.log(response)

                        if (response.status === 200) {

                            this.hasNote = true;
                        }
                    })
                    .catch(error => {
                        console.log(error)
                        accountService.tokenExpired(error);
                    })
            } else {
                axios.put(`${instance.baseURL}/api/comics/${this.comic.id}`, {
                    note: average,
                    usersWhoNoted: this.userInfos.id.toString()
                },
                    {
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer ' + localStorage.getItem('token')
                        }
                    })
                    .then(response => {
                        console.log(response)

                        if (response.status === 200) {

                            this.hasNote = true;
                        }
                    })
                    .catch(error => {
                        console.log(error)
                        accountService.tokenExpired(error);
                    })
            }
        },
        handleClickStar(star) {
            this.note = star;
            this.noteThisComics();
        },
        handleMouseOverStar(star) {
            const stars = document.querySelectorAll('.star');
            stars.forEach((currentStar, index) => {
                if (index < star) {
                    currentStar.classList.add('blank-star');
                }
            });
        },
        handleMouseOutStar() {
            const stars = document.querySelectorAll('.star');
            stars.forEach((currentStar) => {
                currentStar.classList.remove('blank-star');
            });
        },
    },
    comic: {
        handler(newValue) {
            if (localStorage.getItem('isConnected')) {
                // Si l'utilisateur a déjà noté un comic
                if (newValue.usersWhoNoted) {
                    if (newValue.usersWhoNoted != "") {
                        let tabUsersWhoNoted = newValue.usersWhoNoted.split(',');

                        tabUsersWhoNoted.forEach((user) => {
                            if (user == this.userInfos.id) {
                                this.hasNote = true;
                            }
                        })
                    }
                }
            }
        },
        immediate: true
    },
    created() {
        // Créer une promesse qui se résout lorsque this.comic est défini
        const waitForComic = new Promise(resolve => {
            const interval = setInterval(() => {
                if (this.comic.usersWhoNoted) {
                    clearInterval(interval);
                    resolve();
                }
            }, 100);
        });

        // Attendre que la promesse se résolve avant d'exécuter la logique
        waitForComic.then(() => {
            if (localStorage.getItem('isConnected')) {
                console.log("this.comic", this.comic);
                console.log("this.comic.usersWhoNoted", this.comic.usersWhoNoted);
                if (this.comic) {
                    if (this.comic.usersWhoNoted != "") {
                        console.log("this.comic.usersWhoNoted", this.comic.usersWhoNoted);
                        let tabUsersWhoNoted = this.comic.usersWhoNoted.split(',');
                        tabUsersWhoNoted.forEach((user) => {
                            console.log("user", user);
                            if (user == this.userInfos.id) {
                                this.hasNote = true;
                            }
                        })
                    }
                }
            }
        });
    }
}

</script>


<template>
    <div class="note-comics">
        <div v-if="hasNote == false" class="stars">
            <span class="material-symbols-outlined star" v-for="star in 5" :key="star" @click="() => handleClickStar(star)"
                @mouseover="() => handleMouseOverStar(star)" @mouseout="() => handleMouseOutStar()">
                star
            </span>
        </div>
        <div v-if="hasNote == true">
            <p> Vous avez noté ce comic </p>
        </div>
    </div>
</template>


<style scoped >
.note-comics {
    background-color: #f0f0f0;
    /* border: 1px solid #ddd; */
    /* padding: 20px; */
    width: 500px;
    margin: 0 auto;
    font-family: Arial, sans-serif;
}

.note-comics h1 {
    font-size: 28px;
    margin-bottom: 10px;
}

.note-comics p {
    font-size: 12px;
    margin-bottom: 5px;
    margin: 0;
    padding: 0;
}

.note-comics .note-input {
    margin-top: 20px;
}

.note-comics label {
    display: block;
    font-size: 16px;
    margin-bottom: 5px;
}

.note-comics input[type="number"] {
    font-size: 16px;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.note-comics .note-btn {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 4px;
    margin-top: 20px;
    cursor: pointer;
}

.note-comics .note-btn:hover {
    background-color: #0069d9;
}



.star {
    font-size: 40px;
    cursor: pointer;
}

.material-symbols-outlined {
    font-variation-settings:
        'FILL' 0,
        'wght' 400,
        'GRAD' 0,
        'opsz' 48
}

.blank-star {
    color: #efbf00;
    font-variation-settings:
        'FILL' 1,
        'wght' 400,
        'GRAD' 0,
        'opsz' 48
}
</style>