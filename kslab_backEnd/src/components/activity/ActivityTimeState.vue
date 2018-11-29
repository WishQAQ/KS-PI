<template>
    <div class="Timed-activity-state">
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <div class="title">
                <p>活动状态</p>
                <p @click="handleRefresh">
                    <img :src="img" alt="">
                    <span>刷新</span>
                </p>
            </div>
            <div class="content_contain">
                <div class="search-top">
                    <!-- 活动时间 -->
                    <el-select size="mini" class="select_normal" v-model="typeValue" placeholder="活动状态" @change=changeSearchStatus($event)>
                        <el-option v-for="item in TypeOptions" :key="item.value" :label="item.label" :value="item.value" class="hei"></el-option>
                    </el-select>
                    <!-- 活动开始时间区间选择 -->
                    <el-date-picker
                        v-model="contentTime"
                        type="daterange"
                        range-separator="至"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                        @change="selectTime">
                    </el-date-picker>
                    <!-- <el-select size="mini" class="select_normal" v-model="plateValue" placeholder="报名截止时间">
                        <el-option v-for="item in PlateOptions" :key="item.value" :label="item.label" :value="item.value"></el-option>
                    </el-select> -->
                    <!-- 状态 -->
                    <!-- <el-select size="mini" class="select_normal" v-model="StateValue" placeholder="状态">
                        <el-option v-for="item in StateOptions" :key="item.value" :label="item.label" :value="item.value"></el-option>
                    </el-select> -->
                    <!-- 报名人数 -->
                    <!-- <el-select size="mini" class="select_normal" v-model="PeopleValue" placeholder="报名人数">
                        <el-option v-for="item in PeopleOptions" :key="item.value" :label="item.label" :value="item.value"></el-option>
                    </el-select> -->
                    <!-- 活动名称 -->
                    <el-input class="select_normal" placeholder="活动名称" size="mini" suffix-icon="el-icon-search" v-model="name" @blur="searchName()"></el-input>
                </div>
                <div class="tables">
                    <el-table   :data="tableData" border :stripe="true" :header-row-style="{height:'40px'}" :header-cell-style="{padding:0,background:'#15bafe',color:'white'}" :row-style="{height:'40px'}" :cell-style="{padding:0}" style="width: 100%">
                        <el-table-column prop="id" label="ID" width="50"></el-table-column>
                        <el-table-column prop="title" label="活动名称" min-width="200"></el-table-column>
                        <el-table-column prop="city_name" label="城市" width="80"> </el-table-column>
                        <el-table-column prop="company_name" label="公司对外名称" width="200"> </el-table-column>
                        <el-table-column prop="active_date_start" label="活动开始时间" width="100"> </el-table-column>
                        <el-table-column prop="active_date_end" label="活动截止时间" width="100"> </el-table-column>
                        <el-table-column prop="registration_deadline" label="报名截止时间" width="120"></el-table-column>
                        <el-table-column prop="enrollment" label="报名人数" width="80"></el-table-column>
                        <el-table-column prop="sale_num" label="售票数量" width="120"> </el-table-column>
                        <el-table-column prop="view_num" label="浏览人数" width="120"> </el-table-column>
                        <el-table-column prop="score" label="评价分数" width="70"> </el-table-column>
                        <el-table-column prop="status" label="状态" width="120"> </el-table-column>
                        <el-table-column label="操作" width="240" fixed="right">
                            <template slot-scope="scope">
                                <el-button size="small" type="text">
                                    <el-dropdown trigger="click">
                                    <span class="el-dropdown-link">
                                        查看
                                    </span>
                                    <el-dropdown-menu slot="dropdown" type="text">
                                        <el-dropdown-item >
                                            <el-button size="small" type="text" @click="seeBasicInfo(scope.row.id)">基本信息</el-button>
                                        </el-dropdown-item>
                                        <el-dropdown-item>
                                            <el-button size="small" type="text">查看评价</el-button>
                                        </el-dropdown-item>
                                    </el-dropdown-menu>
                                    </el-dropdown>
                                </el-button>
                                <el-button size="small" type="text" @click=" openRemarks(scope.row.id)" >添加备注</el-button>
                                <el-button size="small" type="text" @click="deleteActcity(scope.row.id)">删除</el-button>
                                <el-button size="small" type="text" @click="cancelActivity(scope.row.id)">取消活动</el-button>
                                <el-button size="small" type="text" @click="cancelSuspend(scope.row.id)">恢复</el-button>
                                <el-button size="small" type="text" @click="handleModify(scope.row.id)">修改</el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
            </div>
        </div>
        <!-- 弹框 -->
        <el-dialog  :visible.sync="basicInformation" width="705px">
            <div slot="title" class="dialog_head_title">
                <i class=" el-icon-document examine_icon"></i>
                <span>基本信息</span>
            </div>
            <!-- <div class="ti-le">
                    <img src="../../assets/image/book.png" alt="">
                    <span>基本信息</span>
            </div> -->
            <div class="info">
                <div>
                    <div class="info-left">
                        <span>活动开始时间：</span>
                        <div>{{infoData.active_date_start}}</div>
                    </div>
                    <div class="info-right">
                        <span>活动截止时间：</span>
                        <div>{{infoData.active_date_end}}</div>
                    </div>
                </div>
                <div>
                    <div class="info-left">
                        <span>报名截止时间：</span>
                        <div>{{infoData.registration_deadline}}</div>
                    </div>
                    <div class="info-right">
                        
                    </div>
                </div>
                <div>
                    <div class="info-left">
                        <span>板块：</span>
                        <div>{{infoData.menu.folder_name}}</div>
                    </div>
                    <div class="info-right">
                        <span>二级目录:</span>
                        <div>{{infoData.menu.menu_1_name}}</div>
                    </div>
                </div>
                <div>
                    <div class="info-left">
                        <span>城市：</span>
                        <div>{{infoData.city_name}}</div>
                    </div>
                    <div class="info-right">
                        <span>活动负责人:</span>
                        <div>{{infoData.promotee}}</div>
                    </div>
                </div>
                <div class="p1">
                    <span>详细地址：</span>
                    <div>{{infoData.address}}</div>
                </div>
                <div>
                    <div class="info-left">
                        <span>电话：</span>
                        <div>{{infoData.telphone}}</div>
                    </div>
                    <div class="info-right">
                        <span>结束时间：</span>
                        <div>{{infoData.active_date_end}}</div>
                    </div>
                </div>
            </div>
            <div class="act">
                <div>
                    <img src="../../assets/image/yuanx.png" alt="">
                </div>
                <div>
                    <img src="../../assets/image/fangda.png" alt="">
                    <img src="../../assets/image/yuanx.png" alt="">
                </div>
            </div>
            <div class="preview">
                <div class="down_load">
                    <div class="examine_contents">
                        <div class="examine_contain">
                        <div class="examine_list" v-for="(item,index) in 4" :key="index">
                            <a class="examine_text" href="http://cdn.kushualab.com/0E2B038E-FD7D-4883-955C-4D900B6A7A25.png?attname=">
                                <p class="examine_down_p">{{index}}.{{' '}}{{'毒贩夫妇付付付付付付付付付付付付付付付付付付付付付付付付付付所多所'}}</p>
                                <i class="icon_examine el-icon-download"></i>
                            </a>
                        </div>
                        </div>
                    </div>
                    <div class="img_contents">
                        <div class="img_contain">
                        <div v-for="(item,index) in 14" :key="index" :class="index%3===2?'img_item2':'img_item1'">
                            <a href="http://cdn.kushualab.com/0E2B038E-FD7D-4883-955C-4D900B6A7A25.png?attname=">
                                <img class="img_3" src="http://cdn.kushualab.com/0E2B038E-FD7D-4883-955C-4D900B6A7A25.png">
                                <div class="modal_img">
                                    <i class="el-icon-download modal_icon"></i>
                                </div>
                            </a>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </el-dialog>
        <!-- 取消活动原因弹窗 -->
        <el-dialog :visible.sync="cancelVisible" width="360px">
            <div slot="title" class="dialog_head_title">
                <i class=" el-icon-delete examine_icon"></i>
                <span>取消活动原因</span>
            </div>
            <div class="reject_content">
                <el-input type="textarea" :rows="2" placeholder="请输入取消活动原因" v-model="textarea"></el-input>
            </div>
            <div class="tips">
                取消活动后系统将自动退款给用户，此操作不可逆。
            </div>
            <div class="user_footer" slot="footer">
                <el-row class="row_e">
                <el-button class="btn_deletes" size="small" @click="cancelVisible = false">取消</el-button>
                <el-button type="primary" size="small"  class="btn_delete" @click="submitReasons()">提交</el-button>
                </el-row>
            </div>
        </el-dialog>
        <!-- 添加备注弹窗 -->
        <el-dialog :visible.sync="remarkVisible" width="400px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-edit-square delete_icon"></i>
                <span>添加备注</span>
            </div>
            <div class="remark_content">
            <p class="remark_p">内容</p>
            <el-input
                type="textarea"
                :rows="2"
                class="text_area"
                placeholder="商家的修改，取消，结束活动都将显示在历史里面"
                v-model="remark">
            </el-input>
            <p class="history_p">历史</p>
            <div class="h_content">
                <div class="history_item" v-for="(item,index) in historyData" :key="index">
                <div class="item_top">
                    <div class="point"/>
                    <p class="h_name">{{item.create_name}}</p>
                    <p class="h_time">{{item.created_at}}</p>
                </div>
                <p class="h_message">{{item.content}}</p>
                </div>
            </div>
            </div>
            <div class="user_footer" slot="footer">
            <el-row class="row_e">
                <el-button class="btn_deletes" size="small" @click="remarkVisible = false;remark = '';">取消</el-button>
                <el-button type="primary" size="small"  class="btn_delete" @click="submitRemarks">提交</el-button>
            </el-row>
            </div>
        </el-dialog>
        <!-- 删除弹窗 -->
        <el-dialog :visible.sync="deleteVisible" width="300px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-trash delete_icon"></i>
                <span>删除</span>
            </div>
            <div class="delete_content">
                <img class="boolean_delete" :src="warmImg"/>
                <p>确定删除吗？</p>
            </div>
            <div class="user_footer" slot="footer">
            <el-row class="row_e">
                <el-button class="btn_deletes" size="small" @click="deleteVisible = false">取消</el-button>
                <el-button type="primary" size="small"  class="btn_delete" @click="sureDelete()">确定</el-button>
            </el-row>
            </div>
        </el-dialog>
        <!-- 恢复活动弹窗 -->
        <el-dialog :visible.sync="recoveryVisible" width="300px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="iconfont icon-trash delete_icon"></i>
                <span>恢复</span>
            </div>
            <div class="delete_content">
                <img class="boolean_delete" :src="warmImg"/>
                <p>确定开启此活动吗？</p>
            </div>
            <div class="user_footer" slot="footer">
            <el-row class="row_e">
                <el-button class="btn_deletes" size="small" @click="deleteVisible = false">取消</el-button>
                <el-button type="primary" size="small"  class="btn_delete" @click="sureRecovery()">确定</el-button>
            </el-row>
            </div>
        </el-dialog>
        <!-- 修改 -->
        <el-dialog :visible.sync="modifyVisible" width="550px" class="frame">
          <div slot="title" class="dialog_delete_head_title">
            <i class="iconfont icon-menu delete_icon"></i>
            <span>修改</span>
          </div>
          <div class="basic_content">
            <div class="modifyTitle">
                <span class="til">标题：</span>
                <el-input v-model="editData.title" placeholder="请输入内容"></el-input>
            </div>
            <div class="introduce">
                <span class="inttil">简介：</span>
                <el-input type="textarea" :rows="3" placeholder="请输入内容" v-model="editData.description"></el-input>
            </div>
            <div class="introduce">
                <span class="inttil">活动内容：</span>
                <el-input type="textarea" :rows="3" placeholder="请输入内容" v-model="editData.content"></el-input>
            </div>
            <div class="lunbo">
                <span class="lunbotil">活动轮播图：</span>
                <div class="imglist">
                    <el-upload
                        action="http://test.kslab.com/api/article/null"
                        list-type="picture-card"
                        :file-list="showList"
                        :on-preview="handlePictureCardPreview"
                        :on-remove="handleRemovewImg"
                        :before-upload="beforeFileUploadImg"
                        >
                        <i class="el-icon-plus"></i>
                    </el-upload>
                    <el-dialog :visible.sync="dialogVisible">
                        <img width="100%" :src="dialogImageUrl" alt="">
                    </el-dialog>
                </div>
            </div>
            <div class="label">
                <div class="babelsmall">
                    <span class="babeltil">标签：</span>
                    <div class="add">
                        <el-input size="small" placeholder="请输入标签名" v-model="tagName"></el-input>
                        <i class="el-icon-plus addi" @click="addTags"></i>
                    </div>
                </div>
                <div class="labellist">
                    <div class="item" v-for="(item,index) in tags" :key="index">
                        <div class="names">{{item.name}}</div>
                        <div class="deletei" style="width:20%;line-height:30px">
                            <i class="el-icon-delete" style="margin:auto;" @click="deleteTags(index)"></i>
                        </div>
                    </div>
                    <!-- <div class="item">
                        <div class="names">开关机度过</div>
                        <div class="deletei" style="width:20%;line-height:30px">
                            <i class="el-icon-delete" style="margin:auto 5px;"></i>
                        </div>
                    </div>
                    <div class="item">
                        <div class="names">开关机度过</div>
                        <div class="deletei" style="width:20%;line-height:30px">
                            <i class="el-icon-delete" style="margin:auto 5px;"></i>
                        </div>
                    </div> -->
                </div>     
            </div>
            <div class="fujian">
                <span>附件:</span>
                
                <el-upload
                    class="upload-demo"
                    action="http://test.kslab.com/api/article/null"
                    :file-list="fileList3"
                    :on-change="handleChange"
                    :on-remove="handleRemove"
                    :before-upload="beforeFileUpload"
                    >
                    <el-button class="btnup" size="small" type="primary">点击上传</el-button>
                    <div slot="tip" class="el-upload__tip ">只能上传word/ppt文件，且不超过5M</div>
                </el-upload>
            </div>
            <div class="btn3">
                <el-button size="small">取消</el-button>
                <el-button type="primary" size="small" @click="saveModify">保存</el-button>
            </div>
          </div>
          <div class="user_footer" slot="footer">

          </div>
        </el-dialog>
    </div>
