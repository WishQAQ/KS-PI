<template>
    <div class="">
        <div class="service_box_datals">
            <div class="service_box_body">
                <div class="service_box_img_Deta">
                  <!--图片数据-->
                    <div class="marketUser">
                        <div class="market_box_user">
                           <div>
                              <img src="/static/img/avatar/avatar.jpg" alt="">
                           </div>
                           <span>李超</span>
                           <el-rate
                            v-model="value2"
                            :colors="['#15bafe', '#15bafe', '#15bafe']">
                          </el-rate>
                          <div class="float"></div>
                        </div>
                        <div class="market_box_buttom">
                           <button>
                             <img src="/static/img/icon/user_huih.png" alt="">
                             联系卖家
                           </button>
                        </div>
                        <ul class="market_length">
                            <li>
                              <p>商品浏览次数</p>
                              <p>179</p>
                            </li>
                            <li>
                              <p>最近编辑</p>
                              <p>2018-08-14 14:58</p>
                            </li>
                        </ul>
                    </div>
                    <market-left :imgData="DataMoni"></market-left>
                    <market-font :fontData="DataMoni"></market-font>
                </div>
                <!--tabs详情切换-->
                <el-tabs v-model="activeName" @tab-click="handleClick">
                  <el-tab-pane label="简介" name="first">简介</el-tab-pane>
                  <el-tab-pane label="评论" name="second">
                      <market-comment></market-comment>
                  </el-tab-pane>
                  <el-tab-pane label="附件" name="third">附件</el-tab-pane>
                </el-tabs>
            </div>
            <market-right :type="DataMoni"></market-right>
        </div>
        <floating-div></floating-div>
    </div>
</template>

<script>
import FloatingDiv from '@/components/floating'
import MarketRight from '@/views/Market/marketDataRight'
import MarketLeft from '@/views/Market/marketDataleft'
import MarketFont from '@/views/Market/marketDataFont'
import MarketComment from '@/views/Market/marketDataComment'
export default {
  data(){
    return{
        activeName:'second',
        value2: 4,
        DataMoni:[
          {
            title:"胆太大!男子为图方便 将马路双···",
            username:"李超",
            kan:"56k+"
          }
        ]
    }
  },
  components:{
    FloatingDiv,
    MarketRight,
    MarketLeft,
    MarketFont,
    MarketComment
  },
  methods: {
      handleClick(tab, event) {
        console.log(tab, event);
      },
    }
}
</script>

<style lang="css">
.market_length>li>p:nth-child(1){
  color:#a1a1a1;
}
.market_length{
  display: flex;
}
.market_length>li{
  text-align: center;
  width: 150px;
  margin-left: 10px;
  padding: 3px;
  font-size: 14px;
}
.market_length>li:nth-child(2){
  border-left:1px dashed #CCC;
}
.market_length{
  float:right;
}
.market_box_buttom>button{
  cursor: pointer;
  background-color: #15bafe;
  color:#FFF;
  border:1px solid #15bafe;
  padding: 5px;
  border-radius: 5px;
  margin-top: 10px;
  float: left;
}
.market_box_user>span{
  font-size:16px;
  font-weight: 500;
}
.market_box_user>div:nth-child(1){
  width: 45px;
  height: 45px;
  border:1px solid #15bafe;
  border-radius: 3px;
  overflow: hidden;
  float: left;
  margin-right: 10px;
}
.market_box_user>div>img{
  width: 100%;
}
.market_box_user{
  width: 169px;
  float: left;
}
.market_box_user>.el-rate>.el-rate__item{
  width: 20px;
}
.marketUser{
  width: 100%;
  border:1px solid #e8e8e8;
  border-top: 2px solid #15bafe;
  padding: 10px;
  margin-bottom: 20px;
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
.service_box_kx{
  width: 440px;
}
.service_box_img_Deta{
  width: 100%;
  display: flex;
  justify-content: space-between;
  margin-bottom: 30px;
  flex-wrap: wrap;
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
