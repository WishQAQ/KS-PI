<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">板块管理</p>
            <div class="content_contain">
                <div class="plates clearfloat">
                    <div @click="modifyVisible = true">
                        <img src="../../assets/image/lancar.png" alt="">
                        <p>汽车</p>
                    </div>
                    <div @click="modifyVisible = true">
                        <img src="../../assets/image/lanmoto.png" alt="">
                        <p>摩托车</p>
                    </div>
                    <div @click="modifyVisible = true">
                        <img src="../../assets/image/lanplan.png" alt="">
                        <p>无人机/车</p>
                    </div>
                    <div @click="modifyVisible = true">
                        <img src="../../assets/image/lanmoto.png" alt="">
                        <p>IOT</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- 修改弹框 -->
        <el-dialog :visible.sync="modifyVisible" width="355px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>修改</span>
            </div>
            <el-input  placeholder="名称"  class="kd" v-model="modifiedValue"></el-input>
            <div class="box">
                <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/" :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"> 
                    <img v-if="imageUrl" :src="imageUrl" class="avatar"><i v-else class="el-icon-plus avatar-uploader-icon"></i>
                </el-upload>
            </div>
            <div class="btn">
                <el-button>取消</el-button>
                <el-button type="primary" @click="save(index,data)" :id="index" :data="data">保存</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'PagePlateManagement',
    components: {BreadCrumb},
    data: function() {	
        return {
            breadData: [{
            id: 1,
            name: '上传菜单',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '板块管理',
            urls: '/index/PagePlateManagement',
            icon: 'icon-home'
          }],
          modifyVisible:false,
          modifiedValue:"",
          imageUrl: '',
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
    .plates{
        /* border: 1px solid #bfbfbf; */
        padding: 50px;
    }
    .plates>div{
        width: 140px;height: 140px;border: 1px solid #fafbfb;text-align: center;
        float: left;
        margin-right: 25px;
        box-shadow: 2px 2px 2px 2px #e0e4e6;
        border-radius: 5px;
    }
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .plates>div>img{
        margin-top: 25%;
        width: 44px;height: 44px;
    }
    .dialog_delete_head_title{
        height: 16px;
        border-bottom: 1px solid #cccccc;
        padding-bottom: 10px;
        text-align: left;
        font-size: 15px;
        color: #a2a2a2;
    }
    .delete_icon{
        color: #15bafe;
        font-size: 18px;
        top: 1px;
        position: relative;
    }
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
        width: 300px;
        height: 230px;
        line-height: 178px;
        text-align: center;
        border: 1px solid #bfbfbf;
  }
  .avatar {
        width: 300px;
        height: 230px;
        display: block;
  }
  .box{
      margin-top: 20px;
      border: 1px solid #d2d2d2;
      padding: 6px;
  }
  .btn{
      margin-top: 25px;
  }
</style>
<style lang="less">
    .kd{
        .el-input__inner{
            text-align: center;
        }
    }

</style>
