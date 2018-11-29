<template>
  <ul class="actviDataLi_box">
     <li ref="activeList" v-for="(item, index) in activityData" :key="index">
       <div class="search_actvity_div">
         <video
           :id="'video'+item.active_id"
           @timeupdate="updateTime"
           @mouseenter="handleMouseEnter(item.active_id)"
           @mousemove="handleMouseOver(item.active_id)"
           @mouseleave="handleMouseOut(item.active_id)"
           muted
           v-if="item.video"
           class="carousel_video"
           :poster="handleVideoSrc(item.video)+'?vframe/jpg/offset/2'"
           :src="handleVideoSrc(item.video)"
         >
         </video>
          <img v-else :src="handleImg(item.pic)" alt="">
       </div>

       <!--字体框-->
       <div class="activity_search_padding" @click="handleJumpToDetail(item.active_id)">
         <div class="search_actvity_data">
           <img src="/static/img/icon/iconSmall.png" alt="">
           <span>{{item.created_at?handleDateTime(item.created_at):''}}</span>
         </div>

          <p class="title_actvity">{{item.title}}</p>
          <p class="title_actvity_color">{{item.description}}</p>
          <div class="activity_Rate_div">
            <el-rate
              v-bind:value="item.score/2"
              disabled
              :show-text="true"
              :colors="['#15bafe','#15bafe','#15bafe']"
              text-color="#15bafe"
              :texts="[item.score,item.score,item.score,item.score,item.score]"
              score-template="{value}">
            </el-rate>
            <p>￥{{item.price}}</p>
          </div>
         <div class="tao_item_bottom">
           <div class="activity_ul_right">
                  <span>
                    <img src="/static/img/icon/aiye.png" alt="">
                    <span class="color_actvit_seachr">{{item.enrollment}}</span>
                  </span>
                  <span>
                    <img src="/static/img/icon/usersta.png" alt="">
                    <span class="color_actvit_seachr">{{item.view_num}}</span>
                  </span>
           </div>
           <p class="tao_bottom_right">{{item.district}}</p>
         </div>
       </div>
       <div class="activity_box_div">
         <div class="activity_ul_flex">
           <keywordInstall :keyword="item.tags"></keywordInstall>
         </div>
       </div>
     </li>
  </ul>
</template>

<script>

  import keywordInstall from '@/components/keywordInstall'
  import * as cfg from "../../../config/app";
  import moment from 'moment'
  // import {TimelineLite} from "gsap";


  export default {
  props:['SearchData','activityData'],
  data(){
    return{
      value2: 3,
    }
  },
  components:{
    keywordInstall
  },
  methods: {
    /***
     * 截取视屏长度 5秒
     * @param data
     * @returns {string}
     */
    handleVideoSrc(data) {
      const start = data.split('.')[0];
      const end = data.split('.')[1];
      /*console.log(start,end)*/
      //console.log(start,end,cfg.imageUrl+start+'_1_5'+end)
      return cfg.imageUrl+start+'_1_5'+'.'+end
    },
    /**
     * 图片格式
     * @param url
     * @returns {string}
     */
    handleImg(url) {
      return cfg.imageUrl+url;
    },
    /***
     * 格式化时间获取月和日
     * @param str
     * @returns {string}
     */
    handleDateTime(str) {
      console.log(str)
      return moment(str).format('MM.DD');
    },
    /***
     * 格式化时间YYYY-MM-DD
     * @param str
     * @returns {string}
     */
    handleDate(str) {
      return moment(str).format('YYYY-MM-DD');
    },
    /***
     * 鼠标移入事件
     * @param index
     */
    handleMouseOver(index) {
      const vdo = document.getElementById("video"+index);
      this.currentVideoIndex = index;
      vdo.play();
    },
    /***
     * 鼠标移除事件
     * @param index
     */
    handleMouseOut(index) {
      /*console.log(11111111,index)*/
      const vdo = document.getElementById("video"+index);
      vdo.pause();
    },
    updateTime(e){//播放进度
      if(e.target.currentTime>=5){
        e.target.currentTime=0;
        e.target.pause();
        this.videoIndex=null;
        this.hotIndex=null;
      }
      this.currentTime=e.target.currentTime;
    },
    /***
     * 鼠标点击事件
     * @param index
     */
    handleMouseEnter(index) {
      const vdo = document.getElementById("video"+index);
      this.currentVideoIndex = index;
      vdo.play();
    },
    /***
     * 跳转到详情页面
     * @param id
     */
    handleJumpToDetail(id) {
      this.$router.push({
        path: '/home/activity-detail',
        query: {
          id: id
        }
      })
    }
  },

    // created(){
    //   const {activeList} = this.$refs;
    //   const timeline = new TimelineLite();
    //   timeline.to(activeList, .8, {
    //     y:0,
    //     opacity:1,
    //   });
    // }
}
</script>

