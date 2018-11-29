<template>
  <div class="service_box_kx" v-if="this.imgData">
      <div class="service_box_body_img">
          <video class="video_class" controls :src="request.picUrl + imgData.video[0].path" autoplay poster="posterimage.jpg" v-if="userVideo"></video>
        <pic-zoom :url="request.picUrl+imgUrl" :scal="3" alt="" v-else></pic-zoom>
      </div>
      <div class="service_box_body_botom">
           <div @mouseenter="marketMouseenter(index)" class="" v-for="(imgDataList ,index) in imgData.show_picture" :key="index">
              <img :src="request.picUrl + imgDataList.path" alt="">
           </div>
      </div>
  </div>
</template>

<script>
  import PicZoom from 'vue-piczoom'
export default {
    props:['imgData'],
  components: {
    PicZoom
  },
    data(){
      return{
        imgUrl:'',
        videoUrl:null,
        userVideo:true
      }
    },
    methods:{
      marketMouseenter(index){
        this.imgUrl = this.imgData.show_picture[index].path
        this.userVideo = false
        console.log(this.imgUrl)
      }
    },
    updated(){
      this.videoUrl = this.imgData.video[0].path
    }
}
</script>

<style lang="css">
.video_class{
  width: 100%;
  height: 100%;
}
  .service_box_body_botom>div>img{
    width: 100%;
  }
  .service_box_body_botom>div{
    width: 80px;
    height: 80px;
    overflow: hidden;
    margin-right: 10px;
    background-color: #CCC;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
  }
  .service_box_body_botom>div:nth-child(5){
    margin-right: 0px;
  }
  .service_box_body_botom{
    width: 100%;
    display: flex;
    margin-top: 10px;
  }
  .service_box_body_img{
    width: 100%;
    height: 360px;
    overflow: hidden;
    background-color: #CCC;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .service_box_body_img>img{
    width: 100%;
  }
</style>