</template>

<script>
    import BreadCrumb from "../public/BreadCrumb";
    export default {
        name: "ActivityTimeState",
        components: {BreadCrumb},
        data (){
            return {
                securityProtocol:[], //安全协议
                infoImg:[], //查看信息图片
                tagName:null,
                tags:[],
                fileList3: [
                    // {
                    //     name: "我是exsel1.xls"
                    // },
                    // {
                    //     name: "我是exsel2.xls"
                    // }
                ],
                dialogImageUrl: '',
                dialogVisible: false,
                active_neir:null,//修改活动内容
                introduce:null,//修改》简介
                active_id:null,//存储删除的活动id
                infoData:{
                    active_date_end:'',
                    active_date_start:'',
                    registration_deadline:'',
                    menu:{folder_name:''},
                    city_name:'',
                    promotee:'',
                    telphone:'',
                },//存储需要操作的对象
                contentTime:null,  //区间时间
                input:"这是个标题",
                textarea:"", //取消活动原因
                warmImg: require("../../assets/image/warm.png"),
               img: require('../../assets/image/new.png'),
               //弹框
               recoveryVisible:false,
               basicInformation:false,
               cancelVisible:false,
               remarkVisible:false,
               deleteVisible:false,
               modifyVisible:false,
               remark:"", //备注内容
                //标签栏
                 breadData: [{
                    id: 1,
                    name: '活动',
                    urls: '/index',
                    icon: 'icon-home'
                },{
                    id: 2,
                    name: '定时活动状态',
                    urls: '/index/test',
                    icon: 'icon-home'
                }],
               gridData: [{
                    date: '2016-05-02',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄'
                }, {
                    date: '2016-05-04',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄'
                }, {
                    date: '2016-05-01',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄'
                }, {
                    date: '2016-05-03',
                    name: '王小虎',
                    address: '上海市普陀区金沙江路 1518 弄'
                }],
               //选择框显示的值
               typeValue: null,plateValue:null,StateValue:null,PeopleValue:null,
            //    选择下拉框的值
               TypeOptions: [{
                    value: 8,
                    label: '已结束'
                }, {
                    value: 1,
                    label: '报名中'
                },{
                    value: 6,
                    label: '已暂停'
                },{
                    value: 4,
                    label: '已取消'
                },{
                    value: 2,
                    label: '待审核'
                },{
                    value: 5,
                    label: '报名停止'
                }],
                // 数据
                imgData: [{
                    img_urls: 'http://cdn.kushualab.com/0E2B038E-FD7D-4883-955C-4D900B6A7A25.png'
                },{
                    img_urls: 'http://cdn.kushualab.com/0E2B038E-FD7D-4883-955C-4D900B6A7A25.png'
                },{
                    img_urls: 'http://cdn.kushualab.com/0E2B038E-FD7D-4883-955C-4D900B6A7A25.png'
                }],
                tableData: [],
                historyData: [],
                //条件查询
                order_date:null,//按时间顺序查询
                order_deadline:null,//
                name:null,//名称搜索
                state:null,//状态搜索
                editData:{},//需要修改的活动信息
                showList:[],//轮播图展示列表

                lunboImg:[], //用于储存要上传的图片数组
                attachmentList:[], //用于存储需要上传附件数组
                upTags:[], //需要上传的标签数组
                newAttachment:[],//新增附件数组
            }
        },
        mounted(){
            this.getTimedList();
        },
        methods:{
            //刷新页面
            handleRefresh(){
                window.location.reload();
            },
            //点击修改
            handleModify(id){
                console.log(id)
                this.HttpClient.get('/admin/actives/edit',{
                    id:id,
                })
                .then(res=>{
                    console.log(res)
                    this.editData = res.data.data;
                    this.active_id = res.data.data.active_id;
                    this.tags = res.data.data.tags;
                    for(let i=0;i<res.data.data.pics.length;i++){ //处理上传的轮播图显示在组件内
                        this.showList.push({
                            url : res.data.data.pics[i],
                            path : res.data.data.pics[i],
                        })
                    };
                    console.log(this.showList);
                    for(let i=0;i<res.data.data.attachment.length;i++){  //附件处理
                        this.fileList3.push(
                            {   
                                name:res.data.data.attachment[i],
                                url:res.data.data.attachment[i]
                            }
                        )
                    }
                    console.log(this.fileList3);

                })
                this.modifyVisible = true;
            },
            //点击恢复取消暂停
            cancelSuspend(id){
                this.active_id = id;
                this.recoveryVisible = true;
            },
            //确认恢复活动
            sureRecovery(){
                this.HttpClient.post('/admin/actives/changeStatus',{
                    active_id:this.active_id,
                    status:1
                })
                .then(res=>{
                    console.log(res)
                    if(res.data.code === 200){
                        this.$message.success(res.data.msg);
                        this.getTimedList();
                        this.recoveryVisible = false;
                    }else{
                        this.$message.error(res.data.msg);
                    }
                })
            },
            // 取消活动
            cancelActivity(id){
                this.cancelVisible = true;
                this.active_id = id;
            },
            // 确认取消活动并提交取消原因
            submitReasons(){
                this.HttpClient.post('/admin/actives/changeStatus',{
                    active_id:this.active_id,
                    status:4,
                    refuse:this.textarea
                })
                .then(res=>{ 
                    console.log(res)
                    if(res.data.code === 200){
                        this.$message.success(res.data.msg);
                        this.cancelVisible = false;
                    }else{
                        this.$message.error(res.data.msg);
                    }
                })
            },
            //删除活动
            deleteActcity(id){
                this.deleteVisible = true;
                this.active_id = id;
            },
            //确定删除
            sureDelete(){
                this.HttpClient.post('/admin/actives/changeStatus',{
                    active_id:this.active_id,
                    status:0,
                })
                .then(res=>{ 
                    console.log(res)
                    if(res.data.code === 200){
                        this.$message.success(res.data.msg)
                        this.getTimedList();
                    }else{
                        this.$message.error(res.data.msg)
                    }
                })
            },
            //提交备注
            submitRemarks(){
                console.log(this.active_id)
                this.HttpClient.post('/admin/remarkLog/create',{
                    content:this.remark,
                    source_id:this.active_id
                })
                .then(res=>{ 
                    console.log(res)
                    if(res.data.code === 200){
                        this.$message.success(res.data.msg);
                        this.remark = '';
                        setTimeout(() => {
                            this.getRemarksList(this.active_id);
                        }, 350);
                    }else{
                        this.$message.error(res.data.msg);
                    }
                })
            },
            //打开备注弹窗
            openRemarks(id){
                this.remarkVisible = true;
                this.getRemarksList(id);
                this.active_id = id;
            },
            //查看活动基本信息
            seeBasicInfo(id){
                this.HttpClient.post('/admin/actives/baseInfo',{
                    id:id
                })
                .then(res=>{ 
                    console.log(res)
                    this.infoData = res.data.data;
                    this.securityProtocol = JSON.parse(res.data.data.admin_upload_protocol);
                    console.log(this.securityProtocol)
                })
                this.basicInformation = true;
            },
            //按名称搜索
            searchName(){
                console.log(this.name);
                this.getTimedList();
            },
            //按状态搜索
            changeSearchStatus(n){
                console.log(n)
                this.state = n;
                this.getTimedList();
            },
            // 区间时间选择
            selectTime(){ 
                console.log(this.contentTime);
                this.getTimedList();
            },
            //获取备注列表
            getRemarksList(id){
                this.HttpClient.post('/admin/remarkLog/lists',{
                    source_id:id
                })
                .then(res=>{ 
                    console.log(res)
                    this.historyData = res.data.data;
                })
            },
            //获取活动列表
            getTimedList(){
                if(this.contentTime != null){    
                   this.HttpClient.post('/admin/actives/lists',{
                        status:this.state,
                        active_date_start:this.contentTime[0],
                        active_date_end:this.contentTime[1],
                        title:this.name,
                        order_date:'asc'
                    })
                    .then(res=>{
                        console.log(res)
                        this.tableData = res.data.data.data;
                    })
                }else{
                    this.HttpClient.post('/admin/actives/lists',{
                        status:this.state,
                        title:this.name,
                        order_date:'asc'
                    })
                    .then(res=>{ 
                        console.log(res)
                        this.tableData = res.data.data.data;
                    })
                }
               
            },
            //保存修改的内容
            saveModify(){
                console.log(this.editData,this.showList,this.fileList3,this.tags)
                //过滤需要上传的数据
                for(let i=0;i<this.showList.length;i++){ //处理轮播图
                    this.lunboImg.push(this.showList[i].path)
                }
                for(let i=0;i<this.fileList3.length;i++){ //处理附件数组
                    this.attachmentList.push(this.fileList3[i].url)
                    console.log(this.fileList3[i].url)
                }
                for(let i=0;i<this.tags.length;i++){ //处理标签
                    this.upTags.push(this.tags[i].name)
                }
                console.log(this.lunboImg,this.attachmentList,this.upTags)
                this.HttpClient.form('/admin/actives/edit',{
                    active_id:this.active_id,
                    description:this.editData.description,
                    content:this.editData.content,
                    tags:JSON.stringify(this.upTags),
                    pics:JSON.stringify(this.lunboImg),
                    attachment:JSON.stringify(this.attachmentList)
                })
                .then((res) => {
                    if(res.data.code ===200){
                        this.$message.success(res.data.msg)
                    }else{
                        this.$message.error(res.data.msg)
                    }
                })
            },
            // 点击删除标签
            deleteTags(index){
                this.tags.splice(index,1);
            },
            //添加标签
            addTags(){
                if(this.tags.length < 3){
                    this.tags.push({
                        name:this.tagName
                    })
                    this.tagName = '';
                }else{
                    this.$message.warning('最多添加3个标签')
                }
            },
            //上传轮播图
            handleRemovewImg(file,fileList){
                console.log(file,fileList)
                this.showList = fileList;
            },
            beforeFileUploadImg(file,fileList){
                console.log(file,fileList)
                this.HttpClient.form('/admin/uploadOneImage',{
                    images:file
                })
                .then((res) => {
                    console.log(res)
                    if(res.data.code === 200){
                        this.$message.success(res.data.msg);
                        this.showList.push({
                            url:res.data.path,
                            path:res.data.path
                        })
                        console.log(this.showList)
                    }else{
                        this.$message.error(res.data.msg);
                    }
                })
            },
            //上传附件
            handleRemove(file, fileList) {
                console.log(file, fileList);
                this.fileList3 = fileList;
            },
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            handleChange(file, fileList) {
                console.log(file)
                this.fileList3 = fileList.slice(-5);
            },
            beforeFileUpload(file,fileList){
                console.log(file,fileList,this.fileList3);
                var FromData = new FormData();
                FromData.append('token', window.localStorage.token);
                FromData.append('files', file);
                this.$ajax.post('http://test.kslab.com/api/admin/uploadOneFile', FromData)
                .then((res) => {
                    console.log(res)
                    if(res.data.code === 200){
                        this.$message.success(res.data.msg);
                        this.fileList3.splice(this.fileList3.length-1,1);//目的为了修改为自己想要的数据
                        this.fileList3.push({
                            name:file.name,
                            url:res.data.path
                        })
                        console.log(this.fileList3);
                        this.newAttachment.push(res.data.path);
                    }else{
                        this.$message.error(res.data.msg);
                        this.fileList3.splice(this.fileList3.length-1,1);//如果没有上传成功就不应该渲染在列表里
                    }
                })
            },
        }
    }
