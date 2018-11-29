<template>
  <div class="uploading_background">
    <section id="editor">
      <uploading-head></uploading-head>
      <div class="mod_uploading mod_uploading_activity">
        <div class="mod_uploading_main">
          <uploading-activity-main-synopsis :data="{title:activityData.title,video:activityData.video,textarea:activityData.description}"></uploading-activity-main-synopsis>
          <uploading-activity-main-content :contents="activityData.content"></uploading-activity-main-content>
          <uploading-activity-main-tag :tags="activityData.tags"></uploading-activity-main-tag>
          <uploading-activity-main-img :data="{fileList:activityData.pics,serial_number:activityData.serial_number}"></uploading-activity-main-img>
          <uploading-activity-main-file :data="{fileList:activityData.attachment,serial_number:activityData.serial_number}"></uploading-activity-main-file>
          <uploading-activity-main-type></uploading-activity-main-type>
          <div class="uploading_main_item uploading_main_time">
            <div class="main_head">
              <i class="icon icon_title"></i>
              <span class="main_txt">活动时间</span>
            </div>
            <div class="main_time_date">
              <!--<select @change="handleSelectTimeType" name="" id="" v-model="timeType">
                <option :value="2">长期</option>
                <option :value="1">定时</option>
              </select>-->
              <span class="activity_time">
                                <span class="time_date_activity_txt">活动开始日期:</span>
                                <el-date-picker
                                  v-model="activityData.active_date_start"
                                  @change="handleActiveStartDate"
                                  type="date"
                                  value-format="yyyy-MM-dd"
                                  class="select_times"
                                  placeholder="选择日期">
                                </el-date-picker>
                            </span>
              <span class="activity_time">
                                <span class="time_date_activity_txt">活动结束日期:</span>
                                <el-date-picker
                                  v-model="activityData.active_date_end"
                                  @change="handleActiveEndDate"
                                  type="date"
                                  value-format="yyyy-MM-dd"
                                  class="select_times"
                                  placeholder="选择日期">
                                </el-date-picker>
                            </span>
              <span class="activity_time">
                                <span class="time_date_activity_txt">报名截止日期:</span>
                                <el-date-picker
                                  v-model="activityData.registration_deadline"
                                  @change="handleEndDate"
                                  type="date"
                                  value-format="yyyy-MM-dd"
                                  class="select_times"
                                  placeholder="选择日期">
                                </el-date-picker>
                            </span>
            </div>
          </div>
          <uploading-activity-main-city :data="{province:activityData.province,city:activityData.city,district:activityData.district,address:activityData.address,telphone:activityData.telphone}"></uploading-activity-main-city>
          <uploading-activity-main-price :isSelect="isSelect" :currentPrice="activityData.price"></uploading-activity-main-price>
          <div class="uploading_main_item uploading_main_people person_num">
            <div class="main_head">
              <i class="icon icon_people"></i>
              <span class="main_txt">活动人数</span>
            </div>
            <div class="main_price_detail">
                            <span class="main_price_input">
                                <input @change="handleQuantity" type="text" class="main_price_num" v-model="activityData.quantity">
                            </span>
            </div>
          </div>
        </div>
        <el-row class="btn_button">
          <el-button size="mini" class="btn_cancel" @click="handleCancel">取消</el-button>
          <el-button size="mini" class="btn_ok" @click="handleSubmit">
            <i class="icon icon_release submit_btn"></i>
            <span class="p1">发布</span>
          </el-button>
        </el-row>
        <!--<main-item-tips ref="mainItemTips"></main-item-tips>-->
      </div>
    </section>
    <aside>
      <floating-div></floating-div>
    </aside>
    <!-- <protocol-div ref="protocol"></protocol-div> -->
  </div>
</template>

