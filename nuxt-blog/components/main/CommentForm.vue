<script>
export default {
  name: "CommentForm",
  props: {
    postId: {
      type: String,
      required: true,
    }
  },
  data() {
    return {
      loading: false,
      controls: {
        name: '',
        text: ''
      },
      rules: {
        name: [
          {required: true, message: 'Пожалуйста, введите имя', trigger: 'blur'},
        ],
        text: [
          {required: true, message: 'Введите текст комментария', trigger: 'blur'},
        ]
      }
    }
  },
  methods: {
    onSubmit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          this.loading = true;
          const formData = {
            name: this.controls.name,
            text: this.controls.text,
            postId: this.postId
          }
          try {
            this.$store.dispatch('comment/create', formData).then((res) => {
              if (res.data._id) {
                this.$message.success('Комментарий добавлен')
                this.$emit('created', res.data)
              }
            }).catch(e => {
              this.$message.error('Комментарий не добавлен')
            })
            this.loading = false
          } catch (e) {
            this.loading = false;
          }
        } else {
          return false;
        }
      })
    }
  }
}
</script>

<template>
  <el-form ref="form" :model="controls"  :rules="rules" @submit.native.prevent="onSubmit">
    <h1>Добавить комментарий</h1>
    <el-form-item label="Ваше имя" prop="name">
      <el-input v-model.trim="controls.name"/>
    </el-form-item>
    <el-form-item label="Текст комментария" prop="text">
      <el-input type="textarea" resize="none" :rows="2" v-model="controls.text"/>
    </el-form-item>
    <el-form-item>
      <el-button :loading="loading" native-type="submit" type="primary" >Отправить</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="less">

</style>
