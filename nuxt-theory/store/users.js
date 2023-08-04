export const state = () => ({
  users: [],
});

export const mutations = {
  updateUsers: (state, val) => (state.users = val),
};

export const actions = {
  async fetchUsers({commit}) {
    try {
      commit('updateUsers', await this.$axios.$get('https://jsonplaceholder.typicode.com/users'));
    } catch (e) {
      throw e;
    }
  }
}
