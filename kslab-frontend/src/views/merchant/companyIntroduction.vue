<template>
    <div class="company_introduction">
        <section>
            <div class="company_introduction_body">
                <div class="merchant_info_top">
                    <button class="merchant_top_button" @click="toBackIndex">返回个人主页</button>
                </div>
                <div class="company_introduction_update">
                    <div class="merchant_head">
                        <span class="merchant_shape"></span>
                        <span class="merchant_txt">公司介绍</span>
                        <span class="merchant_art_txt">COMPANY INTRODUCTION</span>
                    </div>
                    <div class="company_introduction_detail">
                        <div class="company_thumbnail" :class="{activeBorder:!isDrag}">
                            <el-upload
                                    action="http://test.kslab.com/api/null"
                                    list-type="picture-card"
                                    :file-list="showPic"
                                    class="encyclopedia_cover_box"
                                    :drag="isDrag"
                                    :limit="8"
                                    multiple
                                    :on-preview="handlePictureCardPreview"
                                    :on-remove="handleRemove"
                                    :on-change="handleChange"
                                    :before-upload="beforeAvatarUpload"
                                    :on-success="handleSuccess"
                                    :on-error="handleError">
                                <i class="el-icon-plus" v-show="!isDrag"></i>
                                <div class="upload_tips" @dragover.prevent="onDragover" @dragleave="dragLeave" v-if="!ImgFlag">
                                    <i class="el-icon-circle-plus" v-show="!dragOverImg"></i>
                                    <div class="el-upload__text" v-show="!dragOverImg">添加封面图</div>
                                    <span class="upload_tips_suggest" v-show="!dragOverImg">推荐640×640像素,JPG/PNG,1M以内,最多上传8张</span>
                                    <span class="dragOver_txt" v-show="dragOverImg && !dragDoneImg">松开图片以上传</span>
                                </div>
                            </el-upload>
                            <div v-show="dialogVisible" class="product_img_preview">
                                <img width="100%" :src="dialogImageUrl" alt="">
                            </div>
                            <span class="toLeft" v-if="scrollLeft" @click="toLeft">
                                <i class="el-icon-arrow-left"></i>
                            </span>
                            <span class="toRight" v-if="scrollRight" @click="toRight">
                                <i class="el-icon-arrow-right"></i>
                            </span>
                            <span class="picture_num" v-if="fileList.length>=1">({{fileList.length}}/8)</span>
                        </div>
                        <div class="company_introduction_box">
                            <div class="company_address">
                                <span class="merchant_key">
                                    <i class="icon icon-ziyuan16"></i>
                                    <span class="merchant_key_txt">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</span>
                                </span>
                                <div class="company_address_input">
                                    <input type="text" v-model="updateData.address" placeholder="请输入地址" maxlength="25">
                                </div>
                            </div>
                            <div class="company_feature">
                                <span class="merchant_key">
                                    <i class="icon el-icon-star-off"></i>
                                    <span class="merchant_key_txt">特&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色</span>
                                </span>
                                <div class="merchant_feature_input">
                                    <textarea placeholder="请在此输入" v-model="updateData.feature" maxlength="30" rows="3"></textarea>
                                </div>
                            </div>
                            <div class="company_synopsis">
                                <span class="merchant_key">
                                    <i class="icon icon-ziyuan15"></i>
                                    <span class="merchant_key_txt">简&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;介</span>
                                </span>
                                <div class="company_synopsis_input">
                                    <quill-editor
                                            v-model="updateData.profile"
                                            ref="myQuillEditor"
                                            :options="editorOption"
                                            @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
                                            @change="onEditorChange($event,1200)">
                                    </quill-editor>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="merchant_confirm_box">
                        <span class="merchant_cancel" :class="{active:!isActive}" @mouseenter="changeActive($event)" @click="updateCompanyInfo">取消</span>
                        <span class="merchant_confirm" :class="{active:isActive}" @mouseenter="changeActive($event)">确认</span>
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

    import { quillEditor } from 'vue-quill-editor'
    import * as Quill from 'quill'  //引入编辑器
    // 自定义字体大小
    let fontSize = ['10px', '12px', '14px', '16px', '18px', '20px'];
    let Size = Quill.import('attributors/style/size');
    Size.whitelist = fontSize;
    Quill.register(Size, true);

    var toolbarOptions = [
        [ 'italic', 'underline', 'strike','bold'],
        ['blockquote','code-block'],
        [{'list':'ordered'},{'list':'bullet'}],
        [{'script':'sub'},{'script':'super'}],
        [{'indent':'-1'},{'indent':'+1'}],
        [{'direction':'rtl'}],
        [{'size':fontSize}],
        [{'color':[]}],
        [{'align':[]}],
    ];

    export default {
        name: "companyIntroduction",
        data(){
            return {
                dialogImageUrl:'',
                dialogVisible:false,
                dragOver:false,
                dragDone:false,
                isDrag:true,
                ImgFlag:false,
                dragOverImg:false,
                dragDoneImg:false,
                left:0,
                changeNum:0,
                scrollLeft:false,
                scrollRight:false,
                fileList:[],
                editorOption:{
                    modules: {
                        toolbar: toolbarOptions
                    }
                },
                isActive:true,
                companyData:{},//公司信息
                updateData:{
                    address:'',//地址
                    feature:'',//特色
                    profile	:'',//介绍
                },//修改信息
                showPic:[],//图片展示
            }
        },
        components:{
            FloatingDiv
        },
        methods:{
            //返回主页
            toBackIndex(){
                this.$router.push({
                    path:'/home/commercialIndex'
                })
            },
            handleRemove(file, fileList) {
                console.log(file, fileList);
                // if(fileList.length<=0){
                //     this.ImgFlag=false;
                // }else{
                //     this.ImgFlag=true;
                // }
                if(fileList.length<=0){
                    this.isDrag=true;
                    this.dialogVisible=false;
                    this.ImgFlag=false;
                    this.dragOverImg=false;
                    this.dragDoneImg=false;
                }else{
                    this.dialogImageUrl=fileList[fileList.length-1].url;
                    if(fileList.length>=3){
                        this.left-=75;
                        this.scrollLeft=false;
                    }
                }
            },
            handleSuccess(response, file, fileList){
                this.$message.success('上传成功!');
                this.fileList=fileList;
            },
            handleError(err, file, fileList){
                console.log(fileList);
                this.$message.error('上传失败!')
                if(fileList.length>0){
                    this.dialogImageUrl=fileList[fileList.length-1].url;
                    if(fileList.length>=3){
                        this.left-=75;
                        this.scrollLeft=false;
                    }
                    console.log(this.dialogImageUrl);
                }else{
                    this.dialogVisible=false;
                }
            },
            handleChange(file,fileList){
                if(fileList.length>0){
                    this.dragOverImg=true;
                    this.dragDoneImg=true;
                    this.isDrag=false;
                    this.dialogVisible=true;
                    this.dialogImageUrl=fileList[fileList.length-1].url;
                }else{
                    this.isDrag=true;
                    this.dragOverImg=false;
                    this.dragDoneImg=false;
                    this.ImgFlag=false;
                    this.dialogVisible=false;
                }
                this.changeNum++;
                if(this.changeNum===1){
                    if(fileList.length>=4 && fileList.length!==8) {
                        this.left += 75;
                        this.scrollLeft=true
                    }
                }else{
                    this.changeNum=0;
                }
            },
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isPNG = file.type === 'image/png';
                const isLt2M = file.size / 1024 / 1024 < 1;
                if (!isJPG && !isPNG) {
                    this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 5MB!');
                }
                if(isJPG || isPNG && isLt2M){
                    this.HttpClient.post('/uploadSowingMap',{pics:file})
                        .then(res=>{
                            console.log(res);
                            if(res.data.code===200){
                                this.showPic.push({url:res.data.path})
                            }
                        });
                }
                return isJPG || isPNG && isLt2M;

            },
            onDragover(){
                this.dragOverImg=true;
            },
            dragLeave(){
                this.dragOverImg=false;
            },
            toLeft(){
                this.left-=75;
                this.scrollRight=true;
                if(this.left===0){
                    this.scrollLeft=false;
                }
            },
            toRight(){
                this.left+=75;
                console.log(this.left);
                console.log(this.fileList);
                if(this.fileList.length===8) {
                    if ((this.fileList.length - 4) * 75 === this.left) {
                        this.scrollRight = false;
                    }
                }else{
                    if ((this.fileList.length - 3) * 75 === this.left) {
                        this.scrollRight = false;
                    }
                }
                this.scrollLeft=true;
            },
            /***********************************文档编辑器**********************************/
            onEditorBlur(){//失去焦点事件
                this.$emit('ArticleMainContent' ,this.content)
            },
            onEditorFocus(){//获得焦点事件
            },
            onEditorChange(e,decimalNum){//内容改变事件
                e.quill.deleteText(decimalNum,1);//保留 strValue 的 前 decimalNum 位字符，
            },
            /******************操作按钮***********************/
            changeActive(e){
                if(!$(e.currentTarget).is('.active')){
                    this.isActive=!this.isActive
                }
            },

            //获取公司信息
            getCompanyInfo(){
                this.HttpClient.get('/get/companyInfo')
                    .then(res=>{
                        console.log(res);
                        let {code,data} = res.data;
                        if(code===200){
                            this.companyData=data;
                            this.updateData.address=data.address;
                            this.updateData.feature=data.feature;
                            this.updateData.profile=data.profile;
                        }
                    })
            },
            updateCompanyInfo(){

            }
        },
        created(){
            this.getCompanyInfo()
        },
        watch:{
            left:function(){
                let $list=$('.el-upload-list--picture-card');
                $list.css('margin-left','-'+this.left+'px');
            },
            fileList:function(){
                if(this.fileList.length===8){
                    $('.el-upload--picture-card').css('display','none')
                }
            }
        }
    }
