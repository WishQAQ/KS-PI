<template>
    <el-dialog :visible.sync="walletPay" custom-class="payment_mask" width="534px">
        <div class="wallet_pay">
            <div class="payment_mask_title">
                <h2 class="logo"><img src="/static/img/logo/logo_block.png" alt=""></h2>
                <span class="close" @click="handleClose"><i class="el-icon-close"></i></span>
            </div>
            <div class="verification_phone">
                <div class="forget_phone" @click="authenticationId">忘记手机号码</div>
                <div class="verification_phone_box">
                    <div class="verification_phone_input">
                        <div class="phone_num">
                            <span class="phone_num_txt">手机验证</span>
                            <el-input placeholder="请输入手机号码" type="number" v-model="vPhone" :suffix-icon="suffixIcon" @input="testPhone">
                                <template slot="prepend">+86</template>
                            </el-input>
                        </div>
                        <div class="verification_num">
                            <el-input placeholder="请输入验证码" v-model="verification" class="input-with-select" :disabled="!isGetVerification">
                                <el-button slot="append" :class="{active:isPhone}" @click="getVerification">获取验证码</el-button>
                            </el-input>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="confirm_control" slot="footer">
            <span class="cancel" :class="{active:!isActive}" @click="handleClose" @mouseenter="changeActive($event)">取消</span>
            <span class="confirm" :class="{active:isActive && !isDisabled,disabled:isDisabled}" @click="wallet" @mouseenter="changeActive($event)">确定</span>
        </div>
    </el-dialog>
</template>

<script>
    export default {
        name: "walletPay",
        data(){
            return {
                walletPay:false,//是否显示
                vPhone:'',//手机号
                verification:'',//手机验证码
                isPhone:false,
                isActive:true,
                isDisabled:true,
                isGetVerification:false,//获取验证码
                suffixIcon:null,
                parameters:{},//支付参数
            }
        },
        props:['parameter'],//支付所需参数
        methods:{
            //关闭弹窗
            handleClose(){
                this.isShow=false;
                this.walletPay=false;
                if(!this.walletPay){
                    this.vPhone='';
                    this.verification='';
                }
            },
            //是否绑定身份证
            authenticationId(){
                if(this.isAuthentication){
                    this.$router.push({
                        path:'authentication'
                    })
                }else{
                    this.$router.push({
                        path:'idCardAuthentication'
                    })
                }
            },
            //验证手机号
            testPhone(value){
                if(value) {
                    let reg = /1[35789]\d{9}/;
                    if (reg.test(value)) {
                        this.suffixIcon = 'el-icon-success';
                        this.isPhone=true;
                    } else {
                        this.suffixIcon = 'el-icon-error';
                        this.isPhone=false;
                    }
                }else{
                    this.suffixIcon=null;
                    this.isPhone=false;
                }
            },
            //获取手机验证码
            getVerification(){
                if(this.isPhone) {
                    this.isGetVerification = true;
                    this.isDisabled=false;
                    this.HttpClient.post('/companyOrders/sendVerifyCode',{mobile:this.vPhone,type:1})
                        .then(res=>{
                            console.log(res);
                            if(res.data.code===200){
                                this.$message.success(res.data.msg)
                            }
                        })
                }
            },
            //按钮样式变化
            changeActive(e){
                if(!$(e.currentTarget).is('.active')){
                    if(!$(e.currentTarget).is('.disabled')) {
                        this.isActive = !this.isActive
                    }
                }
            },
            //支付
            wallet(){
                if(!this.isDisabled){
                    this.parameters.mobile=this.vPhone;
                    this.parameters.verify_code=this.verification;
                    console.log(this.parameters);
                    this.HttpClient.post('/companyOrders/pay',this.parameters)
                        .then(res=>{
                            console.log(res);
                            if(res.data.code===200){
                                this.$message.success(res.data.msg);
                                this.walletPay=false
                            }else{
                                this.$message.error(res.data.msg)
                            }
                        });
                }
            },
        },
        watch:{
            parameter:{
                handler(n,o){
                    console.log(n);
                    console.log(o);
                    console.log(this.parameter);
                    this.parameters=this.parameter
                },
                deep:true,
                immediate:true,
            }
        }
    }
