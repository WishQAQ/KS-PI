<template lang="html">
    <div class="activityDataImg">
      <el-carousel
        trigger="click"
        :autoplay="false"
        height="420px">
        <el-carousel-item v-if="headerData.video">
          <div class="player-container">
            <video-player class="vjs-custom-skin" :options="playerOptions"></video-player>
          </div>
        </el-carousel-item>
        <el-carousel-item v-for="(item, index) in JSON.parse(headerDatas.images?headerDatas.images:'[]')" :key="index">
          <div><img style="width: 100%" :src="handleImg(item.path)" alt=""></div>
        </el-carousel-item>
      </el-carousel>
      <div class="activity_date_font">
         <div class="activity_Font_title">
            <p class="activity_title_p">{{headerDatas.title}}</p>
            <div class="Font_title_div">
               {{headerData.description}}
            </div>
         </div>
         <div class="activity_Font_Right">
            <ul>
               <li v-for="(item, index) in headerDatas.tagsname" :key="index">{{item}}</li>
            </ul>
            <p>￥{{headerDatas.price}}</p>
            <button type="button" name="button"  @click="handleOpenModal">咨询商家</button>
         </div>
      </div>
      <div class="activity_botom_font">
         <div class="activity_ul_data">
            <ul>
               <li>
                 <div class="icon_div_width">
                    <img src="/static/img/icon/usericon.png" alt="">
                 </div>
                 <span>服务方</span>
                 <p>{{headerDatas.merchantInfo?headerDatas.merchantInfo.name:''}}</p>
                 <div class="float"></div>
               </li>
               <li>
                 <div class="icon_div_width dw">
                    <img src="/static/img/icon/dw_dxz.png" alt="">
                 </div>
                 <span>地址:</span>
                 <p>{{headerDatas.address}}</p>
                 <div class="float"></div>
               </li>
               <li>
                 <div class="icon_div_width">
                    <img src="/static/img/icon/temicon.png" alt="">
                 </div>
                 <span>联系电话:</span>
                 <p>{{headerDatas.telphone}}</p>
                 <div class="float"></div>
               </li>
            </ul>
         </div>
         <div class="activity_icon_font">
            <span @click="shareModalShowTrue">
              <img src="/static/img/icon/fx.png" alt="">
              <span class="opctiy">分享</span>
            </span>
            <span @click="handleOpenReport">
              <img src="/static/img/icon/jub.png" alt="">
              <span class="opctiy">举报</span>
            </span>
         </div>
      </div>

      <ReportModal @getReportModal="getReportModal" :modelReport="modelReport"></ReportModal>
      <ShareModalDiv ref="shareModal" :show="shareModalShow"></ShareModalDiv>
      <div class="service_detail_modal">
        <el-dialog
          :visible.sync="dialogVisible"
          width="500px">
          <div class="service_detail_modal_title" slot="title">
            <p>发送消息给XXXX</p>
          </div>
          <el-input
            type="textarea"
            class="text_area"
            :rows="18"
            maxlength="199"
            placeholder="最多两百个字，只能是文字"
            v-model="sendMessage">
          </el-input>
          <el-input v-model="getMessage" :value="getMessage"></el-input>
          <div slot="footer" class="service_detail_modal_bottom">
            <el-button class="btn_cancel" size="mini" @click="dialogVisible = false">取 消</el-button>
            <el-button class="btn_ok" size="mini" type="primary" @click="handleSend">确 定</el-button>
          </div>
        </el-dialog>
      </div>
      <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="headerData.service_id"></ReportDialog>
    </div>
</template>

<script>
  import SockJS from 'sockjs-client';
  import Stomp from 'stompjs';
  import ShareModalDiv from '@/components/shareModal'
  import ReportModal from '@/components/reportModal'
  import ReportDialog from '@/components/ReportDialog'
  import cfg from "../../../config/app";
  //引入video样式
  import 'video.js/dist/video-js.css'
  import 'vue-video-player/src/custom-theme.css'

  //引入hls.js
  import 'videojs-contrib-hls.js/src/videojs.hlsjs'
  // import ActivityPay from '@/views/activity/activityPay'

