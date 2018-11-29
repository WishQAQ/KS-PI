<template>
    <div class="PageNewProductType">
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">新增产品类型</p>
            <div class="content_contain">
                <div class="hd">
                    <div class="sle-til">
                        <div>汽车</div>
                        <div>摩托车</div>
                        <div>无人机</div>
                        <div>智能设备</div>
                    </div>
                    <div class="right" @click="addVisible = true">
                        <div class="ri-left">
                            <img src="../../assets/image/tianjia.png" alt="">
                        </div>
                        <div class="ri-right">
                            添加产品类型
                        </div>
                    </div>
                </div>
                <!-- 添加产品 -->
                <div class="add-product">
                    <el-input class="inputa" placeholder="请输入产品类别名称" ></el-input>
                    <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/"  :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload">
                        <img v-if="imageUrl" :src="imageUrl" class="avatar">
                        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                        <p style="color:#888888">添加图片</p>
                    </el-upload>
                    <div class="custom">
                        <div class="custom-left">
                            <span>自定义：</span>
                            <div>选择框</div>
                            <div>数字区间</div>
                        </div>
                        <div class="custom-right">
                            <div class="cus-left">
                                <img src="../../assets/image/tianjia.png" alt="">
                            </div>
                            <div class="cus-right">
                                添加
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 类型和选项 -->
                <div class="type">
                    <!-- 类型 -->
                    <div class="type-top">
                        <span>类型：</span>
                        <div>单选</div>
                        <div>多选</div>
                    </div>
                    <div class="type-bot clearfloat">
                        <div class="specific">
                            <div>品牌</div>
                            <div>-</div>
                        </div>
                        <div class="specific">
                            <div>形状</div>
                            <div>-</div>
                        </div>
                        <div class="specific">
                            <div>用途</div>
                            <div>-</div>
                        </div>
                    </div>
                    <!-- 现有选项 -->
                    <div class="now-option">
                        <div class="opt-top">
                            <span>现有选项：</span>
                            <el-input class="inputb" placeholder="请输入产品类别名称"></el-input>
                            <div class="jiah">+</div>
                        </div>
                        <div class="all-type clearfloat">
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
        <!-- 弹框    -->
        <el-dialog :visible.sync="addVisible" width="505px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>添加</span>
            </div>
            <div class="modify">
                <span>标题：</span>
                <el-input placeholder="输入选项类型"  class="kd"></el-input>
                <div class="jiah">+</div>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'PageNewProductType',
    components: {BreadCrumb},
    data: function() {	
        return {
            breadData: [{
                id: 1,
                name: '后端页面',
                urls: '/index',
                icon: 'icon-home'
            },{
                id: 2,
                name: '新增产品类型',
                urls: '/index/NewProductType',
                icon: 'icon-home'
            }],
            imageUrl: '',
            addVisible:false,
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
    .PageNewProductType{width: 100%; box-sizing: border-box;height: calc(100vh - 90px);}
    .bread{
        margin: 10px;
    }
    .content{
        background: white;
        margin-left: 10px;
        margin-right: 10px;
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
    .hd{
        display: flex;
        justify-content: space-between;
        border-bottom: 1px solid #bfbfbf;
        padding-bottom: 20px;
    }
    .sle-til{display: flex;}
    .sle-til>div{width: 110px;height: 35px;border: 1px solid #bfbfbf;color: #999999;line-height: 35px;text-align: center;margin-right: 20px;}
    .right{
        width: 150px;height: 35px;
        border: 1px solid #fff; 
        display: flex;
        justify-content: space-between;
        border-radius: 5px;
    }
    .ri-left{
        background: #15bafe;
        width: 25%;
        display: flex;align-items: center;
        justify-content: center;
    }
    .ri-right{background: #15bafe;width: 74%;color: #fff;line-height: 35px;text-align: center;font-size: 14px;}
    .add-product{text-align: left;}
    .inputa{width: 325px;height: 35px;margin-top: 20px;color: #999999;display: flex;align-items: center;}
    .inputb{width: 175px;height: 35px;color: #999999;display: flex;align-items: center;}
    .avatar-uploader{
        border: 1px dashed #d9d9d9;
        width: 178px;
        margin-top: 20px;
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
        width: 178px;
        height: 178px;
        line-height: 178px;
        text-align: center;
  }
  .avatar {
        width: 178px;
        height: 178px;
        display: block;
  }
  .custom{
        display: flex;justify-content: space-between;
        width: 50%;margin-top: 40px;border-bottom:1px solid #bfbfbf;
        padding-bottom: 20px;
  }
  .custom-left{
        display: flex;align-items: center;
  }
  .custom-left>span{
        color: #222222;font-size: 14px;margin-right:14px;
  }
  .custom-left>div{
        width:110px ;height: 30px;color:#a9a9a9;margin-right:22px;
        text-align: center;line-height: 30px;border: 1px solid #bfbfbf; 
        font-size: 14px;
        color:#bfbfbf; 
  }
  .custom-right{
    width: 95px;height: 30px;
    border: 1px solid #fff; 
    display: flex;
    justify-content: space-between;
    border-radius: 5px;
  }
    .cus-left{
        background: #15bafe;
        width: 25%;
        display: flex;align-items: center;
        justify-content: center;
    }
    .cus-right{background: #15bafe;width: 74%;color: #fff;line-height: 30px;text-align: center;font-size: 14px;}
    .type{text-align: left;margin-top: 20px;}
    .type-top{
        display: flex;align-items: center;
    }
    .type-top>div{
        width:110px ;height: 30px;color:#a9a9a9;margin-right:22px;
        text-align: center;line-height: 30px;border: 1px solid #bfbfbf; 
        font-size: 14px;
        color:#bfbfbf; 
    }
    .type-top>span{
        color: #222222;font-size: 14px;margin-right:28px;
  }
    .specific{
        width: 120px;height: 35px;
        /* border: 1px solid #bfbfbf; */
        display: flex;justify-content: space-between;
        font-size: 14px;
    }
    .type-bot{margin-top: 28px;padding: 0 70px;}
    .type-bot>div{float: left;margin-right: 50px;}
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .type-bot>div:first-child{margin-bottom: 25px;}
    .specific>div:first-child{width: 80%;background: #15bafe;text-align: center;line-height: 35px;color: #fff;}
    .specific>div:last-child{width: 20%;background: #ff5858;text-align: center;line-height: 35px;font-size: 24px;color: #fff;}
    .jiah{width: 30px;height: 30px;background: #15bafe;color: #fff;font-size: 32px;text-align: center;line-height: 35px;}
    .opt-top{display: flex;align-items: center;}
    .opt-top>span{font-size: 14px;color:#222222}
    .all-type{border:1px solid #d2d2d2;margin: 25px 70px;padding: 25px 30px;box-sizing: border-box; width: 50%;}
    .all-type>div{width: 90px;height: 30px;border:1px solid #d2d2d2; float: left;margin: 0 30px 25px 0;color: #999999;font-size: 14px;line-height: 30px;text-align: center;}
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
    .modify{display: flex;justify-content: center;align-items: center;margin:40px 0;}
    .modify>span{margin-right: 40px;}
    .kd{width: 50%;margin-right: 15px;}
</style>
<style lang="less">
.inputa{
    .el-input__inner{
        height: 35px;
    }
}
.inputb{
    .el-input__inner{
        height: 30px;
    }
}
.opt-top{
    .el-input{
        margin-right: 15px;
    }
}
.kd{
    .el-input__inner{
        height: 30px;
    }
}
</style>
