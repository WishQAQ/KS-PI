<template>
  <div class="uploading_main_item uploading_main_title">
    <div class="main_head">
      <i class="icon icon_title"></i>
      <span class="main_txt">{{mainTxt}}</span>
    </div>
    <input type="text" class="main_title_input" @change="ArticleTitleNames" placeholder="标题限定15字以内" v-model="articleTitleName" maxlength="25" >
    <div class="mod_uploading_date">
    </div>
  </div>
</template>

<script>
    export default {
        name: "uploadingServiceMainTitle",
        props:["mainTxt","encData",'serviceData',"title"],
        data(){
          return{
            articleTitleName:''
          }
        },
      created() {
        //this.articleTitleName = this.$store.state.serviceUpload.serviceUploadData.title;
      },
      watch: {
        title(){
          this.articleTitleName=this.title
        },
        serviceData: {
          handler(newData, oldData) {
            console.log(newData, oldData)
            this.articleTitleName = newData.title
          },
          deep: true
        }
      },

        mounted(){
          // console.log(this.encData)
          // this.articleTitleName = this.encData.title
        },
        methods:{
          //通用方法
          ArticleTitleNames(value){
            this.$emit('ArticleTitleName' , this.articleTitleName)
          }
        },
    }
</script>

<style scoped>

</style>
