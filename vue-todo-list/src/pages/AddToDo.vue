<template>
<div class="todo_form">
  <b-form @submit="onSubmit" @reset="reset">
    <b-row>
      <b-col>
        <b-form-group
        label="Название задачи"
        id="input-group-1"
        label-for="input-1"
        >
          <b-form-input
           id="input-1"
           v-model="form.name"
           type="text"
           placeholder="Введите название"
           required
          >
          </b-form-input>
        </b-form-group>
        <b-form-group
            label="Описание задачи"
            id="input-group-2"
            label-for="input-2"
        >
          <b-form-textarea
              id="input-2"
              v-model="form.description"
              type="text"
              placeholder="Введите описание"
          >
          </b-form-textarea>
        </b-form-group>
      </b-col>
      <b-col>
        <b-form-group
          id="input-group-3"
          label="Приоритет:"
          label-for="check-1"
          >
          <b-checkbox-group
            id="check-1"
            v-model="form.type"
          >
            <b-checkbox value="important">Очень важно</b-checkbox>
            <b-checkbox value="major">Важно</b-checkbox>
            <b-checkbox value="normal">Обычно</b-checkbox>
            <b-checkbox value="minor">Не важно</b-checkbox>
          </b-checkbox-group>
        </b-form-group>
        <b-row>
          <b-col>
            <b-form-group
                label="Дата выполнения"
                id="input-group-4"
                label-for="input-3"
            >
              <b-form-datepicker
                  id="input-3"
                  v-model="form.date"
                  locale="ru"
                  placeholder="Выберите дату"
                  required
              >
              </b-form-datepicker>
            </b-form-group>
          </b-col>
          <b-col>
            <b-form-group
                label="Время выполнения"
                id="input-group-5"
                label-for="input-4"
            >
              <b-form-timepicker
                  id="input-4"
                  v-model="time"
                  placeholder="Выберите время"
                  locale="ru"
                  required
              >
              </b-form-timepicker>
            </b-form-group>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
    <b-button type="submit" variant="dark">Добавить</b-button>
    <b-button type="reset" variant="secondary">Очистить</b-button>
  </b-form>

</div>
</template>

<script>
import {db} from "@/firebase";

export default {
  name: "AddToDo",
  data() {
    return {
      form: {
        name: "",
        description: "",
        type: "",
        date: "",
      },
      time: null
    }
  },
  methods:{
     onSubmit(event) {
       this.form.date = new Date(this.form.date+ " " + this.time)
       this.form.progress = "open"
       event.preventDefault()
      db.collection("todo").add(this.form).then(() => {
        event.stopPropagation()
        this.$emit('added', '')
        }).catch(err => {
          console.log(err)
        event.stopPropagation()
        })
    },
    reset() {
      this.form.name = ""
      this.form.description = ""
      this.form.type = ""
      this.form.date = ""
      this.time = ""
    }
  }
}
</script>

<style lang="less">
.todo_form {
  .form-group {
    margin-bottom: 20px;
    .d-block {
      margin-left: 10px;
      margin-bottom: 10px;
    }
  }
  #check-1 {
    display: flex;
    div {
      margin-right: 10px;
      label {
        margin-left: 5px;
      }
    }
  }
  .btn-dark {
    margin-right: 30px;
  }
}
</style>