<template>
    <select v-bind="{
             ...$attrs,
             onChange: (event) => $emit('update:modelValue', event.target.value)}"
              @change="changeOption">
        <option v-for="option in selectOptions"
            :key="option.value"
            :value="option.value">{{option.name}}</option>
    </select>
</template>

<script>
    export default {
        name: 'MySelect',
        props: {
            modelValue: String,
            selectOptions: {
                type: Array,
                default: () => []
            }
        },
        methods: {
            changeOption(event) {
                this.$emit('update:modelValue', event.target.value)
            }
        },
        created() {
            console.log(this.selectOptions)
        }
    }
</script>

<style lang="less" scoped>

</style>