<script>

export default {
  layout: 'admin',
  middleware: ['admin-auth'],
  head() {
    return {
      title: `Пост | ${this.post.title}`
    }
  },
  validate({params}) {
    return Boolean(params.id)
  },
  async asyncData({store, params}) {
    const post = await store.dispatch('post/fetchAdminById', params.id)
    return {post}
  },
  data() {
    return {
      loading: false,
      controls: {
        text: '',
      },
      rules: {
        text: [
          {required: true, message: 'Пожалуйста, введите текст', trigger: 'blur'},
        ],
      }
    }
  },
  mounted() {
    this.controls.text = this.post.text;
  },
  methods: {
    onSubmit() {
      this.$refs.form.validate(async valid => {
        if (valid) {
          this.loading = true;
          const formData = {
            text: this.controls.text,
            id: this.post._id,
          }

          try {
            await this.$store.dispatch('post/update', formData);
            this.$message.success('Пост обновлен')
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
  <div class="page-wrap">
    <el-breadcrumb separator="/" class="mb">
      <el-breadcrumb-item to="/admin/list">Посты</el-breadcrumb-item>
      <el-breadcrumb-item>{{post?.title}}</el-breadcrumb-item>
    </el-breadcrumb>

    <el-form ref="form" :model="controls"  :rules="rules" @submit.native.prevent="onSubmit">
      <el-form-item label="Текст в формате .md или .html" prop="text">
        <el-input type="textarea" resize="none" :rows="10" v-model.trim="controls.text"/>
      </el-form-item>
      <div class="mb">
        <small class="mr">
          <i class="el-icon-time"></i>
          <span style="margin-left: 10px">
            {{new Date(post.date).toLocaleString()}}
          </span>
        </small>
        <small>
          <i class="el-icon-view"></i>
          <span >
            {{post.views}}
          </span>
        </small>
      </div>
      <el-form-item>
        <el-button round :loading="loading" native-type="submit" type="primary" >Обновить</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<style scoped lang="less">
.page-wrap {
  max-width: 600px;
  .mr {
    margin-right: 2rem;
  }
}
</style>
