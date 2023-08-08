<template>
  <el-card
    shadow="hover"
    :body-style="{padding: 0}"
    class="post"
    >
    <header slot="header" class="post-header">
      <h3>Post title</h3>
      <small>{{ new Date().toLocaleString()}}</small>
    </header>
    <div class="post-body">
      <img
        src="https://docs.unity3d.com/cn/2021.1/uploads/Main/LightUsageSceneView.svg"
        alt="post image"
        class="post-img">
    </div>
    <footer class="post-footer">
        <el-button round @click="openPost">Открыть</el-button>
        <span>
          <i class="el-icon-message">
            12
          </i>
        </span>
    </footer>
  </el-card>
</template>

<script>
export default {
  methods: {
    openPost() {

    }
  }
}
</script>

<style lang="less" scoped>
  .post {
    min-height: 200px;
    margin-bottom: 2rem;
  }
</style>
