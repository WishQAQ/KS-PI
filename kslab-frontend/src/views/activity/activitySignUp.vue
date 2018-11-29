<template>
    <div class="activitySignUp appBackground">
      <div class="activitySignUp_box width_1200">
        <div class="activitySignUp_title">
          <i class="icon icon-huaban4"></i>
          <p>报名结算</p>
        </div>

        <div class="activitySignUp_theRemainingTime">
          <div class="activitySignUp_time">
            <i class="icon icon-shijian"></i>
            <p><span>{{minutes}}</span>分<span>{{second}}</span>秒</p>
          </div>
          <div class="activitySignUp_title_text">
            <span>填写信息</span>
            <p>请您在规定时间内完成支付，否则订单会被自动取消</p>
          </div>
        </div>

        <div class="activitySignUp_input">
          <div>
            <span>姓名</span>
            <input v-model="conducts" type="text">
          </div>

          <div>
            <span>电话</span>
            <input v-model="telphone" type="text" placeholder="用于接受活动码">
          </div>
        </div>
        <!--<address-modal></address-modal>-->
        <div class="activityBuy">
          <div class="activityBuy_title">
            购买
          </div>

          <div class="activityBuy_center">
            <div class="activityBuy_box activityBuy_item1">
              <div class="activityBuy_box_title">
                票数
              </div>
              <div class="activityBuy_box_main">
                <i class="el-icon-remove" @click="handleReduceTicket"></i>
                <p>{{activityBuyQuantity}}</p>
                <i class="el-icon-circle-plus" @click="handleAddTicket"></i>
              </div>
            </div>

            <div class="activityBuy_box activityBuy_item2">
              <div class="activityBuy_box_title">
                单价
              </div>
              <div class="activityBuy_box_main">
                <p><span>&yen;</span>{{activityBuyUnitPrice}}</p>
              </div>
            </div>

            <div class="activityBuy_box activityBuy_item2">
              <div class="activityBuy_box_title">
                总价
              </div>
              <div class="activityBuy_box_main">
                <p><span>&yen;</span>{{activityBuyTotalPrice}}</p>
              </div>
            </div>
          </div>

        </div>

        <div class="activityBuyPay">
          <div class="activityBuyPay_title">
            支付方式
          </div>

          <div class="activityBuyPay_box">
            <el-radio-group v-model="payType" class="activityBuyPay_box_radio" @change="handlePayType">
              <el-radio label="wxpay" border><i class="icon icon-weixinzhifu" style="color: #62b900"></i>微信支付</el-radio>
              <el-radio label="alipay" border><i class="icon icon-zhifubao" style="color:#00aaee;"></i>支付宝支付</el-radio>
              <el-radio label="balance" border><i class="icon icon-qiandai" style="color: #15bafe"></i>余额支付</el-radio>
            </el-radio-group>
            <div class="activityBuyPay_box_money">
              <p><span>余额：</span>&yen;{{balance}}</p>
            </div>
          </div>

          <div class="activityBuyPay_box_totalPrice">
            <p>应付金额：</p>
            <p><span>&yen;</span>{{activityBuyTotalPrice}}</p>
          </div>

          <div class="activityBuyPay_button">
            <el-button type="primary" plain @click="handleBack">取消</el-button>
            <el-button type="primary" @click="handleSubmit">支付</el-button>
          </div>
        </div>

      </div>
      <wallet-pay :parameter="parameter" ref="walletVisible"></wallet-pay>
      <!--<el-dialog title="扫描二维码" width="290px" :visible.sync="qrCodeVisible">
        <div id="qrcode_active" ref="qrcodes" class="img_qrcode"></div>
        <div slot="footer" class="dialog-footer">
          <el-button @click="qrCodeVisible = false">取 消</el-button>
          <el-button type="primary" @click="qrCodeVisible = false">确 定</el-button>
        </div>
      </el-dialog>-->
      <qr-code :content="qrUrl" ref="qrcode"></qr-code>
    </div>
</template>

