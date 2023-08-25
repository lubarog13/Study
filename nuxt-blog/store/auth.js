export const state = () => ({
  token: true, //чтобы каждый раз не входить
});

export const mutations = {
  updateToken: (state, val) => (state.token = val),
  clearToken: (state) => (state.token = null)
}

export const actions = {
  async login({commit, dispatch}, formData) {
    try {
      const token = await new Promise((resolve, reject) => {
        setTimeout(() => resolve('mock-token'), 2000)
      })
      commit('updateToken', token);
    } catch (e) {
      commit('setError', e, {root: true})
      throw e
    }
  },
  logout({commit}) {
    commit('clearToken')
  },
  async createUser({commit}, formData) {
    try {
      console.log('create user', formData)
    } catch (e) {
      console.log(e)
    }
  }
}

export const getters = {
  isAuthenticated: (state) =>  {
    return Boolean(state.token);
  }
}
