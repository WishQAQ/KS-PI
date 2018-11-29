<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">页面背景</p>
            <div class="content_contain">
                <Category :categoryData="categoryData"></Category>
                <div class="box">
                    <img :src="imageUrl" alt="">
                </div>
                <div class="upload">
                    <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/" 
                    :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"> 
                        <img v-if="false" :src="imageUrl" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon">
                            <span>点击添加图片</span>
                        </i>
                    </el-upload>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
import Category from "../public/Category";
export default {
    name: 'PageBackground',
    components: {BreadCrumb,Category},
    data: function() {	
        return {
            breadData: [{
            id: 1,
            name: '上传菜单',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '页面背景',
            urls: '/index/PageBackground',
            icon: 'icon-home'
          }],
          categoryData:[{
                id:1,
                name:'主页',
            },{
                id:2,
                name:'商城',
            },{
                id:3,
                name:'活动',
            },{
                id:4,
                name:'淘货',
            }],
          imageUrl:'',
        }
    },
    methods: {
        handleAvatarSuccess(res, file) {
                this.imageUrl = URL.createObjectURL(file.raw);
            },
        beforeAvatarUpload(file) {
            const isJPG = file.type === 'image/jpeg';
            const isLt2M = file.size / 1024 / 1024 < 2;
            if (!isJPG) {
                this.$message.error('上传头像图片只能是 JPG 格式!');
            }
            if (!isLt2M) {
                this.$message.error('上传头像图片大小不能超过 2MB!');
            }
            return isJPG && isLt2M;
        }
    }
}
</script>

<style scoped>
    .bread{
        margin: 10px;
    }
    .content{
        background: white;
        margin-left: 10px;
        margin-right: 10px;
        height: calc(100vh - 87px);
        width: calc(100vw - 221px);
        border-radius: 2px;
    }
    .title{
        text-align: left;
        padding: 10px;
        padding-left: 20px;
        font-size: 14px;
        border-bottom: 1px solid #f2f2f2;
    }
    .content_contain{
        padding: 30px 55px;
        box-sizing: border-box;
    }
    .box{
        width: 800px;height: 450px;
        border: 1px solid #bfbfbf;
        margin-bottom: 25px;
        margin-top: 25px;
    }
    .box>img{
        width: 100%;height: 100%;
    }
    .upload{
        width: 800px;height: 165px;
        border: 1px dashed #bfbfbf;
    }
    /* 图片上传 */
    .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 770px;
    height: 140px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 770px;
    height: 140px;
    display: block;
  }
  /* 。。。。。 */
</style>
<style lang="less">
    .upload{
        .avatar-uploader{
            height: 100%;
            .el-upload{
                margin-top:15px;
                background: #f8f8f8;
            }
        }
    }
</style>
