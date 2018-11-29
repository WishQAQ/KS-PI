// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import store from './vuex'
import VueAxios from 'vue-axios'
import Axios from 'axios'
import qs from 'qs'

import {HttpClient} from './utils/HttpUtils'
import Tools from './utils/tools'

import 'element-ui/lib/theme-chalk/index.css'
import './assets/iconfont/iconfont.css'
import './assets/scss/main.css'

Vue.prototype.$ajax = Axios;
Vue.prototype.HttpClient = HttpClient;
Vue.prototype.Tools = Tools;
Vue.prototype.$qs = qs;

Vue.config.productionTip = false
Vue.use(ElementUI)
Vue.use(VueAxios, Axios);
window.Vue = Vue;
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})