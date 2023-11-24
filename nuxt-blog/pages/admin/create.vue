<script>
export default {
  name: "create",
  layout: "admin",
  middleware: ['admin-auth'],
  data() {
    return {
      loading: false,
      image: null,
      previewDialog: false,
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
        if (valid && this.image) {
          this.loading = true;
          const formData = {
            title: this.controls.title,
            text: this.controls.text,
            image: this.image,
          }

          try {
            await this.$store.dispatch('post/create', formData);
            this.controls.text = '';
            this.controls.title = ''
            this.image = null;
            this.$refs.upload.clearFiles();
            this.$message.success('Пост создан')
            this.loading = false
          } catch (e) {
            this.loading = false
          }
        } else if (!this.image) {
          this.$message.warning('Добавьте изображение')
        }
      })
    },
    handleImageChange(file, fileList) {
      this.image = file.raw
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
      <el-input v-model="controls.title"/>
    </el-form-item>
    <el-form-item label="Текст в формате .md или .html" prop="text">
      <el-input type="textarea" resize="none" :rows="10" v-model="controls.text"/>
    </el-form-item>
    <el-button class="mb" type="success" plain @click="previewDialog = true">
      Предпросмотр
    </el-button>
    <el-dialog
      title="Предпросмотр"
      :visible.sync="previewDialog"
      width="30%">
      <div :key="controls.text">
      <vue-markdown>{{controls.text}}</vue-markdown>
      </div>
      <span slot="footer" class="dialog-footer">
    <el-button @click="previewDialog = false">Закрыть</el-button>
  </span>
    </el-dialog>
    <el-upload
        class="mb"
        drag
        action="https://jsonplaceholder.typicode.com/posts/"
        :on-change="handleImageChange"
        :auto-upload="false"
        ref="upload"
        >
      <i class="el-icon-upload"></i>
      <div class="el-upload__text">Перетащите картинку <em>или нажмите</em></div>
      <div class="el-upload__tip" slot="tip">Файлы с расширением jpg/png</div>
    </el-upload>
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
