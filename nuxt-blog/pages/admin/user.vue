<script>
export default {
  name: "user",
  head() {
    return {
      title: `Добавление пользователя | ${process.env.appName}`
    }
  },
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
    onSubmit() {
      this.$refs.form.validate(async valid => {
        if (valid) {
          this.loading = true
          try {
            const formData = {
              login: this.controls.login,
              password: this.controls.password,
            }
            await this.$store.dispatch('auth/createUser', formData);
            this.$message.success('Новый пользователь добавлен');
            this.controls.login = ''
            this.controls.password = ''
            this.loading = false;
          } catch (e) {
            this.loading = false;
          }
        } else {

        }
      })
    }
  }
}
</script>

<template>
  <el-form ref="form" :model="controls"  :rules="rules" @submit.native.prevent="onSubmit">
    <h2>Создать пользователя</h2>
    <el-form-item label="Логин" prop="login">
      <el-input v-model.trim="controls.login"/>
    </el-form-item>
    <div class="mb2">
      <el-form-item label="Пароль" prop="password">
        <el-input type="password" v-model.trim="controls.password"/>
      </el-form-item>
    </div>
    <el-form-item>
      <el-button :loading="loading" native-type="submit" type="primary" >Создать</el-button>
    </el-form-item>
  </el-form>
</template>

<style scoped lang="less">
form {
  width: 600px;
}
</style>
