<script>
import AppAside from '@/components/admin/Aside.vue'
export default {
  name: "admin",
  components: {
    AppAside
  }
}
</script>

<template>
  <div class="admin-layout-wrap">
    <el-container :style="{height: '100%'}">
      <el-aside width="250px">
        <AppAside/>
      </el-aside>
      <el-main><nuxt/></el-main>
    </el-container>
  </div>
</template>

<style scoped lang="less">
.admin-layout-wrap {
  width: 100%;
  height: 100vh;
}
</style>
