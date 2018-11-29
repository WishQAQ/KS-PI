<template>
    <div class="">
        <div class="sss">
          <componeds-tab></componeds-tab>
          <div class="section_EncyBody">
              <ul class="EncyUl">
                  <li>
                      <div class="font-bottom">
                          <p>60分钟让你懂得新能源汽车</p>
                          <p>从行内人角度回答普通用户会问到的关于新能源汽车的问题，帮助用户认识和了解新能源汽车，帮助用户认识和了解新能源汽车</p>
                      </div>
                      <div class="font-bottom_right">
                          <p>老机友之李超说车 · 25万 次观看 · 2小时前</p>
                          <ul>
                             <li>精品教程</li>
                             <li>精品教程</li>
                             <li>精品教程</li>
                          </ul>
                      </div>
                      <div class="float"></div>
                  </li>
              </ul>
          </div>
        </div>
        <div class="float"></div>
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

$(function(){
  $(".EncyUl li").hover(function(){
    $(this).css({
      "backgroundColor":"#f0f0f0"
    })
    $(this).children('div')[0].style.borderLeft = "5px solid #15bafe"
  },function(){
    $(this).css({
      "backgroundColor":"#FFF"
    })
    $(this).children('div')[0].style.borderLeft = "5px solid #FFF"
  })
})
</script>

<style scoped src="../../assets/css/EncyclopIndex.css"></style>
<style lang="css">

</style>
