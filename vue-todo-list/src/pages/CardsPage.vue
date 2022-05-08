<template>
<div class="cards_page">
  <Particles id="tsparticles" :options="particlesConfig"/>
  <b-row class="cards_content" v-if="hasData">
    <b-col class="cards__col">
      <h2>{{text[lang].columns[0]}}</h2>
      <draggable :animation="200" class="draggable-list" v-model="opened" group="my-group">
        <transition-group>
      <to-do-card @selected="select" v-for="(card) in opened" :key="card.id" :content="card">
      </to-do-card>
        </transition-group>
      </draggable>
    </b-col>
    <b-col class="cards__col">
      <h2>{{text[lang].columns[1]}}</h2>
      <draggable :animation="200" class="draggable-list" v-model="inProgress" group="my-group" >
        <transition-group>
          <to-do-card @selected="select" v-for="(card) in inProgress" :key="card.id" :content="card"></to-do-card>
        </transition-group>
      </draggable>
    </b-col>
    <b-col class="cards__col">
      <h2>{{text[lang].columns[2]}}</h2>
      <draggable :animation="200" class="draggable-list" v-model="complete" group="my-group">
        <transition-group>
          <to-do-card @selected="select" v-for="(card) in complete" :key="card.id" :content="card"></to-do-card>
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
import particlesConfig from "../assets/particles.json";
import languageMixin from "@/mixines/languageMixin";
import firebase from "firebase";
export default {
  name: "CardsPage",
  components: {ToDoCard, draggable},
  mixins: [languageMixin],
  data() {
    return {
        particlesConfig,
        opened: [],
        inProgress: [],
        complete: [],
        hasData: false,
        collectionName: "todo_" + firebase.auth().currentUser.uid
    }
  },
  watch: {
    opened(newVal, oldVal) {
      if (!this.hasData) return
      let val = newVal.filter(val => oldVal.filter(val1 => val1.id===val.id).length===0)[0]
      if (val===undefined || val.progress==="open")  return;
      val.progress = "open"
      db.collection(this.collectionName).doc(val.id).update(val)
    },
    inProgress(newVal, oldVal) {
      if (!this.hasData) return
      let val = newVal.filter(val => oldVal.filter(val1 => val1.id===val.id).length===0)[0]
      if (val===undefined || val.progress==="in_progress")  return;
      val.progress = "in_progress"
      db.collection(this.collectionName).doc(val.id).update(val)
    },
    complete(newVal, oldVal) {
      if (!this.hasData) return
      let val = newVal.filter(val => oldVal.filter(val1 => val1.id===val.id).length===0)[0]
      if (val===undefined || val.progress==="complete")  return;
      val.progress = "complete"
      db.collection(this.collectionName).doc(val.id).update(val)
    },
  },
  methods: {
    select(item) {
      this.$emit('selected', item)
    }
  },
  created() {
    db.collection(this.collectionName).onSnapshot((snapshotChange) => {
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
  },
}
</script>

<style lang="less">
.cards_page {
  position: relative;
  height: 100%;
  overflow-y: auto;
  overflow-x: hidden;
   h2 {
     z-index: 1;
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
#tsparticles {
  position: fixed;
  margin: 0;
  padding: 0;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
}
</style>