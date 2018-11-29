<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">词汇管理</p>
            <div class="content_contain">
                <div class="all-vocabulary">
                    <div class="all">当前共有250个词汇</div>
                    <div class="right" @click="addVisible = true">
                        <div class="ri-left">
                            <img src="../../assets/image/tianjia.png" alt="">
                        </div>
                        <div class="ri-right">
                            新增词汇
                        </div>
                    </div>
                </div>
                <div class="tables">
                    <el-table :data="tableData" border :stripe="true" style="width: 100%">
                        <el-table-column label="选择" width="100">
                            <template slot-scope="scope">
                                <el-checkbox></el-checkbox>
                            </template> 
                        </el-table-column>
                        <el-table-column prop="id" label="ID" width="150"></el-table-column>
                        <el-table-column prop="vocabulary" label="词汇" min-width="240"></el-table-column>
                        <el-table-column prop="phone" label="联系电话" width="200"></el-table-column>
                        <el-table-column prop="type" label="类型" width="200"></el-table-column>
                        <el-table-column prop="state" label="状态" width="200"></el-table-column>
                        <el-table-column prop="creationTime" label="创建时间" width="240"></el-table-column>
                        <el-table-column label="操作" width="240" fixed="right">
                            <template slot-scope="scope">
                                <el-button size="small" type="text" @click="identityConfirmVisible = true">禁用</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                    <div class="bot">
                        <div class="allcheck">
                            <template>
                                <el-checkbox  v-model="checkAll">全选</el-checkbox>
                            </template>
                        </div>
                        <div class="start">启用</div>
                        <div class="stop">禁用</div>
                    </div>
                    
                </div>
            </div>
        </div>
        <!-- 弹窗 -->
        <el-dialog :visible.sync="addVisible" width="515px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>新增词汇</span>
            </div>
            <div class="modify">
                <span>新词汇名称：</span>
                <el-input placeholder="至少两个字 不超过10个字"  class="kd" v-model="modifiedValue"></el-input>
            </div>
            <div class="leibie">
                <span>类别：</span>
                <div class="leixs">
                    <div>色情</div>
                    <div>政治</div>
                    <div>扰乱社会</div>
                    <div>封建迷信</div>
                </div>
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
    name: 'PageSensitiveVocabulary',
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
            name: '词汇管理',
            urls: '/index/page-sensitive-vocabulary',
            icon: 'icon-home'
          }],
          checkAll:"",
          tableData:[{
            id: 1,
            vocabulary:"牛逼",
            phone:"1234655684",
            type:"脏话谩骂",
            state:"正常",
            creationTime:"2018/10/12"
          },
          {
            id: 2,
            vocabulary:"牛逼",
            phone:"1234655684",
            type:"脏话谩骂",
            state:"正常",
            creationTime:"2018/10/12"
          },
          {
            id: 3,
            vocabulary:"牛逼",
            phone:"1234655684",
            type:"脏话谩骂",
            state:"正常",
            creationTime:"2018/10/12"
          },],
          addVisible:false,
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
    .all-vocabulary{display:flex;justify-content: space-between;}
    .all{
        width: 160px;height: 35px;background: #15bafe;color:#fff;font-size: 14px;
        line-height: 35px;text-align: center;
    }
    .right{display: flex;width: 96px;justify-content: space-between;height: 30px;}
    .right>div{background: #15bafe;}
    .ri-left{width: 32%;display: flex;align-items: center;justify-content: center;}
    .ri-right{width: 66%;line-height: 30px; text-align: center;font-size: 14px;color: #fff;}
    .bot{display: flex;margin-top: 30px;}
    .allcheck{height: 35px;background: #15bafe;color:#fff;width: 80px;line-height: 35px;border: 1px solid #15bafe;}
    .start{height: 35px;padding:0 15px;color: #bfbfbf;border: 1px  solid #bfbfbf;line-height: 35px;text-align: center;font-size: 14px;margin: 0 10px;}
    .stop{height: 35px;padding:0 15px;color: #bfbfbf;border: 1px  solid #bfbfbf;line-height: 35px;text-align: center;font-size: 14px;}
    .start:hover{border: 1px solid #15bafe;background: #15bafe;color: #fff;}
    .stop:hover{border: 1px solid #ff5858;background: #ff5858;color: #fff;}
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
    .btn{
        display: flex;
        justify-content:flex-end;
        margin-top: 30px;
        margin-bottom: 40px;
    }
    .leixs{margin-left: 112px;}
    .leixs>div{width: 285px;height: 35px;border:1px solid #bfbfbf;margin-bottom: 5px;border-radius: 4px;color:#bfbfbf;line-height: 35px;text-align: center;}
    .leibie{display: flex;margin-top: 30px;color:#bfbfbf;line-height: 35px;text-align: center;}
</style>
<style lang="less">
    // .tables{
    //     .el-table{
    //         .el-table__header-wrapper{
    //             .el-table__header{
    //                 .has-gutter{
    //                     color:#fff;
    //                     tr{
    //                         background-color: #15bafe;
    //                     }
    //                 }
    //             }    
    //         }
    //     }
    // }
    .el-table th{
        background-color: #15bafe;
    }
    .el-table thead{
        color: #fff;
    }
    .allcheck{
        .el-checkbox{
            color: #fff;
        }
    }
    .el-checkbox__input.is-checked+.el-checkbox__label{
        color:#fff;
    }
    .cell{
        text-align:center;
    }
    .modify{
        .el-input{
            width: 60%;
            margin-left: 70px;
        }
    }
</style>
