<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">目录管理</p>
            <div class="content_contain">
                <div class="sle-til">
                    <div>汽车</div>
                    <div>摩托车</div>
                    <div>无人机</div>
                    <div>智能设备</div>
                </div>
                <!-- 目录添加列表 -->
                <div class="list">
                    <!-- 一级目录 -->
                    <div class="one-catalog">
                        <div class="shu"></div>
                        <div class="information">
                            <div class="top">
                                <div class="til">一级目录</div>
                                <div class="inp">
                                    <el-input v-model="input" placeholder="汽车配件"></el-input>
                                    <div class="add">+</div>
                                </div>
                            </div>
                            <div class="bot clearfloat">
                                <div class="one-hover">
                                    <div class="name" @click="modifyVisible = true">汽车配件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="one-hover">
                                    <div class="name" @click="modifyVisible = true">汽车配件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="one-hover">
                                    <div class="name" @click="modifyVisible = true">汽车配件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="one-hover">
                                    <div class="name" @click="modifyVisible = true">汽车配件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="one-hover">
                                    <div class="name" >汽车配件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 二级目录 -->
                    <div class="two-catalog">
                        <div class="shu two-color"></div>
                        <div class="information">
                            <div class="top">
                                <div class="til two-color">二级目录</div>
                                <div class="inp">
                                    <el-input v-model="input" placeholder="汽车配件"></el-input>
                                    <div class="add two-color" >+</div>
                                </div>
                            </div>
                            <div class="bot clearfloat">
                                <div class="two-hover">
                                    <div class="name" @click="modifyVisible = true">保养零件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="two-hover">
                                    <div class="name" @click="modifyVisible = true">保养零件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="two-hover">
                                    <div class="name" @click="modifyVisible = true">保养零件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="two-hover">
                                    <div class="name" @click="modifyVisible = true">保养零件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="two-hover">
                                    <div class="name" @click="modifyVisible = true">保养零件</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 三级目录 -->
                    <div class="three-catalog">
                        <div class="shu three-color"></div>
                        <div class="information">
                            <div class="top">
                                <div class="til three-color">三级目录</div>
                                <div class="inp">
                                    <el-input v-model="input" placeholder="汽车配件"></el-input>
                                    <div class="add three-color">+</div>
                                </div>
                            </div>
                            <div class="bot clearfloat">
                                <div class="three-hover">
                                    <div class="name" @click="modifyVisible = true">常规保养</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="three-hover">
                                    <div class="name" @click="modifyVisible = true">常规保养</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="three-hover">
                                    <div class="name" @click="modifyVisible = true">常规保养</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="three-hover">
                                    <div class="name" @click="modifyVisible = true">常规保养</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                                <div class="three-hover">
                                    <div class="name" @click="modifyVisible = true">常规保养</div>
                                    <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <el-dialog :visible.sync="modifyVisible" width="420px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>修改</span>
            </div>
            <div class="tkinp">
                <span>名称：</span>
                <input type="text" placeholder="输入新名称">
            </div>
            <div class="btn">
                <button>取消</button>
                <button>保存</button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'PageProfessionalCategory',
    components: {BreadCrumb},
    data: function() {	
        return {
            breadData: [{
            id: 1,
            name: '专业目录管理',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '目录管理',
            urls: '/index/page/page-professional-category',
            icon: 'icon-home'
          }],
          input:"",
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
    .sle-til{
        display: flex;
        border-bottom: 1px solid #bfbfbf;
    }
    .sle-til>div{
        width: 110px;
        height: 35px;
        line-height: 35px;
        text-align: center;
        border: 1px solid #bfbfbf; 
        color: #999999;
        margin-right: 20px;
        margin-bottom: 20px;
    }
    .one-catalog,.two-catalog,.three-catalog{
        padding: 35px 0;
        display: flex;
        border-bottom: 1px solid #bfbfbf;
    }
    .top{display: flex;}
    .inp{display: flex;width: 175px;height: 30px;margin-left: 40px;justify-content: space-between;}
    .add{background: #1e88e5;font-size: 27px;color: #fff;width: 25%;}
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .bot>div{display: flex;width: 175px;height: 30px;justify-content: space-between;border: 1px solid #d2d2d2;color: #666666;line-height: 30px;font-size: 14px;float: left;margin-right: 25px;margin-top: 20px;}
    .one-hover:hover{border: 1px solid #1e88e5;color: #fff;box-shadow:2px 2px 1px #888888;background: #1e88e5;}
    .two-hover:hover{border: 1px solid #4dacff;color: #fff;box-shadow:2px 2px 1px #888888;background: #4dacff;}
    .three-hover:hover{border: 1px solid #26c6da;color: #fff;box-shadow:2px 2px 1px #888888;background: #26c6da;}
    .name{width: 80%;border-right:1px solid #d2d2d2;}
    .tubiao{background: #fff;line-height: 30px;width: 20%;color: #666666;}
    .til{width: 140px;height: 30px;background: #1e88e5;color: #fff;line-height: 30px;text-align: center;font-size: 16px;}
    .shu{width: 5px;background: #1e88e5;margin-right: 25px;}
    .two-color{background: #4dacff;}
    .three-color{background: #26c6da;}
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
    .tkinp>input{
        width: 250px;height: 30px;padding: 0 15px;border-radius: 5px;
        border: 1px solid #bfbfbf;outline: none;
    }
    .btn{margin-top: 40px;text-align: right;}
    .btn>button{outline:none;width: 90px;height: 32px;border-radius: 5px;}
    .btn>button:nth-child(1){background: #fff;color: #15bafe;border: 1px solid #15bafe;}
    .btn>button:nth-child(2){background: #15bafe;color: #fff;border: 1px solid #15bafe;margin-left: 30px;}
</style>
<style lang="less">
    .inp{
        .el-input{
            .el-input__inner{
                height: 30px;
                line-height:30px;
                outline:0 !important;
                border-radius:0;
            }
        }
        
    }
    
</style>