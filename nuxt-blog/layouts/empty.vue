<script>
export default {
  name: "empty",
  computed: {
    error() {
      return this.$store.getters.error;
    }
  },
  watch: {
    error(value) {
      this.$message.error(value);
    }
  }
}
</script>

<template>
<div class="empty-layout">
  <nuxt/>
</div>
</template>

<style scoped lang="less">
.empty-layout {
  display: flex;
  justify-content: center;
  width: 100%;
  padding-top: 4rem;
}
</style>