</script>

<style scoped>
    .company_introduction{
        background:#F2F2F2;
    }
    .company_introduction_body{
        width:1200px;
        margin:0 auto;
        padding-top:30px;
    }
    .merchant_top_button{
        width: 120px;
        height: 36px;
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
    .company_introduction .company_introduction_update{
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
    .company_introduction_detail{
        margin-top:36px;
        text-align:center;
    }
    .company_introduction_detail .company_thumbnail{
        position:relative;
        display:inline-block;
        width:350px;
        height:400px;
    }
    .company_thumbnail .encyclopedia_cover_box,
    .company_thumbnail .upload_tips{
        position:relative;
        width:100%;
        height:100%;
    }
    .company_thumbnail .upload_tips .el-icon-circle-plus{
        margin-top:140px;
    }
    .company_thumbnail .product_img_preview{
        position:absolute;
        top:10px;
        left:25px;
        width:300px;
        height:300px;
        line-height:350px;
        overflow:hidden;
    }
    .company_introduction_detail .company_thumbnail.activeBorder{
        border:1px dashed #ccc;
        /*overflow:hidden;*/
    }
    .company_introduction_detail .company_thumbnail.activeBorder .encyclopedia_cover_box{
        position:absolute;
        bottom:5px;
        left:24px;
        width:300px;
        height:80px;
        padding-top:5px;
        overflow:hidden;
        white-space: nowrap;
    }
    .company_thumbnail .toLeft,
    .company_thumbnail .toRight{
        position:absolute;
        bottom:10px;
        display:inline-block;
        width:15px;
        height:70px;
        font-size:14px;
        text-align:center;
        line-height:70px;
        background:#eee;
        color:#666;
        cursor:pointer;
    }
    .company_thumbnail .toLeft{
        left:8px;
        border-top-left-radius:2px;
        border-bottom-left-radius:2px;
    }
    .company_thumbnail .toRight{
        right:7px;
        border-top-right-radius:2px;
        border-bottom-right-radius:2px;
    }
    .company_thumbnail .toLeft:hover,
    .company_thumbnail .toRight:hover{
        background:#ddd;
    }
    .company_thumbnail .picture_num{
        position:absolute;
        bottom:-20px;
        left:160px;
        color:#999;
    }
    .company_introduction_detail .company_thumbnail .el-upload--picture-card i{
        font-size:50px;
    }
    .company_introduction_detail .company_thumbnail .upload_tips_suggest{
        color:#999;
    }
    /******************************编辑区*************************/
    .company_introduction_body .company_introduction_box{
        display:inline-block;
        width:680px;
        margin-left:30px;
        vertical-align:top;
        text-align:left;
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
    .company_introduction_body .company_introduction_box .company_address_input{
        margin-top:7px;
    }
    .company_introduction_body .company_introduction_box .company_address_input input{
        width:100%;
        height:30px;
        padding-left:13px;
        border-radius: 5px;
        border: solid 1px #e5e5e5;
        box-sizing:border-box;
    }
    .company_introduction_body .company_introduction_box .company_feature{
        margin-top:15px;
    }
    .company_introduction_body .company_introduction_box .merchant_feature_input{
        margin-top:7px;
    }
    .company_introduction_body .company_introduction_box .merchant_feature_input textarea{
        width:100%;
        resize:none;
        padding-left:15px;
        border:1px solid #ccc;
        border-radius:5px;
        box-sizing:border-box;
    }
    .company_introduction_body .company_introduction_box .company_synopsis{
        margin-top:15px;
    }
    .company_introduction_body .company_introduction_box .company_synopsis_input{
        margin-top:7px;
        width:100%;
    }
    /*************************操作按钮***************************/
    .company_introduction_body .company_introduction_update .merchant_confirm_box{
        margin-top:40px;
        text-align:right;
        padding-right:45px;
    }
    .company_introduction_body .company_introduction_update .merchant_confirm_box span{
        font-size: 16px;
        letter-spacing: 0;
        color: #15bafe;
        cursor:pointer;
        padding:5px 24px;
        border:1px solid #15bafe;
        border-radius:5px;
        serviceComment-select:none;
    }
    .company_introduction_body .company_introduction_update .merchant_confirm_box span.merchant_confirm{
        margin-left:12px;
    }
    .company_introduction_body .company_introduction_update .merchant_confirm_box span.active{
        color:#fff;
        background:#15bafe;
    }
</style>

<style>
    .company_introduction .company_introduction_update .company_thumbnail .el-upload--picture-card{
        width:100%!important;
        height:100%!important;
        border:none!important;
        line-height:initial!important;
    }
    .company_introduction .company_introduction_update .company_thumbnail .el-upload-dragger{
        width:100%!important;
        height:100%!important;
    }
    /*.company_thumbnail .el-upload-list--picture-card{*/
        /*position:absolute;*/
        /*bottom:0;*/
        /*left:15px;*/
        /*z-index:1;*/
    /*}*/
    .company_thumbnail .el-upload-list--picture-card .el-upload-list__item{
        width:72px!important;
        height:72px!important;
        margin:0 3px 0 0!important;
    }
    .company_thumbnail .el-upload-list--picture-card  .el-upload-list__item-actions i{
        font-size:20px;
    }
    .company_thumbnail .el-upload-list--picture-card .el-upload-list__item-actions span+span{
        margin-left:0;
    }
    .company_introduction_detail .company_thumbnail .el-upload-dragger .el-upload__text{
        font-size:16px!important;
        color:#000!important;
        margin:7px 0!important;
    }
    .company_introduction_detail .company_thumbnail.activeBorder .el-upload--picture-card{
        width:72px!important;
        height:72px!important;
        border:1px dashed #ccc!important;
    }
    .company_introduction_detail .company_thumbnail.activeBorder .el-upload--picture-card i{
        margin-top:20px;
        font-size:32px;
    }
    .company_introduction_body .company_introduction_box .quill-editor .ql-container.ql-snow{
        height:300px;
    }
</style>
