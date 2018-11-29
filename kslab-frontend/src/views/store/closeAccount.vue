<template>
    <div class="close_account">
        <div class="shopping_close_account">
            <div class="close_account_title">
                <h1 class="logo"><img src="/static/img/logo/logo_sm.png" alt=""></h1>
                <span class="close_account_title_txt">结算页</span>
            </div>
            <div class="close_account_body">
                <div class="close_account_consignee">
                    <div class="consignee_info">
                        <span class="consignee_info_txt">收件人信息</span>
                        <div class="account_count_down">
                            <i class="icon icon-shijian"></i>
                            <span class="count_down">
                                <span class="count_down_minutes">{{minutes}}</span>分<span class="count_down_second">{{second}}</span>秒
                            </span>
                            <p class="count_down_txt">请您在规定事件内完成支付，否则订单将会被自动取消</p>
                        </div>
                    </div>
                    <shipping-address @getAddressId="getAddress"></shipping-address>
                    <!--<ul class="consignee_address_list">-->
                        <!--<li class="address_item" v-for="(addr,index) in newList" :key="index">-->
                            <!--<span class="address_detail" :class="{select:selected===index}" @click="handleSelected(index,addr)">-->
                                <!--{{addr.conducts+' '+addr.detail+' '+addr.telphone.slice(0,3)+'****'+addr.telphone.slice(-4)}}-->
                                <!--<i class="icon icon_selectTriangle" v-show="selected===index">-->
                                    <!--<i class="el-icon-check "></i>-->
                                <!--</i>-->
                            <!--</span>-->
                            <!--<span class="consignee_address_modification">-->
                                <!--<i class="icon icon-ziyuan17" @click="showPayment({item:addr})"></i>-->
                              <!--<i class="icon icon-delete"></i>-->
                            <!--</span>-->
                        <!--</li>-->
                    <!--</ul>-->
                    <!--<p class="address_empty" v-if="address.length<=0">暂无收件人信息</p>-->
                    <!--<el-button type="primary" plain @click="showPayment">新增地址</el-button>-->
                    <!--<a href="javascript:;" class="show_more" v-show="this.address.length>3 && this.newList.length<=3" @click="loadMore">展示更多</a>-->
                </div>
                <div class="close_account_payment">
                    <div class="payment_method">支付方式</div>
                    <ul class="payment_list">
                        <li class="payment_item" :class="{active:paymentIndex===index}" v-for="(tmp,index) in payment" :key="index" @click="selectedPayment(tmp.name,index)">
                            <img :src="tmp.img" class="payment_pic">
                            <span class="payment_txt">{{tmp.name}}</span>
                            <i class="icon icon_selectTriangle" v-show="paymentIndex===index">
                                <i class="el-icon-check "></i>
                            </i>
                        </li>
                    </ul>
                    <span class="account_balance">
                        <span class="account_balance_txt">账户余额:</span>
                        <span class="account_balance_num">{{balance.toFixed(2)}}</span>
                    </span>
                </div>
                <div class="amount_payable">
                    <span class="amount_payable_txt">应付金额:</span>
                    <span class="amount_payable_num">¥{{totalPrice.toFixed(2)}}</span>
                </div>
                <div class="payment_confirm">
                    <span class="payment_cancel" :class="{active:!active}" @mouseenter="confirmBtn($event)" @click="goBack">取消</span>
                    <span class="payment_pay" :class="{active}" @mouseenter="confirmBtn($event)" @click="goPayment">支付</span>
                </div>
            </div>
        </div>
        <!--<div class="payment_mask" v-show="isShow">-->
            <!--<div class="mask"></div>-->
            <!--<div class="payment_mask_box">-->
                <!--<div class="payment_mask_title">-->
                    <!--<h2 class="logo"><img src="/static/img/logo/logo_block.png" alt=""></h2>-->
                    <!--<span class="close" @click="handleClose"><i class="el-icon-close"></i></span>-->
                <!--</div>-->
                <!--<div class="add_shipping_address">-->
                    <!--<div class="add_form_title">新增收货地址</div>-->
                    <!--<el-form ref="form" :model="form" label-width="80px" label-position="left">-->
                        <!--<el-form-item label="收货人"-->
                                      <!--prop="conducts"-->
                                      <!--:rules="[-->
                                          <!--{ required: true, message: '收货人不能为空'}-->
                                      <!--]">-->
                            <!--<el-input v-model="form.conducts"></el-input>-->
                        <!--</el-form-item>-->
                        <!--<el-form-item label="详细地址"-->
                                      <!--prop="detail"-->
                                      <!--:rules="[-->
                                          <!--{ required: true, message: '地址不能为空'}-->
                                      <!--]">-->
                            <!--<el-input type="textarea" v-model="form.detail"></el-input>-->
                        <!--</el-form-item>-->
                        <!--<el-form-item-->
                                <!--label="电话"-->
                                <!--prop="telphone"-->
                                <!--:rules="[-->
                                    <!--{ required: true, message: '电话不能为空'},-->
                                    <!--{ type: 'number', message: '电话必须为数字值'},-->
                                    <!--{ pattern: /^1[34578]\d{9}$/, message:'请输入正确的手机号码' }-->
                                <!--]">-->
                            <!--<el-input type="age" v-model.number="form.telphone" auto-complete="off"></el-input>-->
                        <!--</el-form-item>-->
                        <!--<el-form-item style="text-align:right;">-->
                            <!--<el-button type="primary" @click="submitForm('form',form)">保存</el-button>-->
                        <!--</el-form-item>-->
                    <!--</el-form>-->
                <!--</div>-->
            <!--</div>-->
        <!--</div>-->
        <!--<div class="payment_mask" v-show="walletPay">-->
            <!--<div class="mask"></div>-->
            <!--<div class="wallet_pay">-->
                <!--<div class="payment_mask_title">-->
                    <!--<h2 class="logo"><img src="/static/img/logo/logo_block.png" alt=""></h2>-->
                    <!--<span class="close" @click="handleClose"><i class="el-icon-close"></i></span>-->
                <!--</div>-->
                <!--<div class="verification_phone">-->
                    <!--<div class="forget_phone" @click="authenticationId">忘记手机号码</div>-->
                    <!--<div class="verification_phone_box">-->
                        <!--<div class="verification_phone_input">-->
                            <!--<div class="phone_num">-->
                                <!--<span class="phone_num_txt">手机验证</span>-->
                                <!--<el-input placeholder="请输入手机号码" type="number" v-model="vPhone" :suffix-icon="suffixIcon" @input="testPhone">-->
                                    <!--<template slot="prepend">+86</template>-->
                                <!--</el-input>-->
                            <!--</div>-->
                            <!--<div class="verification_num">-->
                                <!--<el-input placeholder="请输入验证码" v-model="verification" class="input-with-select" :disabled="!isGetVerification">-->
                                    <!--<el-button slot="append" :class="{active:isPhone}" @click="getVerification">获取验证码</el-button>-->
                                <!--</el-input>-->
                            <!--</div>-->
                        <!--</div>-->
                        <!--<div class="confirm_control">-->
                            <!--<span class="cancel" :class="{active:!isActive}" @click="handleClose" @mouseenter="changeActive($event)">取消</span>-->
                            <!--<span class="confirm" :class="{active:isActive && !isDisabled,disabled:isDisabled}" @click="wallet" @mouseenter="changeActive($event)">确定</span>-->
                        <!--</div>-->
                    <!--</div>-->
                <!--</div>-->
            <!--</div>-->
        <!--</div>-->
        <wallet-pay ref="walletPay" :parameter="parameter"></wallet-pay>
    </div>
