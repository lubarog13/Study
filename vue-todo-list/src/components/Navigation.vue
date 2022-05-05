<template>
  <b-navbar toggleable="lg" type="dark">
    <b-navbar-brand href="#">To Do List</b-navbar-brand>
    <div class="spacer"></div>
    <b-navbar-nav href="#"><b-icon icon="gear-fill" variant="light"></b-icon></b-navbar-nav>

    <b-navbar-nav>
        <b-nav-item-dropdown text="Язык" right>
          <b-dropdown-item href="#">EN</b-dropdown-item>
          <b-dropdown-item href="#">RU</b-dropdown-item>
        </b-nav-item-dropdown>
    </b-navbar-nav>
      <b-navbar-nav>
        <b-nav-item-dropdown right>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em><b-avatar></b-avatar></em>
          </template>
          <b-dropdown-item href="#">Профиль</b-dropdown-item>
          <b-dropdown-item href="#">Выйти</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
  </b-navbar>
</template>

<script>
export default {
  name: "Navigation"
}
</script>

<style lang="less">
.spacer {
  flex: 1;
}
.navbar {
  padding: 0.2rem 40px;
  z-index: 1;
  background-color: #122a86 !important;
  margin-bottom: 20px;
  flex-direction: row;
  &-nav {
    margin-left: 20px;
  }
  .dropdown-menu {
    position: absolute !important;
    right: -20px;
  }
}
</style>