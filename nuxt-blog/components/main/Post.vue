<template>
  <el-card
    shadow="hover"
    :body-style="{padding: 0}"
    class="post"
    >
    <header slot="header" class="post-header">
      <h3>{{ post.title }}</h3>
      <small><i class="el-icon-time"></i> {{ post.date | date }}</small>
    </header>
    <div class="post-body">
      <img
        :src="post.imageUrl"
        alt="post image"
        class="post-img">
    </div>
    <footer class="post-footer">
        <el-button round @click="openPost">Открыть</el-button>
        <span>
          <i class="el-icon-message">
            {{ post.comments.length }}
          </i>
        </span>
    </footer>
  </el-card>
</template>

<script>
export default {
  props: {
    post: {
      type: Object,
      required: true,
    }
  },
  methods: {
    openPost() {
      this.$router.push(`/post/${this.post._id}`);
    }
  }
}
</script>

<style lang="less" scoped>
  .post {
    margin-bottom: 1.5rem;
    &-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    &-img {
      width: 100%;
      height: auto;
    }
    &-footer {
      padding: 1rem;
      align-items: center;
      display: flex;
      justify-content: space-between;
    }
  }
</style>