</script>

<style scoped>
    .payment_mask .payment_mask_box,
    .payment_mask .wallet_pay{
        width:587px;
        padding:10px 16px 20px;
        background:#fff;
        z-index:99;
    }
    .payment_mask .payment_mask_title{
        padding-bottom:7px;
        border-bottom:1px solid #ccc;
    }
    .payment_mask .payment_mask_title .logo{
        display:inline-block;
    }
    .payment_mask .payment_mask_title .close{
        float:right;
        color:#ccc;
        font-size:14px;
        cursor:pointer;
    }
    .payment_mask .payment_mask_title .close:hover{
        color:#aaa;
    }
    .payment_mask .add_form_title{
        margin:14px 0 34px 12px;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 2px;
        color: #141414;
        opacity: 0.85;
    }
    .payment_mask .wallet_pay{
        width:534px;
        height:281px;
        margin:0 auto;
    }
    .payment_mask .wallet_pay .verification_phone{
        width:416px;
        margin:30px auto 0;
        text-align:right;
    }
    .payment_mask .wallet_pay .verification_phone .forget_phone{
        font-size: 12px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 1px;
        color: #15bafe;
        opacity: 0.85;
        cursor:pointer;
        serviceComment-select:none;
    }
    .payment_mask .wallet_pay .verification_phone .phone_num{
        display:flex;
        justify-content:space-between;
        margin-top:12px;
    }
    .payment_mask .wallet_pay .verification_phone .phone_num_txt{
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 2px;
        color: #141414;
        opacity: 0.85;
        line-height:40px;
    }
    .payment_mask .wallet_pay .verification_phone .el-input{
        width:326px;
    }
    .payment_mask .wallet_pay .verification_phone .verification_num{
        margin-top:14px;
    }
    .payment_mask .wallet_pay .verification_phone .el-input-group__append button.el-button{
        color:#fff;
        background:#989898;
        border:1px solid #989898;
        border-radius:0 3px 3px 0;
    }
    .payment_mask .wallet_pay .verification_phone .el-input-group__append button.el-button.active{
        background:#15bafe;
        border-color:#15bafe;
    }
    .payment_mask .confirm_control{
        position:absolute;
        right:10px;
        bottom:20px;
        /*margin-top:30px;*/
    }
    .payment_mask .confirm_control span{
        padding:5px 20px;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #15bafe;
        cursor:pointer;
        border:1px solid #15bafe;
        border-radius:3px;
    }
    .payment_mask .confirm_control span.active{
        color:#fff;
        cursor:pointer;
        background:#15bafe;
        border-color:#15bafe;
    }
    .payment_mask .confirm_control .confirm.disabled{
        color:#c0c4cc;
        background:#F5F7FA;
        border-color:#c0c4cc;
        cursor:not-allowed;
    }
</style>
<style>
    .payment_mask.el-dialog{
        height:281px!important;
        background:transparent!important;
        box-shadow:none!important;
    }
    .payment_mask .el-dialog__header{
        display:none!important;
    }
    .payment_mask .el-dialog__body{
        padding:0!important;
    }
    .payment_mask .wallet_pay .verification_phone .phone_num .el-icon-error:before{
        color:#f55959;
    }
    .payment_mask .wallet_pay .verification_phone .phone_num .el-icon-success:before{
        color:#4aca6d;
    }
    .payment_mask .wallet_pay .verification_phone .phone_num input::-webkit-outer-spin-button,
    .payment_mask .wallet_pay .verification_phone .phone_num input::-webkit-inner-spin-button {
        -webkit-appearance: none;
    }
    .payment_mask .wallet_pay .verification_phone .phone_num input[type="number"]{
        -moz-appearance: textfield;
    }
</style>