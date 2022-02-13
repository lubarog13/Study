import Vue from 'vue'
import Vuex from 'vuex'
import axiousInstance from '../api'
import { CHARACTERS_BY_PAGE, CHARACTER_BY_ID } from '../api/routes'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    characters: {},
    pages: 0
  },
  mutations: {
    setCharacters(state, {page, characters}) {
      Vue.set(state.characters, page, characters)
      console.log(state.characters)
      console.log(3)
    },
    setPages(state, pages) {
      state.pages = pages
    }
  },
  actions: {
    fetchCharacters({state, commit}, page) {
      const pageCharacters = state.characters[page];
      console.log(1)
      if(pageCharacters) {
        return Promise.resolve(pageCharacters);
      }
      return axiousInstance.get(CHARACTERS_BY_PAGE(page))
      .then(({data}) => {
        const {info, results} = data
        commit('setCharacters', {page, characters: results});
        commit('setPages', info.pages)
      })
      .catch(err => {
        console.log(err)
      })
    },
    fetchSingleCharacter(_, id) {
      return axiousInstance.get(CHARACTER_BY_ID(id))
    }
  },
  modules: {
  },
  getters: {
    getCharactersByPage: (state) => ({page}) => {
      console.log(2)
      console.log(state.characters)
      const pageCharacters = state.characters[page];
      console.log(pageCharacters)
      return pageCharacters
    },
    getCharacterById: (state) => ({id}) => {
      let page = 1
      if(state.pages===0) return null
      while (page!=state.pages) {
        let characters = state.characters[page].filter((char) => id === char.id)
        if (characters.length>0) {
          return characters[0]
        }
        page = page + 1
      }
      return null
    }
  }
})
