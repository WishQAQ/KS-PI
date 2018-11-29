<template>
    <div class="merchant_info appBackground">
        <section>
            <div class="merchant_info_body">
                <div class="merchant_info_top">
                    <router-link to="/home/commercialIndex" class="merchant_top_button">返回商户个人主页</router-link>
                </div>
                <div class="merchant_list">
                    <div class="merchant_head">
                        <span class="merchant_shape"></span>
                        <span class="merchant_txt">基本信息</span>
                        <span class="merchant_art_txt">ESSENTIAL INFORMATION</span>
                    </div>
                    <div class="merchant_info_detail">
                        <div class="merchant_avatar">
                            <span class="merchant_key">
                                <i class="icon icon-ziyuan19"></i>
                                <span class="merchant_key_txt">头&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;像</span>
                            </span>
                            <span class="merchant_avatar_img">
                                <img :src="basicData.avatar+'?imageView2/1/w/85/h/85'" alt="">
                            </span>
                        </div>
                        <div class="merchant_name">
                            <span class="merchant_key">
                                <i class="icon icon-ziyuan28"></i>
                                <span class="merchant_key_txt">公司名称</span>
                            </span>
                            <span class="merchant_company_name">{{basicData.name}}</span>
                        </div>
                        <div class="merchant_signature">
                            <span class="merchant_key">
                                <i class="icon icon-ziyuan36"></i>
                                <span class="merchant_key_txt">签&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名</span>
                            </span>
                            <span class="merchant_signature_input">
                                <input type="text" v-model="signature" placeholder="不超过20个汉字">
                            </span>
                        </div>
                    </div>
                    <div class="merchant_confirm_box">
                        <span class="merchant_cancel" :class="{active:!isActive}" @mouseenter="changeActive($event)">取消</span>
                        <span class="merchant_confirm" :class="{active:isActive}" @mouseenter="changeActive($event)" @click="updateInfo">确认</span>
                    </div>
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
        name: "merchantInfo",
        data(){
            return {
                isActive:true,
                signature:'',//签名
                basicData:{},//公司信息
            }
        },
        components:{
            FloatingDiv
        },
        methods:{
            changeActive(e){
                if(!$(e.currentTarget).is('.active')){
                    this.isActive=!this.isActive
                }
            },
            //获取公司信息
            getInfo(){
                this.HttpClient.get('/get/companyInfo')
                    .then(res=>{
                        console.log(res);
                        if(res.data.code===200){
                            this.basicData=res.data.data;
                            this.signature=res.data.data.signature;
                        }
                    })
            },
            //修改信息
            updateInfo(){
                this.HttpClient.post('/edit/companyInfo',{signature:this.signature})
                    .then(res=>{
                        console.log(res);
                        if(res.data.code===200){
                            this.$message.success(res.data.msg);
                            this.getInfo()
                        }else{
                            this.$message.error('修改失败，请重试!')
                        }
                    })
            }
        },
        created(){
            this.getInfo()
        }
    }
</script>

<style scoped>
    .merchant_info{
        background:#F2F2F2;
    }
    .merchant_info section{
        padding-bottom:17.7vh;
    }
    .merchant_info .merchant_info_body{
        width:1200px;
        margin:0 auto;
    }
    .merchant_top_button{
        display: block;
        width: 150px;
        height: 36px;
        line-height:36px;
        text-align:center;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #15bafe;
        cursor:pointer;
        border-radius: 3px;
        border: solid 1px #15bafe;
        background:transparent;
    }
    .merchant_top_button:hover{
        color:#fff;
        background:#15bafe;
    }
    .merchant_info .merchant_info_body .merchant_list{
        margin-top:13px;
        padding:24px 24px 50px;
        background:#fff;
        box-shadow: 0 2px 5px 0 rgba(34, 24, 21, 0.16);
    }
    .merchant_head{
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        padding-left:3px;
        padding-bottom:3px;
        border-bottom:1px solid #dbdbdb;
    }
    .merchant_head span{
        display:inline-block;
        vertical-align:middle;
    }
    .merchant_head .merchant_shape{
        width:0;
        height:0;
        border-style:solid;
        border-color:#15bafe;
        border-width:10px 3px;
    }
    .merchant_head .merchant_txt{
        color: #000;
    }
    .merchant_head .merchant_art_txt{
        font-style: italic;
        color: #e5e5e5;
    }
    .merchant_info_detail{
        margin-top:36px;
    }
    .merchant_key .icon{
        font-size:13px;
        color:#15bafe;
    }
    .merchant_key .merchant_key_txt{
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 20px;
        letter-spacing: 0;
        color: #000;
        margin-left:10px;
    }
    .merchant_info .merchant_info_body .merchant_avatar_img{
        display:inline-block;
        width:85px;
        height:85px;
        margin-left:30px;
        border-radius:50%;
        overflow:hidden;
        vertical-align:middle;
    }
    .merchant_info .merchant_info_body .merchant_avatar_img img{
        width:85px;
        height:85px;
    }
    .merchant_info .merchant_info_body .merchant_name,
    .merchant_info .merchant_info_body .merchant_signature{
        margin-top:30px;
    }
    .merchant_info .merchant_info_body .merchant_name .merchant_company_name{
        font-size: 20px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 20px;
        letter-spacing: 0;
        color: #666666;
        margin-left:30px;
    }
    .merchant_info .merchant_info_body .merchant_signature_input{
        margin-left:30px;
    }
    .merchant_info .merchant_info_body .merchant_signature_input input{
        width:500px;
        height:30px;
        padding-left:13px;
        border-radius:3px;
        border:1px solid #e5e5e5;
    }
    .merchant_info .merchant_info_body .merchant_signature_input input:hover{
        border-color:#aaa;
    }
    .merchant_info .merchant_info_body .merchant_signature_input input:focus{
        border-color:#15bafe;
    }
    /*************************操作按钮***************************/
    .merchant_info .merchant_info_body .merchant_confirm_box{
        margin-top:13px;
        text-align:right;
    }
    .merchant_info .merchant_info_body .merchant_confirm_box span{
        font-size: 16px;
        letter-spacing: 0;
        color: #15bafe;
        cursor:pointer;
        padding:5px 24px;
        border:1px solid #15bafe;
        border-radius:5px;
    }
    .merchant_info .merchant_info_body .merchant_confirm_box span.merchant_confirm{
        margin-left:12px;
    }
    .merchant_info .merchant_info_body .merchant_confirm_box span.active{
        color:#fff;
        background:#15bafe;
    }
</style>
