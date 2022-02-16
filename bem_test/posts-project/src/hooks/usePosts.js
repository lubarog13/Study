import {  ref } from "vue";
import axios from "axios";

export default function usePosts(limit) {
    const posts = ref([])
    const totalPages = ref(0)
    const isPostsLading = ref(true)
    const fetching = async() => {
            try {
                const response = await axios.get('https://jsonplaceholder.typicode.com/posts', {params: {
                    _page: 1,
                    _limit: limit
                }});
                totalPages.value = Math.ceil(response.headers['x-total-count'] / limit)
                posts.value = response.data
                console.log('posts1', posts.value)
            }catch(err) {
                console.log('err', err)
            } finally {
                isPostsLading.value = false
            }
    }
    console.log('hi')
    fetching().then(() => {
        console.log('posts3', totalPages.value)
        return {
            posts,
            totalPages
        }
    })
}