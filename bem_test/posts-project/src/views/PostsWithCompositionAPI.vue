<template>
    <div class="container">
        <h1>Список постов</h1>
        <my-input v-model="searchQuery" placeholder="Поиск..."></my-input>
        <div class="app__btns">
            <my-button @click="showDialog=true"> Создать пост</my-button>
            <my-select :selectOptions="sortOptions" v-model="selectedSort" />
        </div>
        <my-dialog v-model:show="showDialog">
            <post-form />
        </my-dialog>
        <div>
            <post-list :posts="sortedAndSearchedPosts" @reset="deletePost"/>
        </div>
    </div>
</template>

<script>
import PostForm from '../components/PostForm.vue'
import PostList from '../components/PostList.vue' 
import usePosts from '@/hooks/usePosts'
import useSortedPosts from '@/hooks/useSortedPosts'
import useSortedAndSearchedPosts from '@/hooks/useSortedAndSearchedPosts' 
import {onMounted} from "vue"
    export default {
        components: { PostList, PostForm },
        name: 'PostsWithCompositionAPI',
        data: () => {
            return{
                showDialog: false,
                sortOptions: [
                    {value: 'id', name: "Выберите опцию"},
                    {value: "title", name: "По названию"},
                    {value: "body", name: "По содержимому"},
                ]
            }
        },
        setup(props) {
            console.log(props)
            onMounted(() => {
                console.log(`The initial count is.`)
                const {posts, totalPages} = usePosts(10)
                console.log('posts', posts, totalPages)
                const {selectedSort, sortedPosts} = useSortedPosts(posts)
                console.log('value', sortedPosts)
                const {searchQuery, sortedAndSearchedPosts} = useSortedAndSearchedPosts(sortedPosts)
                return {
                    posts, totalPages,
                    selectedSort, sortedPosts,
                    searchQuery, sortedAndSearchedPosts
                } 
            }) 
        }
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