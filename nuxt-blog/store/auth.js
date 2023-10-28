export const state = () => ({
  token: null, //чтобы каждый раз не входить
});

export const mutations = {
  updateToken: (state, val) => (state.token = val),
  clearToken: (state) => (state.token = null)
}

export const actions = {
  async login({commit, dispatch}, formData) {
    try {
      const {token} = await this.$axios.$post('/api/auth/admin/login', formData)
      this.$axios.setToken(token, 'Bearer')
      commit('updateToken', token);
    } catch (e) {
      commit('setError', e, {root: true})
      throw e
    }
  },
  logout({commit}) {
    this.$axios.setToken(false)
    commit('clearToken')
  },
  async createUser({commit}, formData) {
    try {
      await this.$axios.$post('/api/auth/admin/create', formData)
    } catch (e) {
      commit('setError', e, {root: true})
      throw e;
    }
  }
}

export const getters = {
  isAuthenticated: (state) =>  {
    return Boolean(state.token);
  }
}
