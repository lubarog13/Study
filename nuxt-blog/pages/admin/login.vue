<script>
export default {
  name: "login",
  layout: "empty",
  head() {
    return {
      title: `Авторизация | ${process.env.appName}`
    }
  },
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
  mounted() {
    const {message} = this.$route.query;
    if (message === 'login') {
      this.$message.info('Для начала войдите в систему')
    } else if (message === 'logout') {
      this.$message.success('Вы успешно вышли из системы')
    } else if (message === 'session') {
      this.$message.warning('Время сессии истекло, пожалуйста зайдите заного')
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
            await this.$store.dispatch('auth/login', formData);
            await this.$router.push('/admin')
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
  <el-card shadow="always" :style="{width: '500px'}">
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
  </el-card>
</template>

<style scoped lang="less">

</style>
