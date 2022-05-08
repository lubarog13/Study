<template>
<div class="todo_form">
  <b-form @submit="onSubmit" @reset="onReset">
    <b-row>
      <b-col>
        <b-form-group
            :label="text[lang].form.title"
            id="input-group-1"
            label-for="input-1"
        >
          <b-form-input
              id="input-1"
              v-model="form.name"
              type="text"
              :placeholder="text[lang].form.title_placeholder"
              required
          >
          </b-form-input>
        </b-form-group>
        <b-form-group
            :label="text[lang].form.description"
            id="input-group-2"
            label-for="input-2"
        >
          <b-form-textarea
              id="input-2"
              v-model="form.description"
              type="text"
              :placeholder="text[lang].form.description_placeholder"
          >
          </b-form-textarea>
        </b-form-group>
      </b-col>
      <b-col>
        <b-form-group
            id="input-group-3"
            :label="text[lang].form.priority"
            label-for="check-1"
        >
          <b-checkbox-group
              id="check-1"
              v-model="form.type"
          >
            <b-checkbox value="important">{{text[lang].type.important}}</b-checkbox>
            <b-checkbox value="major">{{text[lang].type.major}}</b-checkbox>
            <b-checkbox value="normal">{{text[lang].type.normal}}</b-checkbox>
            <b-checkbox value="minor">{{text[lang].type.minor}}</b-checkbox>
          </b-checkbox-group>
        </b-form-group>
        <b-row>
          <b-col>
            <b-form-group
                :label="text[lang].form.date"
                id="input-group-4"
                label-for="input-3"
            >
              <b-form-datepicker
                  id="input-3"
                  v-model="form.date"
                  :locale="lang"
                  :placeholder="text[lang].form.date_placeholder"
                  required
              >
              </b-form-datepicker>
            </b-form-group>
          </b-col>
          <b-col>
            <b-form-group
                :label="text[lang].form.time"
                id="input-group-5"
                label-for="input-4"
            >
              <b-form-timepicker
                  id="input-4"
                  v-model="time"
                  :placeholder="text[lang].form.time_placeholder"
                  :locale="lang"
                  required
              >
              </b-form-timepicker>
            </b-form-group>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
    <b-button type="submit" variant="dark">{{text[lang].form.save}}</b-button>
    <b-button type="reset" variant="secondary">{{ text[lang].form.reset }}</b-button>
    <b-button type="button" variant="light" @click="$emit('back', 0)">{{ text[lang].back }}</b-button>
  </b-form>

</div>
</template>

<script>
import {db} from "@/firebase";
import moment from "moment";
import languageMixin from "@/mixines/languageMixin";
import firebase from "firebase";

export default {
  name: "EditToDo",
  props: ['todo'],
  mixins: [languageMixin],
  data() {
    return {
      form: {
        name: "",
        description: "",
        type: "",
        date: "",
      },
      time: null,
      collectionName: "todo_" + firebase.auth().currentUser.uid
    }
  },
  methods:{
     onSubmit(event) {
       this.form.date = new Date(this.form.date+ " " + this.time)
       this.form.progress = this.todo.progress
       event.preventDefault()
      db.collection(this.collectionName).doc(this.todo.id).update(this.form).then(() => {
        event.stopPropagation()
        this.$emit('updated', '')
        }).catch(err => {
          console.log(err)
        event.stopPropagation()
        })
    },
    onReset(event) {
       event.preventDefault()
      this.form.name = this.todo.name
      this.form.description = this.todo.description
      this.form.date = moment(this.todo.date).format("YYYY-MM-DD")
      this.form.type = this.todo.type
      this.time = moment(this.todo.date).format("HH:MM")
    }
  },
  mounted() {
    this.form.name = this.todo.name
    this.form.description = this.todo.description
    this.form.date = moment(this.todo.date).format("YYYY-MM-DD")
    this.form.type = this.todo.type
    this.time = moment(this.todo.date).format("HH:MM")
  },
}
</script>

<style lang="less">
.todo_form {
  animation: 1s moveIn ease-out;
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