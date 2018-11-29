<template>
  <div class="marginTop" v-loading="loading" v-if="DataMoni">
    <div class="service_box_datals">
      <div class="service_box_body">

        <div class="service_box_img_Deta">
          <!--图片数据-->
          <div class="marketUser">
            <div class="market_box_user">
              <div>
                <img src="/static/img/avatar/avatar.jpg" alt="">
              </div>
              <span>{{DataMoni.nickname}}</span>
              <el-rate
                v-model="value2"
                disabled
                :colors="['#15bafe', '#15bafe', '#15bafe']">
              </el-rate>
              <div class="float"></div>
            </div>
            <div class="market_box_buttom">
              <button @click="handleOpenChat">
                <img src="/static/img/icon/user_huih.png" alt="">
                联系卖家
              </button>
            </div>
            <ul class="market_length">
              <li>
                <p>商品浏览次数</p>
                <p>{{DataMoni.view_num}}</p>
              </li>
              <li>
                <p>最近编辑</p>
                <p>{{handleDate(DataMoni.created_at)}}</p>
              </li>
            </ul>
          </div>

          <div class="service_title">
            <h4>{{DataMoni.title}}</h4>
            <div class="service_title_box">
              <p class="service_address">{{DataMoni.city}} {{DataMoni.district}}</p>

              <div class="service_optin">
                <p @click="shareModalShowTrue"><i class="icon icon-fenxiang"></i>分享</p>
                <p @click="handleOpenReport"><i class="icon icon-huaban"></i>举报</p>
              </div>
            </div>

          </div>


          <!--轮播图-->
          <verticalSwiper :showPicture="show_picture" :videoUrl="videoUrlPath"></verticalSwiper>
          <div class="service_text">
            <div class="service_text_top">
              <!-- <div class="service_money"><span>&yen;</span>{{DataMoni.price}}</div> -->
              <div class="service_rate">
                <el-rate
                  v-model="serviceRate"
                  disabled
                  text-color="#ff9900">
                </el-rate>
              </div>
            </div>
            <div class="service_text_bottom">
              <div class="service_quantity">
                <el-input-number size="mini" v-model="serviceQuantity"></el-input-number>
                <p>（ 库存：{{DataMoni.stock}} ）</p>
              </div>
              <div class="service_btm">
                <div class="" @click="RouterClost">
                  <el-button type="primary"><i class="icon icon-ziyuan34"></i>添加购物车</el-button>
                </div>
                <div class="fontColor" @click="ptctIndex">
                  <el-button type="primary" plain>立即购买</el-button>
                </div>
              </div>
            </div>

          </div>
        </div>
        <!--tabs详情切换-->
        <el-tabs v-model="activeName" @tab-click="handleClick">
          <el-tab-pane label="商品详情" name="first">
            <div class="" v-html="DataMoni.content">

            </div>
          </el-tab-pane>
          <el-tab-pane label="评论" name="second">
            <market-comment></market-comment>
          </el-tab-pane>
          <el-tab-pane label="附件" name="third">
            <activityData :attachment="DataMoni.attachment"></activityData>
            <!-- <ul class="el-tab-laberl">
              <li v-for="(attachentList ,index) in DataMoni.attachment" :key="index">
                <div class="">
                  <img src="/static/img/icon/fuj.png" alt="">
                  <span>{{attachentList.name}}</span>
                </div>
                <div class="clickonCus" @click="onClickIndex(index)">
                  [下载]
                </div>
              </li>
            </ul> -->
          </el-tab-pane>
        </el-tabs>
      </div>
      <market-right :type="DataMoni"></market-right>
    </div>
    <floating-div></floating-div>
    <el-dialog
      custom-class="floatingKsChat"
      width="960px"
      @close="handleCloseChat"
      :visible.sync="openChat">
      <ksChat-div :merchantData="merchantData" :messageData="messageData" :messageLists="messageList"
                  :chatUserListFlag="chatUserListFlag"></ksChat-div>
    </el-dialog>
    <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="marketDetailId"></ReportDialog>
    <ShareModalDiv ref="shareModal" :show="shareModalShow"></ShareModalDiv>
    <login-warning-modal ref="loginWarn"></login-warning-modal>
  </div>
</template>

