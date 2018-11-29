<template>

  <div class="businessCooperation">

    <div class="bc_banner">
      <div class="bc_title">
        <h2>cooperation</h2>
        <p>企业合作</p>
      </div>

      <div class="bc_main">
        <div class="bc_main_box item_1" :class="{cloneBanner1:cloneBanner1,'openBanner':openBanner1}">
          <div class="bc_main_text" v-if="bannerTextTrue">
            <p>举办活动</p>
            <span>organise event</span>
            <div @click="cloneBannerBtm1" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>
          <div class="bc_main_text main_text_right" v-else>
            <h4>举办活动</h4>
            <span>organise event</span>
            <p>无论您是俱乐部还是酷炫的产品设计公司，甚至是改装厂，都可以通过举办活动的方式与潜在用户进行一场深度的交流。例如： 无人机俱乐部，通过举办活动，用户可以进一步的了解如何操控无人机； 产品设计公司可以展示自己的设计和生产流程；DIY工作室可以为用户提供定制的学习交流活动等等。</p>
            <div @click="cloneBannerBtm1" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>
        </div>
        <div class="bc_main_box item_2" :class="{cloneBanner2:cloneBanner2,'openBanner':openBanner2}">
          <div class="bc_main_text" v-if="bannerTextTrue">
            <p>推广产品</p>
            <span>promoting products</span>
            <div @click="cloneBannerBtm2" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>

          <div class="bc_main_text main_text_right" v-else>
            <h4>推广产品</h4>
            <span>promoting products</span>
            <p>在酷耍，您的产品将直接面对地球上最挑剔的用户，同时也是最专业的用户。通过发布视频、文章和对话，我们为您提供了最棒沟通渠道，您可以深度解刨产品以及讲解如何使用。</p>
            <div @click="cloneBannerBtm2" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>
        </div>
        <div class="bc_main_box item_3" :class="{cloneBanner3:cloneBanner3,'openBanner':openBanner3}">
          <div class="bc_main_text" v-if="bannerTextTrue">
            <p>提供服务</p>
            <span>Provide services</span>
            <div @click="cloneBannerBtm3" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>

          <div class="bc_main_text main_text_right" v-else>
            <h4>提供服务</h4>
            <span>Provide services</span>
            <p>用户的需求可能有多种，某些想修复放置已久的无人机，有些想对自己的爱车来一次完整的改造，或者他们想给最爱的人定制自己的3D首饰。如果您可以提供类似的服务，那就加入我们吧。</p>
            <div @click="cloneBannerBtm3" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>
        </div>
        <div class="bc_main_box item_4" :class="{cloneBanner4:cloneBanner4,'openBanner':openBanner4}">
          <div class="bc_main_text" v-if="bannerTextTrue">
            <p>扩展用户群体</p>
            <span>Extended user community</span>
            <div @click="cloneBannerBtm4" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>

          <div class="bc_main_text main_text_right" v-else>
            <h4>扩展用户群体</h4>
            <span>Extended user community</span>
            <p>强大的搜索引擎和最专业的学习交流空间，您可以无穷尽的与无数的工程师们来一场完美的探讨和研究。无论是您的产品还是您撰写的每一篇专业文章，都会被酷耍AI智能的推送给需要的用户，让工程文化在华夏开花结果。</p>
            <div @click="cloneBannerBtm4" class="bc_main_btm"><i class="icon icon-huaban5"></i></div>
          </div>
        </div>
      </div>



    </div>

    <div class="bc_box">
      <div class="bc_contact">
        <div>
          <p>姓名</p>
          <el-input v-model="input1"></el-input>
        </div>
        <div>
          <p>联系电话</p>
          <el-input v-model="input2">
            <template slot="prepend">+86</template>
          </el-input>
        </div>
      </div>
      <div class="bc_ue">
        <p>详细内容</p>

        <div>
          <quill-editor
            v-model="content"
            ref="myQuillEditor"
            :options="editorOption"
            @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
            @change="onEditorChange($event)">
          </quill-editor>
        </div>

      </div>
      <div class="bc_upload">
        <p>上传附件<span>（最多上传5个，每个最大5M）</span></p>

        <div>
          <el-upload
            action="http://test.kslab.com/api/article/null"
            list-type="picture-card"
            :limit="5"
            :file-list="fileList"
            :before-upload="handleBeforeUpload"
            :before-remove="handleBeforeRemove"
            :on-success="handleSuccess">
            <i class="el-icon-plus"></i>
          </el-upload>
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="dialogImageUrl" alt="">
          </el-dialog>
        </div>
      </div>
      <div class="bc_btn">
        <button type="submit" @click="onSubmitClick">提交</button>
      </div>
    </div>

  </div>

