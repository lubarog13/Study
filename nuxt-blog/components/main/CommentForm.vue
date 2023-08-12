<script>
export default {
  name: "CommentForm",
  data() {
    return {
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
          alert("Комментарий отправлен на модерацию");
        } else {
          console.log('Ошибка');
          return false;
        }
      })
      console.log('submit!');
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
      <el-button native-type="submit" type="primary" >Отправить</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="less">

</style>
