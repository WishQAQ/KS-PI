<template>
    <div class="">
        <div class="Cardata_div">
          <div class="Cardata_div_img">
            <img :src="data.images" alt="" @click="jumpServPage(data.service_id)">
          </div>
          <div class="Cardata_prodiv">
            <h1 @click="jumpServPage(data.service_id)">{{data.title}}</h1>
            <p>商家：{{data.create_user}}</p>
            <el-rate v-model="serviceCar_value"
              disabled
              :colors="['#15bafe', '#15bafe', '#15bafe']"
            >
            </el-rate>
            <div class="oDivfont">
              ￥
              <span>{{data.price}}</span>
            </div>
            <ul class="Ul_li">
              <li v-for="(item,index) in data.label" :key="index">{{item.name}}</li>              
            </ul>
            <span class="span_div">{{data.support_num}}人已报名</span>
            <span class="span_div right">
              <img src="/static/img/icon/watch.png" alt="">
              <span>{{data.view_num}}</span>
            </span>
          </div>
        </div>
    </div>
</template>

<script>
$(function(){
  $(".Ul_li li").hover(function(){
      $(this).css({
        "color":"#FFF",
        "backgroundColor":"#15bafe"
      })
  },function(){
    $(this).css({
      "color":"#15bafe",
      "backgroundColor":"#FFF"
    })
  })

  $(".Cardata_div").hover(function(){
    $(this).css({
      "borderRight":"5px solid #15bafe",
      "boxShadow":"0px 0px 1px 1px #CCC",
      "transition":"all 0.3s"
    })
  },function(){
    $(this).css({
      "borderRight":"5px solid #e8e8e8",
      "boxShadow":"0px 0px 0px #CCC"
    })
  })
})
export default {
    props:[
      'data'
    ],
    data(){
      return{
        serviceCar_value:3
      }
    },
    methods:{
      //跳转服务详情页
      jumpServPage(id){
        this.$router.push({
          path:'/home/service-detail',
          query:{
            id:id,
            status:1
          }
        })
      },
    }
}
</script>

<style  lang="css">
.Cardata_div{
  width: 550px;
  border-right:5px solid #e8e8e8;
  height: 185px;
  cursor: pointer;
  display: flex;
  align-items: center;
  margin-bottom: 30px;
  border-top: 1px solid #eee;
  border-left: 1px solid #eee;
  border-bottom: 1px solid #eee;
}
.Ul_li{
  display: flex;
  align-items: center;
}
.Ul_li li{
  display: inline-block;
  border:1px solid #15bafe;
  border-radius: 5px;
  padding: 1px 3px 1px 3px;
  color:#15bafe;
  margin-right: 10px;
  cursor: pointer;
}
.Ul_li{
  margin: 7px 0;
  padding-bottom: 8px;
  border-bottom: 1px solid #eee;
}
.Cardata_div_img{
  width: 275px;
  margin-right: 15px;
  height: 185px;
}
.oDivfont{
  font-size:18px;
  font-weight: 800;
}
.Cardata_div_img img{
  width: 100%;
  vertical-align:bottom !important;
  height: 185px;
}
.Cardata_prodiv{
  width: 240px;
  height: 185px;
  margin-left: 0 !important;
}
.Cardata_prodiv h1{
  font-size:20px;
  font-weight: 800;
}
.Cardata_prodiv p{
  color:#9d9d9d;
  margin-top: 3px;
  margin-bottom: 3px;
}
.Cardata_prodiv div{
  margin-left: 0 !important;
}

.oDivfont{
  margin-top: 5px;
}
.oDivfont span{
  font-size:27px !important;
}
.float{
  clear: both;
}
.span_div{
  color:#949494;
}
.span_div img{
  width:15px;
}
.right{
  float:right;
  margin-right: 0px;
}
@media screen and (max-width: 1200px) {
  .Cardata_div{
    width: 450px;
    height: 155px;
  }
  .Cardata_prodiv p{
    margin: 0;
  }
  .oDivfont{
    margin: 0;
  }
  .Ul_li{
    margin: 0;
  }
  .right{
    margin-right: 5px;
  }
  .Cardata_prodiv{
    height: 160px;
  }
  .Cardata_div_img img{
  width: 100%;
  vertical-align:bottom !important;
  height: 155px;
  }
  .Cardata_div_img{
  width: 275px;
  margin-right: 15px;
  height: 155px;
  }
}
</style>