</template>

<script>

    import ShippingAddress from '@/components/shippingAddress'
    import WalletPay from '@/components/walletPay'

    export default {
        name: "closeAccount",
        data(){
            return {
                orderId:'',//订单id
                address:[
                    {conducts:'陈C',detail:'重庆 南岸区 保利观塘-南坪镇渝南分流道保利观塘',telphone:'18795761523'},
                    {conducts:'陈C',detail:'重庆 南岸区 保利观塘-南坪镇渝南分流道保利观塘',telphone:'18795761523'},
                    {conducts:'陈C',detail:'重庆 南岸区 保利观塘-南坪镇渝南分流道保利观塘',telphone:'18795761523'},
                    {conducts:'陈C',detail:'重庆 南岸区 保利观塘-南坪镇渝南分流道保利观塘',telphone:'18795761523'},
                    {conducts:'陈C',detail:'重庆 南岸区 保利观塘-南坪镇渝南分流道保利观塘',telphone:'18795761523'},
                ],//收件人地址
                addressId:'',//已选收件地址id
                newList:[],//初始显示收件地址
                selected:0,
                selectedAddress:'',//已选择收件地址
                payment:[//支付方式
                    {name:'微信支付',img:'/static/img/icon/weChat_pay.png'},
                    {name:'支付宝支付',img:'/static/img/icon/Alipay_sm.png'},
                    {name:'余额支付',img:'/static/img/icon/wallet.png'}
                ],
                paymentMethod:'',//已选择支付方式
                paymentIndex:0,//已选择支付方式下标
                totalPrice:0,//支付金额
                balance:0,//账户余额
                active:true,
                isShow:false,
                form: {
                    conducts: '',
                    detail: '',
                    telphone:''
                },
                walletPay:false,//是否余额支付
                vPhone:'',//手机号
                verification:'',//手机验证码
                isPhone:false,
                isActive:true,
                isDisabled:true,
                isGetVerification:false,//获取验证码
                suffixIcon:null,
                isAuthentication:true,
                minutes:30,//倒计时：分
                second:'00',//倒计时：秒
                parameter:{
                    pay_type:'',
                    order_type:'',
                    order_id:'',
                    from_cart:1,
                    address_id:''
                },//支付参数
            }
        },
        components:{
            ShippingAddress,
            WalletPay
        },
        methods:{
            //获取已选地址id
            getAddress(id){
                this.addressId=id;
            },
            handleSelected(index,addr){
                this.selected=index;
                this.selectedAddress=addr;
            },
            // 展示更多地址
            loadMore(){
                this.newList=this.address;
            },
            selectedPayment(tmp,index){
                this.paymentMethod=tmp;
                this.paymentIndex=index;
            },
            confirmBtn(event){
                if(!$(event.currentTarget).is('.active')){
                    this.active = !this.active;
                }
            },
            goBack(){
                this.$router.go(-1);
            },
            goPayment(){
                this.parameter={
                    pay_type:'wxpay',
                    order_type:'products',
                    order_id:this.orderId,
                    from_cart:1,
                    address_id:this.addressId
                };
                if(this.paymentMethod==='余额支付'){
                    this.$refs.walletPay.walletPay=true;
                    this.parameter.pay_type='balance';
                }else{
                    if(this.paymentMethod==='支付宝支付'){
                        this.parameter.pay_type='alipay'
                    }else{
                        this.parameter.pay_type='wxpay'
                    }
                    this.HttpClient.post('/companyOrders/pay',this.parameter)
                        .then(res=>{
                            console.log(res);
                        })
                }

            },
            showPayment({item}){
                this.isShow=true;
                if(item) {
                    this.form.conducts=item.conducts;
                    this.form.detail=item.detail;
                    this.form.telphone=parseInt(item.telphone);
                }else{
                    this.form.conducts='';
                    this.form.detail='';
                    this.form.telphone='';
                }
            },
            submitForm(formName,form) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.form=form;
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
        },
        watch:{
            verification:function(newValue,oldValue){
                this.isDisabled=newValue==='';
            },
        },
        created(){
            console.log(this.$route.query.product);
            if(this.$route.query.result) {
                let {settlementAmount,addresses,balance} = this.$route.query.result;
                this.totalPrice = parseFloat(settlementAmount);
                this.balance = parseFloat(balance);
                this.address = addresses;
                console.log(addresses);
            }
            this.HttpClient.post('/companyOrders/createOrder',{type:'products',product:this.$route.query.product})
                .then(res=>{
                    console.log(res);
                    let {code,balance,addresses,totalPrice,orderId} = res.data;
                    if(code===200){
                        this.totalPrice = parseFloat(totalPrice);
                        this.balance = parseFloat(balance);
                        this.address = addresses;
                        this.orderId=orderId;
                    }
                })
        },
        mounted(){
            this.selectedAddress=this.address[this.selected];
            this.paymentMethod=this.payment[this.paymentIndex].name;
            for(let i in this.address){
                if(i<3) {
                    this.newList.push(this.address[i]);
                }
            }
            //倒计时
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
        }
    }
