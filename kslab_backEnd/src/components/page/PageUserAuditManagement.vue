<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">用户审核管理</p>
            <div class="content_contain">
                <div class="name">
                    <el-input placeholder=""></el-input>
                    <div class="add">+</div>
                </div>
                <div class="name-box">
                    <div class="box">
                        <div>色情</div>
                        <div @click="modifyVisible = true">修改</div>
                        <div>删除</div>
                    </div>
                    <div class="box">
                        <div>上传无关信息</div>
                        <div @click="modifyVisible = true">修改</div>
                        <div>删除</div>
                    </div>
                    <div class="box">
                        <div>故意装怪</div>
                        <div @click="modifyVisible = true">修改</div>
                        <div>删除</div>
                    </div>
                    <div class="box">
                        <div>涉嫌侵权</div>
                        <div @click="modifyVisible = true">修改</div>
                        <div>删除</div>
                    </div>
                    <div class="box">
                        <div>不友善</div>
                        <div @click="modifyVisible = true">修改</div>
                        <div>删除</div>
                    </div>
                    <div class="box">
                        <div>其他</div>
                        <div @click="modifyVisible = true">修改</div>
                        <div>删除</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 修改弹框 -->
        <el-dialog :visible.sync="modifyVisible" width="420px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>修改</span>
            </div>
            <div class="modify">
                <span>名称：</span>
                <el-input placeholder="输入新名称"></el-input>
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
    name: 'PageUserAuditManagement',
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
            name: '用户审核管理',
            urls: '/index/PageUserAuditManagement',
            icon: 'icon-home'
          }],
          modifyVisible:false,
        }
    },
    methods: {}
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
    .name{
        display: flex;
    }
    .add{
        width: 40px;height: 28px;
        border: 1px solid #15bafe;
        font-size: 30px;color: #15bafe;
        border-radius: 4px;
    }
    .name-box{
        margin-top:12px; 
    }
    .box{
        display: flex;
        font-size: 14px;
        margin-bottom: 15px;
    }
    .box>div{text-align: center;line-height: 30px;margin-right: 15px;}
    .box>div:nth-child(1){
        width: 275px;
        height: 30px;
        border: 1px solid #bfbfbf;
        border-radius: 4px;
        color: #222222;
    }
    .box>div:nth-child(2){
        width: 60px;
        height: 30px;
        border: 1px solid #15bafe;
        background: #15bafe;
        border-radius: 4px;
        color: #fff;
    }
    .box>div:nth-child(3){
        width: 60px;
        height: 30px;
        border: 1px solid #15bafe;
        border-radius: 4px;
        color: #15bafe;
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
    .btn{
        display: flex;
        justify-content:flex-end;
        margin-top: 30px;
        margin-bottom: 10px;
    }
</style>
<style lang="less">
    .name{
        .el-input{
            width: 275px;
            margin-right: 15px;
            .el-input__inner{
                height: 30px;
            }
        }
    }
    .modify{
        .el-input{
            width: 245px;
            .el-input__inner{
                height: 30px;
                border-radius: 0;
            }
        }
    }
</style>
