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
  props: ["isSelect","currentPrice"],
  methods: {
    handlePrice(e) {
      let prices = null;
      console.log(e.target.value,this.price);
      if(this.price!=='' && this.price!==null) {
        if(this.price>this.currentPrice){
            prices = Number(this.price);
        }else{
            prices=this.price=this.currentPrice;
            this.$message.error('价格不能比之前价格低！')
        }
      }else {
        prices = 0;
      }
      this.$store.dispatch('getActivityUploadData',{price: prices}).then(res=>{
        console.log(this.$store.state.activityUpload.activityUploadData)
      });
    }
  },
  mounted(){
    console.log(this.price);
  },
  watch:{
      currentPrice: {
          handler() {
              console.log(this.currentPrice);
              this.price = this.currentPrice
          },
          immediate: true
      },
  }
}
</script>

<style scoped lang="less">
.up_price{
  margin-top: 20px;
}
</style>
