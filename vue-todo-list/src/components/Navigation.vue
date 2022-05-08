<template>
  <b-navbar toggleable="lg" type="dark">
    <b-navbar-brand href="#">To Do List</b-navbar-brand>
    <div class="spacer"></div>
    <b-navbar-nav href="#"><b-icon icon="gear-fill" variant="light"></b-icon></b-navbar-nav>

    <b-navbar-nav>
        <b-nav-item-dropdown :text="text[language].lang" right>
          <b-dropdown-item @click="changeLang('en')">EN</b-dropdown-item>
          <b-dropdown-item @click="changeLang('ru')">RU</b-dropdown-item>
        </b-nav-item-dropdown>
    </b-navbar-nav>
      <b-navbar-nav>
        <b-nav-item-dropdown right v-if="user">
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em><b-avatar :src="user.photoURL"></b-avatar></em>
          </template>
          <b-dropdown-item disabled>{{text[lang].hello}}, {{user.displayName!==null? user.displayName: user.email}}</b-dropdown-item>
          <b-dropdown-item href="#">{{ text[language].profile }}</b-dropdown-item>
          <b-dropdown-item @click="logOut">{{ text[language].logout }}</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
  </b-navbar>
</template>

<script>
import languageMixin from "@/mixines/languageMixin";
import firebase from "firebase";

export default {
  name: "Navigation",
  mixins: [languageMixin],
  props: ["is_login"],
  data() {
    return {
      language: this.lang,
      user: firebase.auth().currentUser
    }
  },
  methods: {
    changeLang(language) {
      localStorage.setItem("lang", language)
      window.location.reload()
    },
    logOut() {
      firebase.auth().signOut().then(() => {
        this.$emit('logout', false)
      }).catch(err => {
        console.log(err)
      })
    }
  },
  watch: {
    is_login() {
      this.user = firebase.auth().currentUser
    }
  }
}
</script>

<style lang="less">
.spacer {
  flex: 1;
}
.navbar {
  padding: 0.2rem 40px;
  z-index: 2;
  background-color: #122a86 !important;
  margin-bottom: 20px;
  flex-direction: row;
  &-nav {
    margin-left: 20px;
  }
  .dropdown-menu {
    position: absolute !important;
    right: -20px;
    z-index: 2;
  }
}
</style>