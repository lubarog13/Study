export const actions = {
  async create({commit}, data) {
    return await this.$axios.post('/api/comment', data)
  }
}
