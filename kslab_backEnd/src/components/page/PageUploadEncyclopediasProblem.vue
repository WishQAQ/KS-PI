<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">上传百科&问题</p>
            <div class="content_contain">
                <div class="hd">
                    <div class="sle-til">
                        <div>汽车</div>
                        <div>摩托车</div>
                        <div>无人机</div>
                        <div>智能设备</div>
                    </div>
                </div>
                <div class="til">
                    <div class="car">汽车</div>
                    <div class="search">
                        <el-input placeholder="输入选项类型"  class="inputx"></el-input>
                        <div class="ico">
                            <i class="el-icon-plus"></i>
                        </div>
                    </div>
                </div>
                <div class="names clearfloat">
                    <div class="name">
                        <div class="name-n">基础理论、设计、模拟</div>
                        <div class="icos">
                            <i class="el-icon-delete"></i>
                        </div>
                    </div>
                    <div class="name">
                        <div class="name-n">材料、车内液体、机械零件</div>
                        <div class="icos">
                            <i class="el-icon-delete"></i>
                        </div>
                    </div>
                    <div class="name">
                        <div class="name-n">动力系统</div>
                        <div class="icos">
                            <i class="el-icon-delete"></i>
                        </div>
                    </div>
                    <div class="name">
                        <div class="name-n">无人驾驶</div>
                        <div class="icos">
                            <i class="el-icon-delete"></i>
                        </div>
                    </div>
                    <div class="name">
                        <div class="name-n">车身动力学，运动学</div>
                        <div class="icos">
                            <i class="el-icon-delete"></i>
                        </div>
                    </div>
                    <div class="name">
                        <div class="name-n">发动机</div>
                        <div class="icos">
                            <i class="el-icon-delete"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <el-dialog :visible.sync="refundVisible" width="515px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>解释编辑</span>
            </div>
            <el-input type="textarea" :rows="5" placeholder="请输入内容" v-model="textarea"></el-input>
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
    name: 'PageUploadEncyclopediasProblem',
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
            name: '上传百科&问题',
            urls: '/index/PageUploadEncyclopediasProblem',
            icon: 'icon-home'
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
    .hd{
        display: flex;
        justify-content: space-between;
        border-bottom: 1px solid #bfbfbf;
        padding-bottom: 20px;
    }
    .sle-til{display: flex;}
    .sle-til>div{width: 110px;height: 35px;border: 1px solid #bfbfbf;color: #999999;line-height: 35px;text-align: center;margin-right: 20px;}
    .til{display: flex;margin-top: 30px;}
    .car{width: 140px;height: 30px;background: #15bafe;color:#fff;font-size: 14px;line-height: 30px;text-align: center;}
    .search{display: flex;margin-left: 10px;width: 150px;}
    .ico{width: 32px;text-align: center;line-height: 30px;background: #15bafe;color: #fff;}
    .names{margin-top: 10px;padding: 15px 0;width: 675px;}
    .name{ height: 30px;display: flex;float: left;margin-right: 20px;margin-bottom: 15px;}
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .name-n{width: 280px;height: 30px;font-size: 14px;line-height: 30px;background: #fff;color:#d2d2d2;border: 1px solid #d2d2d2;}
    .icos{width: 32px;text-align: center;line-height: 30px;background: #fff;;height: 30px;visibility:hidden;border: 1px solid #d2d2d2;}
    .name:hover .icos{visibility:visible;color: #15bafe;border: 1px solid #15bafe;}
    .name:hover .name-n{background: #15bafe;color: #fff;border: 1px solid #15bafe;}
</style>
<style lang="less">
    .inputx{
        .el-input__inner{
            height: 30px;
            width: 125px;
            border-radius: 0;
            outline: none;
        }
    }
</style>
