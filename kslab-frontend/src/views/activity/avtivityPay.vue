<template>
    <div class="activityPay">
      <div class="activityPay_header">
        <img src="/static/img/logo/logo_block.png" alt="">
        活动报名
      </div>

      <div class="activityPayTitle">
        填写信息
      </div>

      <div class="activityPayUser">
        <div>姓名 <input type="text"></div>
        <div>电话 <input type="number" placeholder="用于接受活动码"></div>
      </div>

      <div class="activityPayTitle">
        购买
      </div>

      <div class="activityPayShopping">
        <div class="activityPayShopping_number">
          <div class="activityPay_title">票数</div>
          <div class="activityPat_center">
            <el-input-number v-model="num1" @change="handleChange" :min="1" :max="10" label="票数增减"></el-input-number>
          </div>
        </div>

        <div class="activityPayShopping_money">
          <div class="activityPay_title">单价</div>
          <div class="activityPat_center"><span>&yen;</span>100</div>
        </div>

        <div class="activityPayShopping_total">
          <div class="activityPay_title">共计</div>
          <div class="activityPat_center"><span>&yen;</span>100</div>
        </div>

      </div>


      <!--支付方式-->
      <div class="activityPayTitle">
        支付方式
      </div>
      <div class="">
        <!--微信支付-->
        <div class="activityPayWeChar">

        </div>
        <!--支付宝支付-->
        <div class="activityPayAlipay"></div>

        <!--余额支付-->
        <div class="activityPayBalance"></div>


      </div>


    </div>
</template>

<script>
    export default {
        name: "avtivityPay",
      data(){
          return{
            num1: 1
          }
      }


    }
</script>

<style scoped>

</style>