</template>

<script>

  export default {
    name: "businessCooperation",
    data() {
      return {
        cloneBanner1: true, //默认样式
        cloneBanner2: true,
        cloneBanner3: true,
        cloneBanner4: true,

        bannerTextTrue:true,

        openBanner1:false, //打开后切换样式
        openBanner2:false,
        openBanner3:false,
        openBanner4:false,




        // 轮播
        swiperOption: {
          direction: 'vertical',
          slidesPerView: 1,
          spaceBetween: 30,
          mousewheel: {
            releaseOnEdges: true,
          },
          pagination: {
            el: '.swiper-pagination',
            clickable: true
          }
        },


        fileList: [],
        fileFilesFileList: [], // 附件列表
        beforeFilesFileList: [], //上传之后，删除之前的fileList,
        input1: '',
        input2: '',

        // 富文本
        content: null,
        editorOption: {
          modules: {
            toolbar: [
              ['bold', 'italic', 'underline', 'strike'],
              ['blockquote', 'code-block']
            ]
          }
        },
        routerName: '',
        articleDataGather: '',
        arrayDetails: '',
        article_details_title: [{
          praise: '',
          state: 0
        }],
        articleReviews: '',   //文章评论
        outerVisible: null,
        innerVisible: false,
        thiscc: 1,
        isAutoTrue: false,
        isAuto: true,
        commentLength: '',  //回复评论参数
        commentFont: '',   //富文本编辑内容

        // 上传
        dialogImageUrl: '',
        limit: 5,
        dialogVisible: false,
        arrayPath: [],      //附件返回链接地址
      }
    },
    created() {
      this.serial_number = this.Tools.GetNumber();
    },
    methods: {
      cloneBannerBtm1(){
        this.openBanner1 = true;
        if(this.cloneBanner2 === true){
          this.bannerTextTrue = false;
          this.cloneBanner2 = false;
          this.cloneBanner3 = false;
          this.cloneBanner4 = false;
        }else{
          this.bannerTextTrue = true;
          this.openBanner1 = false;
          this.cloneBanner2 = true;
          this.cloneBanner3 = true;
          this.cloneBanner4 = true;
        }
      },
      cloneBannerBtm2(){
        this.openBanner2 = true;
        if(this.cloneBanner3 === true){
          this.bannerTextTrue = false;
          this.cloneBanner1 = false;
          this.cloneBanner3 = false;
          this.cloneBanner4 = false;
        }else{
          this.bannerTextTrue = true;
          this.openBanner2 = false;
          this.cloneBanner1 = true;
          this.cloneBanner3 = true;
          this.cloneBanner4 = true;
        }
      },
      cloneBannerBtm3(){
        this.openBanner3 = true;
        if(this.cloneBanner4 === true){
          this.bannerTextTrue = false;
          this.cloneBanner2 = false;
          this.cloneBanner1 = false;
          this.cloneBanner4 = false;
        }else{
          this.bannerTextTrue = true;
          this.openBanner3 = false;
          this.cloneBanner2 = true;
          this.cloneBanner1 = true;
          this.cloneBanner4 = true;
        }
      },
      cloneBannerBtm4(){
        this.openBanner4 = true;
        if(this.cloneBanner1 === true){
          this.bannerTextTrue = false;
          this.cloneBanner2 = false;
          this.cloneBanner3 = false;
          this.cloneBanner1 = false;
        }else{
          this.bannerTextTrue = true;
          this.openBanner4 = false;
          this.cloneBanner2 = true;
          this.cloneBanner3 = true;
          this.cloneBanner1 = true;
        }
      },


      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },

      // 富文本
      onEditorBlur() {//失去焦点事件
      },
      onEditorFocus() {//获得焦点事件
      },
      onEditorChange(event) {//内容改变事件
        this.commentFont = event.html
      },
      /*****
       * 上传图片之前
       * @param file
       * @returns {boolean}
       */
      async handleBeforeUpload(file) {
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        if(fileType !== 'jpg' && fileType !== 'doc' && fileType !== 'png' && fileType !== 'pdf'){
          this.$message.error('文档类型只能为txt、doc、docx');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传文件大小不能超过5M!')
          return false;
        }
        var FromData = new FormData();
        //文章上传图片接口
        //FromData.append('token', window.localStorage.token);
        FromData.append('attachment', file);
        FromData.append('serial_number', this.serial_number);
        this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'footer/positions/uploadattachment', FromData)
          .then((res) => {
            //console.log(res)
            if (res.data.code === 200) {
              console.log(res.data)
              this.fileFilesFileList.push(res.data.path)
              this.$message.success(res.data.msg)
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg)
              return false
            }

          })
      },
      /*****
       * 删除图片之前
       * @param file
       * @param fileList
       * @returns {Promise<boolean>}
       */
      async handleBeforeRemove(file, fileList) {
        const isLt5M = file.size / 1024 / 1024 < 5;
        const fileType = file.name.split('.')[1];
        if(fileType !== 'jpg' && fileType !== 'doc' && fileType !== 'png' && fileType !== 'pdf'){
          this.$message.error('文档类型只能为txt、doc、docx');
          return false;
        }
        if (!isLt5M) {
          this.$message.error('上传文件大小不能超过5M!')
          return false;
        }
        let index = this.beforeFilesFileList.map(item => item.name).indexOf(file.name)
        console.log(index)
        let urls = this.fileFilesFileList[index];
        console.log(urls)
        await this.HttpClient.post('/services/destroyFile', {url: urls}).then(res => {
          if (res.data.code === 200) {
            this.fileFilesFileList.splice(index, 1);
          } else {
            file.status = false;
            this.$message.error('删除失败');
            return false;
          }
        });
      },
      /***
       * 上传成功
       * @param response
       * @param file
       * @param fileList
       */
      handleSuccess(response, file, fileList) {
        console.log(file, fileList)
        this.beforeFilesFileList = fileList;
      },
      onSubmitClick() {
        const param = {
          name: this.input1,
          content: this.commentFont,
          phone: this.input2,
          attachment: this.serial_number
        };
        this.HttpClient.post('/footer/businesscooperation', param)
          .then(res =>{
            if(res.data.code === 200) {
              this.$message.success('提交成功');
              this.input1 = '';
              this.commentFont = '';
              this.input2 = '';
              this.serial_number = this.Tools.GetNumber();
            }else {
              this.$message.error(res.data.msg);
            }
          })
      }
    },
    components: {}
  }
