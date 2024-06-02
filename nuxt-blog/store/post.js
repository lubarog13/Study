const posts = [
  {title: 'Post 1', date: new Date(), views: 22, comments: [1, 2], _id: "1"},
  {title: 'Post 2', date: new Date(), views: 22, comments: [1, 2], _id: "2"}
];

export const actions = {
  async fetchAdminPosts({commit}) {
    try {
      return this.$axios.$get('/api/post/admin')
    } catch (e) {
      commit('setError', e, {root: true})
      throw e;
    }
  },
  async fetch({commit}) {
    try {
      return this.$axios.$get('/api/post/')
    } catch (e) {
      commit('setError', e, {root: true})
      throw e;
    }
  },
  async remove({commit}, id) {
    try {
      return this.$axios.$delete(`/api/post/admin/${id}`)
    } catch (e) {
      commit('setError', e, {root: true})
      throw e;
    }
  },
  async update({commit}, {id, text}) {
    try {
      return this.$axios.$put(`/api/post/admin/${id}`, {text})
    } catch (e) {
      commit('setError', e, {root: true})
      throw e;
    }
  },
  async create({commit}, {title, text, image}) {
    try {
      const  fd = new FormData()
      fd.append('title', title);
      fd.append('text', text);
      fd.append('image', image, image.name)
      return await this.$axios.$post('/api/post/admin', fd)
    } catch (e) {
      commit('setError', e, {root: true})
      throw e;
    }
  },
  async fetchAdminById({commit}, id) {
    try {
      return this.$axios.$get(`/api/post/admin/${id}`)
    } catch (e) {
      commit('setError', e, {root: true})
      throw e;
    }
  }
}
