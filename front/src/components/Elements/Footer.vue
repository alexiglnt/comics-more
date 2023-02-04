<script >

export default {
  name: 'Footer',
  data() {
    return {
      date: new Date().getFullYear(),
    };
  },
  methods: {
    redirect(routeName) {
      this.$router.push({ name: routeName });
    }
  },
}

</script>

<template>
  <footer>
    <div class="footer-container">
      <div class="content">
        <div class="left">
          <img src="../../assets/logo_contour.png" alt="">
          
        </div>
        <div class="middle">
          <ul>
            <li @click="() => redirect('MentionsLegales')" > Mentions légales </li>
            <li @click="() => redirect('PolitiqueConfidentialite')" > Politique de confidentialité </li>
            <li @click="() => redirect('ConditionsGeneralesUtilisations')" > Conditions générales d'utilisation </li>
            <li @click="() => redirect('Home')" > Nous contacter </li>
            <li @click="() => redirect('Home')" > Plan du site </li>
          </ul>
        </div>
        <div class="right">
          <p>© {{ date }} - <span @click="redirect('Home')"> Comics More </span></p>
        </div>
      </div>
    </div>

  </footer>
</template>

<style scoped>
.footer-container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-color: var(--bg-color);
  color: var(--font-color);
  padding: 3em;

  margin-top: 200px;

  border-top: 7px solid var(--main-color);
}


.content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  max-width: 1200px;
}

.content div {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.left img {
  width: 100px;
  margin-right: 1em;
}

ul {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
}

li {
  list-style: none;
  margin-bottom: 1em;
  cursor: pointer;
}

li:hover {
  text-decoration: underline var(--main-color) ;
}

</style>
