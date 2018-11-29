<template>
    <div>
      <div class="report_modal">
        <el-dialog
          :visible.sync="visible"
          @close="handleCancel"
          width="400px">
          <div class="report_modal_title" slot="title">
            <div class="title_img"><img src="/static/img/logo/logo_block.png" alt=""></div>
          </div>
          <el-input
            type="textarea"
            class="text_area"
            :rows="5"
            maxlength="49"
            placeholder="请输入举报理由，最多50字"
            v-model="sendMessage">
          </el-input>
          <p class="picture_remark">JPG/PNG/JPEG，1M以内最多上传5张
            截图必须包含被举报者ID</p>
          <div class="report_up_img">
            <el-upload
              action="http://test.kslab.com/api/article/null"
              list-type="picture-card"
              ref="uploads1"
              :limit="5"
              :multiple="true"
              :on-error="hanldeUpError"
              :on-success="handleUpSuccess"
              :before-upload="handleBeforeUpload"
              :before-remove="handleBeforeRemove"
              :on-change="handleUpChange"
              :on-remove="handleRemove">
              <i class="el-icon-plus"></i>
            </el-upload>
          </div>
          <div class="urls">
            <input v-model="reportUrls" class="url_input" placeholder="输入网页链接..."/>
          </div>
          <div slot="footer" class="report_modal_bottom">
            <el-button class="btn_cancel" size="mini" @click="handleCancel">取 消</el-button>
            <el-button class="btn_ok" size="mini" type="primary" @click="hanldeReportOk">举 报</el-button>
          </div>
        </el-dialog>
      </div>
    </div>
</template>

<script>
import * as cfg from "../../config/app";
import moment from 'moment';

export default {
  name: "ReportDialog",
  props: ['serviceId','reportVisible'],
  data() {
      return {
        sendMessage: '',
        //reportVisible: true,
        serialnum: null,
        fileList: [],
        fileList2: [], //组件生成的filelist,
        beforeFileList: [], //上传之后，删除之前的fileList
        upImgUrl: cfg.upImgUrl,
        reportUrls: '',
        visible: false,
        service_ids: '',
      }
  },
  created() {
    console.log(this.serviceId)
    this.service_ids = this.serviceId;
    this.serialnum = this.handleSerialNum();
    console.log(this.serialnum )
    this.$watch('serviceId',function (newVal, oldVal) {
      this.service_id = newVal;
      this.$store.dispatch('getServiceDetail',{service_id:newVal}).then(()=>{
        //console.log(this.$store.state.serviceDetail.serviceDetail.service_id)
      })
    });
    this.$watch('reportVisible',function (newVal, oldVal) {
      this.visible = newVal
    })
  },
  methods: {
    /***
     * 图便移除
     * @param file
     * @param fileList
     */
    handleRemove(file, fileList) {
      console.log(111,file, fileList);
      //console.log(this.fileList)
    },
    async handleBeforeRemove(file, fileList) {
      let result = null;
      console.log(file, fileList,this.beforeFileList,this.fileList);
      //console.log(222,this.beforeFileList,file.name)
      let index = this.beforeFileList.map(item => item.name).indexOf(file.name)
      //console.log(index)
      const urls = this.fileList[index];
      await this.HttpClient.post('/services/destroyFile',{url: urls}).then(res =>{
        if(res.data.code === 200) {
          this.fileList.splice(index, 1);
          result = true
        }else {
          result = false;
          file.status = false;
          this.$message.error('删除失败');
          this.$message.error(res.data.succeed)
        }
      });
      console.log(result)
      return result;
    },
    /***
     * 图片预览
     * @param file
     */
    handlePictureCardPreview(file) {
      this.dialogImageUrl = file.url;
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
        FromData.append('images',file)
        FromData.append('serial_number',this.serialnum)
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'actives/answersAttachment',FromData)
          .then((res) => {
            //console.log(res)
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
     * 举报
     */
    hanldeReportOk() {
      const param = {
        source_id: this.service_ids?this.service_ids:this.$store.state.serviceDetail.serviceDetail.service_id,
        content: this.sendMessage,
        serial_number: this.serialnum,
        url: this.reportUrls
      };
      this.HttpClient.post('/addComplains',param).then(res =>{
        if(res.data.code === 200) {
          this.$emit('getReportVisible',false);
          this.$message.success(res.data.msg)
        }else {
          this.$message.error(res.data.msg)
        }
      });
    },
    /***
     * 获取唯一值
     * @returns {string}
     */
    handleSerialNum() {
      return moment().format('YYYYMMDDHHmmssS')
    },
    /***
     * 关闭弹窗
     */
    handleCancel() {
      this.$emit('getReportVisible',false);
    }
  }
}
</script>

<style lang="less">
  .report_modal{
    .report_modal_title{
      border-bottom: 1px solid #f2f2f2;
      padding-bottom: 3px;
      .title_img{
        display: flex;
        padding-bottom: 7px;
      }
    }
    .text_area{
      .el-textarea__inner{
        resize: none;
      }
    }
    .report_modal_bottom{
      text-align: center;
      .btn_cancel{
        width: 100px;
      }
      .btn_ok{
        width: 100px;
      }
    }
    .el-dialog__body{
      padding: 10px 20px !important;
    }
    .picture_remark{
      color: #808080;
    }
    .report_up_img{
      border: 1px dotted #cccccc;
      min-height: 130px;
      margin-top: 10px;
      padding-top: 10px;
      padding-left: 5px;
      .el-upload--picture-card{
        width: 80px;
        height: 80px;
        line-height: 84px;
      }
      .el-upload-list--picture-card .el-upload-list__item{
        width: 80px;
        height: 80px;
      }
    }
    .urls{
      margin-top: 10px;
      .url_input{
        border: none;
        border-bottom: 1px solid #f2f2f2;
        width: 100%;
        padding-bottom: 10px;
      }
    }
  }

</style>
