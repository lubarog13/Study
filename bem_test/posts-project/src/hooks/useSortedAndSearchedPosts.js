import { ref } from "vue";

export default function useSortedAndSearchedPosts(sortedPosts) {
    const searchQuery = ref('')
    const sortedAndSearchedPosts =  sortedPosts.value.filter((post) => post.title.toLowerCase().includes(searchQuery.value.toLowerCase()))
    return {
        searchQuery, sortedAndSearchedPosts
    }
}