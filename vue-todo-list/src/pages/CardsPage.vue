<template>
<div class="cards_page">
  <b-row class="cards_content" v-if="hasData">
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
      <draggable :animation="200" class="draggable-list" v-model="inProgress" group="my-group" >
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
  <b-spinner variant="danger" class="spinner" v-else></b-spinner>
</div>
</template>

<script>
import ToDoCard from "@/components/ToDoCard";
import draggable from "vuedraggable"
import {db} from "@/firebase";
export default {
  name: "CardsPage",
  components: {ToDoCard, draggable},
  data() {
    return {
        opened: [],
        inProgress: [],
        complete: [],
        hasData: false
    }
  },
  watch: {
    opened(newVal, oldVal) {
      if (!this.hasData) return
      let val = newVal.filter(val => oldVal.filter(val1 => val1.id===val.id).length===0)[0]
      if (val===undefined || val.progress==="open")  return;
      val.progress = "open"
      db.collection("todo").doc(val.id).update(val)
    },
    inProgress(newVal, oldVal) {
      if (!this.hasData) return
      let val = newVal.filter(val => oldVal.filter(val1 => val1.id===val.id).length===0)[0]
      if (val===undefined || val.progress==="in_progress")  return;
      val.progress = "in_progress"
      db.collection("todo").doc(val.id).update(val)
    },
    complete(newVal, oldVal) {
      if (!this.hasData) return
      let val = newVal.filter(val => oldVal.filter(val1 => val1.id===val.id).length===0)[0]
      if (val===undefined || val.progress==="complete")  return;
      val.progress = "complete"
      db.collection("todo").doc(val.id).update(val)
    },
  },
  created() {
    db.collection('todo').onSnapshot((snapshotChange) => {
      this.opened = []
      this.inProgress = []
      this.complete = []
      snapshotChange.forEach((item) => {
        let key = item.id
        let data = item.data()
        data.date = new Date(data.date.seconds * 1000)
        data.id = key
        switch (data.progress) {
          case "open":
            this.opened.push(data)
            break
          case "in_progress":
            this.inProgress.push(data)
            break
          default:
            this.complete.push(data)
            break
        }
      });
      this.hasData = true
    })
  }
}
</script>

<style lang="less">
.cards_page {
  position: relative;
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
  .spinner {
    position: absolute;
    top: 50%;
    left: 50%;
    width: 50px;
    height: 50px;
  }
}
</style>