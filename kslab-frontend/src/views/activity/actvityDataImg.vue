<template lang="html">
    <div class="activityDataImg">
      <el-carousel :autoplay="false" trigger="click" height="420px">
        <el-carousel-item v-if="headerData.video">
          <div class="player-container">
            <video-player class="vjs-custom-skin" :options="playerOptions"></video-player>
          </div>
        </el-carousel-item>
        <el-carousel-item v-for="(item, index) in headerData.cover" :key="index">
          <div><img class="carousel_img" :src="handleImg(item.path)" alt=""></div>
        </el-carousel-item>
      </el-carousel>
      <div class="activity_date_font">
         <div class="activity_Font_title">
            <p>{{headerData.title}}</p>
            <div class="Font_title_div">
               {{headerData.description}}
            </div>
         </div>
         <div class="activity_Font_Right">
            <ul>
               <li v-for="(item,index) in headerData.tags" :key="index">{{item}}</li>
            </ul>
            <p>￥{{headerData.price}}</p>
            <button v-show="false" @click="handleSignUp(activeId)" type="button" name="button">点击报名</button>
         </div>
      </div>
      <div class="activity_botom_font">
         <div class="activity_ul_data">
            <ul>
               <li>
                 <div class="icon_div_width">
                    <img src="/static/img/icon/usericon.png" alt="">
                 </div>
                 <span>举办方</span>
                 <p>{{headerData.promotee}}</p>
                 <div class="float"></div>
               </li>
               <li>
                 <div class="icon_div_width dw">
                    <img src="/static/img/icon/dw_dxz.png" alt="">
                 </div>
                 <span>地址:</span>
                 <p>{{headerData.address}}</p>
                 <div class="float"></div>
               </li>
               <li>
                 <div class="icon_div_width">
                    <img src="/static/img/icon/temicon.png" alt="">
                 </div>
                 <span>联系电话:</span>
                 <p>{{headerData.telphone}}</p>
                 <div class="float"></div>
               </li>
            </ul>
           <div class="activity_icon_font">
            <span @click="shareModalShowTrue">
              <img src="/static/img/icon/fx.png" alt="">
              <span class="opctiy">分享</span>
            </span>
             <span>
              <img src="/static/img/icon/jub.png" alt="">
              <span class="opctiy" @click="handleOpenReport">举报</span>
            </span>
           </div>
         </div>

      </div>


      <ShareModalDiv ref="shareModal" :show="shareModalShow"></ShareModalDiv>
      <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="headerData.active_id"></ReportDialog>

    </div>
</template>

<script>
  import ShareModalDiv from '@/components/shareModal'
  import ReportDialog from '@/components/ReportDialog'
  import * as cfg from "../../../config/app";
  //引入video样式
  import 'video.js/dist/video-js.css'
  import 'vue-video-player/src/custom-theme.css'

  //引入hls.js
  import 'videojs-contrib-hls.js/src/videojs.hlsjs'
  // import ActivityPay from '@/views/activity/activityPay'
  import moment from 'moment'

export default {
   props:['activeId'],
  components:{
    ShareModalDiv,
    ReportDialog
    // ActivityPay
  },
   data(){
     return{
       headerData: {},
       shareModalShow: false,
       reportVisible: false,
       playerOptions: {
         playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
         autoplay: false, //如果true,浏览器准备好时开始回放。
         controls: true, //控制条
         preload: 'auto', //视频预加载
         muted: false, //默认情况下将会消除任何音频。
         loop: false, //导致视频一结束就重新开始。
         language: 'zh-CN',
         aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
         fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
         sources: [{
           type: '',
           src: 'https://video-dev.github.io/streams/x36xhzz/x36xhzz.m3u8'
         }],
         poster: "http://static.smartisanos.cn/pr/img/video/video_03_cc87ce5bdb.jpg", //你的封面地址
         width: document.documentElement.clientWidth,
         notSupportedMessage: '此视频暂无法播放，请稍后再试' //允许覆盖Video.js无法播放媒体源时显示的默认信息。
       }
     }
   },
  created() {
    this.$watch('activeId',function (newVal, oldVal) {
      console.log(newVal)
      this.getActivityDetail(newVal)
      this.$store.dispatch('getActivityDetail',{active_id:newVal}).then(()=>{
        console.log(this.$store.state.activityDetail.activityDetail.active_id)
        //this.getActivityDetail(this.$store.state.activityDetail.activityDetail.active_id)
      });
    })
  },
  methods:{
    shareModalShowTrue(){
      if(!this.$refs.shareModal.modelDelete){
        this.$refs.shareModal.show();
      }
      // this.shareModalShow = true
    },
    /***
     * 格式化图片
     * @param url
     * @returns {*}
     */
    handleImg(url) {
      return cfg.imageUrl+url;
    },
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
    /***
     * 获取详情信息
     * @param active_id
     */
    getActivityDetail(active_id) {
      this.HttpClient.get('/actives/detail',{
        active_id: active_id,//'dc25b01b-48cb-438f-9aea-e3866487bd90',
        time: moment().valueOf(),
      }).then(res=>{
        console.log(res)
        if(res.data.code === 200){
          this.headerData = res.data.data;
          this.playerOptions.sources[0].src = this.handleImg(this.headerData.video);
          this.playerOptions.poster = this.handleVideoSrc(this.headerData.video)+'?vframe/jpg/offset/2';
        }else{
          //this.$message.error('获取详情信息失败');
        }
      })
    },
    // 打开举报框
    handleOpenReport() {
      this.reportVisible = true;
    },
    /***
     * 回调举报
     * @param value
     */
    getReportVisible(value) {
      this.reportVisible = value;
    },
    /**
     * 报名
     */
    handleSignUp(activeId) {
      console.log(activeId)
      this.$router.push({
        path: '/home/activitySignUp',
        query: {
          id: activeId
        }
      })
    }
  },
}
</script>
<!--<style lang="scss">
  @import "@/assets/css/player.less";
