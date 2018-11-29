<template>
  <div class="">
    <activity-header></activity-header>
    <div class="search_actvity_box">
       <actvity-div :SearchData="max"></actvity-div>
    </div>
  </div>
</template>

<script>
import ActivityHeader from '@/components/activityHeader'
import ActvityDiv from '@/views/activity/actvityDataLi'
export default {
    data(){
      return{
        max:"1"
      }
    },
    components:{
      ActvityDiv,
      ActivityHeader,
    }
}
</script>

<style lang="css">
.search_actvity_box{
  width: 1200px;
  margin: 0 auto;
}
.search_actvity_box>ul{
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}
.search_actvity_box>ul>li{
  width: 373px;
  height: 387px;
  border:1px solid #000;
  position: relative;
  border:1px solid #dcdcdc;
  margin-bottom: 37px;
}

</style>
