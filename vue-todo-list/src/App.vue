<template>
  <div id="app">
    <navigation/>
    <cards-page/>
  </div>
</template>

<script>
import CardsPage from "@/pages/CardsPage";
import Navigation from "@/components/Navigation";

export default {
  name: 'App',
  components: {
    Navigation,
    CardsPage,
  }
}
</script>

<style lang="less">
@import (css) url('https://fonts.googleapis.com/css2?family=Comfortaa:wght@400;500;600;700&family=Open+Sans:wght@400;500;600;700&display=swap');
#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #333333;
  overflow-x: hidden;
  height: 100%;
}
body, html {
  height: 100%;
  margin: 0;
}
</style>
