<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">类型管理</p>
            <div class="content_contain">
                <div class="opt-top">
                    <span>现有选项：</span>
                    <el-input class="inputd" placeholder="请输入产品类别名称"></el-input>
                    <div class="jiah">+</div>
                </div>
                <div class="all-type clearfloat">
                    <div class="type">
                        <div @click="modifyVisible = true">邪教</div>
                        <div class="delete">-</div>
                    </div>
                    <div class="type">
                        <div @click="modifyVisible = true">邪教</div>
                        <div class="delete">-</div>
                    </div>
                    <div class="type">
                        <div @click="modifyVisible = true">邪教</div>
                        <div class="delete">-</div>
                    </div>
                    <div class="type">
                        <div @click="modifyVisible = true">邪教</div>
                        <div class="delete">-</div>
                    </div>
                    <div class="type">
                        <div @click="modifyVisible = true">邪教</div>
                        <div class="delete">-</div>
                    </div>
                </div>
            </div>
        </div>
        <el-dialog :visible.sync="modifyVisible" width="515px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>修改</span>
            </div>
            <div class="modify">
                <span>新标题名称：</span>
                <el-input placeholder="至少两个字 不超过10个字"  class="kd" v-model="modifiedValue"></el-input>
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
    name: 'PageTypeManagement',
    components: {BreadCrumb},
    data: function() {	
        return {
            breadData: [{
            id: 1,
            name: '敏感词汇管理',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '类型管理',
            urls: '/index/PageTypeManagement',
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
    .jiah{width: 30px;height: 30px;background: #15bafe;color: #fff;font-size: 32px;text-align: center;line-height: 35px;}
    .opt-top{display: flex;align-items: center;}
    .opt-top>span{font-size: 14px;color:#222222}
    .inputd{width: 11%;}
    .all-type{border:1px solid #bfbfbf;padding: 30px 37px;margin-top: 20px;}
    .type{width: 120px;height: 35px;border: 1px solid #bfbfbf;border-radius: 4px;display: flex;justify-content: space-between;float: left;margin-left: 35px;}
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .type>div:nth-child(1){width: 70%;color:#a1a1a1;font-size: 14px;line-height: 35px;text-align: center;}
    .type>div:nth-child(1):hover{background: #15bafe;color: #fff;}
    .delete{width: 30%;background: #ff5858;font-size: 30px;color: #fff;line-height: 35px;text-align: center;}
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
    .modify{
        display: flex;
        align-items: center;
    }
    .kd{
        width: 50% !important;
        margin-left: 25px;
    }
    .btn{
        display: flex;
        justify-content:flex-end;
        margin-top: 30px;
        margin-bottom: 40px;
    }
</style>
<style lang="less">
    .inputd{
        .el-input__inner{
            height: 30px;
            border-radius: 0;
        }
    }
    .opt-top{
        .el-input{
            margin-right: 15px;
        }
    }
    .kd{
       .el-input__inner{
            height: 35px;
            border-radius: 0;
        } 
    }
</style>
