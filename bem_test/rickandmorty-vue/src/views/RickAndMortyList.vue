<template>
    <div class="main">
        <div class="characters">
        <character-block v-for="character in characters" :key="character.id" :character="character"></character-block>
        </div>
        <div class="pagination-block">
            <b-pagination
                v-model="page"
                :total-rows="pages*2"
                :perPage = "2"
                aria-controls="my-table"
                size="large"
            ></b-pagination>
        </div>
    </div>
    
</template>

<script>
import CharacterBlock from "../components/CharacterBlock.vue"

export default {
    name: 'RickAndMortyList',
    components: { CharacterBlock },
    data: () =>{
        return {
            page: 1,
            characters: [],
            pages: 0
        }
    },
      created() {
    },
    methods: {
        paginate() {
            console.log(this.page)
        }
    },
    watch: {
        page: {
            handler(currentPage) {
                this.$store.dispatch('fetchCharacters', currentPage).then(() => {
                    this.characters = this.$store.getters['getCharactersByPage']({page: currentPage})
                    this.pages = this.$store.state.pages
                })
            },
            immediate: true
        }
    }
}
</script>