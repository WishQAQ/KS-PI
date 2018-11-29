<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">上传协议管理</p>
            <div class="content_contain">
                <Category :categoryData="categoryData"></Category>
                <div class="til">
                    <span class="biaoti1">标题：</span>
                    <el-input placeholder="请输入内容"></el-input>
                </div>
                <div class="edit">
                    <span class="biaoti2">协议内容：</span>
                    <div class="edit-box">
                        <div id="editor">
                            <p></p>
                        </div>
                    </div>
                </div>
                <div class="btn">
                    <el-button>取消</el-button>
                    <el-button type="primary" @click="save(index,data)" :id="index" :data="data">保存</el-button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
import Category from "../public/Category";
export default {
    name: 'PageUploadProtocolManagement',
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
            name: '上传协议管理',
            urls: '/index/PageUploadProtocolManagement',
            icon: 'icon-home'
          }],
          categoryData:[{
                id:1,
                name:'商品',
            },{
                id:2,
                name:'服务',
            },{
                id:3,
                name:'活动',
            },{
                id:4,
                name:'视频',
            },{
                id:5,
                name:'百科',
            },{
                id:6,
                name:'淘货',
            },{
                id:7,
                name:'文章',
            }],
        }
    },
    mounted(){
        var E = require('wangeditor')
        var editor = new E('#editor')
        // 自定义菜单配置
        editor.customConfig.menus = [
            'head',  // 标题
            'bold',  // 粗体
            'fontSize',  // 字号
            'fontName',  // 字体
            'italic',  // 斜体
            'underline',  // 下划线
            'strikeThrough',  // 删除线
            'foreColor',  // 文字颜色
            'backColor',  // 背景颜色
            'link',  // 插入链接
            'list',  // 列表
            'justify',  // 对齐方式
            'quote',  // 引用
            'emoticon',  // 表情
            'image',  // 插入图片
            'table',  // 表格
            'video',  // 插入视频
            'code',  // 插入代码
            'undo',  // 撤销
            'redo'  // 重复
        ]
        editor.create()
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
    .til{text-align: left;margin-top: 25px;}
    .edit{display: flex;margin-top: 30px;}
    .edit-box{width: 810px;height: 340px;}
    span{font-size: 14px;color: #222222;}
    .biaoti1{margin-right:33px;}
    .biaoti2{margin-right: 10px;}
    .btn{
        display: flex;
        justify-content:flex-start;
        margin-top: 30px;
        margin-left:700px; 
        margin-bottom: 10px;
    }
</style>
<style lang="less">
    .til{
        .el-input{
            width: 240px;
            .el-input__inner{
                height: 30px;
                border-radius: 0;
            }
        }
    }
</style>
