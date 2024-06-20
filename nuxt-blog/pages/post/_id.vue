<template>
  <article class="post">
    <header class="post-header">
      <div class="post-title">
        <h1>{{ post.title }}</h1>
        <nuxt-link to="/"><i class="el-icon-back"></i></nuxt-link>
      </div>
      <div class="post-info">
        <small><i class="el-icon-time"></i> {{ post.date.toLocaleString() }}</small>
        <small><i class="el-icon-view"></i> {{ post.views }}</small>
      </div>
      <div class="post-image">
        <img
          :src="post.imageUrl"
          alt="post image">
      </div>
    </header>
    <main class="post-text">
      <vue-markdown>{{post.text}}</vue-markdown>
    </main>
    <footer>
      <AppCommentForm v-if="showCommentForm" :post-id="post._id" @created="createCommentHandler"/>
      <div class="comments" v-if="post.comments.length">
        <app-comment v-for="comment in post.comments" :key="comment._id" :comment="comment"/>
      </div>
      <div class="text-center" v-else>Комментариев нет</div>
    </footer>
  </article>
</template>

<script>
import AppComment from '@/components/main/Comment.vue'
import AppCommentForm from '@/components/main/CommentForm.vue';
export default {
  components: {
    AppComment,
    AppCommentForm
  },

  head() {
    return {
      title: `${this.post.title} | ${process.env.appName}`,
      meta: [
        {hid: `post-${this.post._id}d`, name: 'description', content: this.post.title},
        {hid: `post-${this.post._id}k`, name: 'keywords', content: 'post, пост, nuxt'}
      ]
    }
  },

  data() {
    return {
      showCommentForm: true,
    }
  },
  validate({params}) {
    return Boolean(params.id)
  },
  async asyncData({store, route}) {
    const post = await store.dispatch('post/fetchById', route.params.id);
    await store.dispatch('post/addView', post)
    return {
      post: {
        ...post,
        views: ++post.views
      }
    }
  },
  methods: {
    createCommentHandler(comment) {
      this.showCommentForm = false;
      this.post.comments.push(comment)
    }
  }
}
</script>

<style scoped lang="less">
.post {
  max-width: 600px;
  margin: 0 auto;
  &-title, &-info {
    display: flex;
    justify-content: space-between;
    margin-bottom: 1rem;
    align-items: center;
  }
  &-info {
    margin-bottom: .5rem;
  }
  &-image img {
    width: 100%;
    height: auto;
  }
  &-header {
    margin-bottom: 1.5rem;
  }
  &-content {
    margin-bottom: 2rem;
  }
  &-text {
    margin-bottom: 1.5rem;
  }
}
</style>
