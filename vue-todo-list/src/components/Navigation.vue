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
        <b-nav-item-dropdown right>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em><b-avatar></b-avatar></em>
          </template>
          <b-dropdown-item href="#">{{ text[language].profile }}</b-dropdown-item>
          <b-dropdown-item href="#">{{ text[language].logout }}</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
  </b-navbar>
</template>

<script>
import text from "@/text/text";
export default {
  name: "Navigation",
  data() {
    return {
      text,
      language: this.lang
    }
  },
  methods: {
    changeLang(language) {
      localStorage.setItem("lang", language)
      window.location.reload()
    }
  },
  inject: {
    lang: {
      from: 'lang',
      default: 'en'
    }
  },
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