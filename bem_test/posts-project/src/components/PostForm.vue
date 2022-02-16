<template>
    <div class="post-form">
        <h2>Создание поста</h2>
        <form @submit.prevent="formSubmit">
            <my-input v-model="post.title" placeholder="Название" v-focus/>
            <my-input v-model="post.body" placeholder="Содержимое"/>
            <my-button type="submit" class="btn">Отправить</my-button>
        </form>
    </div>
</template>

<script>
    export default {
        name: 'PostForm',
        data: ()=> {
            return {
                post: {
                    id: 0,
                    title: '',
                    body: ''
                }
            }
        },
        methods: {
            formSubmit() {
                this.post.id = new Date().getTime()
                this.$emit('created', this.post)
                this.post = {
                    id: 0,
                    title: '',
                    body: ''
                }
            }
        }
    }
</script>

<style lang="less" scoped>
    .btn {
        margin-top: 20px;
    }
</style>