<template lang="html">
    <div class="Body_img_index">
        <!-- <header-div></header-div> -->
        <car-div></car-div>
        <motuo-div></motuo-div>
        <drone-div></drone-div>
        <brain-power></brain-power>
        <!-- <footer-div></footer-div> -->
    </div>
</template>

<script>
  import FooterDiv from "@/components/footer"
  import HeaderDiv from "@/components/header"
  import CarDiv from '@/views/index/Car'
  import MotuoDiv from '@/views/index/Motorcycle'
  import DroneDiv from '@/views/index/Drone'
  import BrainPower from '@/views/index/Brainpower'
export default {
    data(){
      return{

      }
    },
    components:{
      FooterDiv,
      HeaderDiv,
      CarDiv,
      MotuoDiv,
      DroneDiv,
      BrainPower
    },
}
</script>

<!-- <style scoped src="../assets/css/kslabIndex.css"></style> -->
<style lang="css">
.Body_img_index{
  background-image: url("/static/img/Indexback.png");
  background-size: cover;
  padding-bottom: 30px;
  padding-top: 30px;
}
</style>
