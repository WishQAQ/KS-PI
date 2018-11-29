<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <div class="title">
                <p>社会招聘</p>
                <p>
                    <img src="../../assets/image/new.png" alt="">
                    <span>刷新</span>
                </p>
            </div>
            <div class="content_contain">
                <div class="choice">
                    <div class="choice-left">
                        <el-select v-model="value" placeholder="时间排列">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                        <el-select v-model="value" placeholder="学校选择">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                        <el-select v-model="value" placeholder="状态选择">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                        <el-select v-model="value" placeholder="教育程度">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                        <el-select v-model="value" placeholder="应聘职位">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                    </div>
                    <div class="choice-right">
                        <el-select v-model="value" placeholder="按综合得分">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                        <el-select v-model="value" placeholder="按专业能力">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"></el-option>
                        </el-select>
                    </div>
                </div>
                <div class="tables">
                    <el-table :data="list" border :stripe="true" :header-row-style="{height:'40px'}" :header-cell-style="{padding:0}" :row-style="{height:'40px'}" :cell-style="{padding:0}" style="width: 100%">
                        <el-table-column label="选择" width="50">
                            <template slot-scope="scope">
                                <el-checkbox></el-checkbox>
                            </template> 
                        </el-table-column>
                        <el-table-column prop="id" label="ID" width="50"></el-table-column>
                        <el-table-column prop="name" label="姓名" width="130"></el-table-column>
                        <el-table-column prop="email" label="Email" width="200"></el-table-column>
                        <el-table-column prop="school" label="学校" width="150"></el-table-column>
                        <el-table-column prop="education" label="教育程度" width="80"></el-table-column>
                        <el-table-column prop="major" label="专业" width="120"></el-table-column>
                        <el-table-column prop="position_name" label="应聘职位" width="150"></el-table-column>
                        <el-table-column prop="created_at" label="申请时间" width="200"> </el-table-column>
                        <el-table-column prop="demand" label="特殊要求" width="180"></el-table-column>
                        <el-table-column prop="status" label="状态" width="60"></el-table-column>
                        <el-table-column label="操作" width="200" fixed="right">
                            <template slot-scope="scope">
                                <el-button size="small" type="text" @click="handleContact(scope.$index)">联系方式</el-button>
                                <el-button size="small" type="text"><a href="" download="">简历</a></el-button>
                                <el-button size="small" type="text" @click="handleOperation(scope.$index)">操作</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
            </div>
        </div> 
        <!-- 查看联系方式 -->
        <el-dialog :visible.sync="seeVisible" width="470px">
          <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>联系方式：</span>
            </div>
            <div class="dlog">
                <p class="info">电话：</p>
                <div class="info-neir">{{phone}}</div>
                <p class="info">邮箱：</p>
                <div class="info-neir">{{email}}</div>
                <div class="btn">
                    <el-button type="primary">确定</el-button>
                </div>
            </div>
        </el-dialog>
        <!-- 操作 -->
        <el-dialog :visible.sync="operationVisible" width="335px">
          <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>操作：</span>
            </div>
            <div class="dlog">
                <div class="pass" @click="pass()">通过</div>
                <div class="nopass" @click="refuse()">拒绝</div>
                <div class="interview" @click="interview()">邀请面试</div>
                <div class="btn">
                    <el-button type="primary">取消</el-button>
                </div>
            </div>
            
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'RecruitSocialRecruitment',
    components: {BreadCrumb},
    data: function() {	
        return {
            phone:'18996657240',
            email:'1028580665@qq.com',
            seeVisible:false,
            operationVisible:false,
            breadData: [{
                id: 1,
                name: '招聘',
                urls: '/index',
                icon: 'icon-home'
            },{
                id: 2,
                name: '社会招聘',
                urls: '/index/RecruitSocialRecruitment',
                icon: 'icon-home'
            }],
            options: [{
                value: '1',
                label: '由高到低'
                }, {
                value: '2',
                label: '由低到高'
                }],
            value: '',
            list:[],   //原始数组
            slist:[],  //渲染数组
            token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90ZXN0LmtzbGFiLmNvbVwvYXBpXC9hZG1pblwvbG9naW4iLCJpYXQiOjE1Mzk5MzA5NzksImV4cCI6MTU0MDAxNzM3OSwibmJmIjoxNTM5OTMwOTc5LCJqdGkiOiJIeVBWR2RsVVZadmlNdG41Iiwic3ViIjoxLCJwcnYiOiI5ZjA3ZDY0MGNlYTg3ODhjMDY5Mjg1YjM5ZWU2NjcwN2IyOWEzNTM3In0.3BKLFEbgk_qkxdwNdJTjQc8bdzzNJlebMq9JbKEHnQg',
            index:'',
        }
    },
    mounted(){
        this.$axios.post('http://test.kslab.com/api/admin/positionApply/getList', 
            {
                token:this.token,
            }   
        )
        .then((res) =>{
            console.log(res);
            this.list = res.data.data;
        })
        .catch((e) =>{
            console.log("请求失败"+e)
        })
    },
    methods: {
        handleOperation(index){
            this.operationVisible = true;
            this.index = index ;
        },
        handleContact(index){
            this.seeVisible = true;
            // console.log(this.list[index].phone)
            this.phone = this.list[index].phone;
            this.email = this.list[index].email;
        },
        //点击通过
        pass(){
            console.log(this.list[this.index])
            this.$axios.post('http://test.kslab.com/api/admin/positionApply/changeStatus', 
                {
                    token:this.token,
                    id:this.list[this.index].id,
                    status:4
                }   
            )
            .then((res) =>{
                console.log(res);
                this.operationVisible = false;
                this.index = '';
                
                this.$axios.post('http://test.kslab.com/api/admin/positionApply/getList', 
                    {
                        token:this.token,
                    }   
                )
                .then((res) =>{
                    this.list = res.data.data
                    console.log("已通过")
                    // that.setSlist(this.list)
                })
                .catch((e) =>{
                    console.log("请求失败"+e)
                })
            })
            .catch((e) =>{
                console.log("请求失败"+e)
            })
        },
        //点击拒绝
         refuse(){
            console.log(this.list[this.index])
            this.$axios.post('http://test.kslab.com/api/admin/positionApply/changeStatus', 
                {
                    token:this.token,
                    id:this.list[this.index].id,
                    status:3
                }   
            )
            .then((res) =>{
                console.log(res);
                this.operationVisible = false;
                this.index = '';
                this.$axios.post('http://test.kslab.com/api/admin/positionApply/getList', 
                    {
                        token:this.token,
                    }   
                )
                .then((res) =>{
                    this.list = res.data.data
                    console.log("已拒绝")
                    // this.setSlist(this.list)
                })
                .catch((e) =>{
                    console.log("请求失败"+e)
                })
            })
            .catch((e) =>{
                console.log("请求失败"+e)
            })
        },
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
    .content_contain{
        padding: 30px 55px;
        box-sizing: border-box;
    }
    .title{
        text-align: start;height: 70px;line-height: 70px;border-bottom: 2px solid #f2f2f2;
        padding:0 50px;display: flex;justify-content: space-between;color: #222222;
    }
    .choice{
        display: flex;justify-content:space-between;
    }
    .choice-left{
        display: flex;
    }
    .choice-right{
        display: flex;
    }
    .tables{
        margin-top: 20px;
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
    .info-neir{
        height: 35px;width: 410px;
        border: 1px solid #bfbfbf;
        border-radius: 4px;
        padding: 0 15px;font-size: 14px;text-align: left;
        line-height: 35px;
    }
    .dlog{text-align: center;}
    .dlog>p{
        margin: 15px 0;text-align: left;
    }
    .btn{
        margin-top: 15px;
    }
    .pass{
        margin: 20px auto 0 auto;
        width: 185px;height: 35px;
        background: #4cd01a;
        /* margin-top: 20px; */
        border-radius: 4px;
        font-size: 14px;color: #fff;
        line-height: 35px;
    }
    .nopass{
        margin: 20px auto 0 auto;
        width: 185px;height: 35px;
        background: #f95452;
        margin-top: 20px;
        border-radius: 4px;
        font-size: 14px;color: #fff;
        line-height: 35px;
    }
    .interview{
        margin: 20px auto 0 auto;
        width: 185px;height: 35px;
        background: #15bafe;
        margin-top: 20px;
        border-radius: 4px;
        font-size: 14px;color: #fff;
        line-height: 35px;
    }
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
    .choice{
        .el-select{
            margin-right: 12px;
            .el-input{
                width: 120px;
                .el-input__inner{
                    height: 30px;
                    border-radius: 0;
                }
                .el-input__suffix{
                    .el-input__suffix-inner{
                        .el-input__icon{
                            line-height: 30px;
                        }
                    }
                }
            }
        }
    }
</style>
