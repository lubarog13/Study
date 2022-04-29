<template>
<div class="cards_page">
  <b-row class="cards_content">
    <b-col class="cards__col">
      <h2>Открыто</h2>
      <draggable :animation="200" class="draggable-list" v-model="opened" group="my-group">
        <transition-group>
      <to-do-card v-for="(card) in opened" :key="card.id" :content="card">
      </to-do-card>
        </transition-group>
      </draggable>
    </b-col>
    <b-col class="cards__col">
      <h2>В процессе</h2>
      <draggable :animation="200" class="draggable-list" v-model="inProgress" group="my-group">
        <transition-group>
          <to-do-card v-for="(card) in inProgress" :key="card.id" :content="card"></to-do-card>
        </transition-group>
      </draggable>
    </b-col>
    <b-col class="cards__col">
      <h2>Сделано</h2>
      <draggable :animation="200" class="draggable-list" v-model="complete" group="my-group">
        <transition-group>
          <to-do-card v-for="(card) in complete" :key="card.id" :content="card"></to-do-card>
        </transition-group>
      </draggable>
    </b-col>
  </b-row>
</div>
</template>

<script>
import ToDoCard from "@/components/ToDoCard";
import draggable from "vuedraggable"
export default {
  name: "CardsPage",
  components: {ToDoCard, draggable},
  data() {
    return {
        opened: [
          {
            id: 1,
            name: "Протестировать приложение",
            type: "important",
            date: new Date()
          },
          {
            id: 2,
            name: "Загрузить на сервер",
            type: "minor",
            date: new Date()
          }
        ],
        inProgress: [
          {
            id: 3,
            name: "Загрузить на сервер",
            type: "minor",
            date: new Date()
          }
        ],
        complete: []
    }
  }
}
</script>

<style lang="less">
.cards_page {
  height: 100%;
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
  .cards_content {
    background: #eeeeee;
    height: 100%;
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
  .draggable-list {
    width: 100%;
    height: 100%;
    span {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;
      height: 100%;
    }
  }
}
</style>