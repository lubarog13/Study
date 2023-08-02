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
  asyncData({$axios, error}) {
      return $axios.$get('https://jsonplaceholder.typicode.com/users').then(users => {
        return {
          users
        };
      }).catch(error => {
        error(error);
      })
  },
  data: () => ({
    isLoading: false,
  }),
  methods: {
    goTo(user) {
      this.$router.push('/users/' + user.id)
    }
  }
}
</script>
