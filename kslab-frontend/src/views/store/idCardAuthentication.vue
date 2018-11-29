<template>
    <div class="id_card_authentication">
        <section>
            <div class="card_authentication_body">
                <div class="authentication_head">
                    <img src="/static/img/logo/logo_sm.png" alt="">
                    <span class="authentication_head_txt">身份证绑定</span>
                </div>
                <div class="id_card_info">
                    <div class="id_card_name">
                        <span class="id_card_title">
                            <span class="id_card_title_txt">姓名</span>
                        </span>
                        <el-input
                                placeholder="请输入您的姓名"
                                v-model="name">
                            <i slot="suffix" class="el-input__icon el-icon-error" v-if="name"></i>
                        </el-input>
                    </div>
                    <div class="id_card_num">
                        <span class="id_card_title">
                            <span class="id_card_title_txt">身份证</span>
                        </span>
                        <el-input
                                placeholder="请输入身份证号码"
                                v-model="idNum">
                            <i slot="suffix" class="el-input__icon el-icon-error" v-if="idNum"></i>
                        </el-input>
                    </div>
                    <div class="id_card_img">
                        <div class="id_card_front">
                            <upload-id-card :serial_number="serial_number" :infoData="infoData" :type="positive_type"></upload-id-card>
                        </div>
                        <div class="id_card_reverse">
                            <upload-id-card :serial_number="serial_number" :infoData="infoData" :type="opposite_type"></upload-id-card>
                        </div>
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
    import UploadIdCard from '@/views/store/uploadIdCard'

    export default {
        name: "idCardAuthentication",
        data() {
            return {
                positive_type:1, //正面
                opposite_type:2, //反面
                name:'',
                idNum:'',
                isActive:true,
                serial_number:null,
                infoData:1234,
            }
        },
        components: {
            FloatingDiv,
            UploadIdCard
        },
        created(){
            
            this.generateUUID();
        },
        methods: {
            //生成随机码，用于批次号
            generateUUID(){
                var d = new Date().getTime();
                var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = (d + Math.random()*16)%16 | 0;
                d = Math.floor(d/16);
                return (c=='x' ? r : (r&0x3|0x8)).toString(16);
                });
                this.serial_number = uuid;
                return uuid;
                
            },
            /***************确认按钮****************/
            cancelClick(){
                // this.showWithdraw = false
            },
            //点击确定绑定
            confirm(){
                this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'usersProfile/verifyUserIdCard',{
                    token:window.localStorage.token,
                    name:this.name,
                    id_card_num:this.idNum,
                    serial_number:this.serial_number
                })
                .then((res) => {
                    console.log(res)
                    if(res.data.code === 200){
                        this.$router.back(-1);
                        this.$message.success(res.data.msg)
                    }else{
                        this.$message.error(res.data.msg)
                    }
                })
            },
            changeActive(e){
                if(!$(e.currentTarget).is('.active')){
                    this.isActive=!this.isActive
                }
            }
        },
    }
</script>

<style scoped>
    .card_authentication_body{
        width:1200px;
        margin:0 auto;
        padding:40px 40px 140px;
        box-shadow: 0 2px 5px 0 rgba(34, 24, 21, 0.16);
        border: solid 1px #dedede;
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
    .id_card_info{
        position:relative;
        padding:74px 0 0 20px;
    }
    .id_card_title{
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
    .id_card_title:after{
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
    .id_card_title_txt{
        display:inline-block;
        width:42px;
        height:30px;
        text-align: justify;
        text-justify:inter-ideograph;
        text-align-last: justify;
    }
    /*.id_card_title_txt:after{*/
    /*display:inline-block;*/
    /*content:'.';*/
    /*width:100%;*/
    /*height:0;*/
    /*margin:0;*/
    /*overflow:hidden;*/
    /*}*/
    .id_card_num{
        margin-top:62px;
    }
    .id_card_info .el-input{
        display:inline-block;
        width:268px;
        margin-left:19px;
    }
    /*************************操作按钮***************************/
    .authentication_confirm_box{
        margin-top:115px;
        text-align:center;
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
    .id_card_info .el-input__inner{
        height:30px;
        color:#999;
        line-height:30px;
        border:none;
        background:#f2f2f2;
    }
    .id_card_info .el-input__icon{
        line-height:30px;
    }
    /*************************上传身份证***********************/
    .id_card_img{
        position:absolute;
        top:48px;
        right:20px;
        width:610px;
        display:flex;
        justify-content:space-between;
    }
    .id_card_img .el-upload-dragger{
        width:295px;
        height:166px;
    }
    .id_card_img .uploading_tips{
        width:100%;
        height:100%;
    }
    .id_card_img .uploading_tips i{
        color:#c9c9c9;
        font-size:44px;
        margin-top:30px;
    }
    .id_card_img .id_card_describe{
        color:#000;
        font-size:14px;
        font-weight:800;
        margin-top:10px;
    }
    .id_card_img .id_card_suggest{
        color:#666;
        margin-top:10px;
    }
    .id_card_preview{
        width:295px;
        height:166px;
        display:block;
    }
    .id_card_img .el-upload__txt{
        color:#666;
        font-size:14px;
        margin-top:70px;
    }
</style>