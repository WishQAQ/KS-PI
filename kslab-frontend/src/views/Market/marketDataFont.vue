<template>
  <div class="serice_box_botom_two" v-if="this.fontData">
     <p>{{fontData.title}}</p>
     <div class="serice_box_boxFont">
        <el-rate
          v-model="value2"
          disabled
          :colors="['#15befe', '#15befe', '#15befe']">
        </el-rate>
        <p><span class="marketColorFont"><!--辽宁葫芦岛 连山区-->{{fontData.city}}{{fontData.district}}</span></p>
        <div class="market_box_shoppin">
          <div>
              <button type="button" name="button" class="market_butom">
                <img src="/static/img/icon/gw.png" alt="">
                <span class="market_font_top">添加购物车</span>
              </button>
          </div>
          <div>
            <p class="marketFont_color">￥561</p>
            <button type="button" class="market_right_btn" name="button">
              立即购买
            </button>
          </div>
        </div>
     </div>
     <div class="serice_box_momy">
        <div class="serice_box_right">
            <div class="">
                <img src="/static/img/icon/fx.png" alt="">
                <span @click="shareModalShowTrue" class="span_box">分享</span>
            </div>
            <div class="">
                <img src="/static/img/icon/jub.png" alt="">
                <span>举报</span>
            </div>
        </div>
        <div class="float"></div>
     </div>
     <ShareModalDiv ref="shareModal" :show="shareModalShow"></ShareModalDiv>
  </div>
</template>

<script>
import ShareModalDiv from '@/components/shareModal'
export default {
    props:['fontData'],
    data(){
      return{
        shareModalShow: false,
        value2: 3,
        num1:1
      }
    },
    methods:{
      shareModalShowTrue(){
        if(!this.$refs.shareModal.modelDelete){
          this.$refs.shareModal.show();
        }
      },
      handleChange(value) {
        console.log(value);
      }
    },
    components:{
      ShareModalDiv
    }
}
</script>

<style lang="css">
.marketFont_color{
  color:#15befe;
  font-size: 35px;
  text-align: right;
}
.market_right_btn{
  float: right;
  border:1px solid #15befe;
  background-color: #FFF;
  border-radius: 5px;
  color:#15befe;
  padding: 10px 45px 10px 45px;
}
.serice_box_right{
  top:10px;
}
.market_font_top{
  position: relative;
  top:-4px;
  color:#FFF;
}
.market_butom{
  border:1px solid #15befe;
  background-color: #15befe;
  border-radius: 5px;
  color:#FFF;
  margin-top: 51px;
  padding: 7px 25px 7px 25px;
}

@media screen and (max-width: 1150px) and (min-width: 300px) {
  .market_butom,
  .market_right_btn{
    width: 115px;
    padding: 0;
    height: 35px;
  }
}



.market_box_shoppin{
  display: flex;
  justify-content: space-between;
}
.market_box_shoppin>.el-input-number{
  width: 120px !important;
}
.serice_box_boxFont>.el-input-number{
  width: 120px !important;
}
.market_box_left>span:nth-child(1){
  width: 30px;
  border:1px solid red;
  text-align: center;
  background-color: #f4f4f4;
  color:#a0a0a0;
  padding: 8px 10px 8px 10px;
  border-radius: 5px 0px 0px 5px;
}
.market_box_left>span:nth-child(2){
  width: 30px;
  border:1px solid red;
  text-align: center;
  color:#a0a0a0;
  padding: 8px 10px 8px 10px;
}
.market_box_left>span:nth-child(3){
  width: 30px;
  border:1px solid red;
  text-align: center;
  background-color: #f4f4f4;
  color:#a0a0a0;
  padding: 8px 10px 8px 10px;
  border-radius: 0px 5px 5px 0px;
}
.marketShopping{
  width: 100%;
  border:1px solid red;
  display: flex;
}
.marketColorFont{
  color:#939393;
  position: relative;
  top:3px;
}
.marketRight{
  float: right;
}
.marketUser_momy>p:nth-child(1){
  font-size: 16px;
}
.marketUser_momy>p:nth-child(2){
  font-size: 29px;
  margin-top: -12px;
  color:#15bafe;
  font-weight: 600;
}
.marketUser_momy>p{
  float: left;
}
.marketUser_momy{
  border-bottom: 1px solid #e9e9e9;
  padding-top:20px;
}
.span_box{
  cursor: pointer;
}
.serice_box_momy{
  width: 100%;
  margin-top: 10px;
  padding-right: 10px;
}
.serice_box_boxFont>p{
  font-size: 14px;
  height: 241px;
}
.serice_box_boxFont{
  width: 100%;
  border-bottom: 1px solid #e5e5e5;
  padding-bottom: 15px;
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
  margin-bottom: 10px;
}
.serice_box_botom_two{
  width: 42%;
}
</style>