<script>
  import FloatingDiv from '@/components/floating'
  import UploadImg from '@/components/uploadImg'
  import UploadFile from '@/components/uploadFile'
  import LayDate from '@/components/layDate'
  import ProtocolDiv from '@/views/upload/protocol'
  import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
  import UploadingActivityMainType from '@/views/upload/uploadingActivityMainType'
  import UploadingActivityMainContent from '@/views/upload/uploadingActivityMainContent'
  import UploadingActivityMainTag from '@/views/upload/uploadingActivityMainTag'
  import UploadingActivityMainImg from '@/views/upload/uploadingActivityMainImg'
  import UploadingActivityMainFile from '@/views/upload/uploadingActivityMainFile'
  import UploadingActivityMainCity from '@/views/upload/uploadingActivityMainCity'
  import UploadingActivityMainPrice from '@/views/upload/uploadingActivityMainPrice'
  import ModUploadingConfirm from '@/views/upload/modUploadingConfirm'
  import UploadingActivityMainSynopsis from '@/views/upload/uploadingActivityMainSynopsis'
  import MainItemTips from '@/views/upload/mainItemTips'
  import moment from 'moment'
  var UploadingHead = {
    template: "<div class='mod_uploading_head'><div class='uploading_head_txt'>上传活动</div></div>",
    data() {
      return {}
    },
  };

  export default {
    name: "uploadingActivity",
    components: {
      UploadingHead,
      FloatingDiv,
      UploadImg,
      UploadFile,
      LayDate,
      ProtocolDiv,
      UploadingMainTitle,
      UploadingActivityMainType,
      UploadingActivityMainContent,
      UploadingActivityMainTag,
      UploadingActivityMainImg,
      UploadingActivityMainFile,
      UploadingActivityMainCity,
      UploadingActivityMainPrice,
      ModUploadingConfirm,
      UploadingActivityMainSynopsis,
      // MainItemTips
    },
    data() {
      return {
        id:this.$route.query.active_id,
        isSelect: false,
        title: "标题",
        timeType: 2,
        active_date: '',
        registration_deadline: '',
        activityData: {
          title: '',//标题
          description: '',//简介
          content: '',//内容
          category_id: null,//类别id
          address: '',//地址
          province: null,//省份id
          city: null,//市级id
          district: null,//区县id
          telphone: null,//电话
          price: null,//价格
          quantity: null,//活动人数
          active_date_type: null,//活动时间类型
          active_date_start: '',//活动开始时间
          active_date_end: '', //活动结束时间
          registration_deadline: '',//报名截止时间
          tags: [],//标签
          serial_number: null,//编次号
          pics:[],//展示图片
          attachment:[],//附件
          video:'',//视频
          enrollment:0,//报名人数
        }
      }
    },
    async created(){
        console.log(this.id);
        if(this.id){
            await this.HttpClient.get('/actives/editDetail',{active_id:this.$route.query.active_id})
                .then(res=>{
                    console.log(res);
                    let {code,data} = res.data;
                    if(code===200){
                        this.handleSet(data)
                    }
                })
        }else{
            this.activityData.serial_number = this.handleSerialNum();
            this.$store.dispatch('getActivityUploadData',this.activityData).then(res =>{
                console.log(this.$store.state.activityUpload.activityUploadData)
            });
        }
        console.log(this.activityData.serial_number);

    },
    // created() {
    //   /**
    //   *判断是否为修改
    //   */
    //   if(this.id){
    //       this.timeType=this.$store.state.activityUpload.activityUploadData.active_date_type;
    //       this.activityData.quantity=this.$store.state.activityUpload.activityUploadData.quantity;
    //   }else{
    //
    //   }
    // },
    methods: {
      /***
      * 修改时放置数据
      */
      async handleSet(data){
          await this.$store.dispatch('getActivityUploadData',data).then(res =>{
              console.log(this.$store.state.activityUpload.activityUploadData);
              this.activityData=this.$store.state.activityUpload.activityUploadData;
              //this.timeType=this.$store.state.activityUpload.activityUploadData.active_date_type
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
       * 获取售卖票数
       * @param e
       */
      handleQuantity(e) {
        console.log(this.activityData.quantity,e.target.value);
        if(this.activityData.quantity<=this.activityData.enrollment){
            this.activityData.quantity=this.$store.state.activityUpload.activityUploadData.quantity
        }
        this.$store.dispatch('getActivityUploadData',{quantity:this.activityData.quantity}).then(res =>{
          console.log(this.$store.state.activityUpload.activityUploadData);
          this.activityData=this.$store.state.activityUpload.activityUploadData
        })
      },
      /***
       * 选择活动时间类型
       * @param e
       */
      handleSelectTimeType(e) {
        this.activityData.active_date_type = parseInt(e.target.value);
        this.$store.dispatch('getActivityUploadData',{active_date_type:this.activityData.active_date_type}).then(res =>{
            console.log(this.$store.state.activityUpload.activityUploadData);
            this.activityData=this.$store.state.activityUpload.activityUploadData
        })
      },
      /***
       * 选择活动开始时间
       * @param str
       */
      handleActiveDate(str) {
        this.activityData.active_date = str;
        this.$store.dispatch('getActivityUploadData',{active_date:this.activityData.active_date}).then(res =>{
            console.log(this.$store.state.activityUpload.activityUploadData);
            this.activityData=this.$store.state.activityUpload.activityUploadData
        })
      },
      /**
       * 选择报名截止时间
       * @param str
       */
      handleEndDate(str) {
        this.activityData.registration_deadline = str;
        this.$store.dispatch('getActivityUploadData',{registration_deadline:this.activityData.registration_deadline}).then(res =>{
            console.log(this.$store.state.activityUpload.activityUploadData);
            this.activityData=this.$store.state.activityUpload.activityUploadData
        })
      },
      /**
       * 选择活动开始时间
       * @param str
       */
      handleActiveStartDate(str) {
        this.activityData.active_date_start = str;
        this.$store.dispatch('getActivityUploadData',{active_date_start:this.activityData.active_date_start}).then(res =>{
          console.log(this.$store.state.activityUpload.activityUploadData);
          this.activityData=this.$store.state.activityUpload.activityUploadData
        })
      },
      /**
       * 选择活动结束时间
       * @param str
       */
      handleActiveEndDate(str) {
        this.activityData.active_date_end = str;
        this.$store.dispatch('getActivityUploadData',{active_date_end:this.activityData.active_date_end}).then(res =>{
          console.log(this.$store.state.activityUpload.activityUploadData);
          this.activityData=this.$store.state.activityUpload.activityUploadData
        })
      },
      /***
       * 点击取消
       */
      handleCancel() {

      },
      /***
       * 点击提交
       */
      handleSubmit() {
        this.activityData = this.$store.state.activityUpload.activityUploadData;
          if(this.id){
            let updateData={
                active_id:this.activityData.active_id,
                description:this.activityData.description,
                content:this.activityData.content,
                telphone:this.activityData.telphone,
                price:this.activityData.price,
                quantity:this.activityData.quantity,
                registration_deadline:this.activityData.registration_deadline,
                tags:this.activityData.tags,
                pics:this.activityData.pics,
                attachment:this.activityData.attachment,
                video:this.activityData.video,
                serial_number:this.activityData.serial_number
            };
              console.log(updateData);
              this.HttpClient.post('/company/editActive',updateData)
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.$router.push({
                            path: '/home/commercial-activity'
                        })
                    }
                })
        }else{
              console.log(this.activityData);
              this.HttpClient.post('/actives/create',this.activityData).then(res =>{
                if(res.data.code === 200) {
                    this.$message.success(res.data.msg);
                    this.activityData = {};
                    this.activityData.serial_number = this.handleSerialNum();
                    this.$store.dispatch('getActivityUploadData',this.activityData).then(res =>{
                    });
                    this.$router.push({
                        path: '/home/commercial-activity'
                    })
                }else {
                    this.$message.error(res.data.msg)
                }
            })
        }

      }
    },
    mounted() {
      // this.$refs.activityDate.output("activityDate");
      // this.$refs.deadline.output("deadline");
      // this.$refs.mainItemTips.fixedEnd("main_city_map");
      // this.$refs.protocol.handleTimer();
    }
  }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>

<style lang="less">
.activity_time{
  margin-right: 10px;
  .el-input__icon{
    line-height: 35px !important;
  }
  .select_times{
    width: 200px;
  }
}
  .person_num{
    margin-top: 20px;
  }
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
