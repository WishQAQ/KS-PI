<template>
    <div class="">
           <div class="Classify_header">
              <img src="/static/img/Classifitbaike.png" alt="">
              <div class="Classify_body">
                <div class="">
                  <p></p>
                  <span>发动机管理</span>
                  <div class="float"></div>
                  <div class="Classify_font">
                      包含热循环原理，进排气、供油和点烧策略以及设计。同事也涵盖冷热系统控制。engine mapping和turbo mapping也包括在内。包含热循环原理，进排气、供油和点烧策略以及设计。同事也涵盖冷热系统控制。
                      engine mapping和turbo mapping也包括在内。包含热循环原理，进排气、供油和点烧策略以及设计。同事也涵盖冷热系统控制。
                  </div>
                </div>
              </div>
           </div>
           <div class="Classify_data">
              <baike-data></baike-data>
           </div>
        <float-div></float-div>
    </div>
</template>

<script>
import FloatDiv from '@/components/floating'
import BaikeData from '@/views/baike/baikedata'
export default {
  data(){
    return{
      activeName: 'first'
    }
  },
  components:{
    FloatDiv,
    BaikeData
  },
  created(){}
}
</script>

<style lang="css">
.el-tabs>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.is-top{
  float: left;
}
  .Classify_font{
    color:#4c4c4c;
    font-size: 15px;
    line-height: 25px;
    margin-top: 10px;
  }
  .Classify_data{
    width: 1200px;
    margin: 0 auto;
    background-color: #FFF;
    margin-top: 20px;
    box-shadow: 0 0 10px 1px #CCC;
    padding: 15px;
  }
  .Classify_header{
    width:1200px;
    margin: 0 auto;
    background-color: #FFF;
    box-shadow: 0 0 10px 1px #CCC;
  }
  .Classify_body{
    width: 1200px;
    padding: 20px;
  }
  .Classify_body>div>p:nth-child(1){
    width: 5px;
    height: 25px;
    background-color:#15bafe;
    padding: 3px;
    float: left;
    position: relative;
    top:5px;
    margin-right: 20px;
  }
  .Classify_body>div>span:nth-child(2){
    font-weight: 800;
    font-size: 23px;
  }
</style>
