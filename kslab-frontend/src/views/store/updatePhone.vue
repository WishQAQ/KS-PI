<template>
    <div class="update_phone">
        <section>
            <div class="update_phone_box">
                <div class="update_phone_head">
                    <img src="/static/img/logo/logo_sm.png" alt="">
                    <span class="update_phone_txt">修改手机号</span>
                </div>
                <div class="update_phone_num">
                    <div class="new_phone_num">
                        <span class="authentication_ID_title">
                            <span class="authentication_ID_title_txt">新手机号</span>
                        </span>
                        <div class="new_phone_input">
                            <el-input
                                    placeholder="请输入新手机号"
                                    v-model="newPhone">
                                <i slot="suffix" class="el-input__icon el-icon-error" v-if="newPhone"></i>
                                <template slot="prepend">+86</template>
                            </el-input>
                        </div>
                    </div>
                    <div class="phone_verification">
                        <el-input placeholder="请输入内容" v-model="verification" class="input-with-select">
                            <el-button slot="append">获取验证码</el-button>
                        </el-input>
                    </div>
                </div>
                <div class="update_phone_confirm_box">
                    <span class="update_phone_cancel" :class="{active:!isActive}" @mouseenter="changeActive($event)" @click="cancelClick">取消</span>
                    <span class="update_phone_confirm" :class="{active:isActive}" @mouseenter="changeActive($event)" @click="confirm">确定</span>
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

    export default {
        name: "updatePhone",
        data() {
            return {
                newPhone:'',
                verification:'',
                isActive:true
            }
        },
        components: {
            FloatingDiv
        },
        methods: {
            cancelClick(){
                this.showWithdraw = false
            },
            confirm(){
                this.$message.success('您点击了确定按钮！');
                this.showWithdraw = false
            },
            changeActive(e){
                if(!$(e.currentTarget).is('.active')){
                    this.isActive=!this.isActive
                }
            },
        },
    }
</script>

<style scoped>
    .update_phone_box{
        width:1200px;
        margin:0 auto;
        padding:40px 40px 240px;
        box-shadow: 0 2px 5px 0 rgba(34, 24, 21, 0.16);
        border: solid 1px #dedede;
        text-align:center;
    }
    .update_phone_head{
        padding-bottom:44px;
        text-align:center;
        border-bottom:1px solid #e6e6e6;
    }
    .update_phone_txt{
        font-size: 26px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 3px;
        color: #141414;
        opacity: 0.86;
        margin-left:20px;
        vertical-align:bottom;
    }
    .update_phone_num{
        text-align:center;
        margin-top:54px;
    }
    .authentication_ID_title{
        position:relative;
        display:inline-block;
        width:70px;
        height:30px;
        color:#fff;
        font-size:14px;
        line-height:30px;
        text-align:center;
        padding-left:5px;
        background:#15bafe;
    }
    .authentication_ID_title:after{
        position:absolute;
        top:0;
        right:-20px;
        display:inline-block;
        content:'';
        width:0;
        height:0;
        border: 15px solid transparent;
        border-right-width: 10px;
        border-left: 10px solid #15bafe;
    }
    .new_phone_input{
        display:inline-block;
        width:268px;
        height:30px;
        margin-left:19px;
    }
    .phone_verification{
        display:inline-block;
        width:357px;
        text-align:right;
        margin-top:26px;
    }
    .phone_verification .el-input-group{
        width:268px;
    }
    .phone_verification .el-button{
        color:#fff;
        padding:8px 13px;
        background:#666;
    }
    .new_phone_input .el-input__icon{
        line-height:30px;
    }
    /*************************操作按钮***************************/
    .update_phone_confirm_box{
        display:inline-block;
        width:357px;
        margin-top:70px;
        margin-right:33px;
        text-align:right;
    }
    .update_phone_confirm_box span{
        font-size: 16px;
        letter-spacing: 0;
        color: #15bafe;
        cursor:pointer;
        padding:5px 24px;
        border:1px solid #15bafe;
        border-radius:5px;
    }
    .update_phone_confirm_box span.authentication_confirm{
        margin-left:12px;
    }
    .update_phone_confirm_box span.active{
        color:#fff;
        background:#15bafe;
    }
</style>
<style>
    .update_phone_num .el-input__inner{
        height:30px;
        color:#999;
        line-height:30px;
        border:none;
        background:#f2f2f2;
    }
    .update_phone_num .el-input-group__prepend{
        border:none;
        /*border-right:1px solid #7d7d7d;*/
        background:#f2f2f2;
        font-size: 14px;
        color: #222222;
    }
    .update_phone_num .el-input-group__prepend:after{
        position:relative;
        top:0;
        left:20px;
        display:inline-block;
        content:'';
        width:0;
        height:0;
        border:.5px solid #7d7d7d;
        border-top-width:10px;
        border-bottom-width:10px;
        vertical-align:middle;
    }
</style>