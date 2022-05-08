<template>
<div class="bottom_panel">
  <b-icon icon="dash-lg" class="icon"></b-icon>
  <div class=" content">
    <div class="default_page" v-if="action===''">
      <h1>To Do List</h1>
      <b-button @click="changeAction('add')" variant="danger"> <b-icon icon="plus" animation="throb"></b-icon>{{text[lang].add}}</b-button >
    </div>
    <add-to-do v-if="action==='add'" @added="changeAction"/>
    <to-do-details v-if="action==='details'" :todo="value" @back="clear" @edit="changeAction('edit')"/>
    <edit-to-do v-if="action==='edit'" :todo="value" @back="changeAction('details')"/>
  </div>
</div>
</template>

<script>
import AddToDo from "@/pages/AddToDo";
import ToDoDetails from "@/pages/ToDoDetails";
import EditToDo from "@/pages/EditToDo";
import languageMixin from "@/mixines/languageMixin";
export default {
  props: ["value"],
  name: "BottomPanel",
  mixins: [languageMixin],
  components: {EditToDo, ToDoDetails, AddToDo},
  data() {
    return {
      action: ''
    }
  },
  methods: {
    changeAction(action) {
      this.action = action
    },
    clear() {
      this.$emit('input', null)
      this.action = ''
    }
  },
  watch: {
    value(newVal) {
      if(newVal!==null) {
        this.action='details'
      }
    }
  }
}
</script>

<style lang="less" scoped>
.bottom_panel {
  z-index: 1;
  bottom: 0;
  width: 100%;
  background: white;
  border-radius: 20px;
  overflow-y: auto;
  padding: 10px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  .icon {
    margin-bottom: 20px;
  }
  .content {
    width: 100%;
    height: 97%;
    cursor: auto;
    display: flex;
    flex-direction: column;
    .default_page {
      display: flex;
      align-self: center;
      margin-top: 50px;
      animation: 2s moveIn ease-in-out;
      h1 {
        font-family: 'Comfortaa';
        color: #0c1a52;
        margin-right: 40px;
      }
    }
  }
}
</style>