</script>

<style lang="less">
  .bc_banner{
    display: flex;
    align-items: center;
    height: calc(100vh - 58px);

    /*左侧标题*/
    .bc_title{
      height: 100%;
      width: 360px;
      background: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      overflow: hidden;
      h2{
        font-size: 60px;
        color: #15befe;
        font-weight: bold;
        position: absolute;
        transform: rotate(90deg);
        margin-right: 20px;
        left: -25%;
        text-transform:uppercase
      }
      p{
        font-size: 32px;
        color: #606060;
        width: 32px;
        position: relative;
        top: -120px;
      }
    }

    /*右侧盒子*/
    .bc_main{
      display: flex;
      align-items: center;
      flex: 1;
      width: 100%;
      height: 100%;
      overflow: hidden;

      .bc_main_box.cloneBanner1,
      .bc_main_box.cloneBanner2,
      .bc_main_box.cloneBanner3,
      .bc_main_box.cloneBanner4{
        flex: 1;
        height: 100%;
        transition: all .5s;
        position: relative;
        display: flex;
        justify-content: center;
        align-items: flex-end;
      }

      .bc_main_box{
        width: 0;
        flex: 0;
        overflow: hidden;
        position: relative;
        transition: all .5s;

        /*预览文字*/
        .bc_main_text{
          text-align: center;
          text-transform:uppercase;
          color: #fff;
          position: relative;
          overflow: hidden;
          z-index: 1;
          transition: all .2s;
          margin-bottom: -50px;
          p{
            font-size: 30px;
          }
          span{
            font-size: 16px;
            color: #ababab;
          }
          .bc_main_btm{
            position: relative;
            top: 100px;
            overflow: hidden;
            transition: all .3s;
            cursor: pointer;
            .icon{
              font-size: 50px;
              color: #15befe;
            }
          }
        }

        .main_text_right{
          width: 300px;
          margin-right: 100px;
          color: #fff;
          text-align: right;

          h4{
            font-size: 30px;
            margin-bottom: 10px;
          }
          span{
            display: inline-block;
            color: #ababab;
            font-size: 16px;
            margin-bottom: 10px;
          }
          p{
            font-size: 14px;
          }
          .bc_main_btm{
            .icon{
              padding-right: 10px;
              transform: rotate(-90deg);
            }
          }
        }
      }

      /*放大*/
      .bc_main_box:hover{
        flex: 1.3;
        transition: all .5s;

        /*按钮浮起*/
        .bc_main_text{
          position: relative;
          padding-bottom: 30px;
          margin-bottom: 0;
          z-index: 1;
          .bc_main_btm{
            top: 0;
            transition: all .3s;
          }
        }
      }

      .bc_main_box.item_1{
        background: url("/static/img/business_activity.jpg") center center no-repeat;
        background-size: cover;

      }
      .bc_main_box.item_2{
        background: url("/static/img/business_product.jpg") center center no-repeat;
        background-size: cover;

      }
      .bc_main_box.item_3{
        background: url("/static/img/business_service.jpg") center center no-repeat;
        background-size: cover;

      }
      .bc_main_box.item_4{
        background: url("/static/img/business_client.jpg") center center no-repeat;
        background-size: cover;

      }


      .bc_main_box.openBanner{
        align-items: center;
        justify-content: flex-end;
      }

      .bc_main_box.openBanner::before{
        content: '';
        height: 100% !important;
        width: 40% !important;
        right: 0;
        position: absolute;
        background: linear-gradient(to left,rgba(0,0,0,.6),rgba(0,0,0,0)) !important;
      }
      .bc_main_box.openBanner:hover::before{
        content: '';
        height: 100% !important;
        width: 40% !important;
        right: 0;
        position: absolute;
        background: linear-gradient(to left,rgba(0,0,0,.6),rgba(0,0,0,0)) !important;
      }



      /*黑色遮罩*/
      .bc_main_box.cloneBanner1::before,
      .bc_main_box.cloneBanner2::before,
      .bc_main_box.cloneBanner3::before,
      .bc_main_box.cloneBanner4::before{
        content: '';
        transition: all .5s;
        width: 100%;
        height: 20%;
        bottom: 0;
        position: absolute;
        background: linear-gradient(to top,rgba(0,0,0,.6),rgba(0,0,0,0));
      }
      .bc_main_box.cloneBanner1:hover::before,
      .bc_main_box.cloneBanner2:hover::before,
      .bc_main_box.cloneBanner3:hover::before,
      .bc_main_box.cloneBanner4:hover::before{
        content: '';
        position: absolute;
        width: 100%;
        height: 50%;
        bottom: 0;
        background: linear-gradient(to top,rgba(0,0,0,.6),rgba(0,0,0,0));
        transition: all 350ms;
        -o-transition: all 350ms;
        -moz-transition: all 350ms;
        -webkit-transition: all 350ms;
      }
    }
    /*白色遮罩*/
    .bc_main .bc_main_box.cloneBanner1::after,
    .bc_main .bc_main_box.cloneBanner2::after,
    .bc_main .bc_main_box.cloneBanner3::after,
    .bc_main .bc_main_box.cloneBanner4::after{
      content: '';
      position: absolute;
      width: 100%;
      height: 100%;
      opacity: 0;
      transition: all 350ms;
      -o-transition: all 350ms;
      -moz-transition: all 350ms;
      -webkit-transition: all 350ms;
      top: 0;
    }
    .bc_main:hover .bc_main_box.cloneBanner1::after,
    .bc_main:hover .bc_main_box.cloneBanner2::after,
    .bc_main:hover .bc_main_box.cloneBanner3::after,
    .bc_main:hover .bc_main_box.cloneBanner4::after{
      content: '';
      position: absolute;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,.6);
      transition: all 350ms;
      -o-transition: all 350ms;
      -moz-transition: all 350ms;
      -webkit-transition: all 350ms;
      opacity: 1;
      top: 0;
    }
    .bc_main .bc_main_box.cloneBanner1:hover::after,
    .bc_main .bc_main_box.cloneBanner2:hover::after,
    .bc_main .bc_main_box.cloneBanner3:hover::after,
    .bc_main .bc_main_box.cloneBanner4:hover::after{
      content: '';
      position: absolute;
      width: 100%;
      height: 100%;
      opacity: 0;
      transition: all 350ms;
      -o-transition: all 350ms;
      -moz-transition: all 350ms;
      -webkit-transition: all 350ms;
      top: 0;
    }

    .bc_main:hover{
      .bc_main_text{
        z-index: 0;
      }
    }





  }

  .bc_box{
    max-width: 600px;
    margin: 50px auto 30px auto;
    >div{
      margin-bottom: 20px;
      >p{
        margin-bottom: 10px;
      }
    }
    .bc_contact{
      display: flex;
      justify-content: space-between;
      align-items: center;
      }
    .bc_ue{
      .ql-editor{
        height: 200px;
      }
    }
    .bc_btn{
      display: flex;
      justify-content: flex-end;
      button{
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0 15px;
        height: 30px;
        background: #15befe;
        color: #fff;
        border-radius: 4px;
        cursor: pointer;
        border: none;
      }
    }

  }

