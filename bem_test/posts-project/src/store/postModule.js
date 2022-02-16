import axios from "axios";

export default {
    state:  () => ({
        posts: Array(0),
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
    }),
    mutations: {
        setPosts(state, posts) {
            state.posts = posts
        },
        addPost(state, post) {
            state.posts.push(post)
        },
        deletePost(state, id) {
            state.posts = state.posts.filter(post => post.id!==id)
        },
        setSelectedSort(state, selectedSort) {
            state.selectedSort = selectedSort
        },
        setSearchQuery(state, searchQuery) {
            state.searchQuery = searchQuery
        },
        setPage(state, page) {
            state.page = page
        },
        setLimit(state, limit) {
            state.limit = limit
        },
        setTotalPages(state, totalPages) {
            state.totalPages = totalPages
        },
    },
    getters: {
        sortedPosts(state) {
            let posts = [...state.posts].sort((post1, post2) => {
                return post1[state.selectedSort].toString()?.localeCompare(post2[state.selectedSort]).toString()
            })
            return posts
        },
        sortedAndSearchedPosts(state, getters) {
                let posts = getters.sortedPosts.filter(post =>  post.title.toLowerCase().includes(state.searchQuery.toLowerCase()))
                console.log('posts', posts)
                return posts
        },
        getPosts(state) {
            return state.posts
        }
    },
    actions: {
        async fetchPosts({state, commit}) {
            try {
                const response = await axios.get('https://jsonplaceholder.typicode.com/posts', {params: {
                    _page: state.page,
                    _limit: state.limit
                }});
                commit('setTotalPages', Math.ceil(response.headers['x-total-count'] / state.limit))
                commit('setPosts',response.data)
            }catch(err) {
                console.log(err)
            }
        },
        async loadMorePosts({state, commit}) {
            commit('setPage', state.page+1)
            try {
                const response = await axios.get('https://jsonplaceholder.typicode.com/posts', {params: {
                    _page: state.page,
                    _limit: state.limit
                }});
                commit('setTotalPages', Math.ceil(response.headers['x-total-count'] / state.limit))
                commit('setPosts', [...state.posts, ...response.data])
            }catch(err) {
                console.log(err)
            }
        }
    },
    namespaced: true
}