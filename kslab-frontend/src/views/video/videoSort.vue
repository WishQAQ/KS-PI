<template>
    <div>
        <section class="">
          <compon-tab></compon-tab>
          <div class="videoDeta_body">
              <div class="videoDeta_title">
                  <p>推荐视频</p>
              </div>
              <div class="video_body_import">
                  <ul>
                      <li>
                        <div class="">
                            <img src="/static/img/car_title.png" alt="">
                            <img src="/static/img/icon/h_video_label.png" alt="">
                        </div>
                        <p class="video_Font_block">各种精彩有趣的汽车实验</p>
                        <ul class="tab_xxx">
                           <li>维修</li>
                           <li>汽车</li>
                           <li>汽车</li>
                        </ul>
                        <div class="videoDeta_foot">
                          <span>李超</span>
                          <div class="video_flaot">
                            <div class="">
                               <span>7月19日</span>
                            </div>
                             <div class="">
                                <img src="/static/img/icon/watch.png" alt="">
                                <span>571</span>
                             </div>
                          </div>
                        </div>
                      </li>
                      <li></li>
                      <li></li>
                      <li></li>
                  </ul>
              </div>
          </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
    </div>
</template>

<script>

    import FloatingDiv from '@/components/floating'
    import ComponTab from '@/components/Componeds_tab'

    export default {
        data(){
            return {
              
            }
        },
        components:{
            FloatingDiv,
            ComponTab
        }
    }
</script>

<style src="../../assets/css/videoSort.css">

</style>
