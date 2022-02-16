import { ref } from "vue";

export default function useSortedPosts(posts) {
    const selectedSort = ref('id')
    const sortedPosts =  [...posts.value].sort((post1, post2) => {
        return post1[selectedSort.value].toString()?.localeCompare(post2[selectedSort.value]).toString()
    })
    console.log('sp', posts.value)
    return {
        selectedSort,
        sortedPosts
    }
}