<template>
    <div class="Margin_top_bot">
      <div class="Components_tab">
          <div class="tab_titile">
              <div class="title_tab">
                  <img src="/static/img/icon/serviec.png" alt="">
                  <span>关键词</span>
              </div>
              <div class="title_tab_input">
                  <input type="text" name="" value="">
                  <button type="button" name="button">
                     <img src="/static/img/icon/ss_imgcs.png" alt="">
                  </button>
              </div>
          </div>
          <div class="Vide_botm">
            <div class="Video_titile">
                <div class="Video_titile_header">
                    <img src="/static/img/icon/Video_img.png" alt="">
                    <span>视频类型</span>
                    <img src="/static/img/icon/bottom_video.png" alt="">
                </div>
                <div class="Video_body_tab">
                    <ul>
                        <li>
                          汽车
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          摩托车
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          无人机
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                    </ul>
                </div>
            </div>
          </div>
          <div class="filter_title">
            <div class="filter_titile_header">
                <img src="/static/img/icon/filfel_img.png" alt="">
                <span>过滤</span>
                <img src="/static/img/icon/bottom_video.png" alt="">
            </div>
            <div class="filter_body_sttole">
              <div class="filter_deta">
                  <span>上传日期</span>
              </div>
                <div class="filter_nav">
                    <ul>
                        <li>
                          今天
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          本月
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          本周
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          本年
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                    </ul>
                </div>
                <div class="filter_deta">
                    <span>长度</span>
                </div>
                <div class="filter_nav">
                    <ul>
                        <li>
                          小于十分钟
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          大于十分钟
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                    </ul>
                </div>
                <div class="filter_deta">
                    <span>排列</span>
                </div>
                <div class="filter_nav">
                    <ul>
                        <li>
                          上传时间
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          观看次数
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                        <li>
                          影响力
                          <img src="/static/img/icon/block_cont_acd.png" alt="">
                        </li>
                    </ul>
                </div>
              </div>
            </div>
      </div>
    </div>
</template>

<script>
export default {
    data(){
      return{

      }
    }
}

$(function(){
  $(".Video_titile_header").click(function(){
      $(".Video_body_tab").slideToggle()
  })

  $(".filter_titile_header").click(function(){
      $(".filter_body_sttole").slideToggle()
  })
})
</script>

<style scoped lang="css">
.Margin_top_bot{
  position:relative;
}
.filter_title_header{
  width: 100%;
}
.filter_nav ul li{
  line-height: 30px;
  font-size:14px;
}
.filter_nav ul li img{
  float: right;
  position: relative;
  top:7px;
}
.filter_nav{
  width: 165px;
  margin: 0 auto;
  padding-left: 15px;
}
.filter_deta{
  width: 160px;
  border-bottom:1px solid #e0e0e0;
  padding-bottom: 5px;
  margin: 0 auto;
  margin-top: 15px;
  margin-bottom: 15px;
}
.filter_deta span{
  font-size:17px;
  color:#898989;
  margin-left: 15px;
}
.filter_title{
  width: 190px;
  margin: 0 auto;
  background-color: #FFF;
  border-radius: 5px;
}
.Vide_botm{
  width: 190px;
  margin: 0 auto;
  padding-bottom: 15px;
  border-bottom:1px solid #e0e0e0;
  margin-bottom: 15px;
}
.title_tab{
  width: 160px;
  margin: 0 auto;
  padding-left: 5px;
  margin-top: 15px;
}
.Video_body_tab ul{
  margin-left: 10px;
}
.Video_body_tab ul li{
  width: 150px;
  font-size:14px;
  line-height: 30px;
}
.Video_body_tab ul li img{
  float: right;
  position: relative;
  top:8px;
}
.Video_body_tab{
  width: 100%;
  background-color: #FFF !important;
  text-align: left;
  padding: 10px;
  border-radius: 5px;
}
.Video_titile_header img:nth-child(1){
  position: relative;
  top:2px;
}
.Video_titile_header img:nth-child(3){
  float: right;
  margin-top: 10px;
}
.Video_titile_header span{
  font-size:17px;
  margin: 0 10px 0 10px;
}
/* ---- */
.filter_titile_header img:nth-child(1){
  position: relative;
  top:2px;
}
.filter_titile_header img:nth-child(3){
  float: right;
  margin-top: 10px;
}
.filter_titile_header span{
  font-size:17px;
  margin: 0 10px 0 10px;
}
.Video_titile{
  width: 190px;
  margin: 0 auto;
  margin-top: 15px;
  background-color: #FFF;
  text-align: center;
  border-radius: 5px;
  padding: 7px;
}
.Video_titile_header{
  width: 100%;
  cursor: pointer;
  padding-right: 10px;
  padding-top: 5px;
  border-radius: 5px !important;
}
.filter_titile_header{
  width: 100%;
  cursor: pointer;
  border-radius: 5px !important;
  padding: 10px 10px 0 28px;
  padding-bottom: 10px;
}
.tab_titile{
  width: 195px;
  border-bottom:1px solid #e0e0e0;
  padding-bottom: 15px;
  margin: 0 auto;
}
.title_tab_input{
  width: 190px;
  height: 30px;
  margin: 0 auto;
  padding-left: 5px;
  margin-top: 15px;
  background-color: #FFF;
  border:1px solid #bebebe;
  border-radius: 5px;
}
.title_tab_input input{
  height: 25px;
  border:1px solid #fff;
}
.title_tab_input button{
  background-color: #FFF;
  border:0;
  float: right;
  position: relative;
  top:-20px;
  cursor: pointer;
}
.title_tab img{
  width: 30px;
  margin-right: 10px;
}
.title_tab span{
  font-size:18px;
  color:#616161;
}
.section_EncyBody{
  width: 1200px;
  margin: 0 auto;
  margin-left: 120px;
}
.sss{
  display: flex;
}
.float{
  clear: both;
}
.Components_tab{
  width: 240px;
  background-color: #f0f0f0;
  padding-bottom: 70px;
  padding-top: 10px;
  float: left;
}
</style>
