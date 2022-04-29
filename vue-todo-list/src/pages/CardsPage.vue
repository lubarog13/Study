<template>
<div class="cards_page">
  <b-row>
    <b-col class="cards__col">
      <h2>Открыто</h2>
      <to-do-card v-for="(card, index) in todos" :key="index" :content="card">
      </to-do-card>
    </b-col>
    <b-col class="cards__col">
      <h2>В процессе</h2>
    </b-col>
    <b-col class="cards__col">
      <h2>Сделано</h2>
    </b-col>
  </b-row>
</div>
</template>

<script>
import ToDoCard from "@/components/ToDoCard";
export default {
  name: "CardsPage",
  components: {ToDoCard},
  data() {
    return {
        todos: [
          {
            name: "Протестировать приложение",
            type: "important",
            date: new Date()
          },
          {
            name: "Загрузить на сервер",
            type: "minor",
            date: new Date()
          }
        ]
    }
  }
}
</script>

<style lang="less">
.cards_page {
   h2 {
    background: #FFFFFF;
    border: 1px solid #D6D6D6;
    box-sizing: border-box;
    width: 100%;
    text-align: center;
    border-right: 1px solid #C60000;
    font-family: 'Comfortaa';
    font-style: normal;
    font-weight: 700;
    font-size: 20px;
    line-height: 22px;
    padding: 6px 0;
  }
  .row {
    .cards__col {
      border-right: 1px solid #9B9A9A;
      align-items: center;
      display: flex;
      flex-direction: column;
      padding: 0;
      &:last-child {
        border-right: none;
        h2 {
          border-right: none;
        }
      }
    }
  }
}
</style>