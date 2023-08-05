<template>
  <section>
    <h1>Users page</h1>

    <ul class="list-group">
      <li class="list-group-item" v-for="user of users" :key="user.id">
        <a href="#" @click.prevent="goTo(user)">{{ user.name }} ({{user.email}})</a>
      </li>
    </ul>
  </section>
</template>

<script>
export default {
  // async asyncData({store, error}) {
  //   try {
  //     await store.dispatch("users/fetchUsers");
  //     return {users: store.state.users.users}
  //   } catch (e) {
  //     console.log(e);
  //   }
  // },
  // async fetch({store, error}) {
  //   try {
  //     if (store.state.users.users.length === 0) {
  //       await store.dispatch('users/fetchUsers');
  //     }
  //   } catch (err) {
  //     console.log(err)
  //   }
  // },
  data: () => ({
    isLoading: false,
  }),
  methods: {
    goTo(user) {
      this.$router.push('/users/' + user.id)
    }
  },
  computed: {
    users() {
      return this.$store.state.users.users;
    }
  }
}
</script>
