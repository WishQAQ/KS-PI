<template>
   <div class="uploading_main_item uploading_main_price up_price">
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
              <input v-model="price" @change="handlePrice" type="text" class="main_price_num">
          </span>
    </div>
   </div>
</template>

<script>
export default {
  name: "uploadingMainPrice",
  data(){
    return {
      selectedValue:'fixed',
      price: null
    }
  },
  props: ["isSelect",'servicePriceData'],
  watch: {
    servicePriceData: {
      handler(newData, oldData) {
        console.log(newData, oldData)
        this.price = newData.price
      },
      deep: true
    }
  },
  methods: {
    handlePrice(e) {
      let prices = null;
      console.log(e.target.value,this.price)
      if(this.price!=='' && this.price!==null) {
        prices = Number(this.price);
      }else {
        prices = 0;
      }
      this.$store.dispatch('getServiceUploadData',{price: prices}).then(res=>{
        console.log(this.$store.state.serviceUpload.serviceUploadData)
      });
    }
  }
}
</script>

<style scoped lang="less">
.up_price{
  margin-top: 20px;
}
</style>
