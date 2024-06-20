const pkg = require('./package')


module.exports = {
  mode: 'universal',

  head: {
    title: 'SSR Blog',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Блог, написанный с использованием server-side rendering' },
      { name: 'format-detection', content: 'telephone=no' },
      { hid: 'keywords', name: 'keywords', content: 'js, javascript,, ssr, blog'}
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
    '@nuxtjs/axios',
    '@nuxtjs/pwa',
    ['nuxt-seo-module', {
      robots: {},
      sitemap: [{
        baseUrl: 'https://127.0.0.1',
        generate: true,
        exclude: ['/admin/']
      }]
    }]
  ],

  workbox: {

  },

  axios: {},

  env: {
    appName: 'SSR Blog',
  },

  build: {
    transpile: [/^element-ui/],
    extend(config, ctx) {

    }
  }
}
