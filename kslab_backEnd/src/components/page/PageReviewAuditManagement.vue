<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">评论审核管理</p>
            <div class="content_contain">
                <div class="name">
                    <el-input placeholder="" v-model="name" @keyup.13.native="addNewRefuse"></el-input>
                    <div class="add" @click="addNewRefuse">+</div>
                </div>
                <div class="name-box">
                    <div class="box" v-for="item in refuseList" :key="item.id">
                        <div>{{item.name}}</div>
                        <div @click="modifyRefuse(item.id)" class="button">修改</div>
                        <div @click="deleteRefuse(item.id)" class="button">删除</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 修改弹框 -->
        <el-dialog :visible.sync="modifyVisible" width="420px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>修改</span>
            </div>
            <div class="modify">
                <span>名称：</span>
                <el-input placeholder="输入新名称" v-model="newName" @keyup.13.native="confirmModify"></el-input>
            </div>
            <div class="btn">
                <el-button>取消</el-button>
                <el-button type="primary" @click="confirmModify">保存</el-button>
            </div>
        </el-dialog>
        <!--删除弹框-->
        <delete-modal ref="delete" @doDelete="confirmDelete"></delete-modal>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
import DeleteModal from "../public/modalDelete";
export default {
    name: 'PageReviewAuditManagement',
    components: {BreadCrumb,DeleteModal},
    data: function() {	
        return {
            breadData: [{
            id: 1,
            name: '上传菜单',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '评论审核管理',
            urls: '/index/PageReviewAuditManagement',
            icon: 'icon-home'
          }],
          modifyVisible:false,
          name:'',//驳回类别名称
          refuseList:[],//驳回类别列表
          id:'',//驳回类别id
          newName:'',//修改类别名称
        }
    },
    methods: {
        //获取驳回类别列表
        getRefuseList(){
            this.HttpClient.post('/admin/webReview/getList',{type:'answers'})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.refuseList=res.data.data;
                    }else{
                        this.refuseList=[]
                    }
                })
        },
        //新增驳回类别
        addNewRefuse(){
            this.HttpClient.post('/admin/webReview/create',{name:this.name,type:'answers'})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.name='';
                        this.$message.success(res.data.msg);
                        setTimeout(()=>{
                            this.getRefuseList()
                        },500)
                    }else{
                        this.$message.error(res.data.msg)
                    }
                })
        },
        //修改驳回类别按钮
        modifyRefuse(id){
            this.id=id;
            this.modifyVisible=true;
            // this.HttpClient.get('/admin/webReview/edit',{id:this.id})
            //     .then(res=>{
            //         console.log(re);
            //     })
        },
        //删除驳回类别按钮
        deleteRefuse(id){
            this.id=id;
            this.$refs.delete.deleteDialog=true;
        },
        //确认修改
        confirmModify(){
            if(this.newName){
                this.HttpClient.post('/admin/webReview/edit',{id:this.id,name:this.newName,type:'answers'})
                    .then(res=>{
                        console.log(res);
                        if(res.data.code===200){
                            this.$message.success(res.data.msg);
                            this.modifyVisible=false;
                            this.newName='';
                            setTimeout(()=>{
                                this.getRefuseList()
                            },500)
                        }else{
                            this.$message.error(res.data.msg)
                        }
                    })
            }else{
                this.$message.warning('请填写修改后的名称')
            }
        },
        //确认删除
        confirmDelete(){
            this.HttpClient.post('/admin/webReview/destroy',{id:this.id})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.$message.success(res.data.msg);
                        setTimeout(()=>{
                            this.getRefuseList()
                        },500)
                    }else{
                        this.$message.error(res.data.msg)
                    }
                })
        }
    },
    created(){
        this.getRefuseList()
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
    .name{
        display: flex;
    }
    .add{
        width: 40px;height: 28px;
        border: 1px solid #15bafe;
        font-size: 30px;color: #15bafe;
        border-radius: 4px;
        cursor:pointer;
    }
    .name-box{
        margin-top:12px; 
    }
    .box{
        display: flex;
        font-size: 14px;
        margin-bottom: 15px;
    }
    .box>div{text-align: center;line-height: 30px;margin-right: 15px;}
    .box>div:nth-child(1){
        width: 275px;
        height: 30px;
        border: 1px solid #bfbfbf;
        border-radius: 4px;
        color: #222222;
    }
    .box>div:nth-child(2){
        width: 60px;
        height: 30px;
        border: 1px solid #15bafe;
        background: #15bafe;
        border-radius: 4px;
        color: #fff;
    }
    .box>div:nth-child(3){
        width: 60px;
        height: 30px;
        border: 1px solid #15bafe;
        border-radius: 4px;
        color: #15bafe;
    }
    .box .button{
        cursor:pointer;
    }
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
    .btn{
        display: flex;
        justify-content:flex-end;
        margin-top: 30px;
        margin-bottom: 10px;
    }
</style>
<style lang="less">
    .name{
        .el-input{
            width: 275px;
            margin-right: 15px;
            .el-input__inner{
                height: 30px;
            }
        }
    }
    .modify{
        .el-input{
            width: 245px;
            .el-input__inner{
                height: 30px;
                border-radius: 0;
            }
        }
    }
</style>
