import { createStore } from 'vuex'
import postModule from './postModule.js'

export default createStore({
  modules: {
    post: postModule
  }
})
