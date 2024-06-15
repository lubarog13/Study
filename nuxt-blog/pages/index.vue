<template>
    <el-row type="flex" justify="center">
      <el-col :xs="24" :sm="18" :md="12" :lg="10">
        <app-post
          v-for="post in posts"
          :key="post.id"
          :post="post"
        />
      </el-col>
    </el-row>
</template>

<script>
import AppPost from '@/components/main/Post.vue'
export default {
  name: 'IndexPage',
  head: {
    title: `Главная | ${process.env.appName}`
  },
  async asyncData({store}) {
    const posts = await store.dispatch('post/fetch')
    return {posts}
  },
  components: {AppPost}
}
</script>
