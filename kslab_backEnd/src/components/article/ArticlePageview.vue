<template>
    <div class="articlePageview">
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <div class="articlePageview_main">
        <!--标题-->
        <div class="title">
          文章浏览量统计
        </div>
        <!--列表-->
        <div class="articlePageview_content">
          <form>
            <div class="content_header">
              <el-date-picker
                v-model="contentTime"
                type="daterange"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
                @change="selectTime">
              </el-date-picker>
              <div class="content_header_search">
                <el-input placeholder="文章名称" v-model="articleName">
                  <el-button slot="append" icon="el-icon-search" @click="nameSearch"></el-button>
                </el-input>
                <el-input placeholder="昵称搜索" v-model="nickname">
                  <el-button slot="append" icon="el-icon-search" @click="nicknameSearch"></el-button>
                </el-input>
              </div>
            </div>
            <div class="content_table">
              <el-table
                :data="contentData"
                border
                style="width: 100%">
                <el-table-column
                  prop="id"
                  sortable
                  width="80px"
                  align="center"
                  label="ID">
                </el-table-column>
                <el-table-column
                  prop="title"
                  width="200px"
                  align="center"
                  label="文章题目">
                </el-table-column>
                <el-table-column
                  prop="cate_name"
                  width="110px"
                  align="center"
                  label="类别"
                  :filters="[{ text: '汽车', value: '汽车'}
                  , { text: '摩托车', value: '摩托车'}
                  , { text: '无人机', value: '无人机'}
                  , { text: '智能设备', value: '智能设备'}
                  ]"
                  :filter-method="filterHandler">
                </el-table-column>
                <el-table-column
                  prop="nickname"
                  width="110px"
                  align="center"
                  label="昵称">
                </el-table-column>
                <el-table-column
                  prop="userCategory"
                  width="110px"
                  align="center"
                  label="用户类型"
                  :filters="[{ text: '商户', value: '商户'}
                  , { text: '用户', value: '用户'}]">
                  <template slot-scope="scope">{{scope.row.user_type===2?'专业商家':scope.row.user_type===1?'普通用户':'普通商家'}}</template>
                </el-table-column>
                <el-table-column
                  prop="word_num"
                  width="110px"
                  align="center"
                  label="字数">
                </el-table-column>
                <el-table-column
                  prop="view_num"
                  width="110px"
                  align="center"
                  label="浏览次数">
                </el-table-column>
                <el-table-column
                  prop="like_num"
                  width="110px"
                  align="center"
                  label="点赞次数">
                </el-table-column>
                <el-table-column
                  prop="comment_num"
                  width="110px"
                  align="center"
                  label="讨论次数">
                </el-table-column>
                <el-table-column
                  prop="created_at"
                  width="130px"
                  align="center"
                  sortable
                  label="创建时间排列">
                </el-table-column>
                <el-table-column
                  sortable
                  width="120px"
                  align="center"
                  label="状态">
                  <template slot-scope="scope">
                    <div>· {{scope.row.status===1?'正常':scope.row.status===4?'置顶':'已删除'}}</div>
                  </template>
                </el-table-column>
                <el-table-column
                  prop="operating"
                  align="center"
                  class-name="contentOperating"
                  label="操作">
                  <template slot-scope="scope">
                    <div>
                      <span v-if="scope.row.status===1" @click="topping(scope.row.article_id)">置顶</span>
                      <span v-if="scope.row.status===4" @click="unTopping(scope.row.article_id)">取消置顶</span>
                    </div>
                    <div>查看用户</div>
                    <div>查看文章</div>
                  </template>
                </el-table-column>
              </el-table>
            </div>
          </form>
        </div>
      </div>


      <!--置顶弹窗-->
      <el-dialog
        width="400px"
        custom-class="toppingDialog"
        :visible.sync="toppingDialog">
        <span slot="title" class="toppingDialog_title"><i class="iconfont icon-image"></i>置顶图片</span>
        <div class="toppingDialog_box">
          <el-upload
            class="topping_uploader"
            action="http://test.kslab.com/api/article/null"
            :file-list="fileList"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            <img v-if="imageUrl" :src="imageUrl" class="avatar">
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="toppingDialog = false">取 消</el-button>
          <el-button type="primary" @click="toppingSubmit()">确 定</el-button>
        </span>
      </el-dialog>

      <!--取消置顶弹窗-->
      <el-dialog
        width="400px"
        custom-class="cloneToppingDialog"
        :visible.sync="cloneToppingDialog">
        <span slot="title" class="cloneToppingDialog_title"><i class="iconfont icon-image"></i>取消置顶</span>
        <div class="cloneToppingDialog_box">
          <div class="cloneToppingDialog_icon">
            <i class="iconfont icon-warning-circle"></i>
          </div>
          <p>确认取消置顶吗</p>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="cloneToppingDialog = false">取 消</el-button>
          <el-button type="primary" @click="cloneToppingSubmit()">确 定</el-button>
        </span>
      </el-dialog>


    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb'

  export default {
    name: "ArticlePageview",
    components:{
      BreadCrumb,
    },
    data(){
      return{
        // 面包屑
        breadData: [{
          id: 1,
          name: '文章管理',
          urls: '/index/article',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '文章浏览量统计',
          urls: '/index/article/articlePageview',
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

        // 置顶按钮
        toppingBtm: true,  //置顶
        cloneToppingBtm: false,  //取消置顶
        // 置顶弹窗
        toppingDialog: false,
        // 图片上传
        imageUrl: '',

        // 取消置顶框
        cloneToppingDialog: false,
        fileList:[],
        article_id:null,
        articleName:'',
        nickname:'',
      }
    },
    mounted(){
      this.getArticleList();
    },
    methods: {
      //昵称搜索
      nicknameSearch(){
          this.getnkNameArticleList();
      },
      //名称搜索数据
      nameSearch(){
          this.getNameArticleList();
      },
      //改变时间请求数据
      selectTime(){
          console.log(this.contentTime)
          this.getArticleTimeList(this.contentTime);
      },
      //昵称搜索
      getnkNameArticleList(){
          this.HttpClient.post('/admin/article/getList',{
            page:1,
            size:11,
            nickname:this.nickname
          })
          .then(res=>{
              console.log(res);
              this.contentData = res.data.data.data;
          })
      },
      //名称搜索
      getNameArticleList(){
          this.HttpClient.post('/admin/article/getList',{
            page:1,
            size:11,
            username:this.articleName
          })
          .then(res=>{
              console.log(res);
              this.contentData = res.data.data.data;
          })
      },
      //获取文章浏览量统计列表数据
      getArticleList(){
          this.HttpClient.post('/admin/article/getList',{
            page:1,
            size:11,
          })
          .then(res=>{
              console.log(res);
              this.contentData = res.data.data.data;
          })
      },
      //时间区间请求数据
      getArticleTimeList(time){
          this.HttpClient.post('/admin/article/getList',{
            page:1,
            size:11,
            start_time:time[0],
            end_time:time[1]
          })
          .then(res=>{
              console.log(res);
              this.contentData = res.data.data.data;
          })
      },
      // 置顶按钮
      topping(id){
        this.article_id = id;
        if(this.cloneToppingBtm == false){
          this.toppingBtm = true;
          this.toppingDialog = true;
          this.cloneToppingBtm = false;
        }
        if(this.toppingBtm == false) {
          this.toppingDialog = false;
          this.toppingBtm = false;
          this.cloneToppingBtm = true;
          this.cloneToppingDialog = true;
        }
      },
      //取消置顶
      unTopping(id){
          this.HttpClient.post('/admin/article/changeStatus',{
            article_id:id,
            status:1
        })
        .then(res=>{
            console.log(res)
            if(res.data.code === 200){
                setTimeout(() => {
                    this.$message.success(res.data.msg);
                    this.getArticleList();
                }, 300);  
            }else{
                this.$message.error(res.data.msg);
            }
        })
      },
      // 置顶确认框
      toppingSubmit(){
        this.toppingDialog = false;
        this.toppingBtm = false;
        this.cloneToppingBtm = true;
        this.HttpClient.post('/admin/article/changeStatus',{
            article_id:this.article_id,
            status:4,
            image_path:this.imgPath
        })
        .then(res=>{
              console.log(res);
              if(res.data.code === 200){
                  setTimeout(() => {
                    this.$message.success(res.data.msg);
                    this.getArticleList();
                }, 300);
              }else{
                  this.$message.error(res.data.msg);
              }
        })
      },
      // 取消置顶确认框
      cloneToppingSubmit(){
        this.cloneToppingBtm = false;
        this.toppingBtm = true;
        this.cloneToppingDialog = false;
      },


      // 筛选状态
      formatter(row, column) {
        return row.address;
      },
      filterHandler(value, row, column) {
        const property = column['property'];
        return row[property] === value;
      },

      // 图片上传
      handleAvatarSuccess(res, file) {
        console.log(file)
        if(this.imgPath != ''){
            this.imageUrl = URL.createObjectURL(file.raw);
        }else{
            this.imageUrl = '';
        }
        
      },
      beforeAvatarUpload(file) {
        console.log(file)
        var FromData = new FormData()
        const isJPG = file.type === 'image/jpeg'||'image/png'||'image/jpg';
        const isLt10M = file.size / 20480 / 1024 < 2;
        if (isJPG && isLt10M) { 
            FromData.append('token', window.localStorage.token)
            FromData.append('images', file)
            FromData.append('type','article')
            this.$ajax.post('http://test.kslab.com/api/admin/uploadOneImage', FromData)
            .then((res) => {
                console.log(res)
                if(res.data.code === 200){
                    this.$message.success(res.data.msg);
                    this.imgPath = res.data.path;
                }else{
                    this.$message.error(res.data.msg);
                    this.imgPath = '';
                }
                
            })
          return isJPG && isLt10M;
        }else{
          this.$message.error('上传图片格式错误或是图片过大!'); 
        }

        // if (!isLt10M) {
        //   this.$message.error('上传图片大小不能超过 10MB!');
        // }
        
        
        
       
      }

    }
  }
</script>

<style lang="less">
  .articlePageview{
    padding: 10px;
    /*面包屑*/
    .bread{
      margin-bottom: 10px;
    }

    .articlePageview_main{
      height: calc(100vh - 87px);
      width: calc(100vw - 240px);
      border-radius: 2px;
      background: #fff;

      /*标题*/
      .title{
        height: 80px;
        display: flex;
        align-items: center;
        border-bottom: 2px solid #f2f2f2;
        padding-left: 45px;
        color: #222;
        font-size: 20px;
      }

      /*列表*/
      .articlePageview_content{
        padding: 30px 45px;

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
          /*操作*/
          .contentOperating{
            padding: 0;
            .cell{
              display: flex;
              align-items: center;
              justify-content: center;
              height: 100%;
              div{
                flex: 1;
                cursor: pointer;
              }
            }
          }
        }

        /*数量框*/
        .quantity_btm{
          background: #15bafe;
          display: flex;
          margin-top: 20px;
          justify-content: center;
          align-items: center;
          color: #fff;
          font-size: 16px;
          max-width: 130px;
          height: 40px;
        }
      }
    }

    /*置顶框*/
    .toppingDialog{
      .toppingDialog_title{
        display: flex;
        align-items: center;
        font-size: 16px;
        color: #000;
        .iconfont{
          margin-right: 10px;
          color: #15bafe;
        }
      }
      .el-dialog__body{
        padding: 10px 40px;
      }
      .toppingDialog_box{
        .topping_uploader .el-upload {
          border: 1px dashed #d9d9d9;
          border-radius: 6px;
          cursor: pointer;
          position: relative;
          overflow: hidden;
        }
        .topping_uploader .el-upload:hover {
          border-color: #409EFF;
        }
        .avatar-uploader-icon {
          font-size: 28px;
          color: #8c939d;
          width: 318px;
          height: 178px;
          line-height: 178px;
          text-align: center;
        }
        .avatar {
          width: 318px;
          display: flex;
          justify-content: center;
          align-items: center;
        }
      }
    }

    /*取消置顶框*/
    .cloneToppingDialog{
      .cloneToppingDialog_title{
        display: flex;
        align-items: center;
        font-size: 16px;
        color: #000;
        .iconfont{
          margin-right: 10px;
          color: #15bafe;
        }
      }
      .el-dialog__body{
        padding: 10px 40px;
      }
      .cloneToppingDialog_box {
        .cloneToppingDialog_icon{
          i{
            font-size: 80px;
            color: #15bafe;
          }
        }
        p{
          font-size: 14px;
          color: #000;
          margin-top: 20px;
        }
      }
    }

  }
</style>
