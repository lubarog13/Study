<script>
export default {
  name: "list",
  layout: "admin",
  middleware: ['admin-auth'],
  async asyncData({store}) {
    const posts = await store.dispatch('post/fetchAdminPosts')
    return {posts}
  },
  methods: {
    open(id) {
    },
    remove(id) {
      console.log(index, row);
    }
  }
}
</script>

<template>
  <el-table
    :data="posts"
    style="width: 100%">
    <el-table-column
      prop="title"
      label="Название"
      width="180">
    </el-table-column>
    <el-table-column
      label="Дата">
      <template slot-scope="scope">
        <i class="el-icon-time"></i>
        <span style="margin-left: 10px">{{scope.row.date.toLocaleString()}}</span>
      </template>
    </el-table-column>
    <el-table-column label="Просмотры" prop="views">
      <template slot-scope="scope">
        <i class="el-icon-view"></i>
        <span style="margin-left: 10px">{{scope.row.views}}</span>
      </template>
    </el-table-column>
    <el-table-column
      label="Комментарии">
      <template slot-scope="scope">
        <i class="el-icon-s-comment"></i>
        <span style="margin-left: 10px">{{scope.row.comments.length}}</span>
      </template>
    </el-table-column>
    <el-table-column
      label="Действия">
      <template slot-scope="scope">
        <el-button
          circle
          icon="el-icon-edit"
          @click="open(scope.row._id)"></el-button>
        <el-button
          icon="el-icon-delete"
          type="danger"
          circle
          @click="remove(scope.row._id)"></el-button>
      </template>
    </el-table-column>
  </el-table>
</template>

<style scoped lang="less">

</style>
