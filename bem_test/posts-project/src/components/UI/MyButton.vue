<template>
    <button class="btn">
        <slot></slot>
    </button>
</template>

<script>
    export default {
        name: 'MyButton'
        
    }
</script>

<style lang="less">
    .btn {
        border:1px solid teal;
        padding: 10px 15px;
        color: teal;
        background: white;
        height: fit-content;
        &:hover {
            background: whitesmoke;
        }
    }
</style>