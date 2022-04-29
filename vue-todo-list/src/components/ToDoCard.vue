<template>
<div class="card">
  <h3>{{content.name}}</h3>
    <b-row class="card__settings">
    <b-col><div class="card__type"><div class="dot" :style="{background: color}"/><div>{{type}}</div></div> </b-col>
    <b-col>{{date}}</b-col>
    <b-col>{{time}}</b-col>
  </b-row>
</div>
</template>

<script>
import moment from "moment";

export default {
  name: "ToDoCard",
  props: ["content"],
  computed: {
    type() {
      switch (this.content.type) {
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
      switch (this.content.type) {
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
      if (new Date().toLocaleDateString()===this.content.date.toLocaleDateString()) {
        return "Сегодня"
      }
      if (new Date(new Date().setDate(new Date().getDate() + 1)).toLocaleDateString()===this.content.date.toLocaleDateString()) {
        return "Завтра"
      }
      return this.content.date.toLocaleDateString();
    },
    time() {
      return moment(this.content.date).format("HH:MM")
    }
  }
}
</script>

<style lang="less" scoped>
.card {
  background: #FFFFFF;
  border: 0.5px solid #807979;
  margin-bottom: 10px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 90%;
  height: 100px;
  padding: 15px 9px 7px 10px;
  font-family: 'Open Sans';
  h3 {
    font-style: normal;
    font-weight: 400;
    font-size: 14px;
    line-height: 19px;
  }
  &__settings {
    font-weight: 600;
    font-size: 12px;
    align-items: center;
    line-height: 16px;
    .card__type {
      display: flex;
      align-items: center;
      .dot {
        width: 7px;
        flex-shrink: 0;
        height: 7px;
        border-radius: 50%;
        margin-right: 5px;
      }
    }
  }
}
</style>