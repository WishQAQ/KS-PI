<template>
    <div>
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">职位管理</p>
            <div class="content_contain">
                <div class="hd">
                    <div class="right" @click="add()">
                        <div class="ri-left">
                            <img src="../../assets/image/tianjia.png" alt="">
                        </div>
                        <div class="ri-right">
                            创建职位
                        </div>
                    </div>
                </div>
                <div class="tables">
                    <el-table :data="slist" border :stripe="true" :header-row-style="{height:'40px'}" :header-cell-style="{padding:0}" :row-style="{height:'40px'}" :cell-style="{padding:0}" style="width: 100%">
                        <el-table-column prop="id" label="ID" width="80"></el-table-column>
                        <el-table-column prop="name" label="职位" width="250"></el-table-column>
                        <el-table-column prop="province" label="城市" min-width="250"></el-table-column>
                        <el-table-column prop="end_time" label="申请截止时间" width="200"> </el-table-column>
                        <el-table-column prop="limit" label="岗位空缺人数" width="200"> </el-table-column>
                        <el-table-column prop="current" label="当前申请人数" width="200"> </el-table-column>
                        <el-table-column prop="status" label="状态" width="145"></el-table-column>
                        <el-table-column label="操作" width="250" fixed="right">
                            <template slot-scope="scope">
                                <el-button size="small" type="text" @click="handleModify(scope.$index)">编辑</el-button>
                                <el-button size="small" type="text" @click="handleOpen(scope.$index)">禁用/启用</el-button>
                                <el-button size="small" type="text" @click="handleDelete(scope.$index)">删除</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
            </div>
        </div>
        <!-- 添加弹框 -->
        <el-dialog :visible.sync="addVisible" width="515px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>创建新职位</span>
            </div>
                <div class="neir">
                    <p>职位名称</p>
                    <el-input v-model="jobName"  class="input"></el-input>
                    <p>薪资待遇</p>
                    <el-input v-model="salary" class="input"></el-input>
                    <p>职位描述</p>
                    <el-input type="textarea" v-model="jobDescription" placeholder="100字内介绍" class="textarea"></el-input>
                    <div class="bott">
                        <div class="bot-left">
                            <div>
                                <p>报名截止时间</p>
                                <div class="end">
                                    <span>截止</span>
                                    <el-date-picker class="inputdata" v-model="endTime" type="date" placeholder="选择日期" :change="dd()" ></el-date-picker>
                                </div>
                            </div>
                            <div>
                                <p>城市</p>
                                <el-input v-model="city" class="input"></el-input>
                            </div>
                        </div>
                        <div class="bot-rigth">
                            <p>空缺人数</p>
                            <el-input v-model="limit" class="input"></el-input>
                        </div>
                    </div>
                    <div class="btn">
                        <el-button type="primary" @click="sure()">确定</el-button>
                        <el-button>取消</el-button>
                    </div>
                    
                </div>
                
        </el-dialog>
        <!-- 修改弹框 -->
        <el-dialog :visible.sync="modifyVisible" width="515px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>修改职位</span>
            </div>
                <div class="neir">
                    <p>职位名称</p>
                    <el-input v-model="jobName"  class="input"></el-input>
                    <p>薪资待遇</p>
                    <el-input v-model="salary" class="input"></el-input>
                    <p>职位描述</p>
                    <el-input type="textarea" v-model="jobDescription" placeholder="100字内介绍" class="textarea"></el-input>
                    <div class="bott">
                        <div class="bot-left">
                            <div>
                                <p>报名截止时间</p>
                                <div class="end">
                                    <span>截止</span>
                                    <el-date-picker class="inputdata" v-model="endTime" type="date" placeholder="选择日期" :change="dd()" ></el-date-picker>
                                </div>
                            </div>
                            <div>
                                <p>城市</p>
                                <el-input v-model="city" class="input"></el-input>
                            </div>
                        </div>
                        <div class="bot-rigth">
                            <p>空缺人数</p>
                            <el-input v-model="limit" class="input"></el-input>
                        </div>
                    </div>
                    <div class="btn">
                        <el-button type="primary" @click="save()">保存</el-button>
                        <el-button>取消</el-button>
                    </div>
                    
                </div>
                
        </el-dialog>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'RecruitJobManagement',
    components: {BreadCrumb},
    data: function() {	
        return {
            value2:'',
            addVisible:false,
            modifyVisible:false,
            breadData: [{
                id: 1,
                name: '招聘',
                urls: '/index',
                icon: 'icon-home'
            },{
                id: 2,
                name: '职位管理',
                urls: '/index/RecruitJobManagement',
                icon: 'icon-home'
            }],
            status_wen:"来得及福利费",
            slist:[],               //视图数组
            searchlist:[],          //search功能的实现，searchlist为在输入框下方展示的可能要搜索的词语，ss数组则保存过滤后的数据，当循环完毕后，设置调用setSlist方法修改slist数组
            ss:[],                  //搜索后选出来的数据
            selectedlist:{},        //取出的需要修改的数据
            selected:"",
            list:[],
            //新创建职位的数据
            jobName:'',
            salary:'',
            jobDescription:'',
            endTime:'',
            city:'',
            limit:'',
            time:'',
            requirement:'无',  //职位要求
            form: {
                name: '',
                region: '',
                date1: '',
                date2: '',
                delivery: false,
                type: [],
                resource: '',
                desc: ''
            },
            code:'',
            poindex:'',//点击修改职位，存储修改的职位的index
            token:'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90ZXN0LmtzbGFiLmNvbVwvYXBpXC9hZG1pblwvbG9naW4iLCJpYXQiOjE1NDAzNjQ4ODAsImV4cCI6MTU0MDQ1MTI4MCwibmJmIjoxNTQwMzY0ODgwLCJqdGkiOiJKa1B6aWxEOFh4akx5WDRtIiwic3ViIjoxLCJwcnYiOiI5ZjA3ZDY0MGNlYTg3ODhjMDY5Mjg1YjM5ZWU2NjcwN2IyOWEzNTM3In0.Sd0He5vqCYcDr14cNInUFrbzxdSBGQNSk4uzn7zSZUc',
        }
    },
    mounted(){
        this.$axios.post('http://test.kslab.com/api/admin/position/getList', 
            {
                token:this.token,
            }   
        )
        .then((res) =>{
            console.log(res.data.data)
            this.list = res.data.data
            this.setSlist(this.list)
            console.log(this.list)
        })
        .catch((e) =>{
            console.log("请求失败"+e)
        })
    },
    methods: {
        dd(){
            // 转换时间格式
            var d = new Date(this.endTime);  
            var time1=d.getFullYear() + '-' + (d.getMonth() + 1) + '-' + d.getDate(); 
            // console.log(time2)
            this.time = time1+' 00:00:00'
        },
        //赋值渲染列表
        setSlist(arr) {
            this.slist = JSON.parse(JSON.stringify(arr));
        },
        //添加职位
        add(){
            this.addVisible = true;
            // console.log(this.list)
            this.jobName = "";
            this.salary = "";
            this.jobDescription = "";
            this.endTime = "";
            this.city = "";
            this.limit = "";
            
        },
        //保存添加的职位
        sure(){
            this.addVisible = false;
            //发送新创建的职位
            this.$axios.post('http://test.kslab.com/api/admin/position/create', 
                {
                    token:this.token,
                    department_id:1,
                    name:this.jobName,
                    description:this.jobDescription,
                    requirement:this.requirement,
                    limit:this.limit,
                    end_time:this.time,
                    price:this.salary,
                    province:this.city
                }   
            )
            .then((res) =>{
                console.log(res)
                this.list.push({
                    id:res.data.data.id,
                    name:this.jobName,
                    province:this.city,
                    end_time:this.time,
                    limit:this.limit,
                    city:this.city,
                    status:1
                })
                this.setSlist(this.list)
            })
            .catch((e) =>{
                console.log("请求失败")
            })
            
            
        },
        //删除职位
            handleDelete(index){
                console.log(this.list)
                var id = this.list[index].id
                //先删除后台数据，当后台数据删除成功后方可删除视图数据
                this.$axios.post('http://test.kslab.com/api/admin/position/destroy', 
                    {
                        token:this.token,
                        id:id
                    }   
                )
                .then((res) =>{
                    console.log(res.data.code)
                    this.code = res.data.code
                    if(this.code == 200){
                        this.list.splice(index,1)
                        this.setSlist(this.list)
                    }else{
                        alert('删除失败,此职位为开启状态。')
                    }
                })
                .catch((e) =>{
                    console.log("请求失败")
                })
                
            },
            //禁用或启用
            handleOpen(index){
                var id = this.list[index].id  //存储的职位ID
                if(this.list[index].status == 1){
                    this.$axios.post('http://test.kslab.com/api/admin/position/changeStatus', 
                        {
                            token:this.token,
                            id:id
                        }   
                    )
                    .then((res) =>{
                        console.log(res)
                        this.$axios.post('http://test.kslab.com/api/admin/position/getList', 
                            {
                                token:this.token,
                            }   
                        )
                        .then((res) =>{
                            console.log(res.data.data)
                            this.list = res.data.data
                            this.setSlist(this.list)
                        })
                        .catch((e) =>{
                            console.log("请求失败"+e)
                        })
                    })
                    .catch((e) =>{
                        console.log("请求失败")
                    })
                }else{
                    this.$axios.post('http://test.kslab.com/api/admin/position/changeStatus', 
                        {
                            token:this.token,
                            id:id
                        }   
                    )
                    .then((res) =>{
                        console.log(res)
                        this.$axios.post('http://test.kslab.com/api/admin/position/getList', 
                            {
                                token:this.token,
                            }   
                        )
                        .then((res) =>{
                            console.log(res.data.data)
                            this.list = res.data.data
                            this.setSlist(this.list)
                        })
                        .catch((e) =>{
                            console.log("请求失败"+e)
                        })
                    })
                    .catch((e) =>{
                        console.log("请求失败")
                    })
                }
            },
            //编辑修改职位
            handleModify(index){
                this.modifyVisible = true;
                this.poindex = index;  //存储修改的职位的index，用于保存修改的操作
                console.log(this.list[index]);
                this.jobName = this.list[index].name;
                this.salary = this.list[index].price;
                this.jobDescription = this.list[index].description;
                this.endTime = this.list[index].end_time;
                this.city = this.list[index].province;
                this.limit = this.list[index].limit;
            },
            save(){
                this.modifyVisible = false;
                this.$axios.post('http://test.kslab.com/api/admin/position/edit', 
                    {
                        token:this.token,
                        id:this.list[this.poindex].id,
                        department_id:this.list[this.poindex].department_id,
                        name:this.jobName,
                        description:this.jobDescription,
                        requirement:'无',
                        limit:this.limit
                    }   
                )
                .then((res) =>{
                    console.log(res)
                    this.$axios.post('http://test.kslab.com/api/admin/position/getList', 
                            {
                                token:this.token,
                            }   
                        )
                        .then((res) =>{
                            console.log(res.data.data)
                            this.list = res.data.data
                            this.setSlist(this.list)
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
        display: flex;justify-content:flex-end;
    }
    .right{
        width: 150px;height: 35px;
        border: 1px solid #fff; 
        display: flex;
        justify-content: space-between;
        border-radius: 5px;
    }
    .ri-left{
        background: #15bafe;
        width: 25%;
        display: flex;align-items: center;
        justify-content: center;
    }
    .ri-right{background: #15bafe;width: 74%;color: #fff;line-height: 35px;text-align: center;font-size: 14px;}
    .tables{
        margin-top: 25px;
    }
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
    .end{height: 40px;width: 190px; border:1px solid #999999;display: flex;justify-content: space-between;border-radius: 5px;}
    .end>span{margin: auto;color: #666666;font-size: 14px;}
    .bott{
        display: flex;
    }
    .bott>div{
        width: 50%;
    }
    p{
        text-align: left;font-size: 14px;
        margin: 15px 0;
    }
    .neir{
        text-align: left;
    }
    .btn{
        margin:15px 0;text-align: right;
    }
</style>
<style lang="less">
.inputdata{
    
    .el-input__inner{
        border: none;
    }
}
.end{
    .el-date-editor.el-input, .el-date-editor.el-input__inner{
        width: 145px;
    }
}
</style>