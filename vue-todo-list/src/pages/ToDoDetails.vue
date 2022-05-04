<template>
  <div class="details">
    <h4><b-badge variant="info">{{progress}}</b-badge> {{todo.name}}</h4>
    <div class="details__info">
      <div class="details__type"><div class="dot" :style="{background: color}"/><div>{{type}}</div></div>
      <div class="details__date"><b-icon icon="calendar4-week"></b-icon> {{date}}, {{time}}</div>
    </div>
    <div class="details__description">
      {{todo.description}}
    </div>
    <div class="details__action">
      <b-button  variant="dark" @click="$emit('edit', 0)">Редактировать</b-button>
      <b-button  variant="light" @click="$emit('back', 0)">Назад</b-button>
      <b-button pill variant="danger" class="delete_action" v-b-modal.my-modal ><b-icon icon="trash"></b-icon> </b-button>
    </div>
    <b-modal id="my-modal" title="Уделение задачи" @ok="deleteToDo">
      <div class="d-block text-center">
        <h3>Вы действительно хотите удалить задачу?</h3>
      </div>
    </b-modal>
  </div>
</template>

<script>
import moment from "moment";
import {db} from "@/firebase";

export default {
  name: "ToDoDetails",
  props: ["todo"],
  computed: {
    type() {
      switch (this.todo.type) {
        case "important":
          return "Очень важно"
        case "major":
          return "Важно"
        case "normal":
          return "Обычно"
        default:
          return 'Не важно'
      }
    },
    color() {
      switch (this.todo.type) {
        case "important":
          return "#920000"
        case "major":
          return "#ff0000"
        case "normal":
          return "#aadeff"
        default:
          return '#f1eaea'
      }
    },
    date() {
      if (new Date().toLocaleDateString()===this.todo.date.toLocaleDateString()) {
        return "Сегодня"
      }
      if (new Date(new Date().setDate(new Date().getDate() + 1)).toLocaleDateString()===this.todo.date.toLocaleDateString()) {
        return "Завтра"
      }
      return this.todo.date.toLocaleDateString();
    },
    time() {
      return moment(this.todo.date).format("HH:MM")
    },
    progress() {
      switch (this.todo.progress) {
        case 'open':
          return 'Открыта'
        case 'in_progress':
          return 'В процессе'
        default:
          return 'Сделано'
      }
    }
  },
  methods: {
    deleteToDo() {
      db.collection("todo").doc(this.todo.id).delete().then(() => {
        this.$emit('back', 0)
      }).catch(err => {
        console.log(err)
      })
    },
  }
}
</script>

<style lang="less" scoped>
.details {
  animation: 1s moveIn ease-out;
  margin-left: 40px;
  h4 {
    display: flex;
    font-family: Comfortaa;
    font-size: 24px;
    .badge-info {
      background: #6a81da;
      font-size: 12px;
      margin-right: 40px;
      height: fit-content;
    }
  }
  &__info {
    display: flex;
    margin-top: 20px;
    margin-bottom: 20px;
    .details__type {
      display: flex;
      align-items: center;
      margin-right: 20px;
      .dot {
        width: 7px;
        flex-shrink: 0;
        height: 7px;
        border-radius: 50%;
        margin-right: 5px;
      }
    }
  }
  &__description {
    color: #9B9A9A;
    font-size: 16px;
    max-width: 50%;
    margin-bottom: 40px;
  }
  &__action {
    display: flex;
    .btn {
      margin-left: 30px;
    }
    .delete_action {
      width: 40px;
      height: 40px;
      padding: 0;
    }
  }
}
</style>
<style lang="less">
.text-center {
  h3 {
    font-size: 20px;
    margin: 20px 40px;
  }
}
</style>