</script>

<style scoped>
    .bread{margin: 10px;}
    .Timed-activity-state{padding: 0 15px; box-sizing: border-box;height: calc(100vh - 87px);width: calc(100vw - 221px);}
    .content{background: #fff;border-radius: 8px; height: calc(100vh - 87px); width: calc(100vw - 221px);}
    .title{text-align: start;height: 70px;line-height: 70px;border-bottom: 2px solid #f2f2f2;padding:0 50px;display: flex;justify-content: space-between;color: #222222;font-size: 20px;}
    .content_contain{padding: 25px 45px;}
    .search-top{text-align: start;display: flex;}
    .select_normal{width: 150px;margin-right: 10px;}
    .tables{margin-top: 23px;}
    .el-dropdown-link{font-size: 14px;color: #29bdfe;}
    .el-button+.el-button{font-size: 14px;color: #29bdfe;}
    /* 基本信息弹框 */
    .ti-le{text-align: start;border-bottom: 1px solid #e8e8e8;padding-bottom: 18px;display: flex;align-items: center;}
    .ti-le>img{margin-right: 6px;}
    .info>div{display: flex;justify-content: space-around;margin-top: 27px;}
    .info-left{display: flex;align-items: center;width: 46%;justify-content: space-between;}
    .info-right{display: flex;align-items: center;width: 46%;justify-content: space-between}
    .info-left>div{width: 210px;height: 35px;border: 1px solid #ededed;text-align: center;line-height: 35px}
    .info-right>div{width: 210px;height: 35px;border: 1px solid #ededed;text-align: center;line-height: 35px;}
    .p1{display: flex;align-items: center;}
    .p1>div{width: 540px;height: 35px;border: 1px solid #ededed;text-align: center;line-height: 35px}
    .act{display: flex;justify-content: space-between;margin-top: 25px;}
    .act>div{width: 320px;text-align: right;margin-right: 6px;}
    /* .preview{display: flex;justify-content: space-between;} */
    /* .preview>div{width: 320px;height: 157px;border: 1px solid #ededed;margin-bottom: 35px;line-height: 157px;color: #aaaaaa;} */
    .el-dialog__header{padding: 8px 20px 10px !important;}
    .dialog_head_title{ height: 16px; border-bottom: 1px solid #cccccc;  padding-bottom: 10px; text-align: left; font-size: 15px; }
    .examine_icon{ color: #15bafe; } 
    .tips{width: 318px;height: 60px;border: 1px solid #e8e8e8;padding: 10px 60px;box-sizing: border-box;font-size: 14px;color: #b7b7b7;margin-top: 17px;}
    .btn_deletes{ padding: 5px 15px; } 
    .remark_content{ position: relative; top: -10px; }  
    .remark_p{ text-align: left; }
    .text_area{ margin-top: 8px; }
    .history_p{ text-align: left; margin-top: 8px; border-bottom: 1px solid #f2f2f2; padding-bottom: 10px; }
    .h_content{ margin-top: 10px; height: 200px;  overflow-y: auto; } 
    .history_item{  display: block; text-align: left;  margin-bottom: 20px; }  
    .item_top{ display: flex; height: 20px;  line-height: 20px; }  
    .point{ width: 5px;  height: 5px; border-radius: 2.5px; background: #15bafe;  position: relative;  top: 8px; margin-right: 8px; } 
    .h_name{  margin-right: 10px; }
    .h_time{  color: #15bafe;  font-size: 12px; }
    .h_message{ margin-left: 15px; }
    .el-button--text{color: #b7b7b7;}
      .dialog_head_title{
    height: 16px;
    border-bottom: 1px solid #cccccc;
    padding-bottom: 10px;
    text-align: left;
    font-size: 15px;
  }
  .dialog_delete_head_title{
    height: 16px;
    border-bottom: 1px solid #cccccc;
    padding-bottom: 10px;
    text-align: left;
    font-size: 15px;
  }
  .delete_icon{
    color: #15bafe;
    font-size: 18px;
    top: 1px;
    position: relative;
  }
  .examine_icon{
    color: #15bafe;
  }
  .up_safe{
    height: 120px;
    border: 1px solid #f2f2f2;
  }
  .up_safe_header{
    display: flex;
    line-height: 24px;
    margin-top: 10px;
    position: relative;
    left: -60px;
  }
  .btn_up{
    padding: 5px 10px;
    margin-right: 20px;
  }
  .up_img{
    height: 130px;
    border: 1px solid #f2f2f2;
    margin-top: 10px;
    display: grid;
  }
  .remark{
    text-align: left;
    margin-left: 10px;
  }
  .up_img_header{
    display: flex;
    line-height: 24px;
    margin-top: 10px;
    position: absolute;
    left: 30px;
    width: 250px;
  }
  .up_img_item{
    display: -webkit-box;
    overflow-y: auto;
    height: 100px;
    margin-left: 10px;
    margin-top: 10px;
    margin-right: 10px;
    flex-wrap: wrap;
  }
  .icon_plus{
    position: relative;
    bottom: 30px;
  }
  .boolean_delete{
    height: 30px;
    width: 30px;
  }
  .delete_content p{
    margin-top: 5px;
  }
  .row_e{
    text-align: center;
  }
  .btn_delete{
    padding: 5px 15px;
    margin-left: 30px;
  }
  .btn_deletes{
    padding: 5px 15px;
  }
</style>
<style lang="less">
.Timed-activity-state{
    .el-upload-list--picture-card .el-upload-list__item{
        overflow: hidden;
        background-color: #fff;
        border: 1px solid #c0ccda;
        border-radius: 6px;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        width: 94px;
        height: 94px;
        margin: 0 8px 8px 0;
        display: inline-block;
    }
    .el-upload--picture-card{
        background-color: #fbfdff;
        border: 1px dashed #c0ccda;
        border-radius: 6px;
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        width: 94px;
        height: 94px;
        line-height: 94px;
        vertical-align: top;
    }
    .el-input__inner{
        height: 28px;
    }
    .el-date-editor{
        margin-right: 10px;
    }
}
.down_load {
    margin-top: 10px;
    display: flex;
    .examine_contents {
      height: 120px;
      width: 320px;
      margin-right: 10px;
      border: 1px solid #f2f2f2;
      border-radius: 3px;
      .examine_contain{
        height: 100px;
        overflow-y: auto;
        margin-top: 10px;
      }
      .examine_list {
        margin-top: 10px;
        overflow: auto;
        .examine_text{
          display: flex;
          justify-content: space-between;
          margin-left: 10px;
          margin-bottom: 10px;
          cursor: pointer;
          text-decoration: none;
          a{
            text-decoration:none;
            width: 100%;
          }
          .examine_down_p{
            width: 320px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            font-size: 12px;
            color: #15bafe;
          }
          .icon_examine{
            margin-right: 10px;
            color: #404040;
          }
        }
      }
    }
    .img_contents {
      height: 120px;
      width: 330px;
      border: 1px solid #f2f2f2;
      border-radius: 3px;
      .img_contain{
        margin: 0 10px;
        display: flex;
        flex-wrap: wrap;
        height: 100px;
        overflow-y: auto;
        width: calc(100% - 20px);
        .img_3{
          width: 100%;
          height: 100%;
        }
        .img_item1{
          width: 30%;
          margin-right: 5%;
          height: 64px;
          margin-top: 10px;
        }
        .img_item2{
          width: 30%;
          height: 64px;
          margin-top: 10px;
        }
        .modal_img{
          width: 100%;
          height: 64px;
          background: rgba(0,0,0,0.4);
          position: relative;
          margin-top: -67px;
          opacity: 0;
          .modal_icon{
            position: relative;
            font-size: 18px;
            top: calc(50% - 12px);
            color: white;
          }
        }
        .modal_img:hover{
          opacity: 1;
        }
      }
    }
  }
  .modifyTitle{
      display: flex;
      align-items: center;
      margin-top: 15px;
      .til{
          width: 105px;
          text-align: left;
      }
  }
  .introduce{
      display: flex;
      align-items: center;
      margin-top: 15px;
      .inttil{
          width: 105px;
          text-align: left;
      }
  }
  .lunbo{
      text-align: left;
      margin-top: 15px;
      .imglist{
          margin-top: 15px;
      }
  }
  .label{
      text-align: left;
      margin-top: 15px;
        .babelsmall{
            display: flex;
            .add{
                position: relative;
                .addi{
                    position: absolute;
                    top: 15%;
                    right: 5px;
                    font-size: 20px;
                }
                .addi:hover{
                    position: absolute;
                    top: 15%;
                    right: 5px;
                    font-size: 20px;
                    background: #15bafe;
                    color:#fff;
                }
            }
        }
        .labellist{
            display: flex;
            margin: 15px 0;
            .item{
                display: flex;
                margin-right: 10px;
                height: 30px;
                border: 1px solid #bfbfbf;
                .names{
                    width: 100%;
                    line-height: 30px;
                    padding:0 10px;
                }
                .deletei:hover{
                    background: #15bafe;
                    color:#fff;
                }
            }
        }
  }
  .fujian{
      text-align: left;
      .upload-demo{
          position: relative;
            .btnup{
                position: absolute;
                top: -15px;
                left: 42px;
            }
      }
  }
  .btn3{
      text-align: right;
  }
// .preview>div{
//     display: flex;  
//     flex-wrap: wrap;
//     height: 100px;
//     overflow-y: auto;  
// }
</style>

