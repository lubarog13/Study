<template>
    <div class="container">
        <h1>Список постов</h1>
        <my-input @update:model-value="setSearchQuery" :model-value="searchQuery" placeholder="Поиск..."></my-input>
     <div class="app__btns">
            <my-button @click="showDialog=true"> Создать пост</my-button>
            <my-select :selectOptions="sortOptions" :model-value="selectedSort" @update:model-value="setSelectedSort" />
        </div>
        <my-dialog v-model:show="showDialog">
            <post-form @created="addPost"/>
        </my-dialog>
        <div>
            <my-paginator :totalCount="totalPages" v-model:currentPage="page" class="app__paginator"/>
            <post-list :posts="sortedAndSearchedPosts" @reset="deletePost"/>
        </div>
        <div class="app__observer" ref="observer" v-intersection="loadMorePosts"></div>
    </div>
</template>

<script>
import PostForm from '../components/PostForm.vue'
import PostList from '../components/PostList.vue'
import {mapState, mapMutations, mapGetters, mapActions} from 'vuex'
    export default {
        components: { PostList, PostForm },
        name: 'PostsFromStore',
        data: () => {
            return{
                showDialog: false,
            }
        },
        methods: {
            ...mapMutations({
              setPage: 'post/setPage',
              setSearchQuery: 'post/setSearchQuery',
              setSelectedSort: 'post/setSelectedSort',
              addPost: 'post/addPost',
              deletePost: 'post/deletePost'
            }),
            ...mapActions({
              fetchPosts: 'post/fetchPosts',
              loadMorePosts: 'post/loadMorePosts'
            })
        },
        computed: {
            ...mapState({
              posts: state => state.post.posts,
              selectedSort: state => state.post.selectedSort,
              searchQuery: state => state.post.searchQuery,
              page: state => state.post.page,
              limit: state => state.post.limit,
              totalPages: state => state.post.totalPages,
              sortOptions: state => state.post.sortOptions
            }),
            ...mapGetters({
              sortedPosts: 'post/sortedPosts',
              sortedAndSearchedPosts: 'post/sortedAndSearchedPosts',
              getPosts: 'post/getPosts'
            }),
        },
    }
</script>

<style lang="less" scoped>
    .container {
        height: 100%;
        padding: 30px;
        padding-right: 50px;
    }
    .app__btns {
        display: flex;
        margin-top: 20px;
        justify-content: space-between;
    }
    .app__paginator {
        margin-top: 30px;
        margin-bottom: 30px;
    }
    .app__observer {
        height: 30px;
    }
</style>