<template>
  <div>
    <div>
      <ul class="service_ul_box">
        <li v-for="(item, index) in commitDetail" :key="index">
          <!--头像框-->
          <div>
            <div class="user_div_oimg">
              <img :src="request.picUrl+item.avatar" alt="">
            </div>
            <div class="servic_font_box_size">
              <p>{{item.name}}</p>
              <p>{{item.signature}}</p>
            </div>
            <p class="floatRight_box">{{FormatDate(item.created_at)}}前</p>
            <p class="float"></p>
          </div>
          <!--评论框-->
          <div class="service_box_userDetal">
            <div class="service_praise_left">
              <praise-div :type="comit" :index="0"></praise-div>
            </div>
            <div class="service_presca_body">
              <div>
                {{item.content}}
                <ul class="service_img_block">
                  <li class="img_content_commit" v-for="(item1, index) in item.attachment" :key="index">
                    <img class="commit_imgs" :src="handleImg(item1)" alt="">
                  </li>
                </ul>
                <ul class="service_re_ul">
                  <li>
                    <img src="/static/img/icon/jub.png" alt="">
                    <span>举报</span>
                  </li>
                  <li>
                    <el-rate
                      v-bind:value="item.score/2"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']">
                    </el-rate>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </li>
      </ul>
      <el-pagination
        background
        class="pagination"
        layout="prev, pager, next"
        @current-change="handlePageChange"
        :page-size="size"
        :total="total">
      </el-pagination>
    </div>
    <!--<div class="commit">-->
      <!--<div class="commit_header">-->
        <!--<i class="icon icon-pinglun icon_commit"></i>-->
        <!--<p>发表评论</p>-->
      <!--</div>-->
      <!--<div class="text_area">-->
        <!--<el-input-->
          <!--type="textarea"-->
          <!--class="input_area"-->
          <!--maxlength="49"-->
          <!--:autosize="{ minRows:4,maxRows: 4}"-->
          <!--placeholder="评论最多50个字"-->
          <!--v-model="commitInput">-->
        <!--</el-input>-->
      <!--</div>-->
      <!--<div class="rate">-->
        <!--<p>服务评分:</p>-->
        <!--<el-rate-->
          <!--class="el_rate"-->
          <!--v-model="getRate"-->
          <!--:allow-half="true"-->
          <!--:colors="['#15bafe', '#15bafe', '#15bafe']">-->
        <!--</el-rate>-->
      <!--</div>-->
      <!--<div class="up_img">-->
        <!--<el-upload-->
          <!--action="http://test.kslab.com/api/article/null"-->
          <!--list-type="picture-card"-->
          <!--ref="uploads"-->
          <!--:limit="5"-->
          <!--:multiple="true"-->
          <!--:on-error="hanldeUpError"-->
          <!--:on-success="handleUpSuccess"-->
          <!--:before-upload="handleBeforeUpload"-->
          <!--:before-remove="handleBeforeRemove"-->
          <!--:on-change="handleUpChange"-->
          <!--:on-remove="handleRemove">-->
          <!--<i class="el-icon-plus"></i>-->
        <!--</el-upload>-->
        <!--<div class="up_remark" :style="fileList2.length>0?{display:'none'}:{}">-->
          <!--<p>最少上传1张图片，最多5张</p>-->
          <!--<p>图片必须包含服务商相关内容</p>-->
          <!--<p>图片不大于1m</p>-->
          <!--<p>格式限于:jpeg,png,jpg</p>-->
        <!--</div>-->
      <!--</div>-->
      <!--<el-row class="btn_div">-->
        <!--<el-button type="primary" size="mini" class="commit_btn" @click="handleCommit">提交</el-button>-->
      <!--</el-row>-->
    <!--</div>-->
  </div>
</template>

