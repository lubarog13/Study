<template>
    <div class="container">
        <h1>Список постов</h1>
        <my-input v-model="searchQuery" placeholder="Поиск..."></my-input>
        <div class="app__btns">
            <my-button @click="showDialog=true"> Создать пост</my-button>
            <my-select :selectOptions="sortOptions" v-model="selectedSort" />
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
import axios from 'axios';
    export default {
        components: { PostList, PostForm },
        name: 'Home',
        data: () => {
            return{
                posts: [],
                showDialog: false,
                selectedSort: 'id',
                searchQuery: '',
                page: 0,
                limit: 10,
                totalPages: 1,
                sortOptions: [
                    {value: 'id', name: "Выберите опцию"},
                    {value: "title", name: "По названию"},
                    {value: "body", name: "По содержимому"},
                ]
            }
        },
        methods: {
            deletePost(id) {
                this.posts = this.posts.filter(post => post.id!==id)
            },
            addPost(post) {
                this.posts.push(post)
            },
            async fetchPosts() {
                try {
                    const response = await axios.get('https://jsonplaceholder.typicode.com/posts', {params: {
                        _page: this.page,
                        _limit: this.limit
                    }});
                    this.totalPages = Math.ceil(response.headers['x-total-count'] / this.limit)
                    this.posts = response.data
                }catch(err) {
                    console.log(err)
                }
            },
            async loadMorePosts() {
                this.page = this.page+1;
                try {
                    const response = await axios.get('https://jsonplaceholder.typicode.com/posts', {params: {
                        _page: this.page,
                        _limit: this.limit
                    }});
                    this.totalPages = Math.ceil(response.headers['x-total-count'] / this.limit)
                    this.posts = [...this.posts, ...response.data]
                }catch(err) {
                    console.log(err)
                }
            }
        },
        mounted() {
            /* const options = {
                root: document.querySelector('#scrollArea'),
                rootMargin: '0px',
                threshold: 1.0
            }
            const callback = (entries) => {
                if(entries[0].isIntersecting) {
                    console.log('Ok')
                    this.loadMorePosts()
                }
            };
            const observer = new IntersectionObserver(callback, options);
            observer.observe(this.$refs.observer) */
        },
        computed: {
            sortedPosts() {
                return [...this.posts].sort((post1, post2) => {
                    return post1[this.selectedSort].toString()?.localeCompare(post2[this.selectedSort]).toString()
                })
            },
            sortedAndSearchedPosts() {
                return this.sortedPosts.filter((post) => post.title.toLowerCase().includes(this.searchQuery.toLowerCase()))
            }
        },
        /* watch: {
            page() {
                this.fetchPosts()
            }
        } */
        /* watch: {
            selectedSort(newVal) {
                this.posts.sort((post1, post2) => {
                    return post1[newVal].toString()?.localeCompare(post2[newVal]).toString()
                })
            }
        } */
        
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