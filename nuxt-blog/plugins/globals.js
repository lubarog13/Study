import Vue from 'vue'
import VueMarkdown from "vue-markdown";
import Element from 'element-ui'
import locale from 'element-ui/lib/locale/lang/ru-RU'
import DateFilter from "@/common/filters/date.filter";

Vue.use(Element, { locale })
Vue.filter('date', DateFilter)
Vue.component('vue-markdown', VueMarkdown )
