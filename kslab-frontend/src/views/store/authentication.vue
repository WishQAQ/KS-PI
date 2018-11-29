<template>
    <div class="authentication">
        <section>
            <div class="authentication_body">
                <div class="authentication_head">
                    <img src="/static/img/logo/logo_sm.png" alt="">
                    <span class="authentication_head_txt">身份验证</span>
                </div>
                <div class="authentication_ID">
                    <div class="authentication_ID_name">
                        <span class="authentication_ID_title">
                            <span class="authentication_ID_title_txt">姓名</span>
                        </span>
                        <el-input
                                placeholder="请输入您的姓名"
                                v-model="name">
                            <i slot="suffix" class="el-input__icon el-icon-error" v-if="name"></i>
                        </el-input>
                    </div>
                    <div class="authentication_ID_num">
                        <span class="authentication_ID_title">
                            <span class="authentication_ID_title_txt">身份证</span>
                        </span>
                        <el-input
                                placeholder="请输入身份证号码"
                                v-model="idNum">
                            <i slot="suffix" class="el-input__icon el-icon-error" v-if="idNum"></i>
                        </el-input>
                    </div>
                </div>
                <div class="authentication_confirm_box">
                    <span class="authentication_cancel" :class="{active:!isActive}" @mouseenter="changeActive($event)" @click="cancelClick">取消</span>
                    <span class="authentication_confirm" :class="{active:isActive}" @mouseenter="changeActive($event)" @click="confirm">确定</span>
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
        name: "authentication",
        data() {
            return {
                name:'',
                idNum:'',
                isActive:true
            }
        },
        components: {
            FloatingDiv
        },
        methods: {
            cancelClick(){
                // this.showWithdraw = false
            },
            confirm(){
                this.$router.push({
                    path:'updatePhone'
                })
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
    .authentication_body{
        width:1200px;
        margin:0 auto;
        padding:40px 40px 240px;
        box-shadow: 0 2px 5px 0 rgba(34, 24, 21, 0.16);
        border: solid 1px #dedede;
        text-align:center;
    }
    .authentication_head{
        padding-bottom:44px;
        text-align:center;
        border-bottom:1px solid #e6e6e6;
    }
    .authentication_head_txt{
        font-size: 26px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 3px;
        color: #141414;
        opacity: 0.86;
        margin-left:20px;
        vertical-align:bottom;
    }
    .authentication_ID{
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
    .authentication_ID_title_txt{
        display:inline-block;
        width:42px;
        height:30px;
        text-align: justify;
        text-justify:inter-ideograph;
        text-align-last: justify;
    }
    /*.authentication_ID_title_txt:after{*/
        /*display:inline-block;*/
        /*content:'.';*/
        /*width:100%;*/
        /*height:0;*/
        /*margin:0;*/
        /*overflow:hidden;*/
    /*}*/
    /*.authentication_ID_input{*/
        /*width:268px;*/
        /*height:30px;*/
        /*padding-left:22px;*/
        /*border:none;*/
        /*border-radius:5px;*/
        /*background:#f2f2f2;*/
        /*margin-left:19px;*/
    /*}*/
    .authentication_ID_num{
        margin-top:26px;
    }
    .authentication_ID .el-input{
        display:inline-block;
        width:268px;
        margin-left:19px;
    }
    /*************************操作按钮***************************/
    .authentication_confirm_box{
        display:inline-block;
        width:379px;
        margin-top:70px;
        text-align:right;
    }
    .authentication_confirm_box span{
        font-size: 16px;
        letter-spacing: 0;
        color: #15bafe;
        cursor:pointer;
        padding:5px 24px;
        border:1px solid #15bafe;
        border-radius:5px;
    }
    .authentication_confirm_box span.authentication_confirm{
        margin-left:12px;
    }
    .authentication_confirm_box span.active{
        color:#fff;
        background:#15bafe;
    }
</style>
<style>
    .authentication_ID .el-input__inner{
        height:30px;
        color:#999;
        line-height:30px;
        border:none;
        background:#f2f2f2;
    }
    .authentication_ID .el-input__icon{
        line-height:30px;
    }
</style>