export default {
   props:['dataFontImg','headerData'],
    components:{
      ShareModalDiv,
      ReportModal,
      ReportDialog
      // ActivityPay
    },
   data(){
     return{
       reportVisible: false,
       modelReport: false,
       dialogVisible: false,
       sendMessage: '',
       getMessage: '',
       shareModalShow: false,
       headerDatas: {},
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
         height: 420,
         notSupportedMessage: '此视频暂无法播放，请稍后再试' //允许覆盖Video.js无法播放媒体源时显示的默认信息。
       },
       scoket: null,
       stompClient: null,
       timer: null,
     }
   },
  created() {
    this.$watch('headerData',function (newVal, oldVal) {
      this.headerDatas = newVal;
      console.log(newVal)
      this.playerOptions.sources[0].src = this.headerDatas.video?this.handleImg(JSON.parse(this.headerDatas.video)[0].path):'';
      this.playerOptions.poster = this.headerDatas.video?this.handleVideoSrc(JSON.parse(this.headerDatas.video)[0].path)+'?vframe/jpg/offset/2':'';
    })

  },
  mounted() {
    this.initWebScoket();
  },
  methods:{
    handleSend() {
      //this.connection();
      //this.stompClient = Stomp.client('ws://172.16.0.129:15674/ws');
      //发送消息
      this.stompClient.send('/topic/php.logs',{"content-type":"text/plain"},this.sendMessage);
      //订阅消息
      this.stompClient.subscribe('/topic/#.logs', (msg) =>{ // 订阅服务端提供的某个topic
        console.log(msg.body); //msg.body存放的是服务端发送给我们的信息
        this.getMessage = msg.body
      }, (err) =>{
        console.log(err)
      })
    },
    initWebScoket() {
      //this.connection();
      let self = this;
      /*this.timer = setInterval(() => {
        try {
          self.stompClient.send("test");
        } catch (err) {
          console.log("断线了: " + err);
          self.connection();
        }
      }, 5000);*/
    },
    /***
     * 打开连接
     */
    connection() {
      //this.scoket = new SockJS('ws://172.16.0.129:15674/ws');
      this.stompClient = Stomp.client('ws://172.16.0.129:15674/ws');
      this.stompClient.connect('guest','guest', (frame) => {
        this.stompClient.subscribe('/topic/#.logs', (msg) =>{ // 订阅服务端提供的某个topic
          console.log(msg.body); //msg.body存放的是服务端发送给我们的信息
          this.getMessage = msg.body
        }, (err) =>{
          console.log(err)
        })
      })
    },
    /***
     * 断开连接
     */
    disconnect() {
      if(this.stompClient != null) {
        this.stompClient.disconnect();
        console.log('Disconnected')
      }
    },
    shareModalShowTrue(){
      if(!this.$refs.shareModal.modelDelete){
        this.$refs.shareModal.show();
      }
    },
    /***
     * 图片格式化
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
     * 打开咨询商家弹窗
     */
    handleOpenModal() {
      this.connection();
      console.log(111)
      this.dialogVisible = true
    },
    getReportModal(value) {
      console.log(value)
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
    }
  },
}
</script>
<style lang="less">
  .service_detail_modal{
    .service_detail_modal_title{
      border-bottom: 1px solid #f2f2f2;
      padding-bottom: 3px;
    }
    .text_area{
      .el-textarea__inner{
        resize: none;
      }
    }
    .service_detail_modal_bottom{
      text-align: center;
      .btn_cancel{
        width: 100px;
      }
      .btn_ok{
        width: 100px;
      }
    }
    .el-dialog__body{
      padding: 10px 20px !important;
    }
  }

</style>
<style src="../../assets/css/player.less"></style>
<style lang="less">
  .vjs-custom-skin{
    height: 100%;
  }
.activityDataImg{
  width:100%;
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
  font-size: 13px;
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
  /*width: 680px;*/
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
  margin-top: 7px;
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
@media screen and (max-width:1200px){
  .activityDataImg .activity_Font_title{
    width: 504px;
    .activity_title_p{
      width: 504px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  }
  .activityDataImg .activity_Font_Right>ul>li{
    color:#bfbfbf;
    border:1px solid #bfbfbf;
    border-radius: 3px;
    padding: 0px 6px 0 6px;
    margin-left:10px;
    cursor: pointer;
    transition: all .2s;
    max-width: 50px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
}
</style>
