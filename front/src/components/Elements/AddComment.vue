<script>

import axios from 'axios';
import instance from '../../../axios-infos';

export default {
    name: 'AddComment',
    data() {
        return {
            comment: '',
        }
    },
    methods: {
        addComment() {
            let date = new Date().toLocaleString('fr-FR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' });

            axios.post(`${instance.baseURL}/api/comments`, {
                content: this.comment,
                createdAt: date,
                comicId: parseInt(this.$route.params.id),
                userId: JSON.parse(localStorage.getItem('userInfos')).id,
                userCommented: JSON.parse(localStorage.getItem('userInfos')).prenom,
            })
                .then(response => {
                    console.log(response);
                    if (response.status === 201) {
                        alert('Commentaire ajouté ! Il sera visible dans quelques instants.')
                        this.comment = '';
                    }
                })
                .catch(error => {
                    console.log(error);
                    alert('Erreur lors de l\'ajout du commentaire ! Veuillez réessayer.')
                })

        },
    }
}

</script>



<template>
    <div>
        <form @submit.prevent="addComment">
            <div>
                <textarea name="" placeholder="Qu'avez vous pensez de ce comics ?" id="" cols="30" rows="10" v-model="this.comment"></textarea>
                <button type="submit"> Envoyer </button>
            </div>
        </form>
    </div>
</template>



<style scoped >

div {
    margin: 50px auto;
}

form {
    display: flex;
    flex-direction: column;
    align-items: center; 
    
}

form div {
    width: 700px;
    height: 200px;
    position: relative;
}

textarea {
    width: 100%;
    height: 100%;
    border: none;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    background: var(--bg-color);
    color: var(--font-color);
    padding: 20px;
    font-size: 1.2em;
    resize: none;
}

textarea:focus {
    outline: none;
}

form button {
    position: absolute;
    bottom: -20px;
    right: -20px;
}
</style>