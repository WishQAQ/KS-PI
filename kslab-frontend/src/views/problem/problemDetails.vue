<template>
    <div class="problemDetails" v-if="dataproblem">
      <!--上半部分-->
      <div class="problemDetails_top">
        <div class="problemDetails_top_box">
          <!--点赞-->
          <div class="problemDetails_like">
            <praise-div :type="parise" :index="0" :letType="6"></praise-div>
          </div>

          <div class="problemDetails_content">
            <!--标题-->
            <div class="problemDetails_content_title">
              <div class="problemDetails_content_title_text">
                {{dataproblem.title}}
              </div>
              <div class="problemDetails_content_avatar" @click="RouterOut">
                <div class="problemDetails_content_avatar_text">
                  <p>{{dataproblem.userinfo.name}}</p>
                  <span>{{dataproblem.userinfo.signature}}</span>
                </div>
                <div class="problemDetails_content_avatar_img" >
                  <img :src="request.picUrl + dataproblem.userinfo.avatar" alt="">
                </div>
              </div>
            </div>
            <!--详情内容-->
            <div class="problemDetails_content_main">
              <p v-html="dataproblem.content"></p>
            </div>

            <!--详情信息及附件-->
            <div class="problemDetails_content_data">
              <div class="problemDetails_content_data_message">
                <p><i class="icon icon-ziyuan37"></i><span>{{dataproblem.view_num}}</span></p>
                <p><i class="icon icon-ziyuan41"></i><span>{{handleDate(dataproblem.created_at)}}</span></p>
              </div>

              <!--下载按钮-->
              <div class="problemDetails_content_data_download">
                <p class="problemDetails_content_data_btm" @click="problemDetailsDownloadOpen" :class="{downloadBtm:downloadBtmOpen}">
                  显示全部<i class="el-icon-arrow-down"></i>
                </p>
              </div>

            </div>
            <!--下载内容-->
            <div class="problemDetails_content_data_box" :class="{download:downloadOpen}">
              <ActitveData :attachment="dataproblem.attachment"></ActitveData>
              <!-- <ul>
                <li v-for="(dataList ,index) in dataproblem.attachment" :key="index">
                  <el-tooltip class="item" effect="light" placement="top-start" popper-class="problemDetails_content_data_img">
                    <div slot="content">
                      <img src="/static/img/article_details_img.png" alt="">
                    </div>
                    <p>
                      <i class="icon icon-icon--"></i>
                      <span>{{dataList.name}}</span>
                    </p>
                  </el-tooltip>
                  <a href="">[下载]</a>
                </li>
              </ul> -->
            </div>

            <div class="problemDetails_reply">
              <div :class="{problemDetails_reply_btm:true, 'atvice':status}" @click="statusToken?butContClick():butContFalse()">+ 写回答</div>
              <p @click="shareModalShowTrue"><i class="icon icon-fenxiang"></i>分享</p>
              <p @click="handleOpenReport()" ><i class="icon icon-huaban"></i>举报</p>
            </div>
          </div>


        </div>
      </div>
      <!--下半部分-->
      <el-collapse-transition>
        <div class="problemDetails_bottom" v-show="show3">
        <div class="problemDetails_comment">
          <div class="problemDetails_comment_avatar">
            <div class="problemDetails_comment_avatar_img"><img :src="request.picUrl + this.avatarUser" alt=""></div>
            <div class="problemDetails_comment_userName" v-if="userFata">
              <p>{{userFata.nickname}}</p>
              <span>{{userFata.signature}}</span>
            </div>
          </div>

          <div class="problemDetails_comment_edit">
            <quill-editor
              v-model="content"
              ref="myQuillEditor">
            </quill-editor>
          </div>

          <div class="problemDetails_comment_upload">
            <p>附件<span>(最多5个,每个最大5MB）</span></p>

            <div class="problemDetails_comment_uploadBox">
              <el-upload
                action="http://test.kslab.com/api/article/null"
                list-type="picture-card"
                :on-preview="handlePictureCardPreview"
                :on-remove="handleRemove"
                :before-upload="uploadingProblem">
                <i class="el-icon-plus"></i>
              </el-upload>
              <el-dialog :visible.sync="dialogVisible">
                <img width="100%" :src="dialogImageUrl" alt="">
              </el-dialog>
            </div>
          </div>
          <div class="problemDetails_comment_submit">
            <div>取消</div>
            <div @click="textSubmitContent">提交</div>
          </div>
        </div>
      </div>
      </el-collapse-transition>

      <div class="problemDetails_viewComments">
        <!--查看评论-->
        <div class="problemDetails_viewComments_list">
          <div class="viewComments_list_head">
            <div class="viewComments_list_title" v-if="dataProblemList">
              {{this.dataProblemList.length}}个人回答
            </div>
            <div class="viewComments_list_sort">
              <i class="icon icon-ziyuan30"></i>
              <el-select v-model="value" popper-class="viewComments_list_sort_box" @change="selectChange">
                <el-option
                  v-for="item in options"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </div>
          </div>

          <div class="viewComments_list_main">
            <div class="viewComments_list_main_list" v-for="(item ,index) in dataProblemList" :key="index">
              <!--点赞-->
              <div class="problemDetails_list_like">
                <praise-div :type="parises" :index="index" letType="2"></praise-div>
              </div>

              <!--评论内容-->
              <div class="problemDetails_list_content">
                <div class="problemDetails_list_top">
                  <div class="problemDetails_list_avatar" @click="RouterOutCommt(index)">
                    <div class="problemDetails_list_avatar_img">
                      <img :src="request.picUrl + item.avatar" alt="">
                    </div>
                    <div class="problemDetails_list_userName">
                      <p>{{item.name}}</p>
                      <span>{{item.signature}}</span>
                    </div>
                  </div>
                  <div class="problemDetails_list_time">{{handleDate(item.created_at)}}之前</div>
                </div>
                <div class="problemDetails_list_text" v-html="item.content">
                </div>
                <div class="problemDetails_list_bottom">
                  <!--回复子评论-->
                  <div class="problemDetails_list_bottom_reply">
                    <p @click="outerVisible"><i class="icon icon-ziyuan36"></i>{{item.comment_num}}条评论</p>
                    <p @click="shareModalShowTrue"><i class="icon icon-fenxiang"></i></p>
                    <p @click="handleOpenReport()"><i class="icon icon-huaban"></i></p>
                  </div>

                  <div class="problemDetails_list_bottom_annex" @click="problemDetailsAnnexShowBtm(index)" :class="{problemDetailsAnnex:annexBtm}">
                    <p><i class="icon icon-icon--"></i>查看附件</p>
                  </div>
                </div>
                <div class="problemDetails_list_annex" v-show="index == problemDetailsAnnexShow?true:false">
                  <ActitveData :attachment="item.attachment"></ActitveData>
                </div>

              </div>

            </div>
          </div>

        </div>

        <!--学海无涯-->
        <div class="problemDetails_viewComments_right" v-if="problemDataRight">
          <div class="viewComments_right_title">学海无涯</div>
          <div class="viewComments_right_list">
            <div class="viewComments_right_encyclopedia">
              <div class="viewComments_encyclopedia_list" v-for="(item ,index) in problemDataRight.encyclopedias" :key="index" @click="RouterIndexEncy(index)">
                <div class="viewComments_encyclopedia_img">
                  <img :src="request.picUrl + item.cover" alt="">
                </div>
                <div class="viewComments_encyclopedia_text">
                  <p>{{item.title}}</p>
                  <span>{{item.view_num}} 次浏览 · {{handleDate(item.created_at)}}</span>
                </div>
              </div>
            </div>

            <div class="viewComments_right_problem">
              <div class="viewComments_problem_list" v-for="(item ,index) in problemDataRight.questions" :key="index">
                <div class="viewComments_problem_title" @click="RouterIndexProb(index)"><span></span>{{item.title}}</div>
                <p class="viewComments_problem_main" v-html="item.content" @click="RouterIndexProb(index)">

                </p>
                <div class="viewComments_problem_tags"><keywordInstallDiv :keyword="item.tagsname"></keywordInstallDiv></div>
                <div class="viewComments_problem_userMessage" @click="RouterIndexProb(index)">
                  <p><i class="icon icon-ziyuan31"></i>{{item.nickname}}</p>·
                  <p>{{item.view_num}}次浏览</p>·
                  <p>{{handleDate(item.created_at)}}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!--举报盒子-->
      <ReportDialogDiv @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="question_id"></ReportDialogDiv>
      <!--分享盒子-->
      <ShareModalDiv ref="shareModal" v-if="shareModalShow"></ShareModalDiv>
      <!--评论盒子-->
      <commentModalDiv ref="commentModal" v-if="outerVisibleModal" :comments="commentLength"></commentModalDiv>
    </div>
</template>

<script>
  import ActitveData from "@/views/activity/actvityDataFlie"
  import FormatDate from "../../utils/GetDateUtils";
  import praiseDiv from "@/components/praise"
  import ShareModalDiv from '@/components/shareModal'  //分享框
  import ReportDialogDiv from '@/components/ReportDialog'  //举报框
  import keywordInstallDiv from '@/components/keywordInstall'  //tags标签
  import commentModalDiv from '@/components/commentModal'
  import { quillEditor } from 'vue-quill-editor'

  import * as Quill from 'quill'  //引入编辑器

  //quill图片可拖拽改变大小
  import  ImageResize   from 'quill-image-resize-module';
  Quill.register('modules/imageResize', ImageResize);

  //quill图片可拖拽上传
  import { ImageDrop } from 'quill-image-drop-module';
  Quill.register('modules/imageDrop', ImageDrop);

  import {container, ImageExtend, QuillWatch} from 'quill-image-extend-module'
  Quill.register('modules/ImageExtend', ImageExtend);

  // var toolbarOptions = [
  //   [ 'italic', 'underline', 'strike','bold'],
  //   ['blockquote','code-block'],
  //   [{'list':'ordered'},{'list':'bullet'}],
  //   [{'script':'sub'},{'script':'super'}],
  //   [{'indent':'-1'},{'indent':'+1'}],
  //   [{'direction':'rtl'}],
  //   [{'size':fontSize}],
  //   [{'color':[]}],
  //   [{'align':[]}],
  //   ['image']
  // ];


  export default {
        name: "problemDetails",
      components:{
        praiseDiv,
        ShareModalDiv,
        ReportDialogDiv,
        commentModalDiv,
        keywordInstallDiv,
        ActitveData
      },
    data(){
      return{
        avatarImg:'', //头像地址
        parise:[
          {
            'parise':'parise',
            id:this.$route.query.id,
            praise:null,
            state:0
          }
        ],   //问题
        parises:[],    //评论
        downloadOpen:false,  //附件盒子
        downloadBtmOpen:false, //附件按钮
        shareModalShow:false, //分享盒子
        reportVisible: false, //举报盒子

        content:null,  //富文本编辑器

        //上传附件
        dialogImageUrl: '',
        dialogVisible: false,


        // 排序选择框
        options: [{
          value: '1',
          label: '回答时间'
        }, {
          value: '2',
          label: '点赞人数'
        }],
        value: '回答时间',

        outerVisibleModal:false,  //子评论框
        commentLength:'',  //回复评论参数

        annexBtm:false,  //子评论附件框按钮
        problemDetailsAnnexShow:false, //子评论附件框


        // tags标签
        keyword:['汽车','摩托车','无人机'],
        dataproblem:null,
        show3: false,   //回答显示隐藏
        status:null,    //用户是否登陆状态
        order:null,     //排序方式
        dataProblemList:null,   //评论数据
        userFata:null,   //用户评论信息
        attachment:null,    //附件地址  改为编号直接在此变为时间戳即好
        statusToken:window.localStorage.token,
        problemDataRight:null,     //问题学海无涯数据
        avatarUser:null
      }
    },

    methods:{
      
      /*
        百科详情点击头像进入
      */
      RouterOut(){
        this.RouterLinkOther(this.dataproblem.created_id)
      },
      /*
        评论点击头像进入
      */
      RouterOutCommt(index){
        console.log(this.dataProblemList[index].created_id)
        this.RouterLinkOther(this.dataProblemList[index].created_id)
      },
      RouterIndexProb(index){
        console.log(this.problemDataRight)
        this.$router.push({
          path:'/home/problemDetails',
          query:{
            id:this.problemDataRight.questions[index].question_id
          }
        })
      },
      RouterIndexEncy(index){
        console.log(this.problemDataRight.encyclopedias)
        this.$router.push({
          path:'/home/BaikeDetail',
          query:{
            id:this.problemDataRight.encyclopedias[index].encyclopedia_id
          }
        })
      },
      butContFalse(){
          this.$message({
             message: '请先去登陆哟',
             type: 'warning'
          });
      },
      butContClick(){
        this.show3 =! this.show3
        this.userNameData()
      },
      selectChange(index){
        if(index == "选项1"){
          this.commentProblem()
        }else{
          //根据选择传值再次排序
          this.order = 1
          this.commentProblem()
        }
      },
      handleDate(date) {
        return FormatDate.GetDate(date);
      },
      problemDetailsDownloadOpen(){
        if (this.downloadOpen == false){
          this.downloadOpen=true;
          this.downloadBtmOpen=true
        }else {
          this.downloadOpen=false;
          this.downloadBtmOpen=false
        }
      },

      // 打开分享盒子
      shareModalShowTrue(){
        if(!this.$refs.shareModal.modelDelete){
          this.$refs.shareModal.show();
        }
      },
      // 打开举报框
      handleOpenReport() {
        console.log('124346758')
        this.reportVisible = true;
      },
      /***
       * 回调举报
       * @param value
       */
      getReportVisible(value) {
        this.reportVisible = value;
      },

      // 上传附件
      handleRemove(file, fileList) {

      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },


      // 查看子评论
      outerVisible(){
        if (this.outerVisibleModal == false){
          this.outerVisibleModal =true
        }else {
          this.outerVisibleModal = false
        }
      },

      // 打开子评论附件框
      problemDetailsAnnexShowBtm(index){
        this.problemDetailsAnnexShow = index
      },
      //获取评论列表
      commentProblem(){
        this.HttpClient.post('/questions/getAnswer',{
          token:window.localStorage.token,
          question_id:this.$route.query.id,
          order:this.order
        })
        .then((res) => {
          console.log('错误查找')
          console.log(res)
          this.dataProblemList = res.data.data.data
          for(let a = 0;a<this.dataProblemList.length;a++){
          this.parises.push(
              {
                "id":this.dataProblemList[a].answer_id,
                "praise":this.dataProblemList[a].like_num,
                "state":0
              }
           )
          }
          console.log(res)
          console.log(this.dataProblemList)
        })
      },
      userNameData(){
        this.HttpClient.post('/web/user/profile',{
          token:window.localStorage.token
        })
        .then((res) => {
          this.userFata = res.data.data[0]
          this.avatarUser = this.userFata.avatar
        })
      },
      //提交评论-yc
      textSubmitContent(){
        console.log('Cloud Test Content！  ')
        if(this.attachment === null){  //判断是否传附件，未选择附件则不传附件
          console.log('不传附件')
          this.HttpClient.post('/questions/answer',{
            token:window.localStorage.token,
            source_id:this.$route.query.id,
            content:this.content
          })
          .then((res) => {
            console.log(res)
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              this.commentProblem();
            }else{
              this.$message.error(res.data.msg)
            }
          })
        }else{
          this.HttpClient.post('/questions/answer',{
            token:window.localStorage.token,
            source_id:this.$route.query.id,
            content:this.content,
            serialnum:this.attachment
          })
          .then((res) => {
            console.log(res)
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              this.commentProblem();
            }else{
              this.$message.error(res.data.msg)
            }
          })
        }
      },
      //上传附件
      uploadingProblem(file){
        var formData = new FormData();
        formData.append("token",window.localStorage.token)
        formData.append("images",file)
        formData.append("serialnum",this.attachment)
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'questions/upload',formData)
        .then((res) => {
          // console.log(this.attachment)
          this.attachment = Number(new Date())
          if(res.data.code == 200){
            this.$message.success(res.data.msg)

          }else{
            this.$message.error(res.data.msg)
          }
        })
      },
      //获取问题详情-yc
      uploadingDataBody(){
        this.HttpClient.post('/questions/questionsInfo',{
          question_id:this.$route.query.id
        })
        .then((res) => {
          console.log(res)
          this.question_id = res.data.data;
          this.parise[0].praise = res.data.data.like_num
          console.log(res.data.data.like_num)
          this.dataproblem = res.data.data
          this.dataproblem.attachment = JSON.parse(res.data.data.attachment)
          this.avatarUser = res.data.data
          console.log(this.avatarUser)

          /*
            学海无涯
          */
          this.HttpClient.post('/questions/relatedQuestions',{
            question_id:this.$route.query.id,
            title:this.dataproblem.title
          })
          .then((res) => {
            console.log(res)
            this.problemDataRight = res.data.data
          })
        })
      },
    },
    created(){
      console.log(this.$route.query.id)

      this.uploadingDataBody();
      this.commentProblem();
      if(window.localStorage.token){
        console.log("1")
        this.status = true
      }else{
        this.status = false
      }


    },
    watch:{
      $route(to,form){
        /*
          监听路由进行数据重载
        */
        this.uploadingDataBody()
        this.commentProblem()
      }
    }
  }
