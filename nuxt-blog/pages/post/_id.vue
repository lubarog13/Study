<template>
  <article class="post">
    <header class="post-header">
      <div class="post-title">
        <h1>Post title</h1>
        <nuxt-link to="/"><i class="el-icon-back"></i></nuxt-link>
      </div>
      <div class="post-info">
        <small><i class="el-icon-time"></i> {{ new Date().toLocaleString()}}</small>
        <small><i class="el-icon-view"></i> 42</small>
      </div>
      <div class="post-image">
        <img
          src="https://docs.unity3d.com/cn/2021.1/uploads/Main/LightUsageSceneView.svg"
          alt="post image">
      </div>
    </header>
    <main class="post-text">
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. A ad consequatur consequuntur eius esse fugit, illum impedit incidunt iure libero minima natus nesciunt placeat porro possimus sed veniam? At, excepturi!</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Adipisci doloremque est illum libero magnam molestiae non quod! Aut commodi consectetur deleniti dolorum est explicabo, iure nesciunt nisi quae vel velit.</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. A aperiam, consectetur debitis ea expedita explicabo facere natus neque nesciunt, officia perferendis quis quo repellendus sed tempore vel vitae, voluptate voluptatem!</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda at cupiditate debitis delectus enim, et eum eveniet, hic ipsam, itaque necessitatibus nemo obcaecati pariatur perferendis praesentium quas tempora ut voluptatem?</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Animi eos ipsum laboriosam minus modi perferendis, placeat repellat sint unde. Blanditiis debitis delectus ipsum iste officia perspiciatis provident reiciendis saepe tempore!</p>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. A accusamus accusantium adipisci at consectetur cum dolores ducimus, est hic in libero nemo odit rem, repellat similique vel velit voluptas voluptatum!</p>
    </main>
    <footer>
      <AppCommentForm/>
      <div class="comments" v-if="true">
        <app-comment v-for="comment in 4" :key="comment" :comment="comment"/>
      </div>
      <div class="text-center" v-else>Комментариев нет</div>
    </footer>
  </article>
</template>

<script>
import AppComment from '@/components/main/Comment.vue'
import AppCommentForm from '@/components/main/CommentForm.vue'
export default {
  components: {
    AppComment,
    AppCommentForm
  },
  validate({params}) {
    return Boolean(params.id)
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
