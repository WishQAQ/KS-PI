<template>
    <div class="DirectoryAllocation">
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">产品目录分配</p>
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
                            </div>
                            <div class="bot clearfloat">
                                <div class="one-hover">
                                    <div class="name">汽车配件</div>
                                </div>
                                <div class="one-hover">
                                    <div class="name">汽车配件</div>
                                </div>
                                <div class="one-hover">
                                    <div class="name">汽车配件</div>
                                </div>
                                <div class="one-hover">
                                    <div class="name">汽车配件</div>
                                </div>
                                <div class="one-hover">
                                    <div class="name">汽车配件</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 二级目录 -->
                    <div class="two-catalog">
                        <div class="shu two-color"></div>
                        <div class="information">
                            <div class="top">
                                <div class="til two-color" >二级目录</div>
                            </div>
                            <div class="bot clearfloat">
                                <div class="two-hover">
                                    <div class="name">保养零件</div>
                                </div>
                                <div class="two-hover">
                                    <div class="name">保养零件</div>
                                </div>
                                <div class="two-hover">
                                    <div class="name">保养零件</div>
                                </div>
                                <div class="two-hover">
                                    <div class="name">保养零件</div>
                                </div>
                                <div class="two-hover">
                                    <div class="name">保养零件</div>
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
                            </div>
                            <div class="bot clearfloat">
                                <div class="three-hover">
                                    <div class="name">常规保养</div>
                                </div>
                                <div class="three-hover">
                                    <div class="name">常规保养</div>
                                </div>
                                <div class="three-hover">
                                    <div class="name">常规保养</div>
                                </div>
                                <div class="three-hover">
                                    <div class="name">常规保养</div>
                                </div>
                                <div class="three-hover">
                                    <div class="name">常规保养</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 添加产品板块 -->
                <div class="search">
                    <el-input placeholder="输入产品类型" suffix-icon="el-icon-search" v-model="input2" class="inputl"></el-input>
                    <el-input placeholder="输入产品ID" suffix-icon="el-icon-search" v-model="input2" class="inputl"></el-input>
                </div>
                <div class="products clearfloat">
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>添加</el-button>
                    </div>
                </div>
                <!-- 现包含产品 -->
                <div class="three-catalog">
                    <div class="shu green"></div>
                    <div class="information">
                        <div class="top">
                            <div class="til green">现包含产品</div>
                        </div>
                        <div class="bot clearfloat">
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">空气进化器</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                           </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                            <div class="green-hover">
                                <div class="name" @click="tableVisible = true">常规保养</div>
                                <div class="tubiao"><i class="iconfont icon-trash delete_icon"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <el-dialog :visible.sync="tableVisible" width="720px">
            <el-tabs class="bj" v-model="activeName2" type="card" @tab-click="handleClick">
                <el-tab-pane label="选择框" name="first">
                   <div class="cont">
                       <div class="slename">
                           <div class="brand">品牌</div>
                           <div class="elect">单选</div>
                       </div>
                       <el-radio-group v-model="radio3">
                            <el-radio-button label="兰博基尼"></el-radio-button>
                            <el-radio-button label="法拉利"></el-radio-button>
                            <el-radio-button label="帕加尼"></el-radio-button>
                        </el-radio-group>
                        <div class="slename1">
                           <div class="brand">形状</div>
                           <div class="elect">单选</div>
                       </div>
                       <el-radio-group v-model="radio3">
                            <el-radio-button label="圆的"></el-radio-button>
                            <el-radio-button label="方的"></el-radio-button>
                            <el-radio-button label="扁的"></el-radio-button>
                        </el-radio-group>
                   </div>
                </el-tab-pane>
                <el-tab-pane label="数字区间" name="second">
                    <div class="cont clearfloat">
                        <div class="numb">
                            <div class="numb-top">
                                <div class="nmub-topLeft">最大电压</div>
                                <div class="nmub-topRight">小数点后一位</div>
                            </div>
                            <div class="numb-bot">26v</div>
                        </div>
                        <div class="numb">
                            <div class="numb-top">
                                <div class="nmub-topLeft">转数</div>
                                <div class="nmub-topRight">整数</div>
                            </div>
                            <div class="numb-bot">156.5RPM</div>
                        </div>
                        <div class="numb">
                            <div class="numb-top">
                                <div class="nmub-topLeft">长度</div>
                                <div class="nmub-topRight">小数点后一位</div>
                            </div>
                            <div class="numb-bot">226.5mm</div>
                        </div>
                    </div>
                </el-tab-pane>
            </el-tabs>
            <!-- <div class="tab">
                <div>选择框</div>
                <div>数字区间</div>
            </div> -->
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'PageDirectoryAllocation',
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
                name: '产品目录分配',
                urls: '/index/DirectoryAllocation',
                icon: 'icon-home'
            }],
            input2:"",
            tableVisible:false,
            activeName2: 'first',
            radio3: '上海',
        }
    },
    methods: {
        handleClick(tab, event) {
            console.log(tab, event);
        }
    }
}
</script>

