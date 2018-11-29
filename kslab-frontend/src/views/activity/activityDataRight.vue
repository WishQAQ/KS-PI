<template>
  <div class="service_box_data">
    <div class="service_box_DetailsVideo">
      <el-tabs v-model="activeNames" @tab-click="handleClick">
        <el-tab-pane label="相关活动" name="first">
          <ul class="service_right_body">
            <li v-for="(item, index) in rightData" style="cursor: pointer" :key="index" @click="handleActive(item.active_id)">
              <div>
                <img :src="handleImg(item.pics[0])" alt="">
              </div>
              <div>
                <p class="service_right_title">{{item.title}}</p>
                <p class="service_right_titles">{{item.description}}</p>
                <div class="service_right_bottom">
                  <p class="right_price">￥<span>{{item.price}}</span></p>
                  <p class="right_person">{{item.enrollment?item.enrollment:'0'}}人已报名</p>
                </div>
              </div>
            </li>
          </ul>
        </el-tab-pane>
        <el-tab-pane label="相关视屏" name="second">
          <ul class="service_right_body">
            <li v-for="(item, index) in videoData" :key="index">
              <div>
                <img :src="handleImg(item.cover)" alt="">
              </div>
              <div>
                <p class="service_right_header">{{item.title}}</p>
                <p class="right_video_price">{{item.nickname}}</p>
                <p class="right_video_person">{{item.view_num}} 次浏览</p>
              </div>
            </li>
          </ul>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script>
  import * as cfg from "../../../config/app";

  export default {
    props:['objectData','index','headerData'],
    data(){
      return{
        activeNames:'first',
        data:this.objectData,
        dataindex:this.index,  //点击的是当前的那个（下标）
        rightData: [],
        videoData: []
      }
    },
    watch: {
      headerData: {
        handler(newData, oldData) {
          this.getContactService(newData.title,newData.tags);
          this.getContactVideo(newData.title,newData.tags);
        }
      }
    },
    mounted() {
      console.log(this.rightData)
    },
    methods:{
      handleClick(tab){

      },
      /****
       * 获取相关服务
       * @param title
       * @param tags
       */
      getContactService(title,tags) {
        this.HttpClient.get('/actives/relatedActives',{
          title: title,
          tags: tags
        }).then(res =>{
          console.log(res.data)
          if(res.data.code === 200) {
            this.rightData = res.data.data
          }else{
            this.rightData = []
          }
        })
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
       * 获取相关视屏
       * @param title
       * @param tags
       */
      getContactVideo(title,tags) {
        this.HttpClient.get('/actives/relatedActivesVideo',{
          title: title,
          tags: tags
        }).then(res =>{
          console.log(res.data)
          if(res.data.code === 200) {
            this.videoData = res.data.data
          }else{
            //this.$message.error(res.data.msg)
            this.videoData = []
          }
        })
      },
      handleActive(id) {
        this.$emit('getActiveId',id)
      }
    },
  }
</script>

<style scoped lang="css">
  .service_right_title{
    font-size: 15px;
    color: #404040;
  }
  .service_right_titles{
    text-overflow: -o-ellipsis-lastline;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    line-clamp: 3;
    -webkit-box-orient: vertical;
    font-size: 12px;
    color: #808080;
    margin-top: 5px;
  }
  .service_right_bottom{
    display: flex;
    justify-content: space-between;
    margin-top: 10px;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    word-break: break-all;

  }
  .right_price{
    font-size: 12px;
    color: #15BAFE;
  }
  .right_price span{
    font-size: 16px;
    color: #15BAFE;
  }
  .right_person{
    font-size: 12px;
    color: #808080;
    margin-top: 3px;
  }
  .font_service_color{
    margin-top: 33px;
  }
  .font_service_color>p:nth-child(1){
    font-size: 20px;
    float: left;
    font-weight: 800;
  }
  .font_service_color>p:nth-child(2){
    float: right;
    margin-top: 10px;
  }
  .service_dis_flex>li{
    border:1px solid #15bafe;
    color:#15bafe;
    padding: 0px 4px 0 4px;
    border-radius: 3px;
    margin-right: 2px;
    font-size: 12px !important;
  }
  .service_dis_flex{
    display: flex;
  }
  .service_titile_header_size{
    font-size: 17px;
  }
  .service_right_body>li>div>img{
    width: 100%;
    height: 100%;
  }
  .service_bat_color{
    margin-top: 30px;
    color:#888888;
  }
  .service_color_font{
    color:#888888;
  }
  .service_titile_header_font{
    font-size: 14px;
    color:#000;
  }
  .service_right_body>li>div:nth-child(2){
    width: 160px;
    padding-left:10px;
  }
  .service_right_body>li>div:nth-child(1){
    width: 150px;
    height: 110px;
    overflow: hidden;
  }
  .service_right_body>li{
    width: 100%;
    display: flex;
    margin-bottom: 10px;
  }
  .service_box_DetailsVideo{
    width: 100%;
  }
  .service_re_ul>li>img{
    position: relative;
    top:2px;
  }
  .service_re_ul>li:nth-child(1){
    font-size: 13px;
    margin-right: 20px;
  }
  .service_re_ul{
    display: flex;
    margin-top:13px;
  }
  .service_img_block{
    width: 100%;
    display: flex;
    margin-top: 15px;
  }
  .service_img_block>li{
    margin-right: 15px;
  }
  .service_praise_left{
    margin-left: 20px;
    margin-right: 25px;
  }
  .service_praise_left>.praise_ctrl>.praise_ctrl_box:nth-child(1){
    margin-bottom: 6px;
  }
  .service_praise_left>.praise_ctrl>.praise_ctrl_box:nth-child(3){
    margin-top: 6px;
  }
  .service_presca_body>div{
    font-size: 15px;
    margin-left: 5px;
  }
  .service_presca_body{
    width: 100%;
    float: left;
  }
  .service_box_userDetal{
    width: 100%;
    display: flex;
    margin-top: 10px;
  }
  .floatRight_box{
    float: right;
    margin-top: 36px;
    color:#737373;
  }
  .servic_font_box_size{
    float: left;
  }
  .servic_font_box_size>p:nth-child(1){
    font-size:20px;
    font-weight: 800;
  }
  .servic_font_box_size>p:nth-child(2){
    font-size: 14px;
    margin-top: 5px;
    color:#737373;
  }
  .service_ul_box>li>div>div>img{
    width: 100%;
  }
  .user_div_oimg{
    width: 55px;
    height: 55px;
    border:1.5px solid #15bafe;
    border-radius: 5px;
    overflow: hidden;
    float: left;
    margin-right: 10px;
  }
  .service_ul_box>li>div{
    width: 100%;
    padding-right: 15px;
  }
  .service_ul_box>li{
    width: 100%;
    margin-bottom: 40px;
  }
  .serice_box_right>div>span{
    position: relative;
    top:-2px;
  }
  .serice_box_right>div{
    float: left;
    margin-left: 10px;
  }
  .serice_box_momy>p{
    float: left;
  }
  .serice_box_right{
    float: right;
    position: relative;
    top:30px;
  }
  .serice_box_momy>p{
    font-size: 40px;
    font-weight: 600;
    color:#000;
  }
  .serice_box_momy{
    width: 100%;
    margin-top: 15px;
    padding-right: 10px;
  }
  .serice_box_boxFont>ul>li>div>p:nth-child(1){
    color:#000 !important;
    font-size: 16px;
  }
  .serice_box_boxFont>ul>li>div>p:nth-child(2){
    color:#898989;
  }
  .serice_box_boxFont>ul>li>div{
    position: relative;
    top:-7px;
  }
  .serice_box_boxFont>ul>li>img{
    width: 25px;
    float: left;
    margin-right: 15px;
  }
  .serice_box_boxFont>ul>li:nth-child(3){
    margin-bottom: 5px !important;
  }
  .serice_box_boxFont>ul>li{
    margin-bottom: 25px;
  }
  .serice_box_boxFont{
    width: 100%;
    border-bottom: 1px solid #e5e5e5;
    margin-top: 100px;
  }
  .serice_box_title>li{
    border:1px solid #15bafe;
    border-radius: 3px;
    padding: 0px 6px 0px 6px;
    color:#15bafe;
    margin-right: 10px;
  }
  .serice_box_title{
    width: 100%;
    display: flex;
    margin-top: 8px;
  }
  .serice_box_botom_two>p:nth-child(1){
    font-weight: 800;
    font-size: 22px;
  }
  .serice_box_botom_two{
    width: 385px;
  }
  .service_box_body_botom>div{
    width: 80px;
    height: 80px;
    overflow: hidden;
  }
  .service_box_body_botom{
    width: 100%;
    display: flex;
    justify-content:space-between;
    margin-top: 10px;
  }
  .service_box_body_img{
    width: 100%;
    height: 360px;
    overflow: hidden;
  }
  .service_box_kx{
    width: 440px;
  }
  .service_box_img_Deta{
    width: 100%;
    display: flex;
    justify-content: space-between;
    margin-bottom: 30px;
  }
  .service_box_datals{
    width: 1200px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
  }
  .service_box_body{
    width:855px;
  }
  .service_box_data{
    width: 320px;
  }
</style>
