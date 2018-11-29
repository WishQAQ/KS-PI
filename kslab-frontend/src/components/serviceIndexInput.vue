<template>
    <div class="service_input">
      <!--搜索框功能-->
      <div class="">
        <div class="service_div">
          <img class="service_float_img" src="/static/img/icon/serviec.png" alt="">
          <span class='span_size'>关键字：</span>
        </div>
        <div class="service_cont_float">
          <form class="fromsubmit" action="index.html" method="post">
              <input type="text" name="" value="">
              <div class="oDivBlue_div">
                <img src="/static/img/icon/block_gb.png" alt="">
                精品教程
              </div>
              <div class="oDivBlue_div">
                <img src="/static/img/icon/block_gb.png" alt="">
                精品教程
              </div>
              <div class="oDivBlue_div">
                <img src="/static/img/icon/block_gb.png" alt="">
                精品教程
              </div>
              <button type="submit" class="button_ss">
                <img src="/static/img/icon/ss_imgcs.png" alt="">
              </button>
          </form>
        </div>
      </div>
      <!--搜索框功能-->
      <div class="float"></div>  <!--结束浮动-->
      <div class="category_div">
        <div class="preachat_cdiv">
            <img src="/static/img/icon/preachent.png" alt="">
            <span>类&nbsp;&nbsp;&nbsp;&nbsp;别：</span>
        </div>
        <div class="Float_cont">
            <div class="span_float" v-for="(BackImg,index) in serviceImg" :key="index" @click="switchClick" >
                <img  :id="index" :src="BackImg.Img" alt="">
                <span :id="index" :key="index">{{BackImg.name}}</span>
            </div>
        </div>
        <div class="float"></div>
      </div>
      <!--城市定位-->
      <div class="Citdy_div" id="place">
          <img class="T_dw" src="/static/img/icon/T_dw.png" alt="">
          <span class="Crtsname">重庆</span>
          <img class="Dibottom" src="/static/img/icon/triangle_down.png" alt="">
          <div id="in_city" style="display: none;"></div>
      </div>
    </div>
</template>

<script>
export default {
    data(){
      return{
        serviceImg:[
           {
             name:"汽车",
             Img:"/static/img/icon/block_img_hui.png",
             CBackImg:"/static/img/icon/block_cont_acd.png"
           },
           {
             name:"摩托车",
             Img:"/static/img/icon/block_img_hui.png",
             CBackImg:"/static/img/icon/block_cont_acd.png"
           },
           {
             name:"无人机",
             Img:"/static/img/icon/block_img_hui.png",
             CBackImg:"/static/img/icon/block_cont_acd.png"
           },
           {
             name:"其他",
             Img:"/static/img/icon/block_img_hui.png",
             CBackImg:"/static/img/icon/block_cont_acd.png"
           }
        ]
      }
    },
    methods:{
      switchClick(index){
        console.log(index.target.id)
      }
    },
    mounted(){
      var cityA = $(".city_a_le1 a"); //城市
      var pla = $("#place");  //出发地
      var dest = $("#destination");  //目的地
      // 默认值
      inCity.width = "400";  //城市选择框  宽
      inCity.height = "auto";  //城市选择框  高
      inCity.id = "#in_city";  //城市选择框  父级ID
      inCity.Children = '.city_a_le1';  //城市名box
      // 初始化 城市HTML模板
      $(inCity.id).prepend(inCity._template.join(''));
      inCity.Hot(cityA);

      //城市 导航
      var apay = $(".screen a");

      var placeThis; //当前选择标签
      apay.click(function(obj){  //城市导航
          inCity.payment($(this));
      });

      inCity.place(pla); //出发地
      inCity.destination(dest);  //目的地
      inCity.cityClick(cityA); //显示赋值城市
      console.log(cityA)
    }
}

$(function(){
  $(".span_float").click(function(){
    $(this).find('img').attr("src",'/static/img/icon/block_cont_acd.png')
    $(this).siblings().find('img').attr('src',"/static/img/icon/block_img_hui.png")
  })

  $(".city_a_le1 a").click(function () {
      var a_city = $(this).text();  //当前选择的城市
      console.log($(this).text())
      $(inCity.id).hide();  //隐藏城市选择框
      placeThis.val(a_city);  //赋值
      var ContName = placeThis.val()
     if(ContName.length == 4)
     {
      $(".Citdy_div").css("width","130px")
     }
     else if(ContName.length == 3)
     {
      $(".Citdy_div").css("width","120px")
     }
     else{
      $(".Citdy_div").css("width","110px")
     }
      $(".Crtsname").html(ContName)
      return false;
  })
})
</script>

<style scoped src="../assets/css/servicePage.css"></style>
<style lang="css">
ol, ul { list-style: none }
table { border-collapse: collapse; border-spacing: 0 }
caption, td, th { text-align: left; font-weight: 400;}
blockquote, q { quotes: none }
blockquote:after, blockquote:before, q:after, q:before { content: ""; content: none }
a img { border: none }
article, aside, details, figcaption, figure, footer, header, hgroup, main, menu, nav, section, summary { display: block }
button, html, input, select, textarea { font-family:Microsoft YaHei,Hiragino Sans GB W3,PingFang-SC-Regular,Helvetica Neue,Helvetica,microsoft yahei,sans-serif; }
a { color: #555; text-decoration: none }
a, button, div, em, i, input, li, p, section, span, ul { }

html,body { height: 100%; }

input { background-color: #fff; font-size: 1em; outline:none; text-indent: 10px; }

.clear {clear: both;}

#destination { background: url(/static/img/icon/sui.png) no-repeat 96% center; }

#in_city { background: #ddd; position: absolute; z-index: 999;border: solid 1px #d7d7d7; background: #fff;padding-bottom: 6px; }
.screen { overflow: hidden; }
.screen a { float: left; color: #00b8ff; padding: 1px 12.6px; text-align: center; border-bottom: solid 1px #00b8ff; }
.screen a:hover { color: #00b8ff; }
.screen .shar { color: #404040; border: solid 1px #00b8ff; border-bottom: none; }
.city_a_le1 { padding: 10px; overflow: hidden; }
.city_a_le1 a { float: left; width: 20%; margin: 2px 0; }
.Letter span { width: 12%; float: left; text-align: center; padding: 2px 0; }
.Letter div { width: 88%; float: left; }
.city_a_le1 a:hover { color: #00b8ff; }
.Letter div a { width: 25%; }
#in_city h1 { padding: 10px 0; color: #ababab; text-indent: 3%; }
</style>
