<template>
    <div class="articleManagement">
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <div class="articleManagement_main">
        <div class="header">
          <div class="title">文章管理</div>
          <div class="refresh"><i class="iconfont icon-shuaxin"></i><span>刷新</span></div>
        </div>

        <div class="articleManagement_content">

          <!--列表-->
          <div class="articleManagement_table">
            <form>
              <div class="content_header">
                <el-date-picker
                  v-model="contentTime"
                  type="daterange"
                  value-format="yyyy-MM-dd HH:mm:ss"
                  range-separator="至"
                  start-placeholder="开始日期"
                  end-placeholder="结束日期"
                  @change="getArticleList">
                </el-date-picker>

                <div class="content_header_search">
                  <el-input placeholder="用户昵称" v-model="nickname" @keyup.13.native="getArticleList">
                    <el-button slot="append" icon="el-icon-search" @click="getArticleList"></el-button>
                  </el-input>
                  <el-input placeholder="名称" v-model="username" @keyup.13.native="getArticleList">
                    <el-button slot="append" icon="el-icon-search" @click="getArticleList"></el-button>
                  </el-input>
                </div>
              </div>

              <div class="content_table">

                <el-table
                  :data="contentData"
                  border
                  style="width: 100%"
                  :row-class-name="tableRowClassName">
                  <el-table-column
                    prop="id"
                    sortable
                    width="80px"
                    align="center"
                    label="ID">
                  </el-table-column>
                  <el-table-column
                    prop="title"
                    width="280px"
                    align="center"
                    label="文章标题">
                  </el-table-column>
                  <el-table-column
                    prop="nickname"
                    width="140px"
                    align="center"
                    label="昵称">
                  </el-table-column>
                  <el-table-column
                    prop="word_num"
                    width="110px"
                    align="center"
                    label="字数">
                  </el-table-column>
                  <el-table-column
                    prop="cate_name"
                    width="110px"
                    align="center"
                    label="所属板块"
                    :filters="[{ text: '汽车', value: '汽车'}
                  , { text: '摩托车', value: '摩托车'}
                  , { text: '无人机', value: '无人机'}
                  , { text: '智能设备', value: '智能设备'}]">
                  </el-table-column>
                  <el-table-column
                    prop="user_type"
                    width="140px"
                    align="center"
                    label="用户类别"
                    :filters="[{ text: '专业商家', value: '专业商家'}
                  , { text: '普通用户', value: '普通用户'}, { text: '普通商家', value: '普通商家'}]">
                    <template slot-scope="scope">{{scope.row.user_type===2?'专业商家':scope.row.user_type===1?'普通用户':'普通商家'}}</template>
                  </el-table-column>
                  <el-table-column
                    prop="created_at"
                    width="130px"
                    align="center"
                    sortable
                    label="创建时间">
                  </el-table-column>
                  <el-table-column
                    width="120px"
                    align="center"
                    sortable
                    label="通过状态">
                    <template slot-scope="scope">
                      <div>· {{scope.row.status===1?'正常':scope.row.status===2?'待审核':scope.row.status===3?'未通过':scope.row.status===0?'删除':'置顶'}}</div>
                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="review"
                    width="120px"
                    align="center"
                    label="审核状态"
                    sortable>
                      <template slot-scope="scope">
                          <div>· {{scope.row.status===2?'未审核':'已审核'}}</div>
                      </template>
                  </el-table-column>
                  <el-table-column
                    prop="operating"
                    align="center"
                    class-name="contentOperating"
                    label="操作">
                    <template slot-scope="scope">
                      <div @click="agreeButton(scope.row.article_id)" v-if="scope.row.status!==1">批准</div>
                      <div @click="rejectButton(scope.row.article_id)" v-if="scope.row.status!==3">驳回</div>
                      <div @click="updateButton(scope.row.id,scope.row.article_id)">修改</div>
                      <div>预览</div>
                      <div @click="deleteButton(scope.row.article_id)">删除</div>
                    </template>
                  </el-table-column>
                </el-table>
                  <el-pagination
                          v-if="total"
                          layout="prev, pager, next"
                          :total="total"
                          :page-size="pageSize"
                          @current-change="currentChange"
                  ></el-pagination>
              </div>
            </form>
          </div>
          <div class="tatistics">
            <div class="quantity_btm">数量：{{total}}</div>
            <div class="quantity_btm">平均字数：{{wordAverage}}</div>
          </div>
        </div>
      </div>

      <!--批准弹窗-->
      <el-dialog
        width="470px"
        custom-class="approveDialog"
        :visible.sync="approveDialog"
        center>
        <span slot="title" class="approveDialog_title"><i class="iconfont icon-huaban4"></i></span>
        <div class="approveDialog_box">
          <i class="iconfont icon-warning-circle"></i>
          <p>确定批准吗？</p>
        </div>
        <span slot="footer" class="dialog-footer">
        <el-button @click="approveDialog = false">取 消</el-button>
        <el-button type="primary" @click="confirmAgree">确 定</el-button>
      </span>
      </el-dialog>

      <!--驳回弹窗-->
      <el-dialog
        width="470px"
        custom-class="disableDialog"
        :visible.sync="disableDialog">
        <span slot="title" class="disableDialog_title"><i class="iconfont icon-jinyong"></i>驳回</span>
        <div class="disable_dialog_box">
          <div class="disable_dialog_left">理由：</div>
          <div class="disable_dialog_right">
            <el-input
              type="textarea"
              resize="none"
              :rows="4">
            </el-input>
          </div>
        </div>
        <div class="disable_dialog_box">
          <div class="disable_dialog_left">类别：</div>
          <div class="disable_dialog_right">
            <el-radio border v-model="disableDialogRadio" label="1">无效评论</el-radio>
            <el-radio border v-model="disableDialogRadio" label="2">故意装怪</el-radio>
            <el-radio border v-model="disableDialogRadio" label="3">色情</el-radio>
            <el-radio border v-model="disableDialogRadio" label="4">不友善</el-radio>
          </div>
        </div>
        <span slot="footer" class="dialog-footer">
        <el-button @click="disableDialog = false">取 消</el-button>
        <el-button type="primary" @click="confirmReject">确 定</el-button>
      </span>
      </el-dialog>

      <!--删除弹窗-->
      <ModalDelete ref="delete" @doDelete="confirmDelete"></ModalDelete>
    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb';
  import ModalDelete from '@/components/public/modalDelete'

  export default {
    name: "ArticleManagement",
    components: {
      BreadCrumb,
      ModalDelete
    },
    data(){
      return{
        // 面包屑
        breadData: [{
          id: 1,
          name: '文章管理',
          urls: '/index/article/Article',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '文章管理',
          urls: '/index/article/ArticleManagement',
          icon: 'icon-home'
        }],
        userOptions: [{
          value: 1,
          label: '公司'
        },{
          value: 2,
          label: '普通用户'
        }],

        // 日期筛选
        contentTime:'',

        // 主体表格
        contentData: [],

        // 批准弹窗
        approveDialog: false,

        // 驳回弹窗
        disableDialog: false,
        disableDialogRadio: '1',  // 类别选择

        // 删除弹窗
        modalDelete: false,

        username:'',//搜索用户名
        nickname:'',//作者昵称
        currentPage:1,//当前页
        pageSize:10,//每页显示数量
        total:0,//总条数
        wordAverage:0,//平均字数
        id:'',//操作文章id
      }
    },
    methods: {
      formatter(row, column) {
        return row.address;
      },
      filterHandler(value, row, column) {
        const property = column['property'];
        return row[property] === value;
      },
      tableRowClassName({row}){
          if(row.status===1){
              return 'success'
          }else if(row.status===2){
              return 'wait'
          }else if(row.status===3){
              return 'error'
          }
          return ''
      },

      //获取文章列表
      getArticleList(){
        let parameters={
            page:this.currentPage,size:this.pageSize
        };
        if(this.nickname){
            parameters.nickname=this.nickname
        }
        if(this.username){
            parameters.username=this.username;
        }
        if(this.contentTime.length>0){
            parameters.start_time=this.contentTime[0];
            parameters.end_time=this.contentTime[1];
        }
        this.HttpClient.post('/admin/article/getList',parameters)
            .then(res=>{
                console.log(res);
                if(res.data.code===200){
                    this.contentData=res.data.data.data;
                    // this.total=res.data.data.total;
                    // let word=0;
                    // this.contentData.map(item => {
                    //     word += item.word_num;
                    // });
                    // this.wordAverage=word/this.total;
                }
            })
      },
      //获取文章总数及总字数
      getArticleWord(){
          this.HttpClient.post('/admin/article/getTotalAndAverageWord')
              .then(res=>{
                  console.log(res);
                  if(res.data.code===200){
                      this.total=res.data.data.total;
                      this.wordAverage=res.data.data.total_word/res.data.data.total
                  }
              })
      },
      //修改按钮事件
      updateButton(id,aid){
          this.$router.push({
             path:'/index/article/article-modify',
             query:{
                id:id,
                articleId:aid
             }
          })
      },
      //批准按钮事件
      agreeButton(id){
          this.id=id;
          this.approveDialog=true;
      },
      //驳回按钮事件
      rejectButton(id){
          this.id=id;
          this.disableDialog=true;
      },
      //删除按钮事件
      deleteButton(id){
          this.id=id;
          this.$refs.delete.deleteDialog=true;
      },
      //删除/驳回/通过文章
      makeArticle(status){
          let parameters={
              article_id:this.id,
              status:status
          };
          console.log(this.disableDialogRadio);
          if(status===3){
              parameters.refuse=this.disableDialogRadio
          }
          this.HttpClient.post('/admin/article/changeStatus',parameters)
              .then(res=>{
                  console.log(res);
                  if(res.data.code===200){
                      this.$message.success('操作成功');
                      setTimeout(()=>{
                          this.getArticleList()
                      },500);
                  }else{
                      this.$message.error('操作失败')
                  }
              })
      },
      //确认批准
      confirmAgree(){
          this.makeArticle(1);
          this.approveDialog=false;
      },
      //确认驳回
      confirmReject(){
          this.makeArticle(3);
          this.disableDialog=false;
      },
      //确认删除
      confirmDelete(){
          this.makeArticle(0)
      },
      //分页
      currentChange(p){
          this.currentPage=p;
          this.getArticleList()
      }
    },
    created(){
        this.getArticleList();
        this.getArticleWord()
    }

  }