<script>
  import activityData from "@/views/activity/actvityDataFlie"
  import FormatDate from "../../utils/GetDateUtils"
  import FloatingDiv from '@/components/floating'
  import MarketRight from '@/views/Market/marketDataRight'
  import MarketLeft from '@/views/Market/marketDataleft'
  import MarketFont from '@/views/Market/marketDataFont'
  import MarketComment from '@/views/Market/marketDataComment'
  import ProductRack from '@/components/productRack'

  import verticalSwiper from '@/components/verticalSwiper'
  import ksChatDiv from "@/views/ksChat/ksChat"
  import * as cfg from "../../../config/app";
  import ReportDialog from '@/components/ReportDialog'
  import ShareModalDiv from '@/components/shareModal'
  import LoginWarningModal from '@/components/loginWarningModal'


  export default {
    data() {
      return {
        shareModalShow: false,
        reportVisible: false,
        merchantData: {},//商户信息
        openChat: false, //打开聊天框
        activeName: 'second',
        value2: null,
        DataMoni: null,
        loading: true,
        arrData: [],
        serviceRate: null,   // 评分分值
        serviceQuantity: 1,  // 计数器默认值
        // marketData:null
        show_picture: null,    //展示图
        videoUrlPath: null,     //浏览视频
        product: {},      //订单
        routerID: null,
        stompClient: null, //及时聊天
        messageData: {}, //创建及时对话返回的数据
        userInfo: JSON.parse(localStorage.getItem('userInfo')),
        messageList: [], //获取罅隙对话列表
        chatUserListFlag: 0,
        marketDetailId: ''
      }
    },
    components: {
      FloatingDiv,
      MarketRight,
      MarketLeft,
      MarketFont,
      MarketComment,
      ProductRack,
      verticalSwiper,
      activityData,
      ksChatDiv,
      ReportDialog,
      ShareModalDiv,
      LoginWarningModal
    },
    methods: {
      RouterClost() {
        this.HttpClient.post('/shoppingCart/addProducts', {
          token: window.localStorage.token,
          product_id: this.$route.query.id,
          quantity: this.serviceQuantity
        })
          .then((res) => {
            if (res.data.code != 200) {
              this.$message.error(res.data.msg);
            } else {
              this.$message({
                message: res.data.msg,
                type: 'success'
              });
            }
          })
      },
      ptctIndex() {
        // this.$route.query.id
        var a = this.$route.query.id
        this.product[a] = this.serviceQuantity
        this.$router.push({
          path: "/closeAccount",
          query: {
            product: this.product
          }
        })
        console.log(this.product)
      },
      handleDate(date) {
        return FormatDate.GetDate(date);
      },
      handleClick(tab, event) {
        console.log(tab, event);
      },
      onClickIndex(index) {
        window.location.href = this.request.picUrl + this.DataMoni.attachment[index].path
      },
      dataNew() {
        this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'goods/info', {
          token: window.localStorage.token,
          asin: this.$route.query.id
        })
          .then((res) => {
            this.DataMoni = res.data.data
            this.loading = false
            this.serviceRate = Number(this.DataMoni.useravg)
            this.show_picture = this.DataMoni.show_picture
            this.videoUrlPath = this.DataMoni.video
            this.merchantData = {
              uid: res.data.data.uid,
              nickname: res.data.data.nickname,
              headerImg: res.data.data.avatar,
              type: 5
            };
            console.log(res)
            this.DataMoni.show_picture.forEach((item) => {
              this.arrData.push(item.path)
            })

            console.log(this.DataMoni)
          })
      },
      /***
       * 打开聊天弹窗，并创建对话
       */
      async handleOpenChat() {
        if(!this.userInfo) {
          this.$refs.loginWarn.modelDelet = true;
        }else if (this.userInfo.uid === this.merchantData.uid) {
          this.$message.error('自己不能和自己聊天');
        } else {
          const param = {
            uid: this.merchantData.uid
          };
          const data = await this.StompUtils.connection(param);
          console.log(data)
          this.openChat = true;
          this.$store.dispatch('getChatUserFlag', this.chatUserListFlag++);
          this.merchantData.messageData = data;
          /*this.HttpClient.post('/my/dialog/create',param).then(res =>{
            if(res.data.code === 200) {
              console.log(res.data)
              this.messageData = {
                send: res.data.routeKey,
                subscribe: res.data.queueName,
                user: res.data.user
              };
              this.connection(this.messageData);
            }
          });*/
        }
      },
      /***
       * 关闭聊天弹窗并结束对话
       */
      handleCloseChat() {
        console.log('I am close')
        this.$store.dispatch('getChatUserFlag', this.chatUserListFlag++);
        this.StompUtils.disconnect();
      },
      /***
       * 打开连接
       */
      connection(messageData) {
        //this.scoket = new SockJS('ws://172.16.0.129:15674/ws');
        this.stompClient = Stomp.client(cfg.wsUrl);
        let self = this;
        this.stompClient.connect('guest', 'guest', (frame) => {
          this.merchantData.messageData = this.messageData;
          this.merchantData.stompClient = this.stompClient;
          this.openChat = true;
          console.log(messageData.subscribe)
          this.stompClient.subscribe(messageData.subscribe, (msg) => { // 订阅服务端提供的某个topic
            console.log(msg.body); //msg.body存放的是服务端发送给我们的信息
            //this.getMessage = msg.body
            setTimeout(() => {
              self.getMessageList();
            }, 5000)

          }, (err) => {
            console.log(err)
          })
        })
      },
      /***
       * 断开连接
       */
      disconnect() {
        this.StompUtils.disconnect();
        /*if(this.stompClient != null) {
          this.stompClient.disconnect();
          this.messageData = {};
          console.log('Disconnected')
        }*/
      },
      /***
       * 获取对话列表消息
       */
      getMessageList() {
        this.HttpClient.post('/my/message/info', {list_uid: this.merchantData.uid}).then(res => {
          console.log(res.data)
          if (res.data.code === 200) {
            this.messageList = res.data.data;
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
      /***
       * 打开分享框
       */
      shareModalShowTrue(){
        if(!this.$refs.shareModal.modelDelete){
          this.$refs.shareModal.show();
        }
      },
    },
    created() {
      this.dataNew();
      this.marketDetailId = this.$route.query.id;
    },
    watch: {
      $route: function (to, form) {
        console.log("跳转了")
        this.dataNew()
      }
    }
  }
</script>

<style lang="less">
  .fontColor > button > span {
    color: #FFF !important;
  }

  .service_box_body > .el-tabs--top {
    margin-bottom: 20px;
  }

  .service_title {
    width: 100%;
    margin-bottom: 20px;
    h4 {
      font-size: 26px;
      color: #000;
      margin-bottom: 5px;
    }
    .service_title_box {
      display: flex;
      justify-content: space-between;
      align-items: center;
      .service_address {
        font-size: 14px;
        color: #999;
      }
    }

    .service_optin {
      display: flex;
      align-items: center;
      p {
        display: flex;
        align-items: center;
        margin-left: 20px;
        font-size: 14px;
        color: #ccc;
        cursor: pointer;
        .icon {
          margin-right: 5px;
        }
      }
      p:hover{
        color: #15BAFE;
      }
    }

  }

  .service_text {
    width: 25%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;

    .service_money {
      font-size: 26px;
      color: #15befe;
      span {
        font-size: 16px;
        margin-right: 10px;
      }
    }

    .service_rate {
      margin: 5px 0;
      i {
        margin-right: 0 !important;
      }
    }
    .service_quantity {
      margin-bottom: 15px;

      .el-input-number--mini {
        width: 100px !important;
        margin-bottom: 10px;
      }
      p {
        font-size: 16px;
        color: #ccc;
      }
    }

    .service_btm {
      button {
        width: 100%;
        margin: 0;
      }
      button:nth-child(1) {
        margin-bottom: 10px;
        background: #15befe;
        border-color: #15befe;
        .icon {
          margin-right: 10px;
        }
      }
      button:nth-child(2) {
        color: #15befe;
        background: #fff;
        border-color: #15befe;
      }
      button:nth-child(2):hover {
        color: #fff;
        background: #15befe;
        border-color: #15befe;
      }

    }

  }

  .clickonCus {
    cursor: pointer;
  }

  .el-tab-laberl > li {
    display: flex;
    justify-content: space-between;
    border-bottom: 1px dashed #999999;
    padding-bottom: 10px;
    margin-top: 10px;
    cursor: pointer;
  }

  .el-tab-laberl {
    width: 100%;
    margin-bottom: 30px;
  }

  .marginTop {
    margin-top: 30px;
  }

  .market_length > li > p:nth-child(1) {
    color: #a1a1a1;
  }

  .market_length {
    display: flex;
  }

  .market_length > li {
    text-align: center;
    width: 150px;
    margin-left: 10px;
    padding: 3px;
    font-size: 14px;
  }

  .market_length > li:nth-child(2) {
    border-left: 1px dashed #CCC;
  }

  .market_length {
    float: right;
  }

  .market_box_buttom > button {
    cursor: pointer;
    background-color: #15bafe;
    color: #FFF;
    border: 1px solid #15bafe;
    padding: 5px;
    border-radius: 5px;
    margin-top: 10px;
    float: left;
  }

  .market_box_user > span {
    font-size: 16px;
    font-weight: 500;
  }

  .market_box_user > div:nth-child(1) {
    width: 45px;
    height: 45px;
    border: 1px solid #15bafe;
    border-radius: 3px;
    overflow: hidden;
    float: left;
    margin-right: 10px;
  }

  .market_box_user > div > img {
    width: 100%;
  }

  .market_box_user {
    width: 169px;
    float: left;
  }

  .market_box_user > .el-rate > .el-rate__item {
    width: 20px;
  }

  .marketUser {
    width: 100%;
    border: 1px solid #e8e8e8;
    border-top: 2px solid #15bafe;
    padding: 10px;
    margin-bottom: 20px;
  }

  .font_service_color {
    margin-top: 33px;
  }

  .font_service_color > p:nth-child(1) {
    font-size: 20px;
    float: left;
    font-weight: 800;
  }

  .font_service_color > p:nth-child(2) {
    float: right;
    margin-top: 10px;
  }

  .service_dis_flex > li {
    border: 1px solid #15bafe;
    color: #15bafe;
    padding: 0px 4px 0 4px;
    border-radius: 3px;
    margin-right: 2px;
    font-size: 12px !important;
  }

  .service_dis_flex {
    display: flex;
  }

  .service_titile_header_size {
    font-size: 17px;
  }

  .service_right_body > li > div > img {
    width: 100%;
  }

  .service_bat_color {
    margin-top: 30px;
    color: #888888;
  }

  .service_color_font {
    color: #888888;
  }

  .service_titile_header_font {
    font-size: 14px;
    color: #000;
  }

  .service_right_body > li > div:nth-child(2) {
    width: 160px;
    padding-left: 10px;
  }

  .service_right_body > li > div:nth-child(1) {
    width: 150px;
    height: 110px;
    overflow: hidden;
  }

  .service_right_body > li {
    width: 100%;
    display: flex;
    margin-bottom: 10px;
  }

  .service_box_DetailsVideo {
    width: 100%;
  }

  .service_re_ul > li > img {
    position: relative;
    top: 2px;
  }

  .service_re_ul > li:nth-child(1) {
    font-size: 13px;
    margin-right: 20px;
  }

  .service_re_ul {
    display: flex;
    margin-top: 13px;
  }

  .service_img_block {
    width: 100%;
    display: flex;
    margin-top: 15px;
  }

  .service_img_block > li {
    margin-right: 15px;
  }

  .service_praise_left {
    margin-left: 20px;
    margin-right: 25px;
  }

  .service_praise_left > .praise_ctrl > .praise_ctrl_box:nth-child(1) {
    margin-bottom: 6px;
  }

  .service_praise_left > .praise_ctrl > .praise_ctrl_box:nth-child(3) {
    margin-top: 6px;
  }

  .service_presca_body > div {
    font-size: 15px;
    margin-left: 5px;
  }

  .serice_box_right > div > span {
    position: relative;
    top: -2px;
  }

  .serice_box_right > div {
    float: left;
    margin-left: 10px;
  }

  .serice_box_momy > p {
    float: left;
  }

  .serice_box_right {
    float: right;
    position: relative;
    top: 30px;
  }

  .serice_box_momy > p {
    font-size: 40px;
    font-weight: 600;
    color: #000;
  }

  .service_box_kx {
    width: 55%;
  }

  .service_box_img_Deta {
    width: 100%;
    display: flex;
    justify-content: space-between;
    margin-bottom: 30px;
    flex-wrap: wrap;
  }

  .service_box_datals {
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
  }

  .service_box_body {
    width: 855px;
    margin-right: 20px;
  }

  .service_box_data {
    width: 320px;
  }
</style>
