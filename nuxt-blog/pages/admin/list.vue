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
      this.$router.push(`/admin/post/${id}`)
    },
    async remove(id) {
      try {
          await this.$confirm('Удалить пост?', 'Внимание', {
            confirmButtonText: 'Да',
            cancelButtonText: 'Нет',
            type: 'warning'
          })
        await this.$store.dispatch('post/remove', id)
        this.posts = this.posts.filter(post => post._id!==id)
        this.$message.success('Пост удален')
      } catch (e) {
      }
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
        <el-tooltip class="item" effect="dark" content="Открыть пост" placement="top">
        <el-button
          circle
          type="primary"
          icon="el-icon-edit"
          @click="open(scope.row._id)"></el-button>
        </el-tooltip>
        <el-tooltip class="item" effect="dark" content="Удалить пост" placement="top">
        <el-button
          icon="el-icon-delete"
          type="danger"
          circle
          @click="remove(scope.row._id)"></el-button>
        </el-tooltip>
      </template>
    </el-table-column>
  </el-table>
</template>

<style scoped lang="less">

</style>
