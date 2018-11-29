<template>
  <div id="kslab">
    {{sati}}
    <router-view></router-view>
  </div>
</template>

<script>
import {mapState} from 'vuex'
import store from '@/store/store'
export default {
  name: 'App',
  data(){
    return{
      activisa:2,
      momentKey:null
    }
  },
  watch: {
    '$route' (to, from) {
      console.log(to.fullPath)
       this.$store.commit('RouterPath',to.fullPath)
    },
  },
  computed:{
    sati:function(){
      if(window.localStorage.token || window.localStorage.userStatu)
      {
         this.$store.commit('USERTOKEN',window.localStorage.userStatu)
      }
      return store.Userstatus
    }
  },
  //二级目录发生跳转钩子
  beforeRouteUpdate(to,from,next){

  },
}

//关闭浏览器清空localStorage  记住密码在做判断
// window.onunload=function(){
//     localStorage.clear();
// }

</script>

<style>
    @import "./assets/css/font.css";
</style>
<style>
    #kslab{
        position:relative;
    }
</style>
