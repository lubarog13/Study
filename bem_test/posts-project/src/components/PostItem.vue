<template>
    <div class="post">
        <div>
            <div><strong>Название: </strong>{{post.title}}</div>
            <div><strong>Описание: </strong>{{post.body}}</div>
        </div>
        <div class="post__actions">
            <my-button
                @click="$emit('reset')"
            >Удалить</my-button>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'PostItem',
        props: {
            post: {
                type: Object
            }
        }
        
    }
</script>

<style lang="less" scoped>
    .post {
        border: 2px solid teal;
        margin-top: 15px;
        padding: 10px 15px;
        width: 100%;
        display: flex;
        background: white;
        &__actions {
            flex: 1;
            display: flex;
            justify-content: end;
            align-items: center;
        }
    }
</style>