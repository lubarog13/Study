<template>
    <div class="post__list" v-if="posts">
        <transition-group name="post-list">
        <post-item v-for="post in posts" :key="post.id" :post="post" @reset="$emit('reset', post.id)"/>
        </transition-group>
    </div>
    <div v-else class="post__list--empty">
            <h2>Сообщений нет</h2>
        </div>
</template>

<script>
import PostItem from './PostItem.vue'
    export default {
    components: { PostItem },
        name: 'PostList',
        props: {
            posts: {
                type: Object
            }
        },
        created() {
          console.log(this.posts)
        }
    }
</script>

<style lang="less" scoped>
.post__list {
        margin-top: 30px;
    }
    .post__list--empty {
        color: red;
        margin-top: 10%;
    }
    .post-list-item {
  display: inline-block;
  margin-right: 10px;
}
.post-list-enter-active, .post-list-leave-active {
  transition: all 0.5s ease;
}
.post-list-enter, .post-list-leave-to /* .list-leave-active до версии 2.1.8 */ {
  opacity: 0;
  transform: translateX(130px);
}
.post-list-move {
  transition: transform 0.8s ease;
}
</style>