<template>
  <div class="service_box_data">
    <div class="service_box_DetailsVideo">
      <el-tabs v-model="activeNames" @tab-click="handleClick">
        <el-tab-pane label="挖货" name="first">
          <ul class="service_right_body">
             <li v-for="(item ,index) in NuggetsData" :key="index" @click="RouterIdas(index)">
               <div>
                  <img :src="request.picUrl + item.show_picture[0].path" alt="">
               </div>
               <div>
                  <p class="service_titile_header_font">{{item.title}}</p>
                  <!-- <p class="service_color_font">￥{{item.price}}</p> -->
                  <div class="service_bat_color">
                    <p>
                      {{handleDate(item.created_at)}}
                    </p>
                    <p>
                      {{item.city}}
                    </p>
                  </div>
               </div>
             </li>
          </ul>
        </el-tab-pane>
        <el-tab-pane label="相关视频" name="second">
          <ul class="service_right_body">
            <li v-for="(item ,index) in relationData" :key="index" @click="RouterVideo(index)">
              <div>
                 <img :src="request.picUrl + item.cover" alt="">
              </div>
              <div>
                 <p class="service_titile_header_font">{{item.title}}</p>
                 <p class="service_color_font_color">{{item.nickname}}</p>
                 <p class="service_bat_color">{{item.view_num}}观看次数</p>
              </div>
            </li>
          </ul>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script>
import FormatDate from "../../utils/GetDateUtils"
export default {
  props:['objectData','index','type'],
  data(){
    return{
      activeNames:'first',
      data:this.objectData,
      dataindex:this.index,  //点击的是当前的那个（下标）
      arrIndex:[],
      NuggetsData:null,  //挖货数据
      relationData:null   //相关视频数据
    }
  },
  methods:{
    RouterVideo(index){
      this.$router.push({
        path:'/home/videoDetail',
        query:{
          video:this.relationData[index].video_id
        }
      })
    },
    RouterIdas(index){
      this.$router.push({
        path:'/home/market-detail',
        query:{
          id:this.NuggetsData[index].asin
        }
      })
    },
    handleDate(date) {
      return FormatDate.GetDate(date);
    },
    handleClick(){

    },
    dataNew(){
      /***
      **
      挖货
      ***/

      this.HttpClient.post('/goods/relatedGoods',{
        title:this.type.title,
        tags:this.arrIndex
      })
      .then((res) => {
        this.NuggetsData = res.data.data
        console.log(this.NuggetsData)
      })

      //相关视频
      this.HttpClient.post('/goods/relatedGoodsVideo',{
        title:this.type.title,
        tags:this.arrIndex
      })
      .then((res) => {
        this.relationData = res.data.data
        console.log(this.relationData)
      })
    }
  },
  mounted(){

  },
  created(){
    //需求数据格式为数组，触发created进行重组数组
    this.arrIndex.push(this.type.label)
    this.dataNew()
  },
  watch:{
    $route:function(to ,form){
      console.log("跳转了~~")
      this.dataNew()
    }
  }
}
</script>

<style scoped lang="css">
.service_color_font_color{
  color:#888888;
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
}
.service_bat_color{
  margin-top: 22px;
  color:#888888;
  display: flex;
  justify-content:space-between;
  position: absolute;
  bottom: 0;
  width: 100%;
}
.service_color_font{
  color:#15befe;
  font-size: 18px;
  font-weight: bold;
}
.service_titile_header_font{
  font-size: 14px;
  color:#000;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
  overflow: hidden;
}
.service_right_body>li>div:nth-child(2){
  width: 160px;
  padding-left:10px;
  position: relative;
}
.service_right_body>li>div:nth-child(1){
  width: 150px;
  height: 110px;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #000;
  cursor: pointer;
}
.service_right_body>li{
  width: 100%;
  display: flex;
  margin-bottom: 10px;
  cursor: pointer;
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
.market_praise_left{
  margin-left: 20px;
  margin-right: 25px;
}
.market_praise_left>.praise_ctrl>.praise_ctrl_box:nth-child(1){
  margin-bottom: 6px;
}
.market_praise_left>.praise_ctrl>.praise_ctrl_box:nth-child(3){
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
