<template>
    <div class="">
        <div class="ProblemIndexBody">
            <componeds-tab></componeds-tab>
            <div class="Problemsection">
                <ul>
                   <li>
                     <div class="proble_body">
                        <ul>
                           <li>
                             <div class="">
                                <img src="/static/img/icon/love.png" alt="">
                             </div>
                             <span>123</span>
                           </li>
                           <li>
                             <div class="">
                                <img src="/static/img/icon/blockx.png" alt="">
                             </div>
                             <span>5.8k</span>
                           </li>
                           <li>
                             <div class="">
                                <img src="/static/img/icon/yeai.png" alt="">
                             </div>
                             <span>15k</span>
                           </li>
                        </ul>
                        <div class="proble_body_div">
                            <p>2019宝马S1000RR升级 将采用MotoGP技术？</p>
                            <p>随着时间的推移，超级摩托车的世界越来越先进。在杜卡迪高调的推出了旗下的超跑Panigale V4后，作为摩界头部超跑的宝马感受...</p>
                            <ul>
                                <li>摩托车</li>
                                <li>精品教程</li>
                                <li>教程</li>
                            </ul>
                        </div>
                     </div>
                     <div class="Problem_UserName">
                        <p>老机友之李超说车</p>
                        <p>30分钟前</p>
                     </div>
                   </li>
                   <li>
                     <div class="proble_body">
                        <ul>
                           <li>
                             <div class="">
                                <img src="/static/img/icon/love.png" alt="">
                             </div>
                             <span>123</span>
                           </li>
                           <li>
                             <div class="">
                                <img src="/static/img/icon/blockx.png" alt="">
                             </div>
                             <span>5.8k</span>
                           </li>
                           <li>
                             <div class="">
                                <img src="/static/img/icon/yeai.png" alt="">
                             </div>
                             <span>15k</span>
                           </li>
                        </ul>
                        <div class="proble_body_div">
                            <p>2019宝马S1000RR升级 将采用MotoGP技术？</p>
                            <p>随着时间的推移，超级摩托车的世界越来越先进。在杜卡迪高调的推出了旗下的超跑Panigale V4后，作为摩界头部超跑的宝马感受...</p>
                            <ul>
                                <li>摩托车</li>
                                <li>精品教程</li>
                                <li>教程</li>
                            </ul>
                        </div>
                     </div>
                     <div class="Problem_UserName">
                        <p>老机友之李超说车</p>
                        <p>30分钟前</p>
                     </div>
                   </li>
                </ul>
            </div>
            <div class="float"></div>
        </div>
    </div>
</template>

<script>
$(function(){
  $(".Problemsection>ul>li").hover(function(){
    $(this).css({
      "backgroundColor":"#f0f0f0",
      "borderBottom":"1px solid #e6e6e6"
    })
    console.log($(this).children('div')[0])
    $(this).children('div')[0].style.borderLeft = "8px solid #15bafe"
  },function(){
    $(this).css({
      "backgroundColor":"#FFF",
      "borderBottom":"1px solid #FFF"
    })
    $(this).children('div')[0].style.borderLeft = "8px solid #FFF"
  })
})
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

<style scoped src="../../assets/css/ProblemIndexBody.css"></style>
<style lang="css">

</style>