<script>
  import PraiseDiv from '@/components/praise'
  import {HttpClient} from "../../utils/HttpUtils";
  import cfg from '../../../config/app'
  import moment from 'moment'
  export default {
    props: ['activeId','type'],
    data(){
      return{
        value2: 4,
        comit:[
          {
            type:'serviceDetails',
            praise:"20",
            state:0
          }
        ],
        page: 1,
        size: 5,
        total: null, //总条数
        active_id: this.activeId,
        commitInput: '',
        upImgUrl: cfg.upImgUrl,
        imageData: {},
        getRate: 0,
        serialnum: null,
        fileList: [],
        fileList2: [], //组件生成的filelist,
        beforeFileList: [], //上传之后，删除之前的fileList
        commitDetail: [],
      }
    },
    components:{
      PraiseDiv
    },
    created() {
      this.serialnum = this.handleSerialNum();
      this.active_id=this.activeId;
      this.getComments();
    },
    mounted() {
      //console.log(this.service_id)
    },
    methods: {
      /***
       * 获取评论详情
       */
      getComments() {
          // this.active_id = param.active_id;
          const param = {
              page: this.page,
              size: this.size,
          };
          if(this.type==='product'){
              param.product_id=this.activeId;
          }else{
              param.active_id=this.activeId;
          }
        if(this.type==='product'){
            this.HttpClient.get('/products/comments',param)
                .then(res=>{
                    console.log(res);
                    if(res.data.code === 200) {
                        this.commitDetail = res.data.data;
                        this.total = res.data.total;
                        //console.log(this.commitDetail)
                    }
                })
        }else{
            this.HttpClient.get('/actives/comments',param).then(res =>{
                console.log(res)
                if(res.data.code === 200) {
                    this.commitDetail = res.data.data;
                    this.total = res.data.total;
                    //console.log(this.commitDetail)
                }
            })
        }

      },
      /***
       * 图便移除
       * @param file
       * @param fileList
       */
      handleRemove(file, fileList) {
        /*//console.log(file, fileList,idnex1,index2);*/
        //console.log(this.fileList)
      },
      handleBeforeRemove(file, fileList) {
        //console.log(file, fileList);
        //console.log(222,this.beforeFileList,file.name)
        let index = this.beforeFileList.map(item => item.name).indexOf(file.name)
        //console.log(index)
        this.fileList.splice(index, 1);
        //console.log(this.fileList)
      },
      /***
       * 图片预览
       * @param file
       */
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      handleBeforeUpload(file) {
        /*const imageData = {
          token: window.localStorage.getItem('token'),
          images: file,
          serialnum: this.serialnum
        };*/
        //console.log(file,file.size)
        if(file.size/1024<=1024 && (file.type === 'image/jpg' || file.type === 'image/jpeg' || file.type === 'image/png')){
          var FromData = new FormData()
          //文章上传图片接口
          FromData.append('token',window.localStorage.token)
          FromData.append('pics',file)
          FromData.append('serial_number',this.serialnum)
          this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'actives/uploadActivePics',FromData)
            .then((res) => {
              console.log(res)
              if(res.data.code === 200){
                this.fileList.push(res.data.path)
                //console.log(this.fileList)
              }

            })
        }else{
          this.$message.warning('图片大于1M或图片格式不正确')
          return false;
        }

      },
      /***
       * 图片发生变化
       * @param file
       * @param fileList
       */
      handleUpChange(file, fileList) {
        //console.log(file, fileList)
        this.fileList2 = fileList;
      },
      /***
       * 图片上传错误
       * @param err
       * @param file
       * @param fileList
       */
      hanldeUpError(err, file, fileList) {
        //console.log(err, file, fileList);
        this.$message.error(err);
      },
      /****
       * 图片上传成功
       * @param response
       * @param file
       * @param fileList
       */
      handleUpSuccess(response, file, fileList){
        //console.log(111,file, fileList)
        this.beforeFileList = fileList;
      },
      /***
       * 提交评论
       */
      handleCommit() {
        console.log(this.$store.state.activityDetail.activityDetail.active_id)
        const commit = {
          source_id: this.$store.state.activityDetail.activityDetail.active_id,
          content: this.commitInput,
          serial_number: this.serialnum,
          score: this.getRate * 2
        };
        this.HttpClient.post('/actives/answers',commit).then(res=>{
          //console.log(res)
          if(res.data.code === 200) {
            this.$message.success(res.data.msg);
            this.$refs.uploads.clearFiles();
            this.getRate = 0;
            this.commitInput = '';
            this.serialnum = this.handleSerialNum();
          }else{
            this.$message.success('上传失败')
          }
        })
      },
      /***
       * 格式化时间获取年月日天时分
       * @param date
       * @constructor
       */
      FormatDate(date) {
        //console.log(date,this.commitDetail);
        let str = '';
        let res = moment(date).format('YYYY-MM-DD HH:mm:ss');
        const dates =  moment(res,'YYYY-MM-DD HH:mm:ss').valueOf();
        const years = moment().diff(moment(dates),'years');
        const months = moment().diff(moment(dates),'months');
        const days = moment().diff(moment(dates),'days');
        const hours = moment().diff(moment(dates),'hours');
        const minutes = moment().diff(moment(dates),'minutes');

        //console.log(years,' ',months,' ',days,' ',hours+ ' '+minutes)
        if(minutes>0 && minutes<60){
          str = minutes + '分钟';
        }else if(minutes>=60 && minutes<60*24){
          str = hours + '小时';
        }else if(minutes>=60*24 && minutes<60*24*30){
          str = months + '月';
        }else if(minutes>=60*24*30 && minutes<60*24*30*12){
          str = years + '年'
        }
        return str;
      },
      /***
       * 评论页改变
       * @param page
       */
      handlePageChange(page) {
        this.page=page;
        this.getComments();
      },
      /***
       * 获取唯一值
       * @returns {string}
       */
      handleSerialNum() {
        return moment().format('YYYYMMDDHHmmssS')
      },
      /**
       * 图片格式
       * @param url
       * @returns {string}
       */
      handleImg(url) {
        return cfg.imageUrl+url;
      },
    },
    watch:{
        activeId(newVal,oldVal){
                this.active_id = this.activeId;
                this.$store.dispatch('getActivityDetail',{active_id:newVal}).then(()=>{
                    console.log(this.$store.state.activityDetail.activityDetail.active_id)
                });
                //console.log(newVal,' ',this.service_id );

                this.getComments();
        }
    }
  }
