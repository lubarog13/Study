<template>
  <section>
    <h1>{{ user.name }}</h1>
    <hr/>
    <b>{{user.email}}</b>
  </section>
</template>

<script>
export default {
  validate({params}) {
    return /^\d+$/.test(params.id)
  },
  async asyncData({params, error, $axios}) {
    try {
      console.log(params.id)
      const user = await $axios.get(`https://jsonplaceholder.typicode.com/users/${params.id}`);
      return {user: user.data}
    } catch (err) {
      error(err);
    }
  }
}
</script>
