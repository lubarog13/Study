<template>
    <div class="page__wrapper">
        <div class="page__item" v-for="page in totalCount" :key="page" @click="this.$emit('update:currentPage', page)" :class="{'page__item-active': currentPage==page}">{{page}}</div>
    </div>
</template>

<script>
    export default {
        name: 'MyPaginator',
        props: {
            totalCount: {
                type: Number,
                required: true
            },
            currentPage: {
                type: Number,
                default: 1
            }
        },
    }
</script>

<style lang="less" scoped>
    .page__wrapper {
        display: flex;
        flex-direction: row;
        border: 2px solid teal;
        border-radius: 5px;
        width: fit-content;
        .page__item {
            border-right: 1px solid teal;
            background: white;
            width: 30px;
            height: 30px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            &:hover {
                background: rgb(172, 172, 172);
            }
            &-active {
                color: blue;
                background: rgb(230, 230, 230);
            }
        }
    }
</style>