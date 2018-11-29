<template>
    <div class="">
        <div class="VideoBody_Index">
            <componeds-tab></componeds-tab>
            <div class="Video_div_body">
                <ul>
                   <li>
                       <div class="Vide_ming">
                           <img src="/static/img/car002.png" alt="">
                       </div>
                       <div class="Video_div_ming">
                           <p>60分钟让你懂得新能源汽车</p>
                           <p>
                               从行内人角度回答普通用户会问到的关于新能源汽车的问题，帮助用户认识和了解新能源汽车从行内人角度回答普通用户会问到的关于新能源汽车的问题，帮助用户认识和了解新能源汽车
                           </p>
                           <ul>
                               <li>新能源</li>
                               <li>精品教程</li>
                               <li>汽车</li>
                           </ul>
                           <p>老机友之李超说车 · 20万 次观看 · 2小时前</p>
                       </div>
                       <div class="float"></div>
                   </li>
                   <li>
                       <div class="Vide_ming">
                           <img src="/static/img/car002.png" alt="">
                       </div>
                       <div class="Video_div_ming">
                           <p>60分钟让你懂得新能源汽车</p>
                           <p>
                               从行内人角度回答普通用户会问到的关于新能源汽车的问题，帮助用户认识和了解新能源汽车从行内人角度回答普通用户会问到的关于新能源汽车的问题，帮助用户认识和了解新能源汽车
                           </p>
                           <ul>
                               <li>新能源</li>
                               <li>精品教程</li>
                               <li>汽车</li>
                           </ul>
                           <p>老机友之李超说车 · 20万 次观看 · 2小时前</p>
                       </div>
                       <div class="float"></div>
                   </li>
                </ul>
            </div>
        </div>
    </div>
</template>

<script>
import ComponedsTab from '@/components/Componeds_tab'
export default {
    data(){
      return{

      }
    },
    components:{
      ComponedsTab
    }
}
</script>

<style lang="css">
.Video_div_ming>ul{
    display: flex;
    margin-top: 10px;
}
.Video_div_ming>ul>li{
    margin-right: 10px;
    border:1px solid #15bafe;
    padding: 2px 6px 2px 6px;
    border-radius: 5px;
    color:#15bafe;
}
.Video_div_ming{
    width: 65%;
    float: left;
}
.Vide_ming{
    width: 270px;
    height: 150px;
    margin-right: 10px !important;
    overflow: hidden;
    float: left;
}
.Video_div_body{
  width:1200px;
  margin: 0 auto;
  margin-left: 120px;
}
.VideoBody_Index{
   width:100%;
   overflow: hidden;
   display: flex;
}
.Video_div_body>ul>li{
    width: 100%;
    height: 185px;
    border-bottom:1px solid #e6e6e6;
    padding: 10px;
    margin-bottom:30px;
}
.Vide_ming>img{
    width: 100%;
}
.Video_div_ming>p:nth-child(1){
    font-size:18px;
    font-weight: 800;
}
.Video_div_ming>p:nth-child(2){
    font-size:14px;
    color:#898989;
    margin-top: 5px;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
}
.Video_div_ming>p:nth-child(4){
    float: right;
    margin-top: 22px;
    color:#898989;
    font-size:14px;
}
</style>
