<template>
  <div id="app">
    <cards-page/>
  </div>
</template>

<script>
import CardsPage from "@/pages/CardsPage";

export default {
  name: 'App',
  components: {
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
  margin-top: 60px;
}
</style>
