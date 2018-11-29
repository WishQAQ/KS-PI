<template lang="html">
  <div v-if="keywords">
    <!-- {{keyword}} -->
    <ul class="keyword_up">
      <li @click="onValueClick(index)" v-for="(key,index) in keywords" :key="index">{{key}}</li>
    </ul>
  </div>
</template>

<script>
export default {
  props:['keyword'],
  data(){
    return{
        keywords:[]
    }
  },
  methods:{
    onValueClick(index){
      //附带关键字搜索方法
      this.$router.push({
        path:'/home/searchIndex',
        query:{
          keyword:this.keywords[index]
        }
      });
      console.log(typeof this.keyword)
    },
    //初始化标签
    initKeyword(obj){
        if(typeof(obj)==='string'){
            this.keywords=obj.split(',')
        }else if(typeof(obj)==='object'){
            obj.forEach((item)=>{
                if(typeof(item)==='object'){
                    this.keywords.push(item.name)
                }else{
                    this.keywords=obj
                }
            })
        }
    }
  },
  mounted(){
      this.initKeyword(this.keyword)
  },
  watch:{
      keyword:{
        handler(){
            this.initKeyword(this.keyword)
        },
        deep:true
      }
  }
}
</script>

<style lang="css">
.keyword_up{
  display: flex;
  position: relative;
  z-index:999;
}
.keyword_up li{
  color:#999999;
  text-decoration:underline;
  margin-right: 10px;
  margin-top: 10px;
  cursor: pointer;
}
.keyword_up li:hover{
  color:#15befe;
  text-decoration:underline;
  margin-right: 10px;
  margin-top: 10px;
}
</style>