</script>

<style scoped>
    .close_account{
        height:100vh;
    }
    .close_account::-webkit-scrollbar{}
    .shopping_close_account{
        width:1200px;
        margin:0 auto;
        /*min-height:95.9vh;*/
    }
    .close_account_title{
        margin:0 auto;
        padding-top:30px;
        text-align:center;
    }
    .logo{
        display:inline-block;
    }
    .close_account_title_txt{
        font-size: 26px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 3px;
        color: #141414;
        opacity: 0.86;
        margin-left:20px;
    }
    .close_account_body{
        margin:0 40px;
    }
    .close_account_consignee{
        position:relative;
    }
    .close_account_consignee .consignee_info,
    .close_account_payment .payment_method{
        font-size: 20px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 2px;
        color: #141414;
        opacity: 0.84;
        padding-bottom:8px;
        border-bottom:1px solid #ccc;
    }
    .close_account_consignee .consignee_info{
        display:flex;
        justify-content:space-between;
        align-items: flex-end;
    }
    .close_account_consignee .consignee_info .account_count_down{
        text-align:right;
    }
    .close_account_consignee .consignee_info .icon-shijian{
        color:#15bafe;
        font-size:24px;
        vertical-align:middle;
    }
    .close_account_consignee .consignee_info .count_down{
        font-size:12px;
        vertical-align:sub;
    }
    .close_account_consignee .consignee_info .count_down_minutes,
    .close_account_consignee .consignee_info .count_down_second{
        font-size:20px;
    }
    .close_account_consignee .consignee_info .count_down_txt{
        color:#999;
        font-size:12px;
    }
    .close_account_payment .payment_method{
        margin-top:35px;
    }
    .close_account_consignee .consignee_address_list{
        margin-top:18px;
    }
    .close_account_consignee .consignee_address_list .address_detail{
        display:inline-block;
        position:relative;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 2px;
        color: #141414;
        cursor:pointer;
        padding:10px 165px 10px 19px;
        border:1px solid transparent;
        overflow:hidden;
        vertical-align:middle;
    }
    .close_account_consignee .consignee_address_list .address_detail.select{
        border-color:#15bafe;
        border-radius:3px;
    }
    .icon_selectTriangle{
        position:absolute;
        bottom:-1px;
        right:-2px;
        width:21px;
        height:20px;
        color:#fff;
        font-weight:800;
        text-align:right;
        padding-top:2px;
    }
    .close_account_consignee .consignee_address_list .consignee_address_modification{
        display:inline-block;
        width: 75px;
        margin-left:177px;
        overflow:hidden;
        vertical-align:middle;
    }
    .close_account_consignee .consignee_address_list .icon-ziyuan17,
    .close_account_consignee .consignee_address_list .icon-delete{
      font-size: 16px;
        position:relative;
        cursor:pointer;
        box-sizing:initial;
      margin-right: 15px;
      color: #ccc;
    }

    .close_account_consignee .consignee_address_list .icon-ziyuan17:hover,
    .close_account_consignee .consignee_address_list .icon-delete:hover{
      color: #15befe;
    }
    .close_account_consignee .el-button{
        position:absolute;
        right:0;
        top:80px;
    }
    .close_account_consignee .el-button.is-plain{
        color:#666;
        background:#fff;
        border-color:#ccc;
        opacity:.9;
    }
    .close_account_consignee .el-button.is-plain:hover{
        color:#fff;
        background:#15bafe;
        border-color:#15bafe;
    }
    .close_account_consignee .address_empty{
        color:#ccc;
        font-size:14px;
    }
    .close_account_consignee .show_more{
        display:block;
        margin-top:27px;
        font-size:14px;
    }

    .close_account_payment{
        position:relative;
    }
    .close_account_payment .payment_list{
        margin-top:37px;
    }
    .close_account_payment .payment_item{
        display:inline-block;
        position:relative;
        margin-right:31px;
        padding:14px 36px;
        border:1px solid #ccc;
        border-radius:3px;
        cursor:pointer;
    }
    .close_account_payment .payment_item:hover{
        border-color:#15bafe;
    }
    .close_account_payment .payment_item.active{
        border-color:#15bafe;
    }
    .close_account_payment .payment_item .payment_pic{
        width:20px;
        height:20px;
        margin-left:7px;
        vertical-align:middle;
    }
    .close_account_payment .payment_item .payment_txt{
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 2px;
        color: #2a2a2a;
        vertical-align:middle;
    }
    .close_account_payment .account_balance{
        position:absolute;
        bottom:0;
        right:340px;
        font-size:16px;
    }
    .close_account_body .amount_payable{
        float:left;
        margin-top:37px;
    }
    .close_account_body .amount_payable .amount_payable_txt{
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #191919;
    }
    .close_account_body .amount_payable .amount_payable_num{
        font-size: 24px;
        font-weight: normal;
        letter-spacing: 0;
        color: #15bafe;
    }
    .close_account_body .payment_confirm{
        float:right;
        margin-top:40px;
        margin-bottom:102px;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #15bafe;
    }
    .close_account_body .payment_confirm span{
        padding:3px 24px;
        border:1px solid #15bafe;
        border-radius:5px;
        cursor:pointer;
    }
    .close_account_body .payment_confirm .payment_cancel{
        margin-right:15px;
    }
    .close_account_body .payment_confirm span.active{
        color:#fff;
        background:#15bafe;
    }
</style>
