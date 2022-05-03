<template>
<div class="bottom_panel">
  <b-icon icon="dash-lg"></b-icon>
  <div class=" content">
    <div class="default_page" v-if="action===''">
      <h1>To Do List</h1>
      <b-button @click="changeAction('add')" variant="danger"> <b-icon icon="plus" animation="throb"></b-icon> Добавить</b-button >
    </div>
    <add-to-do v-if="action==='add'" @added="changeAction"/>
  </div>
</div>
</template>

<script>
import AddToDo from "@/pages/AddToDo";
export default {
  name: "BottomPanel",
  components: {AddToDo},
  data() {
    return {
      action: ''
    }
  },
  methods: {
    changeAction(action) {
      this.action = action
    }
  }
}
</script>

<style lang="less" scoped>
.bottom_panel {
  bottom: 0;
  width: 100%;
  background: white;
  border-radius: 20px;
  overflow-y: auto;
  padding: 10px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  svg {
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
      h1 {
        font-family: 'Comfortaa';
        color: #0c1a52;
        margin-right: 40px;
      }
    }
  }
}
</style>