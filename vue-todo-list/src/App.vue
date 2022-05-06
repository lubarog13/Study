<template>
  <div id="app">
    <navigation @selected="setLang"/>
    <splitpanes horizontal>
      <pane>
    <cards-page/>
      </pane>
      <pane>
    <bottom-panel v-model="selected_item"/>
      </pane>
    </splitpanes>
  </div>
</template>

<script>
import CardsPage from "@/pages/CardsPage";
import Navigation from "@/components/Navigation";
import BottomPanel from "@/components/BottomPanel";
import { Splitpanes, Pane } from 'splitpanes'
import 'splitpanes/dist/splitpanes.css'

export default {
  name: 'App',
  components: {
    BottomPanel,
    Navigation,
    CardsPage,
    Splitpanes, Pane
  },
  data() {
    return {
      selected_item: null,
      lang: localStorage.getItem("lang") === undefined || localStorage.getItem("lang") === null ? "en" : localStorage.getItem("lang")
    }
  },
  methods: {
    setLang(lang) {
      this.lang = lang
    }
  },
  provide() {
    return {
      lang: this.lang
    }
  }
}
</script>

<style lang="less">
@import (css) url('https://fonts.googleapis.com/css2?family=Comfortaa:wght@400;500;600;700&family=Open+Sans:wght@400;500;600;700&display=swap');
#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #333333;
  position: relative;
  background: #eeeeee;
  height: 100%;
  .splitpanes__splitter {
    height: 4px;
    z-index: 1;
  }
  .splitpanes__pane:last-child {
    background: white;
    border-radius: 20px;
    z-index: 1;
  }
}
body, html {
  height: 100%;
  margin: 0;
}
@keyframes moveIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
</style>
