<template>
<div class="error-layout">
  <div class="error-content">
    <h1 class="error-title">Ошибка 404</h1>
    <nuxt-link to="/">Вернуться на главную</nuxt-link>
  </div>
</div>
</template>

<script>
export default {
  name: "error"
}
</script>

<style scoped lang="less">
.error-layout {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
}

.error-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding-top: 4rem;
}
.error-title {
  color: rgb(145, 6, 6);
  margin-bottom: 1rem;
}
</style>
