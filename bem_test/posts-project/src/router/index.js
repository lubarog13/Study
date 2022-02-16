import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import PostsFromStore from '../views/PostsFromStore.vue'
import PostsWithCompositionAPI from '../views/PostsWithCompositionAPI.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/store',
    name: 'PostsFromStore',
    component: PostsFromStore
  },
  {
    path: '/composition',
    name: 'PostsWithCompositionAPI',
    component: PostsWithCompositionAPI
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