<style scoped>
    .DirectoryAllocation{width: 100%; box-sizing: border-box;height: calc(100vh - 90px);}
    .bread{
        margin: 10px;
    }
    .content{
        background: white;
        margin-left: 10px;
        margin-right: 10px;
        width: 100%;
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
    .bot{}
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .bot>div{display: flex;width: 175px;height: 30px;justify-content: space-between;border: 1px solid #d2d2d2;color: #666666;line-height: 30px;font-size: 14px;float: left;margin-right: 25px;margin-top: 20px;}
    .one-hover:hover{border: 1px solid #1e88e5;color: #fff;box-shadow:2px 2px 1px #888888;background: #1e88e5;}
    .two-hover:hover{border: 1px solid #4dacff;color: #fff;box-shadow:2px 2px 1px #888888;background: #4dacff;}
    .three-hover:hover{border: 1px solid #26c6da;color: #fff;box-shadow:2px 2px 1px #888888;background: #26c6da;}
    .name{width: 100%;}
    .tubiao{background: #fff;line-height: 30px;width: 20%;color: #666666;}
    .til{width: 140px;height: 30px;background: #1e88e5;color: #fff;line-height: 30px;text-align: center;font-size: 16px;}
    .shu{width: 5px;background: #1e88e5;margin-right: 25px;}
    .two-color{background: #4dacff;}
    .three-color{background: #26c6da;}
    .search{display: flex;justify-content: left;margin-top: 55px;}
    .products{border: 1px solid #d2d2d2;margin-top: 25px;padding: 25px;box-sizing: border-box;height: 500px;overflow-y:scroll;}
    .product{width: 16.5%;height: 230px;float: left;}
    .img{width: 190px;height: 140px;border: 2px solid #d2d2d2;margin: 20px auto 0 auto;}
    .img>img{width: 100%;height: 100%;}
    /* .product>button{width: 65px;height: 30px;background: #fff;border: 1px solid #d2d2d2;border-radius: 4px;margin-top: 15px;white-space: nowrap;} */
    .el-button{margin-top: 15px;padding: 7px 20px;}
    .el-button:hover{color:#fff;background: #15bafe;}
    .green{background:#55ce63;}
    .green-hover:hover{border: 1px solid #55ce63;color: #fff;box-shadow:2px 2px 1px #888888;background: #55ce63;}
    /* 弹框 */
    /* .tab{display: flex;justify-content: left;}
    .tab>div{width: 107px;height: 37px;background: #f2f2f2;line-height: 37px;text-align: center;} */
    .cont{height: 280px;border:1px solid #d2d2d2;padding: 40px 37px;overflow-y:scroll;}
    .slename{width: 147px;height: 30px;display: flex;justify-content: space-between;border: 1px solid #15bafe;line-height: 30px;text-align: center;}
    .brand{width: 70%;background: #15bafe;color: #fff;}
    .elect{width: 30%;color: #15bafe;}
    .slename1{margin-top: 40px;width: 147px;height: 30px;display: flex;justify-content: space-between;border: 1px solid #15bafe;line-height: 30px;text-align: center;}
    .numb{width: 250px;float: left;margin-right: 30px;margin-bottom: 40px;}
    .numb-top{width: 195px;display: flex;border: 1px solid #15bafe;}
    .nmub-topLeft{width: 50%;background: #15bafe;color: #fff;}
    .nmub-topRight{width: 50%;color: #15bafe}
    .numb-bot{width: 90px;height: 30px;border:1px solid #bfbfbf;margin-top: 20px;line-height: 30px;text-align: center;color: #999999;}
    
</style>
<style lang="less">
.inputl{
    .el-input__inner{
        height: 30px;
        line-height:30px;
    }
}

.search{
    .el-input{
        width: 165px;
        height: 30px;
        margin-right:20px;
    }
}
    
    .el-input__icon{
        line-height:30px;
    }
    .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
        background: #15bafe;
        color: white;
    }
    .bj>.el-tabs__header .el-tabs__item{
        color: black;
        border-right: none !important;
        border-bottom: none !important;
        border-left: none !important;
        border-top: none !important;
        background: #f2f2f2;
    }
    .el-dialog__body{
        padding:0 20px 30px 20px;
    }
    .el-dialog__headerbtn{top:15px;}
    .el-tabs__header{
        margin:0;
    }
    .el-radio-group{
        margin-top:20px;
        display: flex;
    }
    .el-radio-button:first-child .el-radio-button__inner{
        border-radius:0;
    }
    .el-radio-button:last-child .el-radio-button__inner{
        border-radius:0;
    }
    .el-radio-button{
        margin-right:30px;
    }
    .el-radio-button__inner{
        border: 1px solid #dcdfe6;
    }
</style>
