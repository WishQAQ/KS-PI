<template lang="html">
    <div class="">
      <div class="actvity_odiv_user">
          <p>公司介绍</p>
      </div>
      <div class="actvity_odiv_username">
          <div class="userImg_activity">
            <img :src="handleImg(headerData.merchantInfo?headerData.merchantInfo.avatar:'')" alt="">
          </div>
          <div class="activity_small_div">
            <div>
              <span class="user_titile_name">{{headerData.merchantInfo?headerData.merchantInfo.name:''}}</span>
              <el-rate
                v-model="value2"
                disabled
                :colors="['#15befe', '#15befe', '#15befe']">
              </el-rate>
            </div>
            <p class="activity_icon_color">{{headerData.merchantInfo?headerData.merchantInfo.profile:''}}</p>
          </div>
      </div>
      <div class="activity_odiv_Chara">
         <div class="activity_flex_disc">
            <p></p>
            <span>特色</span>
         </div>
         <div class="activity_flex_disc samll">
            <span>{{headerData.merchantInfo?headerData.merchantInfo.feature:''}}</span>
         </div>
      </div>
      <div class="activity_odiv_Chara">
         <div class="activity_flex_disc">
            <p></p>
            <span>图片展示</span>
         </div>
         <div class="company_images">
            <div class="img_content" v-for="(item, index) in JSON.parse(headerData.merchantInfo?headerData.merchantInfo.cover:'[]')" :key="index" :style="index%5===4?{marginRight:0}:{}">
              <img :src="handleImg(item.path)" class="company_image"/>
            </div>
         </div>
        <div v-if="headerData.merchantInfo && JSON.parse(headerData.merchantInfo.cover)[0]" class="big_img_0" :style="headerData.merchantInfo && JSON.parse(headerData.merchantInfo.cover)[0]?{}:{dispaly:'none'}">
          <img class="big_img" :src="headerData.merchantInfo?handleImg(JSON.parse(headerData.merchantInfo.cover)[0].path):''">
        </div>
      </div>
    </div>
</template>

<script>
import cfg from '../../../config/app'
export default {
  props: ['headerData'],
  data(){
    return{
      value2: 4,
    }
  },
  methods: {
    handleImg(url) {
      return cfg.imageUrl+url;
    }
  }
}
</script>

<style lang="css">
.samll{
  padding-left: 12px;
  margin-top: 5px;
}
.samll>span{
  font-size: 17px !important;
  font-weight: 500 !important;
}
.activity_flex_disc>span{
  font-size: 20px;
  font-weight: 600;
}
.activity_flex_disc>p{
  width: 5px;
  height: 25px;
  background-color: #15befe;
  position: relative;
  top:2.5px;
  margin-right: 8px;
}
.activity_flex_disc{
  display: flex;
}
.activity_odiv_Chara{
  width: 100%;
  margin-top: 20px;
  margin-bottom: 26px;
}
.activity_small_div{
  margin-top: 5px;
}
.actvity_odiv_username>div>div>.el-rate{
  position: relative;
  top:3px;
  left:5px;
}
.activity_icon_color{
  font-size: 14px;
  margin-top: 12px;
  color:#979797;
}
.user_titile_name{
  float: left;
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 5px;
}
.userImg_activity>img{
  width: 100%;
}
.userImg_activity{
  width: 80px;
  height: 80px;
  overflow: hidden;
  float: left;
  margin-right: 10px;
}
.actvity_odiv_username{
  width: 100%;
  overflow: hidden;
  margin-top: 20px;
}
.actvity_odiv_user>p{
  font-size: 20px;
  font-weight: 600;
  padding-left: 20px;
  padding-bottom: 3px;
  border-bottom:1px solid #bfbfbf;
}
.actvity_odiv_user{
  width: 100%;
  margin-top: 20px;
}
  .company_images{
    display: flex;
  }
</style>
<style lang="less">
  @media screen and (min-width: 1200px){
    .company_images{
      display: flex;
      flex-wrap: wrap;
      .img_content{
        width: 151px;
        height: 150px;
        margin-right: 25px;
        margin-top: 10px;
        .company_image{
          width: 100%;
          height: 100%;
        }
      }
    }
    .big_img_0{
      width: 800px;
      height: 800px;
      margin-top: 20px;
      .big_img{
        width: 100%;
        height: 100%;
      }
    }
  }


  @media screen and (max-width: 1200px){
    .company_images{
      display: flex;
      flex-wrap: wrap;
      .img_content{
        width: 120px;
        height: 120px;
        margin-right: 20px;
        margin-top: 10px;
        .company_image{
          width: 100%;
          height: 100%;
        }
      }
    }
    .big_img_0{
      width: 640px;
      height: 640px;
      margin-top: 20px;
      .big_img{
        width: 100%;
        height: 100%;
      }
    }
  }
</style>
