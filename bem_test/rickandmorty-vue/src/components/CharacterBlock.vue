<template>
    <div class="character" @click="dateiledInfo">
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
</template>

<script>
export default {
    name: 'CharacterBlock',
    props: {
        character: {
            type: Object,
            required: true
        }
    },
    methods: {
        dateiledInfo() {
            this.$router.push({name: 'RickAndMortyCaracterDetails', params: {id: this.character.id}})
        }
    }
}
</script>