<script>
  import AddressModal from '@/components/shippingAddress'
  import WalletPay from '@/components/walletPay'
  import QrCode from '@/components/qrCode'
    export default {
        name: "activitySignUp",
      components: {
        AddressModal,
        WalletPay,
        QrCode
      },
      data(){
          return{
            activityBuyPay:'',

            activityBuyQuantity: 1,  //数量
            activityBuyUnitPrice: 0,  //单价
            activityBuyTotalPrice: 0,  //总价

            minutes:30,
            second:'00',
            queryId: '',
            model: '',
            orderData: {}, //生成的订单
            telphone: '', //联系电话
            conducts: '', //联系人
            currentIndex: null,
            payType: null, //支付类型
            orderId: '', //订单号
            balance: '', //余额
            parameter: {}, //传递的参数
            qrCodeVisible: false, //支付二维码生成弹窗
            qrUrl: '', //二维码连接
            timer: null,
            times: 600
          }
      },
      created() {
        this.queryId = this.$route.query.id;
        const param = {
          type: 'actives',
          product: {}
        };
        param.product[this.queryId] = this.activityBuyQuantity;
        console.log(param)
        this.createOrder(param);
      },
      methods: {
        /***
         * 票数减
          */
        handleReduceTicket() {
          if(this.activityBuyQuantity >1) {
            this.activityBuyQuantity -= 1;
            this.activityBuyTotalPrice = (this.activityBuyQuantity * this.activityBuyUnitPrice).toFixed(2);
            const param = {
              type: 'actives',
              product: {}
            };
            param.product[this.queryId] = this.activityBuyQuantity;
            this.createOrder(param);
          }else {
            this.$message.warning('票数不能小于1')
          }
        },
        /***
         * 票数加
         */
        handleAddTicket() {
          this.activityBuyQuantity += 1;
          this.activityBuyTotalPrice = (this.activityBuyQuantity * this.activityBuyUnitPrice).toFixed(2);
          const param = {
            type: 'actives',
            product: {}
          };
          param.product[this.queryId] = this.activityBuyQuantity;
          this.createOrder(param);
        },
        /***
         * 生成订单
         * @param param
         */
        createOrder(param) {
          console.log(param);
          this.HttpClient.post('/companyOrders/createOrder',param).then(res =>{
            console.log(res.data)
            if(res.data.code === 200) {
              this.orderData = res.data;
              this.activityBuyUnitPrice = res.data.price;
              this.orderId = res.data.orderId;
              this.balance = res.data.balance;
              this.activityBuyTotalPrice = (this.activityBuyQuantity * this.activityBuyUnitPrice).toFixed(2);
            }
          })
        },
        /***
         * 去支付
         */
        handleSubmit() {
          let param;
          console.log(this.payType)
          if(this.payType === 'balance') {
            param = {
              pay_type: this.payType,
              order_type: 'actives',
              order_id: this.orderId,
              conducts: this.conducts,
              telphone: this.telphone,
            };
            this.parameter = param;
            this.$refs.walletVisible.walletPay = true;
          }else if(this.payType === 'wxpay') { // 微信支付
            param = {
              conducts: this.conducts,
              telphone: this.telphone,
              pay_type: this.payType,
              order_type: 'actives',
              order_id: this.orderId,
            };
            this.HttpClient.post('/companyOrders/pay',param).then(res =>{
              if(res.data.code === 200) {
                this.qrUrl = res.data.url;
                // this.qrCodeVisible = true;
                this.$refs.qrcode.qrCodeVisible = true;
                this.timer = setInterval(() =>{
                  const param = {
                    order_id: this.orderId,
                    order_type: 'actives'
                  };
                  this.times --;
                  if(this.times<1) {
                    clearInterval(this.timer);
                  }else {
                    this.HttpClient.get('/orders/checkStatus',param).then(res =>{
                      if(res.data.code === 200) {
                        this.$refs.qrcode.qrCodeVisible = false;
                        this.$message.success(res.data.msg);
                        clearInterval(this.timer);
                      }
                    })
                  }

                },3000)
              }else {
                this.$message.error(res.data.msg)
              }
            })
          }else if(this.payType === 'alipay') { //支付宝支付
            param = {
              conducts: this.conducts,
              telphone: this.telphone,
              pay_type: this.payType,
              order_type: 'actives',
              order_id: this.orderId,
            };
            this.HttpClient.post('/companyOrders/pay',param).then(res =>{
              console.log(res.data)
              if(res.data.code === 200) {
                const alipayUrl = res.data.url;
                window.location.href = alipayUrl;
              }else {
                this.$message.error(res.data.msg)
              }
            })
          }

        },
        /**
         * 返回上一页
         */
        handleBack() {
          this.$router.go(-1)
        },
        handlePayType(value) {
          console.log(value)
          this.payType = value;
        },
        /***
         * 初始化二维码
         */
        handleQrCode() {
          let qrcode = new QRCode('qrcode_active', {
            width: 200,
            height: 200,
            text: 'weixin://wxpay/bizpayurl?pr=HQKCtl3',//this.qrUrl
          });
          /*console.log(qrcode)*/
        }
      },
      mounted(){
        let timer=setInterval(()=>{
          if(this.second==='00'){
            this.second=59;
            this.minutes--;
            if (this.minutes < 10) {
              this.minutes = "0" + this.minutes
            } else if (this.minutes === 0) {
              this.second = 0;
              clearInterval(timer)
            }
          }else {
            this.second--;
            if (this.second < 10) {
              this.second = "0" + this.second
            }
          }
        },1000)
      },
    }
