<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">Header菜单名称</p>
            <div class="content_contain">
                <Category :categoryData="categoryData"></Category>
                <div class="menus clearfloat">
                    <div class="menu">
                        <div class="til">首页</div>
                        <el-input placeholder=""></el-input>
                        <div class="save">保存</div>
                    </div>
                    <div class="menu">
                        <div class="til">商城</div>
                        <el-input placeholder=""></el-input>
                        <div class="save">保存</div>
                    </div>
                    <div class="menu">
                        <div class="til">淘货</div>
                        <el-input placeholder=""></el-input>
                        <div class="save">保存</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
import Category from "../public/Category";
export default {
    name: 'PageWebsiteManagement',
    components: {
        BreadCrumb,
        Category
        },
    data: function() {	
        return {
            breadData: [{
            id: 1,
            name: '上传菜单',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '网站管理',
            urls: '/index/PageWebsiteManagement',
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
    .til{
        width: 125px; height: 40px;border: 1px solid #bfbfbf;
        font-size: 16px;color:#222222;
        line-height: 40px;text-align: center;
        border-radius: 4px;
    }
    .save{
        width: 70px;height: 30px;border: 1px solid #15bafe;
        font-size: 14px;color:#15bafe;
        line-height: 30px;text-align: center;
        border-radius: 4px;
    }
    .menus{
        margin-top: 25px;
    }
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .menu{
        display: flex;align-items: center;
        width: 540px;
        float: left;
        margin-right: 130px;
        margin-bottom: 30px;
    }
</style>
<style lang="less">
    .menu{
        .el-input{
            width: 300px;
            padding: 0 20px;
            border-radius: 4px;
        }
    }
</style>
