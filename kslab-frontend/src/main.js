// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import Vuex from 'vuex'
import store from './store/store'
import router from './router'
import axios from 'axios'
import VueAxios from 'vue-axios'
import qs from 'qs'
import $ from 'jquery'
import 'swiper/dist/css/swiper.css'
import VueAwesomeSwiper from 'vue-awesome-swiper'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

import VueQuillEditor  from 'vue-quill-editor'
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
import port from './port/port'
import 'babel-polyfill'
import {HttpClient} from './utils/HttpUtils'
import Tools from './utils/tools'
import VideoPlayer from 'vue-video-player'
import {TweenMax, Power2, TimelineLite} from 'gsap'
require('video.js/dist/video-js.css')
require('vue-video-player/src/custom-theme.css')

import StompUtils from './utils/stompUtils'

Vue.prototype.HttpClient = HttpClient;
Vue.prototype.Tools = Tools;
Vue.prototype.StompUtils = StompUtils;

Vue.use(port)

Vue.use(VideoPlayer)

Vue.use(VueQuillEditor)


Vue.use(ElementUI)

Vue.use(VueAxios, axios);

Vue.use(Vuex);

Vue.use(VueAwesomeSwiper)

// Vue.use(fileinput);
Vue.prototype.$ajax = axios
Vue.prototype.$qs = qs


Vue.config.productionTip = false


/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>',
  render: h => h(App)
})
//
// 路由守卫，判定权限
router.beforeEach((to,from,next) =>{
  store.commit('SREACHROUTER',to.meta.skipSreach)
  window.scrollTo(0, 0);
  if(to.meta.requireAuth){
    if(window.localStorage.token){
      next()
    }else{
      next({
        path:'/login'
      })
    }
  }
  else{
    next()
  }
})
