<template>
    <div class="DirectoryAllocation">
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">修改产品类型</p>
            <div class="content_contain">
                <div class="sle-til">
                    <div>汽车</div>
                    <div>摩托车</div>
                    <div>无人机</div>
                    <div>智能设备</div>
                </div>
                
                <!-- 添加产品板块 -->
                <div class="search">
                    <el-input placeholder="输入产品类型" suffix-icon="el-icon-search" v-model="input2" class="inputg"></el-input>
                    <el-input placeholder="输入产品ID" suffix-icon="el-icon-search" v-model="input2" class="inputg"></el-input>
                </div>
                <div class="products clearfloat">
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/cilun.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                    <div class="product">
                        <div class="img">
                            <img src="../../assets/image/koala1.jpg" alt="">
                        </div>
                        <el-button>修改</el-button>
                    </div>
                </div>
                <div class="braking">制动盘</div>
                <!-- 更改图片 -->
                <div class="upload">
                    <div class="img-container">
                        <img src="../../assets/image/koala1.jpg" alt="">
                        <label for="file">修改图片</label>
                    </div>
                    <input type="file" @change="getFile" ref="file" id="file" style="display:none">
                </div>
                <!-- 自定义 -->
                <div class="custom">
                    <div class="custom-left">
                        <span>自定义：</span>
                        <div>选择框</div>
                        <div>数字区间</div>
                    </div>
                    <div class="custom-right" @click="addVisible = true">
                        <div class="cus-left">
                            <img src="../../assets/image/tianjia.png" alt="">
                        </div>
                        <div class="cus-right">
                            添加
                        </div>
                    </div>
                </div>
                <!-- 类型和选项 -->
                <div class="type">
                    <!-- 类型 -->
                    <div class="type-top">
                        <span>类型：</span>
                        <div>单选</div>
                        <div>多选</div>
                    </div>
                    <div class="type-bot clearfloat">
                        <div class="specific">
                            <div>品牌</div>
                            <div>-</div>
                        </div>
                        <div class="specific">
                            <div>形状</div>
                            <div>-</div>
                        </div>
                        <div class="specific">
                            <div>用途</div>
                            <div>-</div>
                        </div>
                    </div>
                    <!-- 现有选项 -->
                    <div class="now-option">
                        <div class="opt-top">
                            <span>现有选项：</span>
                            <el-input class="inputj" placeholder="请输入产品类别名称"></el-input>
                            <div class="jiah">+</div>
                        </div>
                        <div class="all-type clearfloat">
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                            <div>法拉利</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <el-dialog :visible.sync="addVisible" width="505px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>添加</span>
            </div>
            <div class="modify">
                <span>标题：</span>
                <el-input placeholder="输入选项类型"  class="kd"></el-input>
                <div class="jiah">+</div>
            </div>
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
            addVisible:false,
            src: '../../assets/image/koala1.jpg',
            breadData: [{
                id: 1,
                name: '后端页面',
                urls: '/index',
                icon: 'icon-home'
            },{
                id: 2,
                name: '修改产品类型',
                urls: '/index/PageDirectoryAllocation',
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
        },
        getFile (e) {
            let _this = this
            var files = e.target.files[0]
            if (!e || !window.FileReader) return  // 看支持不支持FileReader
            let reader = new FileReader()
            reader.readAsDataURL(files) // 这里是最关键的一步，转换就在这里
            reader.onloadend = function () {
                _this.src = this.result
            }
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
    .search{display: flex;justify-content: left;margin-top: 30px;}
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
    .braking{width: 325px;height: 35px;border-radius: 4px;border: 1px solid #bfbfbf;text-align: center;line-height: 35px;color:#666666;margin-top: 45px;}
    .upload{text-align:left;margin-top: 20px;}
    .img-container>label{width: 70px;height: 25px;background: #15bafe;display: block;font-size: 12px;color:#fff;line-height: 25px;text-align: center;position: absolute;bottom: 10px;right:20px;}
    .img-container{width: 325px;height: 240px;border:1px dashed #d9d9d9 ;position: relative;padding: 10px 20px;}
    .img-container>img{width:100% ;height: 100%;}
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
    .modify{display: flex;justify-content: center;align-items: center;margin:40px 0;}
    .modify>span{margin-right: 40px;}
    .jiah{width: 30px;height: 30px;background: #15bafe;color: #fff;font-size: 32px;text-align: center;line-height: 35px;}
    .custom{
        display: flex;justify-content: space-between;
        width: 50%;margin-top: 40px;border-bottom:1px solid #bfbfbf;
        padding-bottom: 20px;
  }
  .custom-left{
        display: flex;align-items: center;
  }
  .custom-left>span{
        color: #222222;font-size: 14px;margin-right:14px;
  }
  .custom-left>div{
        width:110px ;height: 30px;color:#a9a9a9;margin-right:22px;
        text-align: center;line-height: 30px;border: 1px solid #bfbfbf; 
        font-size: 14px;
        color:#bfbfbf; 
  }
  .custom-right{
    width: 95px;height: 30px;
    border: 1px solid #fff; 
    display: flex;
    justify-content: space-between;
    border-radius: 5px;
  }
    .cus-left{
        background: #15bafe;
        width: 25%;
        display: flex;align-items: center;
        justify-content: center;
    }
    .cus-right{background: #15bafe;width: 74%;color: #fff;line-height: 30px;text-align: center;font-size: 14px;}
    .type{text-align: left;margin-top: 20px;}
    .type-top{
        display: flex;align-items: center;
    }
    .type-top>div{
        width:110px ;height: 30px;color:#a9a9a9;margin-right:22px;
        text-align: center;line-height: 30px;border: 1px solid #bfbfbf; 
        font-size: 14px;
        color:#bfbfbf; 
    }
    .type-top>span{
        color: #222222;font-size: 14px;margin-right:28px;
  }
    .specific{
        width: 120px;height: 35px;
        /* border: 1px solid #bfbfbf; */
        display: flex;justify-content: space-between;
        font-size: 14px;
    }
    .type-bot{margin-top: 28px;padding: 0 70px;}
    .type-bot>div{float: left;margin-right: 50px;}
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .type-bot>div:first-child{margin-bottom: 25px;}
    .specific>div:first-child{width: 80%;background: #15bafe;text-align: center;line-height: 35px;color: #fff;}
    .specific>div:last-child{width: 20%;background: #ff5858;text-align: center;line-height: 35px;font-size: 24px;color: #fff;}
    .jiah{width: 30px;height: 30px;background: #15bafe;color: #fff;font-size: 32px;text-align: center;line-height: 35px;}
    .opt-top{display: flex;align-items: center;}
    .opt-top>span{font-size: 14px;color:#222222}
    .all-type{border:1px solid #d2d2d2;margin: 25px 70px;padding: 25px 30px;box-sizing: border-box; width: 50%;}
    .all-type>div{width: 90px;height: 30px;border:1px solid #d2d2d2; float: left;margin: 0 30px 25px 0;color: #999999;font-size: 14px;line-height: 30px;text-align: center;}
    .inputj{width: 10%;}
</style>
<style lang="less">
.inputg{
    .el-input__inner{
        height: 30px;
        line-height:30px;
    }
}
.modify{
    .el-input{
        width: 200px;
        margin-right: 15px;
    }
}   
.search{
    .el-input{
        width: 165px;
        height: 30px;
        margin-right:20px;
    }
}
.inputj{
    .el-input__inner{
        width: 100%;
        height: 30px;
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
