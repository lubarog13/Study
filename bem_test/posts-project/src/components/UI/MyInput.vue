<template>
    <input :value="modelValue" @input="updateInput" class="input" type="text"> 
</template>

<script>
    export default {
        name: 'MyInput',
        props: {
            modelValue: [String, Number]
        },
        methods: {
            updateInput(event) {
                this.$emit('update:modelValue', event.target.value)
            }
        }
    }
</script>

<style lang="less" scoped>
    .input {
        border: 1px solid teal;
        margin-top: 15px;
        padding: 10px 15px; 
        width: 90%;
    }
</style>