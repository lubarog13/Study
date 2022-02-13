<template>
<div class="main">
    <div class="character__block">
    <div class="character__main">
        <div class="character__image">
            <img :src="character.image">
        </div>
        <div class="character__info">
            <div class="character__name">
                {{character.name}}
            </div>
            <div class="character__status" :class="[character.status==='Alive'? 'status-alive': 'status-dead']">
                {{character.status}} - {{character.species}}
            </div>
            <div class="character__last-location location">
                <div class="location__title">
                    Last known location:
                </div>
                <div class="location__place">
                    {{character.location.name}}
                </div>
            </div>
            <div class="character__first-location location">
                <div class="location__title">
                    First seen in:
                </div>
                <div class="location__place">
                    {{character.origin.name}}
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</template>

<script>
export default {
    name: 'RickAndMortyCaracterDetails',
  data: () => {
      return {
          character: Object
      }
  },
    async created() {
      const {id} = this.$route.params;
      this.character = this.$store.getters['getCharacterById']({id: id})
      if (this.character === null) {
          try{
            const {data} = await this.$store.dispatch('fetchSingleCharacter', id)
            this.character = data
          }
          catch(err) {
              console.log(err)
          }
      }
  }
    
}
</script>