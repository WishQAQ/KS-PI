<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <div class="top">
                <p class="title">收支提示</p>
                <div class="right" @click="addVisible = true">
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
                    <el-table   :data="tableData" border :stripe="true" :header-row-style="{height:'40px'}" :header-cell-style="{padding:0}" :row-style="{height:'40px'}" :cell-style="{padding:0}" style="width: 100%">
                        <el-table-column prop="id" label="ID" width="80"></el-table-column>
                        <el-table-column prop="category" label="类别" min-width="110"></el-table-column>
                        <el-table-column prop="subcategory" label="子类别" width="120"> </el-table-column>
                        <el-table-column prop="event" label="事件" width="350"> </el-table-column>
                        <el-table-column prop="abstract" label="摘要" width="100"> </el-table-column>
                        <el-table-column prop="info" label="信息内容" width="200"> 
                            <template slot-scope="scope">
                                <div class="box">
                                    <span>商品</span>
                                    <span>系统已完成打款，请查收</span>
                                </div>
                            </template>
                        </el-table-column>
                        <el-table-column prop="remarks" label="备注" width="145"></el-table-column>
                        <el-table-column prop="color" label="颜色" width="135"></el-table-column>
                        <el-table-column prop="code" label="Code" width="120"> </el-table-column>
                        <el-table-column label="操作" width="200" fixed="right">
                            <template slot-scope="scope">
                                <el-button size="small" type="text" @click="modifyVisible = true">修改</el-button>
                                <el-button size="small" type="text">删除</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
            </div>
        </div>
        <!-- 弹框    -->
        <el-dialog :visible.sync="addVisible" width="950px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>添加</span>
            </div>
            <form action="">
                <div class="form-left">
                    <p><span>类别：</span><input type="text" placeholder="阿伏伽德罗常数"></p>
                    <p>子类别：<input type="text" placeholder="Activit/uploading"></p>
                    <p>摘要：<input type="text" placeholder="订单号"></p>
                    <p>
                        信息：<input type="text" placeholder="">
                        <button>+</button>
                    </p>
                    <div class="info">
                        <div class="info-xx">
                            <div>商品</div>
                            <div>-</div>
                        </div>
                        <div class="info-xx">
                            <div>系统已完成打款，请查收</div>
                            <div>-</div>
                        </div>
                    </div>
                </div>
                <div class="form-right">
                    <div class="event">
                        <p>事件：</p>
                        <textarea name="" id="" cols="30" rows="10"></textarea>
                    </div>
                    <div class="remarks">
                        <p>备注：</p>
                        <textarea name="" id="" cols="30" rows="10"></textarea>
                    </div>
                    <div class="state">
                        <p>状态：</p>
                        <div class="colors">
                            <div>红色</div>
                            <div>绿色</div>
                            <div>紫色</div>
                            <div>蓝色</div>
                            <div>黑色</div>
                            <div>白色</div>
                        </div>
                    </div>
                    <div class="btn">
                        <button>取消</button>
                        <button>保存</button>
                    </div>
                </div>
            </form>
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'PageRevenueExpenditureHints',
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
            name: '收支提示',
            urls: '/index/PageRevenueExpenditureHints',
            icon: 'icon-home'
          }],
          addVisible:false,
          tableData:[
            {
                id:22,
                category:"收入",
                subcategory:"商城收入",
                event:"用户确认商品到货后，商家收到系统的打款，商家收到系统的打款",
                abstract:'订单号',
                remarks:"用户",
                color:"红色",
                code:1965,
            },{
                id:22,
                category:"收入",
                subcategory:"商城收入",
                event:"用户确认商品到货后，商家收到系统的打款，商家收到系统的打款",
                abstract:'订单号',
                remarks:"用户",
                color:"红色",
                code:1965,
            },{
                id:22,
                category:"收入",
                subcategory:"商城收入",
                event:"用户确认商品到货后，商家收到系统的打款，商家收到系统的打款",
                abstract:'订单号',
                remarks:"用户",
                color:"红色",
                code:1965,
            }],
            form: {
                name: '',
            }
        }
    },
    methods: {}
}
</script>

<style scoped>
    /* 头 */
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
    .box{padding: 10px 0 0 0;}
    .box>span{display: block; height: 30px;background: #15bafe;color:#fff;font-size: 14px;margin-bottom: 10px;line-height: 30px;}
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
    .form-left{
        width: 50%;
        /* border: 1px solid #000; */
        /* height: 435px; */
        padding: 0 15px 15px 15px ;
        box-sizing: border-box;
    }
    .form-right{
        width: 50%;
        /* border: 1px solid #000; */
        height: 435px;
        padding: 0 15px 15px 15px ;
        box-sizing: border-box;
    }
    form{display: flex;justify-content: space-between;}
    .form-left .info{
        width: 100%;
        border: 1px solid #bfbfbf;
        margin-top: 25px;
    }
    .form-left>p{
        height: 35px;
        margin-top: 30px;
        /* margin-left: 15px; */
        display: flex;justify-content: left;align-items: center;
    }
    .form-left>p>input{
        height: 35px;
        border-radius:5px; 
        outline: none;
        border: 1px solid #bfbfbf;
        padding: 0 10px;
        text-align: center;
        margin-left:75px;
    }
    .info{padding: 20px 25px;box-sizing: border-box;}
    .info-xx{height: 35px;border-radius: 3px;display: flex;justify-content:start;margin-bottom: 15px;}
    .info-xx>div:nth-child(1){background: #15bafe;color: #fff;font-size: 14px;padding: 0 25px;text-align: center;line-height: 35px;}
    .info-xx>div:nth-child(2){background: #ff5858;color: #fff;font-size: 30px;padding: 0 5px;text-align: center;line-height: 35px;}
    .form-left>p:nth-child(2)>input{
        margin-left: 60px;
    }
    .form-left>p>span{
        width: 110;
        display: block;
    }
    .form-left>p>button{width: 58px;height: 35px;background: #15bafe;border: 0;border-radius: 5px;font-size: 30px;color: #fff;margin-left: 15px;}
    .event,.remarks{display: flex;margin-top: 30px;}
    textarea{width: 285px;height: 100px;border-radius: 4px;margin-left: 35px;}
    .state{display: flex;margin-top: 25px;}
    .colors{margin-left: 35px;padding: 0 0 0 0px;width: 305px;}
    .colors>div{
        height: 30px;border: 1px solid #bfbfbf;padding: 0 13px;float: left;margin-right: 20px;margin-bottom: 10px;
        line-height: 30px;
        text-align: center;
    }
    .btn{margin-top: 40px;text-align: right;}
    .btn>button{outline:none;width: 90px;height: 32px;border-radius: 5px;}
    .btn>button:nth-child(1){background: #fff;color: #15bafe;border: 1px solid #15bafe;}
    .btn>button:nth-child(2){background: #15bafe;color: #fff;border: 1px solid #15bafe;margin-left: 30px;}
</style>
<style>
    /* .father{ */
        .el-form-item__label{
             width: 125px;
             border: 1px solid #000;
        }
    /* } */
</style>

