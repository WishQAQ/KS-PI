<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">上传服务</p>
            <div class="content_contain">
                <Category :categoryData="categoryData"></Category>
                <div class="top">
                    <div class="cla">汽车</div>
                    <div class="search">
                        <el-input placeholder="汽车配件"></el-input>
                        <div class="add">+</div>
                    </div>
                </div>
                <div class="bot clearfix">
                    <div class="neir">
                        <div @click="editVisible = true">改装</div>
                        <div><i class="el-icon-delete"></i></div>
                    </div>
                    <div class="neir">
                        <div>改装</div>
                        <div><i class="el-icon-delete"></i></div>
                    </div>
                    <div class="neir">
                        <div>改装</div>
                        <div><i class="el-icon-delete"></i></div>
                    </div>
                    <div class="neir">
                        <div>改装</div>
                        <div><i class="el-icon-delete"></i></div>
                    </div>
                    <div class="neir">
                        <div>改装</div>
                        <div><i class="el-icon-delete"></i></div>
                    </div>
                    <div class="neir">
                        <div>改装</div>
                        <div><i class="el-icon-delete"></i></div>
                    </div>
                    <div class="neir">
                        <div>改装</div>
                        <div><i class="el-icon-delete"></i></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <el-dialog :visible.sync="editVisible" width="470px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-trash delete_icon"></i>
                <span>解释编辑</span>
            </div>
            <el-input type="textarea" :rows="2" placeholder="请输入内容" v-model="textarea"></el-input>
            <div class="but">
                <el-button class="btn_deletes" size="small">取消</el-button>
                <el-button type="primary" size="small"  class="btn_delete" >保存</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
import Category from "../public/Category";
    export default {
        name:'UploadService',
        components: {
            BreadCrumb,
            Category
            },
        data(){
            return{
                breadData: [{
                    id: 1,
                    name: '上传菜单',
                    urls: '/index',
                    icon: 'icon-home'
                },{
                    id: 2,
                    name: '上传服务',
                    urls: '/index/UploadService',
                    icon: 'icon-home'
                }],
                categoryData:[{
                    id:1,
                    name:'汽车',
                },{
                    id:2,
                    name:'摩托车',
                },{
                    id:3,
                    name:'无人机',
                },{
                    id:4,
                    name:'智能设备',
                }],
                editVisible:false,
                textarea:"",
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
    .top{
        display: flex;justify-content: left;
        margin-top: 25px;
    }
    .cla{
        width: 140px;height: 30px;margin-right: 50px;
        border: 1px solid #15bafe;background: #15bafe;
        border-radius: 4px;font-size: 14px ;color: #fff;
        text-align: center;line-height: 30px;
    }
    .search{
        display: flex;justify-content: space-between;
        width: 175px;height: 32px;
    }
    .add{
        width: 30%;background: #15bafe;
        font-size: 30px;color:#fff;
    }
    .clearfix:after{ content:"."; display:block; height:0; clear:both;}
    .bot{
        padding: 25px 0;
        /* 这里要定宽 */
    }
    .neir{
        width: 175px;height: 30px;
        border: 1px solid #15bafe;
        border-radius: 4px;
        display:flex;
        justify-content: space-between;
        float: left;margin-right: 15px;
        margin-bottom: 15px;
    }
    .neir>div{
        text-align: center;line-height: 30px;
    }
    .neir>div:nth-child(1){
        width: 80%;
        background: #15bafe;
        color: #fff;
    }
    .neir>div:nth-child(2){
        width: 20%;
        color:#15bafe;
    }
    .dialog_delete_head_title{
        height: 16px;
        border-bottom: 1px solid #cccccc;
        padding-bottom: 10px;
        text-align: left;
        font-size: 15px;
  }
    .delete_icon{
        color: #15bafe;
        font-size: 18px;
        top: 1px;
        position: relative;
  }
    .but{
        margin-top: 21px;
        text-align: right;
    }
</style>
<style lang="less">
.search{
    .el-input{
        width: 70%;
        .el-input__inner{
            height: 32px;
            text-align: center;
            border-radius: 0;
        }
    }
}
</style>
