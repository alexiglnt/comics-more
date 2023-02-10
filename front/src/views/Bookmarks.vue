<script>
import Navbar from '../components/Elements/Navbar.vue';
import BookmarksComponents from '../components/Elements/BookmarksComponents.vue';

export default {
  name: 'Bookmarks',
  components: {
    BookmarksComponents, Navbar
  }
};

</script>


<template>
    <Navbar />

    <div class="bookmarks">
        <h1> VOS COMICS FAVORIS </h1>
        <BookmarksComponents />
    </div>

</template>


<style scoped >

.bookmarks {
    margin-top: 150px;
    margin-inline: 10%;
}

.bookmarks h1 {
    font-family: var(--secondary-font);
    letter-spacing: 2px;
    font-size: 3em;

    text-align: center;
}

</style>