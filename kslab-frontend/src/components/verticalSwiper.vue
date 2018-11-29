<template>
    <div class="verticalSwiper">
      <swiper :options="swiperOptionTop" class="gallery-top" ref="swiperTop">
        <swiper-slide v-if="videoUrl && videoUrl.length>0">
          <video v-for="(item ,index) in videoUrl" controls :key="index" :src="request.picUrl + item.path" class="video_div"></video>
        </swiper-slide>
        <swiper-slide class="slide-1" v-for="(item ,index) in showPicture" :key="index"><img :src="request.picUrl + item.path" alt=""></swiper-slide>
        <div class="swiper-button-next swiper-button-white" slot="button-next"><i class="el-icon-arrow-down"></i></div>
        <div class="swiper-button-prev swiper-button-white" slot="button-prev"><i class="el-icon-arrow-up"></i></div>
      </swiper>
      <!-- swiper2 Thumbs -->
      <swiper :options="swiperOptionThumbs" class="gallery-thumbs" ref="swiperThumbs">
        <swiper-slide v-if="videoUrl && videoUrl.length>0">
          <video v-for="(item ,index) in videoUrl" :key="index" :src="request.picUrl + item.path" class="video_height"></video>
        </swiper-slide>
        <swiper-slide class="slide-1" v-for="(item ,index) in showPicture" :key="index"><img :src="request.picUrl + item.path" alt=""></swiper-slide>
      </swiper>

    </div>
</template>

<script>
    export default {
        props:['showPicture','videoUrl'],
        name: "verticalSwiper",

      data() {
        return {
          swiperOptionTop: {
            direction : 'vertical',
            spaceBetween: 10,
            navigation: {
              nextEl: '.swiper-button-next',
              prevEl: '.swiper-button-prev'
            }
          },
          swiperOptionThumbs: {
            direction : 'vertical',
            spaceBetween: 10,
            centeredSlides: true,
            slidesPerView: 'auto',
            touchRatio: 0.2,
            slideToClickedSlide: true
          }
        }
      },

      mounted() {
        this.$nextTick(() => {
          const swiperTop = this.$refs.swiperTop.swiper
          const swiperThumbs = this.$refs.swiperThumbs.swiper
          swiperTop.controller.control = swiperThumbs
          swiperThumbs.controller.control = swiperTop
        })
      },
      created(){
        console.log(this.showPicture)
        console.log(this.videoUrl)
      }
    }
</script>

<style lang="less">
  .video_div{
    width:100%;
    background-color: #000;
  }
  .video_height{
    height: 115px;
  }
  .verticalSwiper{
    height: 370px;
    width: 630px;
    background-color: #f2f2f2;
    padding: 10px 0 10px 10px;
    display: flex;
    justify-content: space-between;
    position: relative;
    overflow: hidden;
    .swiper-container {
      overflow: hidden;
      position: unset;
      z-index: unset !important;
      margin: 0 !important;

    }
    .swiper-slide {
      display: flex;
      justify-content: center;
      position: unset;
      img{
        width: 100%;
      }
    }

    .gallery-top {
      height: 100%!important;
      width: 100%;
    }
    .gallery-thumbs {
      width: 33%;
      height: 90%!important;
      margin: auto !important;
      -webkit-box-sizing: border-box;
      box-sizing: border-box;
      padding: 10px 0;

      .swiper-wrapper{
        width: 80%;
        height: 100%;
        margin: auto;
        position: relative;
        top: -30%;
      }
    }
    .gallery-thumbs .swiper-slide {
      width: 100%;
      height: 40%;
      opacity: 0.4;
      display: flex;
      justify-content: center;
      overflow: hidden;

      img{
        width: 100%;
      }
    }
    .gallery-thumbs .swiper-slide-active {
      opacity: 1;
    }

    /*翻页按钮*/
    .swiper-button-white{
      position: absolute;
      right: 0;
      background-color: #f2f2f2;
      top: 0;
      margin: 0 !important;
      background-image: none !important;
      width: 24% !important;
      height: 25px !important;
      left: auto !important;
      display: flex;
      justify-content: center;
      align-items: center;
      color: #000;
      font-size: 30px;
    }
    .swiper-button-next{
      top: auto !important;
      bottom: 10px;
    }
    .swiper-button-prev{
      top: 10px;
    }
    .swiper-button-prev:hover,
    .swiper-button-next:hover{
      background-color: #dedede;
    }
  }
</style>
