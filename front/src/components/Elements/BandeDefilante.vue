
<script>
export default {
    props: {
        text: {
            type: String,
            required: true,
        },
    },
};
</script>

<template>
    <div class="messagedefilant">
        <div :data-text="text">
            <span>
                {{ text }} &nbsp;
            </span>
        </div>
    </div>
</template>

<style>
/* Texte défilant */
.messagedefilant {
    display: block;
    margin: 40px auto;
    padding: 0;
    overflow: hidden;
    position: relative;
    width: 50%;
    max-width: 640px;
    height: 60px;
}

.messagedefilant div {
    position: absolute;
    min-width: 100%;
    /* au minimum la largeur du conteneur */
}

.messagedefilant div span,
.messagedefilant div:after {
    position: relative;
    display: inline-block;
    font-size: 2rem;
    white-space: nowrap;
    top: 0;
}

.messagedefilant div span {
    animation: defilement 10s infinite linear;
    background: transparent;
}

.messagedefilant div:after {
    position: absolute;
    top: 0;
    left: 0;
    content: attr(data-text);
    animation: defilement2 10s infinite linear;
    background: transparent;
}

@keyframes defilement {
    0% {
        margin-left: 0;
    }

    100% {
        margin-left: -100%;
    }
}

@keyframes defilement2 {
    0% {
        margin-left: 100%;
    }

    100% {
        margin-left: 0%;
    }
}</style>
  