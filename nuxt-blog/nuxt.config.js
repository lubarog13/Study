const pkg = require('./package')


module.exports = {
  mode: 'universal',

  head: {
    title: pkg.name,
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Мой блог на nuxt' },
      { name: 'format-detection', content: 'telephone=no' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ]
  },

  pageTransition: { name: 'page', mode: 'out-in' },

  loading: {color: '#409EFF'},

  css: [
    'element-ui/lib/theme-chalk/index.css',
    '@/theme/index.less'
  ],

  plugins: [
    '@/plugins/globals',
    '@/plugins/axios'
  ],

  modules: [
    '@nuxtjs/axios'
  ],

  axios: {},

  build: {
    transpile: [/^element-ui/],
    extend(config, ctx) {

    }
  }
}
