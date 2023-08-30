<script>
export default {
  name: "create",
  layout: "admin",
  middleware: ['admin-auth'],
  data() {
    return {
      loading: false,
      controls: {
        title: '',
        text: '',
      },
      rules: {
        text: [
          {required: true, message: 'Пожалуйста, введите текст', trigger: 'blur'},
        ],
        title: [
          {required: true, message: 'Пожалуйста, введите заголовок', trigger: 'blur'},
        ],
      }
    }
  },
  methods: {
    onSubmit() {
      this.$refs.form.validate(async valid => {
        if (valid) {
          this.loading = true;
          const formData = {
            title: this.controls.title,
            text: this.controls.text,
          }

          try {
            await this.$store.dispatch('post/create', formData);
            this.controls.text = '';
            this.controls.title = ''
            this.$message.success('Пост создан')
            this.loading = false
          } catch (e) {
            this.loading = false
          }
        }
      })
    }
  }
}
</script>

<template>
<div>
  <el-form ref="form" :model="controls"  :rules="rules" @submit.native.prevent="onSubmit">
    <h1 class="mb">
      Создать новый пост
    </h1>
    <el-form-item label="Введите название поста" prop="title">
      <el-input v-model.trim="controls.title"/>
    </el-form-item>
    <el-form-item label="Текст в формате .md или .html" prop="text">
      <el-input type="textarea" resize="none" :rows="10" v-model.trim="controls.text"/>
    </el-form-item>
    <el-form-item>
      <el-button round :loading="loading" native-type="submit" type="primary" >Создать пост</el-button>
    </el-form-item>
  </el-form>
</div>
</template>

<style scoped lang="less">
form {
  max-width: 600px;
}
</style>
