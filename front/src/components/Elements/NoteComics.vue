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
            comicID: this.comic.id
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
        timeoutAndModifyHasNote() {
            setTimeout(() => {

                // si noteIDs est vide alors on ajoute l'id du comic
                if (this.noteIDs == "") {
                    this.noteIDs = this.comic.id
                    this.hasNote = true
                } else {
                    // sinon on ajoute l'id du comic avec une virgule
                    this.noteIDs = this.noteIDs + ',' + this.comic.id
                    this.hasNote = true
                }

                console.log("noteIDs", this.noteIDs);
                // let tabIDsStr = this.noteIDs.toString().replaceAll(',', ' ')
                // console.log("tabIDsStr", tabIDsStr);
                localStorage.setItem('hasNote', this.noteIDs)
            }, 1000)
        },
        addFirstNote() {
            axios.put(`${instance.baseURL}/api/comics/${this.comic.id}`, {
                note: this.note
            },
                {
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + localStorage.getItem('token')
                    }
                })
                .then(response => {
                    console.log(response)

                    this.timeoutAndModifyHasNote();
                })
                .catch(error => {
                    console.log(error)
                    accountService.tokenExpired(error);
                })
        },
        averageNote() {
            let actualNote = this.comic.note
            let newNote = this.note

            let average = (actualNote + newNote) / 2


            axios.put(`${instance.baseURL}/api/comics/${this.comic.id}`, {
                note: average
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

                        this.timeoutAndModifyHasNote();
                    }
                })
                .catch(error => {
                    console.log(error)
                    accountService.tokenExpired(error);
                })
        },
        handleClickStar(star) {

            this.note = star;
            const stars = document.querySelectorAll('.star');

            stars.forEach((currentStar, index) => {
                if (index < star) {
                    currentStar.classList.add('blank-star');
                } else {
                    currentStar.classList.remove('blank-star');
                }
            });

            this.noteThisComics();
        }
    },
    async mounted() {
        // Attendre la définition de this.comic
        await new Promise((resolve) => {
            const interval = setInterval(() => {
                if (this.comic) {
                    clearInterval(interval);
                    resolve();
                }
            }, 100);
        });

        if (localStorage.getItem('hasNote')) {
            this.noteIDs = localStorage.getItem('hasNote');

            this.tabIDs = this.noteIDs.split(',');
            console.log("tabIDs", this.tabIDs);

            this.tabIDs.forEach((id) => {
                if (id == (this.comic.id).toString()) {
                    this.hasNote = true;
                    console.log("ID TROUVE", id)
                }
            })
        }
    }


}

</script>


<template>
    <div class="note-comics">
        <h1>Note</h1>
        <p> Comic id : {{ comic.id }}</p>
        <p v-if="comic.note">Ce comics a une note de {{ comic.note }}</p>
        <p v-else> Ce comics n'a pas encore de note </p>

        <div v-if="hasNote == false" class="stars">
            <span class="material-symbols-outlined star" @click="() => handleClickStar(1)"> star </span>
            <span class="material-symbols-outlined star" @click="() => handleClickStar(2)"> star </span>
            <span class="material-symbols-outlined star" @click="() => handleClickStar(3)"> star </span>
            <span class="material-symbols-outlined star" @click="() => handleClickStar(4)"> star </span>
            <span class="material-symbols-outlined star" @click="() => handleClickStar(5)"> star </span>
        </div>
        <div v-if="hasNote == true">
            <h2> Vous avez noté ce comic </h2>
        </div>
    </div>
</template>


<style scoped >
.note-comics {
    background-color: #f0f0f0;
    border: 1px solid #ddd;
    padding: 20px;
    width: 500px;
    margin: 0 auto;
    font-family: Arial, sans-serif;
}

.note-comics h1 {
    font-size: 28px;
    margin-bottom: 10px;
}

.note-comics p {
    font-size: 16px;
    margin-bottom: 5px;
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