</script>

<style lang="less">
  .problemDetails_list_annex_list>p>.icon{
    color:#15befe !important;
    font-size:15px;
  }
  .atvice{
    background-color: #15befe !important;
  }
  /*附件预览框*/
  .problemDetails_content_data_img{
    width: 150px;
    img{
      width: 100%;
    }
  }

.problemDetails{
  background-color: #f2f2f2;

  /*上半部分*/
  .problemDetails_top{
    background-color: #fff;
    padding-top: 30px;
    padding-bottom: 30px;
    margin-bottom: 30px;
    .problemDetails_top_box{
      max-width: 1200px;
      min-width: 960px;
      margin: 0 auto;
      display: flex;
      /*点赞*/
      .problemDetails_like{
        margin-right: 15px;
      }
      /*详情内容*/
      .problemDetails_content{
        flex: 1;
        /*标题*/
        .problemDetails_content_title{
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 20px;

          /*标题文字*/
          .problemDetails_content_title_text{
            font-size: 26px;
            color: #000;
          }
          /*头像*/
          .problemDetails_content_avatar{
            display: flex;
            cursor: pointer;
            align-items: center;
            /*用户名*/
            .problemDetails_content_avatar_text{
              text-align: right;
              margin-right: 10px;
              p{
                font-size: 16px;
                color: #000;
              }
              span{
                font-size: 12px;
                color: #666;
              }
            }
            .problemDetails_content_avatar_img{
              width: 40px;
              height: 40px;
              border: 1px solid #15bafe;
              border-radius: 5px;
              overflow: hidden;

              img{
                width: 100%;
                height: 100%;
              }
            }
          }
        }
        /*详情内容文字*/
        .problemDetails_content_main{
          font-size: 14px;
          color: #666;
          margin-bottom: 10px;
        }
        /*详情信息及附件*/
        .problemDetails_content_data{
          display: flex;
          align-items: center;
          justify-content: space-between;
          position: relative;
          width: 100%;
          /*详情信息*/
          .problemDetails_content_data_message{
            display: flex;
            align-items: center;
            p{
              margin-right: 20px;
              color: #898989;
            }
            .icon{
              font-size: 12px;
              color: #898989;
              margin-right: 5px;
            }
          }
          /*附件*/
          .problemDetails_content_data_download{
            /*查看更多按钮*/
            .problemDetails_content_data_btm{
              color: #bfbfbf;
              cursor: pointer;
              i{
                margin-left: 5px;
              }
            }
            .downloadBtm{
              color: #15bafe !important;
              i{
                transform: rotate(180deg) !important;
              }
            }
          }
        }
        /*下载附件盒子*/
        .problemDetails_content_data_box{
          width: 100%;
          margin-top: 10px;
          margin-bottom: 10px;
          height: 35px;
          overflow: hidden;
          ul{
            li:hover{
              background-color: #f2f2f2;
            }
            li{
              display: flex;
              justify-content: space-between;
              align-items: center;
              height: 50px;
              border-bottom: 1px dashed #dedede;
              padding: 0 10px;
              p{
                display: flex;
                align-items: center;
                font-size: 14px;
                color: #666;
                .icon{
                  font-size: 24px;
                  color: #15bafe;
                  margin-right: 10px;
                }
              }
              a{
                font-size: 14px;
                color: #666;
              }
              a:hover{
                color: #15bafe;
              }
            }
          }
        }
        .download{
         height: auto;
        }

        /*写回答*/
        .problemDetails_reply{
          display: flex;
          align-items: center;
          .problemDetails_reply_btm{
            width: 70px;
            height: 25px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 5px;
            overflow: hidden;
            background-color: #ccc;
            font-size: 12px;
            color: #fff;
            cursor: pointer;
          }
          p{
            display: flex;
            align-items: center;
            margin-left: 20px;
            color: #ccc;
            cursor: pointer;
            i{
              margin-right: 5px;
              color: #ccc;
              font-size: 12px;
            }
          }
          p:hover{
            color: #999;
            i{
              color: #999;
            }
          }
        }
      }
    }
  }

  /*下半部分*/
  .problemDetails_bottom{
    margin-bottom: 30px;
    /*评论框*/
    .problemDetails_comment{
      max-width: 1200px;
      min-width: 960px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;

      /*头像/用户名*/
      .problemDetails_comment_avatar{
        display: flex;
        align-items: center;

        /*头像*/
        .problemDetails_comment_avatar_img{
          width: 50px;
          height: 50px;
          border: 1px solid #15bafe;
          border-radius: 5px;
          overflow: hidden;
          margin-right: 10px;
          img{
            width: 100%;
          }
        }
        /*用户名*/
        .problemDetails_comment_userName{
          p{
            font-size: 18px;
            font-weight: bold;
            color: #000;
          }
          span{
            font-size: 14px;
            color: #737373;
          }
        }
      }

      /*富文本编辑器*/
      .problemDetails_comment_edit{
        margin: 30px 0;

        /*文本域初始高度*/
        .ql-editor{
          height: 160px;
        }
        /*富文本样式设置*/
        .ql-toolbar.ql-snow{
          border-top-left-radius: 5px;
          border-top-right-radius: 5px;
          background: #f0f0f0;
        }
        .ql-container.ql-snow{
          border-bottom-left-radius: 5px;
          border-bottom-right-radius: 5px;
        }
      }

      /*附件上传*/
      .problemDetails_comment_upload{
        >p{
          font-size: 16px;
          color: #000;
          margin-bottom: 10px;
          span{
            font-size: 12px;
            color: #6a6a6a;
          }
        }

        .problemDetails_comment_uploadBox{
          border: 1px solid #dcdcdc;
          border-radius: 5px;
          padding: 10px;

          .el-upload--picture-card{
            width: 80px;
            height: 80px;
            line-height: 80px;
          }
          .el-upload-list--picture-card .el-upload-list__item{
            width: 80px;
            height: 80px;
            line-height: 80px;
          }
          .el-upload-list--picture-card .el-upload-list__item-status-label i{
            position: absolute;
            top: 0px;
            left: 14px;
          }
        }
      }

      /*提交按钮*/
      .problemDetails_comment_submit{
        margin-top: 20px;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        div{
          width: 65px;
          height: 28px;
          border: 1px solid #15bafe;
          border-radius: 5px;
          font-size: 14px;
          display: flex;
          justify-content: center;
          align-items: center;
          margin-left: 20px;
        }
        div:nth-child(1){
          background-color: #fff;
          color: #15bafe;
        }
        div:last-child{
          background-color: #15bafe;
          color: #fff;
        }
      }
    }
  }

  .problemDetails_viewComments{
    max-width: 1200px;
    min-width: 960px;
    margin: 0 auto;
    display: flex;
    flex: 2;
    padding-bottom: 30px;

    .problemDetails_viewComments_list{
      background-color: #fff;
      flex: 1;
      padding: 20px;
      border-top: 4px solid #15bafe;
      .viewComments_list_head{
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #f2f2f2;
        padding-bottom: 10px;
        margin-bottom: 20px;
        .viewComments_list_title{
          font-size: 18px;
          color: #000;
        }

        /*下拉选择框*/
        .el-input__inner{
          border: none;
          height: 25px;
          line-height: 25px;
          width: 120px;
        }
        .el-input__icon{
          line-height: 25px;
        }
      }
      /*评论列表*/
      .viewComments_list_main{
        .viewComments_list_main_list{
          padding: 20px 10px;
          cursor: pointer;
          display: flex;
          /*内容区*/
          .problemDetails_list_content{
            flex: 1;
            /*用户信息*/
            .problemDetails_list_top{
              display: flex;
              align-items: flex-end;
              justify-content: space-between;
              margin-bottom: 15px;
              /*头像*/
              .problemDetails_list_avatar{
                display: flex;
                align-items: center;
                .problemDetails_list_avatar_img{
                  width: 40px;
                  height: 40px;
                  border: 1px solid #15bafe;
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  border-radius: 5px;
                  overflow: hidden;
                  margin-right: 10px;
                  img{
                    width: 100%;
                    height: 100%;
                  }
                }
               .problemDetails_list_userName{
                 p{
                   font-size: 14px;
                   color: #333;
                 }
                 span{
                   font-size: 12px;
                   color: #999;
                 }
               }
              }
              /*发布时间*/
              .problemDetails_list_time{
                font-size: 12px;
                color: #999;
              }

            }

            /*评论内容*/
            .problemDetails_list_text{
              font-size: 14px;
              color: #333;
              padding-bottom: 10px;
              margin-bottom: 5px;
              border-bottom: 1px dashed #f2f2f2;
            }

            /*查看子评论/下载附件*/
            .problemDetails_list_bottom{
              display: flex;
              justify-content: space-between;
              align-items: center;
              /*查看子评论*/
              .problemDetails_list_bottom_reply{
                display: flex;
                align-items: center;
                p{
                  margin-right: 15px;
                  font-size: 12px;
                  color: #999;
                  cursor: pointer;
                  .icon{
                    font-size: 12px;
                    color: #999;
                    margin-right: 5px;
                  }

                }
                p:hover{
                  color: #333;
                  .icon{
                    color: #333;
                  }
                }

              }

              /*查看附件*/
              .problemDetails_list_bottom_annex{
                margin-bottom: -1px;
                padding: 0 5px;
                cursor: pointer;
                border: 1px solid transparent;
                border-top: 2px solid transparent;
              }
              .problemDetailsAnnex{
                border: 1px solid #f2f2f2;
                border-top: 2px solid #15bafe;
              }
            }

            /*附件框*/
            .problemDetails_list_annex{
              border: 1px solid #f2f2f2;
              .problemDetails_list_annex_list{
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 5px 10px;
              }
              .problemDetails_list_annex_list:hover{
                background-color: #f2f2f2;
              }
            }
          }
        }
      }
    }

    /*学海无涯*/
    .problemDetails_viewComments_right{
      max-width: 370px;
      min-width: 270px;
      background-color: #fff;
      margin-left: 20px;
      padding: 10px 20px;
      .viewComments_right_title{
        font-size: 14px;
        color: #666;
        border-bottom: 1px solid #f2f2f2;
        padding-bottom: 5px;
        margin-bottom: 15px;
      }

      .viewComments_right_list{

        /*百科*/
        .viewComments_right_encyclopedia{

          .viewComments_encyclopedia_list{
            display: flex;
            cursor: pointer;
            align-items: center;
            margin-bottom: 10px;
            .viewComments_encyclopedia_img{
              width: 125px;
              height: 95px;
              overflow: hidden;
              margin-right: 10px;
              img{
                width: 100%;
              }
            }
            .viewComments_encyclopedia_text{
              p{
                height: 70px;
                font-size: 14px;
                color: #333;
                overflow: hidden;
              }
              span{
                font-size: 12px;
                color: #999;
              }
            }
          }
        }

        /*问题*/
        .viewComments_right_problem{
          .viewComments_problem_list{
            margin-bottom: 20px;
            cursor: pointer;
          }
          .viewComments_problem_title{
            font-size: 14px;
            color: #333;
            display: flex;
            align-items: center;
            span{
              display: inline-block;
              width: 4px;
              height: 14px;
              background-color: #15bafe;
              margin-right: 5px;
            }
          }
          .viewComments_problem_main{
            height: 35px;
            overflow: hidden;
          }
          .viewComments_problem_userMessage{
            display: flex;
            align-items: center;
            color: #ccc;
            p{
              font-size: 12px;
              margin: 0 5px;
              display: flex;
              align-items: center;
              .icon{
                margin-right: 5px;
              }
            }
            p:hover{
              color: #333;
            }

          }
        }
      }
    }
  }

}
</style>
