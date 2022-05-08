<template>
<b-card class="card" @click="select">
  <b-card-title>{{content.name}}</b-card-title>
    <b-row class="card__settings">
    <b-col><div class="card__type"><div class="dot" :style="{background: color}"/><div>{{type}}</div></div> </b-col>
    <b-col>{{date}}</b-col>
    <b-col>{{time}}</b-col>
  </b-row>
</b-card>
</template>

<script>
import moment from "moment";
import languageMixin from "@/mixines/languageMixin";

export default {
  name: "ToDoCard",
  props: ["content"],
  mixins: [languageMixin],
  computed: {
    type() {
      return this.text[this.lang].type[this.content.type]
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
        return this.text[this.lang].days.today
      }
      if (new Date(new Date().setDate(new Date().getDate() + 1)).toLocaleDateString()===this.content.date.toLocaleDateString()) {
        return this.text[this.lang].days.tomorrow
      }
      return this.content.date.toLocaleDateString();
    },
    time() {
      return moment(this.content.date).format("HH:mm")
    }
  },
  methods: {
    select() {
      console.log("slslsl")
      this.$emit("selected", this.content)
    }
  },
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
  box-shadow: 0px 3px 4px rgba(0, 0, 0, 0.25);
  cursor: pointer;
  font-family: 'Open Sans';
  h4 {
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