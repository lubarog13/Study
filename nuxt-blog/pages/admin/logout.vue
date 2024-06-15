<script>
export default {
  name: "logout",
  layout: "admin",
  middleware: ['admin-auth'],
  head() {
    return {
      title: `Выход | ${process.env.appName}`
    }
  },
  beforeCreate() {
    this.$store.dispatch('auth/logout')
    this.$router.push('/admin/login?message=logout')
  }
}
</script>

<template>
<div>Очищаем данные</div>
</template>

<style scoped lang="less">

</style>
