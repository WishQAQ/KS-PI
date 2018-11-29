<template>
   <div class="uploading_main_item uploading_main_price">
      <div class="main_head">
          <i class="icon icon_img"></i>
          <span class="main_txt">活动费用</span>
          <!--<span class="main_txt_describe"></span>-->
      </div>
      <div class="main_price_detail">
          <select name="" id="" class="main_price_type" v-if="isSelect" v-model="selectedValue">
              <option value="fixed">固定价格</option>
              <option value="inquiry">询问价格</option>
          </select>
          <span class="main_price_input" v-show="selectedValue==='fixed'">
              <i class="icon icon_price"></i>
              <input type="text" class="main_price_num" value="500">
          </span>
    </div>
   </div>
</template>

<script>
    export default {
        name: "uploadingMainPrice",
        data(){
            return {
                selectedValue:'fixed'
            }
        },
        props:["isSelect"]
    }
</script>

<style scoped>

</style>
