<template>
    <div class="videotitle">
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">小视频标题</p>
            <div class="content_contain">
                <div class="sle-til">
                    <div id="div" class="slect" @click="slect($event)">汽车</div>
                    <div id="div" @click="slect($event)">摩托车</div>
                    <div id="div" @click="slect($event)">无人机</div>
                    <div id="div" @click="slect($event)">智能设备</div>
                </div>
                <div class="add">
                    <span>视频小标题：</span>
                    <el-input v-model="inputTitle" placeholder="请输入内容" class="input"></el-input>
                    <img src="../../assets/image/jia.png" alt="" @click="add()">
                </div>
                <!-- 汽车 -->
                <div class="box clearfloat">
                    <div class="category" v-for="(item,index) in cartitles">
                        <div @click="show(index,cartitles)">{{item.name}}</div>
                        <img src="../../assets/image/jianh.png" alt="" >
                    </div>
                </div>
                <!-- 摩托 -->
                <div class="box clearfloat disp">
                    <div class="category" v-for="(item,index) in mototitles">
                        <div @click="show(index,mototitles)">{{item.name}}</div>
                        <img src="../../assets/image/jianh.png" alt="" >
                    </div>
                </div>
                <!-- 无人机 -->
                <div class="box clearfloat disp">
                    <div class="category" v-for="(item,index) in plantitles">
                        <div @click="show(index,plantitles)">{{item.name}}</div>
                        <img src="../../assets/image/jianh.png" alt="" >
                    </div>
                </div>
                <!-- 智能设备 -->
                <div class="box clearfloat disp">
                    <div class="category" v-for="(item,index) in intelligencetitles">
                        <div @click="show(index,intelligencetitles)">{{item.name}}</div>
                        <img src="../../assets/image/jianh.png" alt="" >
                    </div>
                </div>
            </div>
        </div>
        <!-- 修改弹框 -->
        <el-dialog :visible.sync="refundVisible" width="515px">
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
    name: 'PageVideoTitle',
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
            name: '小视频标题',
            urls: '/index/VideoTitle',
            icon: 'icon-home'
          }],
          inputTitle:'',
          modifiedValue:'', 
          refundVisible:false,
          cartitles:[
              {
                  id:1,
                  name:'汽车测评',
              },{
                  id:2,
                  name:'汽车干吧'
              }
          ],
          mototitles:[
              {
                  id:1,
                  name:'摩托测评',
              },{
                  id:2,
                  name:'摩托干吧'
              }
          ],
          plantitles:[
              {
                  id:1,
                  name:'飞机测评',
              },{
                  id:2,
                  name:'飞机干吧'
              }
          ],
          intelligencetitles:[
              {
                  id:1,
                  name:'智能测评',
              },{
                  id:2,
                  name:'智能干吧'
              }
          ],
          index:0,
          data:"",
          
        }
    },
    methods: {
        add(){
            // console.log(this.inputTitle)
            this.cartitles.push({id : this.cartitles.length+1,name : this.inputTitle})
            // console.log(this.cartitles)
        },
        save(index,n){
            // console.log(this.index)
            n[this.index].name = this.modifiedValue
            this.refundVisible = false
            // console.log(n)
        },
        show(index,n){
            console.log(n)
            this.refundVisible = true
            this.index = index
            this.data = n
            // console.log(this.cartitles[index].name)  
        },
        slect($event){
            console.log($event)
            var div = document.querySelectorAll("#div")
            var disdiv = document.querySelectorAll(".box")

            console.log(disdiv)     
            for(var i=0;i<div.length;i++){
                div[i].classList.remove("slect")
                disdiv[i].classList.remove("disp")
            }
            if($event.target.className == 'slect'){
                $event.target.classList.remove("slect")
            }else{
                $event.target.classList.add("slect")
            }  

        }
    }
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
    }
    .sle-til>div{
        width: 110px;
        height: 35px;
        line-height: 35px;
        text-align: center;
        border: 1px solid #bfbfbf; 
        color: #999999;
        margin-right: 20px;
    }
    .el-input{
        width: 170px !important;
        margin: 0 15px 0 25px;
    }
    .add{display: flex;align-items: center;margin-top: 25px;color: #222222;font-size: 16px;}
    .box{
        width: 100%;
        border: 1px solid #d2d2d2;
        padding: 0px 35px 30px 35px;
        box-sizing: border-box;
        margin-top: 25px;
    }
    .category{
        width: 15%;
        height: 35px;
        border: 1px solid #999999;
        float: left;
        margin:30px 0.7% 0 0.7%;
        display: flex;
        justify-content: space-between;
        border-radius: 5px;
    }
    .category>div{width: 90%;line-height: 35px;text-align: center;font-size:14px;color: #999999; }
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
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
    }
    .btn{
        display: flex;
        justify-content:flex-end;
        margin-top: 30px;
        margin-bottom: 40px;
    }
    .slect{
        background: #15bafe;
        color: #fff !important;
    }
    .disp{display: none;}
</style>
<style lang="less">
.input{
    .el-input__inner{
        height: 30px;
    }
}
.add{
    .el-input{
        width: 170px !important;
        margin: 0 15px 0 25px;
    }
}
    
</style>
