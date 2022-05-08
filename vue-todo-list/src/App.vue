<template>
  <div id="app">
    <navigation @selected="setLang" @logout="setISLogin" :is_login="is_login"/>
    <splitpanes horizontal v-if="is_login">
      <pane>
    <cards-page @selected="setItem"/>
      </pane>
      <pane>
    <bottom-panel v-model="selected_item"/>
      </pane>
    </splitpanes>
    <b-spinner v-else-if="is_login===null"/>
    <login-page @signed="setISLogin" v-else/>
  </div>
</template>

<script>
import CardsPage from "@/pages/CardsPage";
import Navigation from "@/components/Navigation";
import BottomPanel from "@/components/BottomPanel";
import { Splitpanes, Pane } from 'splitpanes'
import 'splitpanes/dist/splitpanes.css'
import LoginPage from "@/pages/LoginPage";
import firebase from "firebase";

export default {
  name: 'App',
  components: {
    LoginPage,
    BottomPanel,
    Navigation,
    CardsPage,
    Splitpanes, Pane
  },
  data() {
    return {
      selected_item: null,
      lang: localStorage.getItem("lang") === undefined || localStorage.getItem("lang") === null ? "en" : localStorage.getItem("lang"),
      is_login: null
    }
  },
  methods: {
    setLang(lang) {
      this.lang = lang
    },
    setISLogin(val) {
      this.is_login = val
    },
    setItem(item) {
      this.selected_item = item
    }
  },
  provide() {
    return {
      lang: this.lang
    }
  },
  mounted() {
    let th = this
    firebase.auth().onAuthStateChanged( function (user) {
      if (user) {
        console.log(true)
        th.is_login = true
      } else {
        console.log(false)
        th.is_login = false
      }
    });
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
.spinner-border {
  position: absolute;
  left: 50%;
  top: 50%;
  color: #C60000;
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
