<script>
export default {
  name: "user",
  layout: "admin",
  middleware: ['admin-auth'],
  data() {
    return {
      loading: false,
      controls: {
        login: '',
        password: ''
      },
      rules: {
        login: [
          {required: true, message: 'Пожалуйста, введите логин', trigger: 'blur'},
        ],
        password: [
          {required: true, message: 'Введите пароль', trigger: 'blur'},
          {min: 6, message: 'Пароль должен быть не менее 6 символов', trigger: 'blur'}
        ]
      }
    }
  },
  methods: {
    onSubmit() {}
  }
}
</script>

<template>
  <el-form ref="form" :model="controls"  :rules="rules" @submit.native.prevent="onSubmit">
    <h2>Войти в панель администратора</h2>
    <el-form-item label="Логин" prop="login">
      <el-input v-model.trim="controls.login"/>
    </el-form-item>
    <div class="mb2">
      <el-form-item label="Пароль" prop="password">
        <el-input type="password" v-model.trim="controls.password"/>
      </el-form-item>
    </div>
    <el-form-item>
      <el-button :loading="loading" native-type="submit" type="primary" >Войти</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="less">

</style>
