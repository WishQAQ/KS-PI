<template>
    <div class="uploading_background">
        <section id="editor">
            <uploading-head></uploading-head>
            <div class="mod_uploading mod_uploading_service">
                <div class="mod_uploading_main">
                    <uploading-service-main-synopsis :serviceTitleData="serviceData"></uploading-service-main-synopsis>
                    <uploading-service-main-content :serviceContentsData="serviceData"></uploading-service-main-content>
                    <uploading-service-main-tag :serviceTagData="serviceData"></uploading-service-main-tag>
                    <uploading-service-main-img :post="uploadUrl" :serviceImgData="serviceData"></uploading-service-main-img>
                    <uploading-service-main-file :serviceFileData="serviceData"></uploading-service-main-file>
                    <uploading-service-main-type :serviceTypeData="serviceData"></uploading-service-main-type>
                    <uploading-service-main-city :serviceCityData="serviceData"></uploading-service-main-city>
                    <uploading-service-main-price :isSelect="isSelect" :servicePriceData="serviceData"></uploading-service-main-price>
                </div>
                <!--<main-item-Tips ref="mainItemTips"></main-item-Tips>-->
                <el-row class="btn_button">
                  <el-button size="mini" class="btn_cancel" @click="handleCancel">取消</el-button>
                  <el-button size="mini" class="btn_ok" @click="handleSubmit">
                    <i class="icon icon_release submit_btn"></i>
                    <span class="p1">发布</span>
                  </el-button>
                </el-row>
            </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
        <!--<protocol-div ref="protocol"></protocol-div>-->
    </div>
</template>

<script>
import FloatingDiv from '@/components/floating'
import UploadImg from '@/components/uploadImg'
import UploadFile from '@/components/uploadFile'
import ProtocolDiv from '@/views/upload/protocol'
// import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
import UploadingServiceMainType from '@/views/upload/uploadingServiceMainType'
import UploadingServiceMainContent from '@/views/upload/uploadingServiceMainContent'
import UploadingServiceMainTag from '@/views/upload/uploadingServiceMainTag'
import UploadingServiceMainImg from '@/views/upload/uploadingServiceMainImg'
import UploadingServiceMainFile from '@/views/upload/uploadingServiceMainFile'
import UploadingServiceMainCity from '@/views/upload/uploadingServiceMainCity'
import UploadingServiceMainPrice from '@/views/upload/uploadingServiceMainPrice'
import UploadingServiceConfirm from '@/views/upload/UploadingServiceConfirm'
import UploadingServiceMainSynopsis from '@/views/upload/uploadingServiceMainSynopsis'
import MainItemTips from '@/views/upload/mainItemTips'


import  '@/assets/js/uploadservice.js'
import moment from 'moment'

var UploadingHead = {
    template:"<div class='mod_uploading_head'><div class='uploading_head_txt'>上传服务</div></div>",
    data(){
        return {

        }
    },
};

export default{
    data () {
        return {
          isSelect:true,
          title:"服务标题",
          uploadUrl:'https://jsonplaceholder.typicode.com/posts/',
          serviceData: {
            category_id: null, //分类ID
            price: null, //费用
            title: '', //	标题
            description: '', //描述
            content: '', //内容
            address: '', //详细地址
            telphone: null, //联系电话
            serial_number: null,
            tags: [], //标签,
            province: null, //省id
            city: null, //市Id,
            district: null, //区id
          },
          service_id: '',
        }
    },
    components:{
        UploadingHead,
        FloatingDiv,
        UploadImg,
        UploadFile,
        ProtocolDiv,
        // UploadingMainTitle,
        UploadingServiceMainType,
        UploadingServiceMainContent,
        UploadingServiceMainTag,
        UploadingServiceMainImg,
        UploadingServiceMainFile,
        UploadingServiceMainCity,
        UploadingServiceMainPrice,
        UploadingServiceConfirm,
        UploadingServiceMainSynopsis,
        MainItemTips
    },
    async beforeCreate() {
      console.log(this.$route.query.id)
      this.$store.dispatch('getServiceUploadData',{}).then(res =>{
      })
      this.service_id = this.$route.query.id;
      if(this.$route.query.id) {
        await this.HttpClient.post('/services/updateInfo',{service_id: this.service_id}).then(res =>{
          console.log(res.data);
          if(res.data.code === 200) {
            this.serviceData = res.data.data;
            this.handleInsert(this.serviceData);
          }else {
            this.$message.error(res.data.msg)
          }
        })
      }
      console.log(222222)
    },
    created() {
      this.serviceData.serial_number = this.handleSerialNum();
      this.$store.dispatch('getServiceUploadData',this.serviceData).then(res=>{
        console.log(this.$store.state.serviceUpload.serviceUploadData)
      });
      console.log(this.serviceData)
    },
    methods:{
      async handleInsert(serviceData) {
        await this.$store.dispatch('getServiceUploadData',serviceData).then(res=> {
          console.log(this.$store.state.serviceUpload.serviceUploadData)
        })
      },
      /***
       * 获取唯一值
       * @returns {string}
       */
      handleSerialNum() {
        return moment().format('YYYYMMDDHHmmssS')
      },
      /**
       * 提交服务信息
       */
      handleSubmit() {
        let param = this.$store.state.serviceUpload.serviceUploadData;
        if(this.$route.query.id) {
          param.tags = param.tagsname?param.tagsname:param.tags;

          delete param.tagsname;
          delete param.status;
          delete param.video;
          delete param.attachment;
          delete param.images;
          delete param.id;
          delete param.pics;
          this.HttpClient.post('/services/updateServices',param).then(res =>{
            console.log(res.data)
            if(res.data.code === 200) {
              this.$message.success(res.data.msg)
              this.serviceData = {};
              this.serviceData.serial_number = this.handleSerialNum();
              this.$store.dispatch('getServiceUploadData',this.serviceData).then(res =>{
              })
              this.$router.push({
                path: '/home/commercial-service'
              })
            }else {
              this.$message.error(res.data.msg)
            }
          })
        }else {
          delete param.tagsname;
          delete param.status;
          delete param.video;
          delete param.attachment;
          delete param.images;
          delete param.id;
          delete param.pics;
          this.HttpClient.post('/services/create',param).then(res =>{
            console.log(res.data)
            if(res.data.code === 200) {
              this.$message.success(res.data.msg)
              this.serviceData = {};
              this.serviceData.serial_number = this.handleSerialNum();
              this.$store.dispatch('getServiceUploadData',this.serviceData).then(res =>{
              })
              this.$router.push({
                path: '/home/commercial-service'
              })
            }else {
              this.$message.error(res.data.msg)
            }
          })
        }

      },
      /***
       * 取消
       */
      handleCancel() {

      }
    },
    mounted(){
        // this.$refs.mainItemTips.fixedEnd("main_city_map");
        // this.$refs.protocol.handleTimer();
    },
}
</script>
<style  src="@/assets/css/uploading.css"></style>
<style  src="@/assets/css/uploadservice.css"></style>
<style lang="less">
  .submit_btn{
    width: 22px;
    height: 20px;
  }
  .btn_button{
    display: flex;
    justify-content: center;
    .btn_cancel{
      height: 33px;
      width: 81.34px;
    }
    .btn_ok{
      height: 33px;
      .p1{
        position: relative;
        top: -5px;
      }
    }
  }
</style>
