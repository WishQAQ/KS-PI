<template>
    <div class="account">
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <div class="top">
                <p class="title">收支管理</p>
                <div class="right" @click="modifyVisible = true">
                    <div class="ri-left">
                        <img src="../../assets/image/tianjia.png" alt="">
                    </div>
                    <div class="ri-right">
                        添加
                    </div>
                </div>
            </div>
            <div class="content_contain">
                <div class="tables">
                    <el-table :data="tableData" border :stripe="true" :header-row-style="{height:'40px'}" :header-cell-style="{padding:0}" :row-style="{height:'40px'}" :cell-style="{padding:0}" style="width: 100%">
                        <el-table-column prop="id" label="ID" width="80"></el-table-column>
                        <el-table-column prop="category" label="类别" min-width="110"></el-table-column>
                        <el-table-column prop="subcategory" label="子类别" width="120"> </el-table-column>
                        <el-table-column prop="event" label="事件" width="365"> </el-table-column>
                        <el-table-column prop="info" label="信息类容" width="270"> </el-table-column>
                        <el-table-column prop="initiatingObject" label="发起对象" width="145"></el-table-column>
                        <el-table-column prop="actionObject" label="作用对象" width="135"></el-table-column>
                        <el-table-column prop="code" label="Code" width="120"> </el-table-column>
                        <el-table-column label="操作" width="200" fixed="right">
                            <template slot-scope="scope">
                                <el-button size="small" type="text" @click="modifyVisible = true">恢复</el-button>
                                <el-button size="small" type="text">修改</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <el-dialog :visible.sync="modifyVisible" width="515px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>修改</span>
            </div>
            <el-form ref="form" :model="form" label-width="90px">
                <el-form-item label="权限名称：">
                    <el-input v-model="form.name" class="input"></el-input>
                </el-form-item>
                <el-form-item label="方法：">
                    <el-input v-model="form.name" class="input"></el-input>
                </el-form-item>
                <el-form-item label="发起对象">
                    <el-radio-group v-model="form.resource">
                        <el-radio label="商家和用户"></el-radio>
                        <el-radio label="商家"></el-radio>
                        <el-radio label="用户"></el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="作用对象">
                    <el-radio-group v-model="form.resource">
                        <el-radio label="商家和用户"></el-radio>
                        <el-radio label="商家"></el-radio>
                        <el-radio label="用户"></el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="事件：">
                    <el-input type="textarea" v-model="form.desc" placeholder="100字内介绍" class="textarea"></el-input>
                </el-form-item>
                <el-form-item label="信息内容：">
                    <el-input type="textarea" v-model="form.desc" placeholder="100字内介绍" class="textarea"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" >确定</el-button>
                    <el-button>取消</el-button>
                </el-form-item>
            </el-form>
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'PageAccount',
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
                name: '收支管理',
                urls: '/index/Account',
                icon: 'icon-home'
            }],
            tableData:[
                {
                    id:22,
                    category:"收入",
                    subcategory:"商城收入",
                    event:"用户确认商品到货后，商家收到系统的打款，商家收到系统的打款",
                    info:"订单号，XXXXX已到账，商场",
                    initiatingObject:"用户",
                    actionObject:"商家",
                    code:1965,
                },{
                    id:23,
                    category:"收入",
                    subcategory:"商城收入",
                    event:"用户确认商品到货后，商家收到系统的打款，商家收到系统的打款",
                    info:"订单号，XXXXX已到账，商场",
                    initiatingObject:"用户",
                    actionObject:"商家",
                    code:1965,
                },{
                    id:24,
                    category:"收入",
                    subcategory:"商城收入",
                    event:"用户确认商品到货后，商家收到系统的打款，商家收到系统的打款",
                    info:"订单号，XXXXX已到账，商场",
                    initiatingObject:"用户",
                    actionObject:"商家",
                    code:1965,
                },{
                    id:25,
                    category:"收入",
                    subcategory:"商城收入",
                    event:"用户确认商品到货后，商家收到系统的打款，商家收到系统的打款",
                    info:"订单号，XXXXX已到账，商场",
                    initiatingObject:"用户",
                    actionObject:"商家",
                    code:1965,
                }
            ],
            modifyVisible:false,
            form: {
          name: '',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '',
          desc: ''
        }
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
        
        font-size: 14px;
        
        box-sizing: border-box;
    }
    .content_contain{
        padding: 30px 55px;
        
    }
    .top{display: flex;justify-content: space-between;border-bottom: 1px solid #f2f2f2;padding: 10px 20px;
       box-sizing: border-box;}
    .right{display: flex;width: 96px;justify-content: space-between;height: 30px;}
    .right>div{background: #15bafe;}
    .ri-left{width: 32%;display: flex;align-items: center;justify-content: center;}
    .ri-right{width: 66%;line-height: 30px; text-align: center;font-size: 14px;color: #fff;}
    /* 弹框 */
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
    .input{width: 80%;}
</style>
<style lang="less">
    .el-table th>.cell{
        text-align: center;
    }
    .el-table th{
        background-color: #15bafe;
    }
    .el-table thead{
        color: #fff;
    }
    
.input{
    .el-input__inner{width: 80%;}
}    
.textarea{
    .el-textarea__inner{width: 80%;margin-left:70px;}
}
    
</style>
