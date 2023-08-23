export const state = () => ({
  token: null,
});

export const mutations = {
  updateToken: (state, val) => (state.token = val),
}

export const actions = {
  async login({commit, dispatch}, formData) {
    const token = await new Promise(resolve => {
      setTimeout(() => resolve('mock-token'), 2000)
    })
    commit('updateToken', token);
  }
}

export const getters = {
  isAuthenticated: (state) =>  {
    return Boolean(state.token);
  }
}