</script>

<style lang="less">
  .img_qrcode{
    width: 100%;
    height: 200px;
    text-align: -webkit-center;
  }
  .activitySignUp{
    .activitySignUp_box{
      margin: 30px auto;
      box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
      padding: 20px 30px;
      background-color: #fff;

      .activitySignUp_title{
        display: flex;
        align-items: baseline;
        justify-content: center;
        .icon{
          font-size: 44px;
          color: #15bafe;
          margin-right: 10px;
        }
        p{
          font-size: 20px;
          color: #333;
          position: relative;
          top: -5px;
        }
      }
      .activitySignUp_theRemainingTime{
        text-align: right;
        border-bottom: 1px solid #dedede;
        padding-bottom: 5px;

        .activitySignUp_time{
          display: flex;
          justify-content: flex-end;
          align-items: baseline;
          .icon{
            color: #15bafe;
            font-size: 22px;
            margin-right: 10px;
          }
          p{
            font-size: 12px;
            color: #333;
            span{
              font-size: 16px;
              color: #333;
              margin-right: 5px;
            }
          }
        }
        .activitySignUp_title_text{
          display: flex;
          justify-content: space-between;
          align-items: center;
          p{
            color: #999;
            font-size: 12px;
          }
          span{
            font-size: 16px;
            color: #333;
          }
        }
      }

      .activitySignUp_input{
        display: flex;
        align-items: center;
        margin-top: 20px;

        span{
          font-size: 14px;
          color: #333;
          margin-right: 10px;
        }
        input{
          height: 30px;
          font-size: 12px;
          border: 1px solid #dedede;
          border-radius: 5px;
          padding-left: 10px;
          min-width: 320px;
        }

        div:nth-child(1){
          margin-right: 50px;
        }

      }

      .activityBuy{
        margin-top: 30px;
        .activityBuy_title{
          font-size: 16px;
          color: #333;
          border-bottom: 1px solid #dedede;
          padding-bottom: 5px;
          margin-bottom: 20px;
        }
        .activityBuy_center{
          display: flex;
          align-items: center;

          .activityBuy_box:not(:last-child){
            margin-right: 30px;
          }

          .activityBuy_box{
            border: 1px solid #dedede;
            width: 210px;

            .activityBuy_box_title{
              text-align: center;
              border-bottom: 1px solid #dedede;
              padding: 5px 0;
              font-size: 14px;
              color: #333;
            }
            .activityBuy_box_main{
              display: flex;
              justify-content: center;
              align-items: center;
              height: 120px;

              i{
                font-size: 30px;
                color: #dedede;
                cursor: pointer;
              }
              i:hover{
                color: #15bafe;
              }
              p{
                margin: 0 50px;
              }
            }
          }

          .activityBuy_item1{
            p{
              font-size: 20px;
              color: #333;
            }
          }

          .activityBuy_item2{
            p{
              font-size: 36px;
              color: #15bafe;
              span{
                font-size: 14px;
                color: #15bafe;
                font-weight: bold;
              }
            }
          }

        }
      }

      .activityBuyPay{
        .activityBuyPay_title{
          font-size: 16px;
          color: #333;
          border-bottom: 1px solid #dedede;
          margin-top: 30px;
          padding-bottom: 5px;
        }
        .activityBuyPay_box{
          margin-top: 20px;
          display: flex;
          align-items: center;
          .el-radio{
            font-size: 16px;
            color: #000;
            padding: 10px 20px;
            height: auto;
            .el-radio__input{
              display: none;
            }
            .el-radio__label{
             padding-left: 0;
            }
          }
          .icon{
            margin-right: 10px;
            font-size: 18px;
          }

          .activityBuyPay_box_money{
            margin-left: 50px;
            p{
              font-size: 24px;
              color: #222;
            }
            span{
              font-size: 14px;
              color: #333;
            }
          }
        }

        .activityBuyPay_box_totalPrice{
          display: flex;
          align-items: baseline;
          p:nth-child(1){
            font-size: 14px;
            color: #333;
          }
          p:nth-child(2){
            font-size: 36px;
            color: #15bafe;
            span{
              font-size: 12px;
              color: #15bafe;
            }
          }
        }

        .activityBuyPay_button{
          display: flex;
          align-items: center;
          justify-content: flex-end;
        }
      }
    }
  }
</style>