<style lang="css">
  .tao_item_bottom{
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
  }
  .tao_bottom_right{
    font-size: 12px;
    color: #cccccc;
    position: relative;
    top: 9px;
  }
  .activity_ul_flex>ul>li:hover{
    border:1px solid #15befe;
    color:#15befe;
    cursor: pointer;
  }
  .actviDataLi_box>li{
    flex: 1;
    max-width: 288px;
    margin-bottom: 20px;
    margin-right: 1.3%;
    position: relative;
    opacity: 0;
    bottom: -200px;
  }

  .actviDataLi_box>li:nth-child(1n){
    animation: activeList 1s forwards;
  }
  .actviDataLi_box>li:nth-child(2n){
    animation: activeList 1.3s forwards;
  }
  .actviDataLi_box>li:nth-child(3n){
    animation: activeList 1.6s forwards;
  }
  .actviDataLi_box>li:nth-child(4n){
    animation: activeList 1.9s forwards;
  }
  @keyframes activeList {
    from{
      opacity: 0;
      bottom: -200px;
    }
    to{
      opacity: 1;
      bottom: 0;
    }
  }


  .actviDataLi_box:after {
    content: "";
    flex: auto;
  }


.search_actvity_div{
  width: 100%;
  height: 220px;
  overflow: hidden;
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
}
.search_actvity_div:hover img{
  transform: scale(1.1);
  transition: all .3s;
}
.search_actvity_div>img{
  width: 100%;
  transition: all .3s;
}
.search_actvity_data{
  width: 55px;
  height: 55px;
  position: absolute;
  top: -30px;
  z-index:9;
  right: 50px;
}
.search_actvity_data>span{
  position: absolute;
  top: 18px;
  font-size: 16px;
  color: #FFF;
  left: 9px;
}
.color_actvit_seachr{
  color:#cccccc;
  position: relative;
  top:-2px;
  margin-right: 5px;
}
.activity_ul_right{
  padding-top: 10px;
  position: relative;
}
.activity_box_div{
  display: flex;
  justify-content: space-between;
  padding-bottom: 8px;
  height: 36px;
  position: relative;
  bottom: 53px;
  left: 6px;
}
.activity_Rate_div>p{
  font-size:30px;
  color:#15bafe;
  margin-top: -21px;
  position: relative;
  top:5px;
}
.activity_Rate_div{
  display: flex;
  justify-content: space-between;
  border-bottom: 1px solid #e5e5e5;
  padding-bottom: 3px;
}

.activity_Rate_div .el-rate__icon{
  font-size: 16px !important;
  margin-right: 0 !important;
}

.title_actvity_color{
  color:#666666;
  margin-bottom: 18px;
  max-height: 35px;
  min-height: 35px;
  overflow: hidden;
}
.activity_search_padding{
  padding: 30px 15px 0px 15px;
  border:1px solid #CCC;
  position: relative;
}
.title_actvity{
  font-size:16px;
  color:#000;
  margin-bottom: 8px;
}

@media screen and (min-width: 1240px) {
  .actviDataLi_box{
    display: flex;
    flex-wrap: wrap;
    flex: 3;
  }
}


  /*960px布局*/
  @media screen and (max-width: 1240px){
    .actviDataLi_box>li{
      flex: 1;
    }

    .search_actvity_div{
      height: auto;
    }

    .search_actvity_data{
      top: -20px;
      right: 15px;
      width: 40px;
      height: 40px;
    }
    .search_actvity_data img{
      width: 100%;
      height: 100%;
    }
    .search_actvity_data span{
      font-size: 12px;
      top: 10px;
      left: 5px;
    }

    .activity_search_padding{
      padding: 10px 5px 0 5px;
    }
    .activity_search_padding .title_actvity{
      font-size: 14px;
    }

    .activity_Rate_div .el-rate__icon{
      font-size: 14px !important;
      margin-right: 2px !important;
    }
    .activity_Rate_div>p{
      font-size: 20px;
    }
    .actviDataLi_box>li {
      max-width: 31%;
      margin-bottom: 20px;
    }
    .activity_main_box .actviDataLi_box>li:not(:nth-child(3n)) {
      margin-right: 26px !important;
    }
    .activity_main_box .actviDataLi_box>li:nth-child(3n){
      margin-right: 0;
    }
    .actviDataLi_box{
      margin: 0 auto;
      display: flex;
      flex-wrap: wrap;
    }
  }



</style>