</script>

<style lang="css">
  .user_div_oimg>img{
    width: 100%;
  }
  .service_presca_body{
    width: 100%;
    float: left;
  }
  .service_presca_body .service_img_block{
      display:flex;
  }
  .service_box_userDetal{
    width: 100%;
    display: flex;
    margin-top: 10px;
  }
  .floatRight_box{
    float: right;
    margin-top: 36px;
    color:#737373;
  }
  .servic_font_box_size{
    float: left;
  }
  .servic_font_box_size>p:nth-child(1){
    font-size:20px;
    font-weight: 800;
  }
  .servic_font_box_size>p:nth-child(2){
    font-size: 14px;
    margin-top: 5px;
    color:#737373;
  }
  .service_ul_box>li>div>div>img{
    width: 100%;
    height: 100%;
  }
  .user_div_oimg{
    width: 55px;
    height: 55px;
    border:1.5px solid #15bafe;
    border-radius: 5px;
    overflow: hidden;
    float: left;
    margin-right: 10px;
  }
  .service_ul_box>li>div{
    width: 100%;
    padding-right: 15px;
  }
  .service_ul_box>li{
    width: 100%;
    margin-bottom: 40px;
  }
</style>
<style lang="less">
  .pagination{
    text-align: right;
  }
  .commit{
    margin-top: 20px;
    .commit_header{
      display: flex;
      align-items: center;
      .icon_commit{
        font-size: 18px;
        color: #15bafe;
      }
      p{
        font-size: 16px;
        margin-left: 10px;
      }
    }
    .text_area{
      margin-top: 10px;
      .input_area{
        .el-textarea__inner{
          resize: none;
        }
      }
    }
    .rate{
      display: flex;
      align-items: center;
      margin-top: 10px;
      margin-bottom: 10px;
      p{
        font-size: 14px;
      }
      .el_rate{
        margin-left: 5px;
      }
    }
    .up_img{
      display: flex;
      .el-upload--picture-card{
        width: 100px;
        height: 100px;
        line-height: 100px;
      }
      .el-upload-list--picture-card .el-upload-list__item{
        width: 100px;
        height: 100px;
      }
      .up_remark{
        position: relative;
        color: #808080;
        top: 20px;
        left: 20px;
      }
    }
    .btn_div{
      text-align: end;
      .commit_btn{
        width: 100px;
      }
    }
  }
  .img_content_commit{
    width: 80px;
    height: 80px;
    .commit_imgs{
      width: 100%;
      height: 100%;
    }
  }
</style>