</style>

<!--<style lang="less">-->
  <!--.swiper-container{-->
    <!--height: 100%;-->
  <!--}-->
  <!--.activity,-->
  <!--.product,-->
  <!--.service,-->
  <!--.client{-->
    <!--display: flex;-->
    <!--justify-content: center;-->
    <!--align-items: center;-->
    <!--color: #fff;-->
    <!--.title{-->
      <!--z-index: 1;-->
      <!--position: relative;-->
      <!--display: flex;-->
      <!--align-items: flex-start;-->
      <!--height: 200px;-->
      <!--font-size: 24px;-->
    <!--}-->
    <!--.main_content{-->
      <!--height: 200px;-->
      <!--width: 30%;-->
      <!--z-index: 1;-->
      <!--position: relative;-->
      <!--display: flex;-->
      <!--align-items: flex-end;-->
      <!--font-size: 18px;-->
    <!--}-->
  <!--}-->


  <!--.activity:before,-->
  <!--.product:before,-->
  <!--.service:before,-->
  <!--.client:before{-->
    <!--content: '';-->
    <!--background: rgba(0,0,0,.5);-->
    <!--width: 100%;-->
    <!--height: 100%;-->
    <!--position: absolute;-->

  <!--}-->
  <!--.activity{-->
    <!--width: 100%;-->
    <!--height: 100%;-->
    <!--background: url("/static/img/business_activity.jpg") center center no-repeat;-->
    <!--background-size: 100%;-->
  <!--}-->
  <!--.product{-->
    <!--width: 100%;-->
    <!--height: 100%;-->
    <!--background: url("/static/img/business_product.jpg") center center no-repeat;-->
    <!--background-size: 100%;-->
  <!--}-->
  <!--.service{-->
    <!--width: 100%;-->
    <!--height: 100%;-->
    <!--background: url("/static/img/business_service.jpg") center center no-repeat;-->
    <!--background-size: 100%;-->
  <!--}-->
  <!--.client{-->
    <!--width: 100%;-->
    <!--height: 100%;-->
    <!--background: url("/static/img/business_client.jpg") center center no-repeat;-->
    <!--background-size: 100%;-->
  <!--}-->
<!--</style>-->

<!--<style src="../../assets/css/businessCooperation.css"></style>-->