</script>

<style lang="less">
  .articleManagement{
    .bread{
      margin: 10px;
    }
    .articleManagement_main{
      margin-left: 10px;
      margin-top: 10px;
      background: #fff;
      height: calc(100vh - 87px);
      width: calc(100vw - 240px);
      border-radius: 2px;
      /*标题*/
      .header{
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 70px;
        border-bottom: 2px solid #f2f2f2;
        padding: 0 40px;
        .title{
          font-size: 20px;
          color: #222;
        }
        /*刷新*/
        .refresh{
          cursor: pointer;
          span{
            display: inline-block;
            margin-left: 10px;
          }
        }
      }
      /*文章管理主体*/
      .articleManagement_content{
        padding: 0 40px;
        /*列表*/
        .articleManagement_table{
          margin-top: 40px;
          /*头部筛选*/
          .content_header{
            display: flex;
            justify-content: space-between;
            align-items: center;
            /*搜索框*/
            .content_header_search{
              display: flex;
              align-items: center;
              .el-input:last-child{
                margin-left: 20px;
              }
            }
          }

          /*表格*/
          .content_table{
            margin-top: 30px;
            /*表格样式*/
            .has-gutter{
              color: #fff;
              th{
                background: #15bafe;
              }
            }
            .el-table{
                .success{
                    background:rgba(74,202,109,.3);
                }
                .wait{
                    background:rgba(255,230,54,.3);
                }
                .error{
                    background:rgba(245,89,89,.3);
                }
            }


            /*操作*/
            .contentOperating{
              padding: 0 0 !important;
              .cell{
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100%;
                div:not(:last-child){
                  border-right: 1px solid #f2f2f2;
                }
                div{
                  flex: 1;
                  cursor: pointer;
                  height: 48px;
                  display: flex;
                  justify-content: center;
                  align-items: center;
                }
              }
            }
          }
        }
      }

      /*底部统计*/
      .tatistics{
        display: flex;
        align-items: center;
        /*数量框*/
        .quantity_btm{
          background: #15bafe;
          display: flex;
          margin-top: 20px;
          justify-content: center;
          align-items: center;
          color: #fff;
          padding: 0 15px;
          height: 40px;
          margin-right: 20px;
          font-size: 14px;
        }
      }
    }

    /*批准弹窗*/
    .approveDialog{
      .approveDialog_title{
        display: flex;
        align-items: center;
        i{
          font-size: 24px;
          color: #15bafe;
        }
      }
      .approveDialog_box{
        text-align: center;
        i{
          font-size: 80px;
          color: #15bafe;
        }
        p{
          font-size: 14px;
          color: #000;
          margin-top: 20px;
        }
      }
    }

    /*驳回弹窗*/
    .disableDialog{
      .disableDialog_title{
        display: flex;
        border-bottom: 1px solid #e8e8e8;
        padding-bottom: 10px;
        i{
          margin-right: 10px;
        }
      }
      .disable_dialog_box:not(:last-child){
        margin-bottom: 20px;
      }
      .disable_dialog_box{
        display: flex;
        align-items: flex-start;
        justify-content: center;
        /*单选框*/
        .disable_dialog_right{
          display: flex;
          flex-wrap: wrap;
          align-items: center;
          justify-content: center;
          width: 275px;
          /*单选框样式*/
          .el-radio:nth-child(1){
            margin-top: 0;
          }
          .el-radio.is-checked{
            background: #15bafe;
            border-color: #15bafe;
            .el-radio__label{
              color: #fff;
            }
          }
          .el-radio{
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 40px;
            width: 275px;
            margin: 10px auto;
            .el-radio__input{
              display: none;
            }
            .el-radio__label{
              padding: 0;
            }
          }
        }
      }
    }

  }
</style>