</style>-->
<style src="../../assets/css/player.less"></style>
<style scoped lang="css">
  .carousel_img{
    width: 100%;
    height: 100%;
  }
.activityDataImg .el-carousel{
  margin-top: 15px;
}
.activityDataImg .el-carousel__arrow{
  top: 90% !important;
}
.activityDataImg .el-carousel>.el-carousel__container>.el-carousel__arrow--left{
  left: 85% !important;
}
.activityDataImg .el-carousel>.el-carousel__container>.el-carousel__arrow--right{
  right: 3% !important;
}
.activityDataImg .el-carousel>.el-carousel__container>.el-carousel__arrow--left,
.activityDataImg .el-carousel>.el-carousel__container>.el-carousel__arrow--right{
  background-color:#FFF;
  color:#15befe;
}
.activityDataImg .el-carousel>.el-carousel__container>.el-carousel__arrow--left:hover,
.activityDataImg .el-carousel>.el-carousel__container>.el-carousel__arrow--right:hover{
  background-color:#15befe;
  color: #fff;
}
.activityDataImg .el-carousel{
  width: 100%;
}
.activityDataImg .activity_icon_font>span{
  cursor: pointer;
}
.activityDataImg .activity_icon_font>span>img{
  margin-left: 10px;
}
.activityDataImg .opctiy{
  position: relative;
  top:-2px;
}
.activityDataImg .activity_icon_font{
  padding-top:28px;
}
.activityDataImg .activity_ul_data>ul>li:nth-child(2){
  margin-right: 65px;
}
.activityDataImg .dw>img{
  width: 75% !important;
}
.activityDataImg .activity_ul_data>ul>li>p{
  color:#666666;
  font-size: 14px;
}
.activityDataImg .activity_ul_data>ul>li>span{
  font-size: 16px;
}
.activityDataImg .icon_div_width>img{
  width: 100%;
}
.activityDataImg .activity_ul_data>ul>li{
  width: 170px;
}
.activityDataImg .icon_div_width{
  width: 30px;
  height: 30px;
  float:left;
  margin-right: 10px;
  margin-top: 5px;
}
.activityDataImg .activity_ul_data>ul{
  width: 680px;
  display: flex;
}
.activityDataImg .activity_botom_font{
  display: flex;
  margin-top: 30px;
  justify-content: space-between;
}
.activityDataImg .activity_Font_Right>button{
  background-color: #15befe;
  color:#FFF;
  border:1px solid #15befe;
  border-radius: 30px;
  cursor: pointer;
  transition: all .2s;
  width: 110px;
  height: 37px;
}
.activityDataImg .activity_Font_Right>button:hover{
  box-shadow: 1px 1px 4px 0 rgba(27,97,175,.69);
}
.activityDataImg .activity_Font_Right>p{
  text-align: right;
  font-size: 30px;
  color:#15befe;
  font-weight: 600;
}
.activityDataImg .activity_Font_Right>ul{
  display: flex;
}
.activityDataImg .activity_Font_Right>ul>li{
  color:#bfbfbf;
  border:1px solid #bfbfbf;
  border-radius: 3px;
  padding: 0px 6px 0 6px;
  margin-left:10px;
  cursor: pointer;
  transition: all .2s;
}
.activityDataImg .activity_Font_Right>ul>li:hover{
  border:1px solid #15bafe;
  color: #15bafe;
}
.activityDataImg .activity_Font_Right{
  text-align: right;
}
.Font_title_div{
  margin-top:15px;
  font-size: 14px;
  word-break: break-all;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
  overflow: hidden;
}
.activityDataImg .activity_Font_title>p{
  font-size: 22px;
  font-weight: 800;
  color:#000;
}
.activityDataImg .activity_Font_title{
  width: 555px;
}
.activityDataImg .activity_date_font{
  width: 100%;
  display: flex;
  justify-content: space-between;
  margin-top:30px;
}
</style>
<style lang="less">
  @media screen and (max-width: 1200px){
    .service_box_datals{
      width: unset !important;
      margin: 0 auto;
      display: -webkit-box;
      display: -ms-flexbox;
      display: flex;
      -webkit-box-pack: justify;
      -ms-flex-pack: justify;
      justify-content: space-between;
      .service_box_body{
        width: 684px;
        margin-left: 10px;
        .activityDataImg{
          .el-carousel__container{
            height: 336px !important;
          }
          .activity_date_font{
            .activity_Font_title{
              width: 444px;
              p{
                width: 444px;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
              }
            }
            .activity_Font_Right{
              ul{
                li{
                  max-width: 65px;
                  text-overflow: ellipsis;
                  overflow: hidden;
                  white-space: nowrap;
                }
              }
            }
          }
          .activity_botom_font{
            display: flex;
            .activity_ul_data{
              display: flex;
              justify-content: space-between;
              ul{
                width: 570px;
              }
            }
          }
        }
      }
      .service_box_data{
        width: 256px !important;
      }
    }

  }
</style>
