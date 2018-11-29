<template>
    <div class="">
        <div class="service_box_datals">
            <div class="service_box_body">
                <div class="service_box_img_Deta">
                  <!--图片数据-->
                    <service-img :headerData="headerData" @getDialogeVisibl="getDialogVisible"></service-img>
                </div>
                <!--tabs详情切换-->
                <el-tabs v-model="activeName" @tab-click="handleClick">
                  <el-tab-pane label="简介" name="first">
                    <div class="service_content_pane" v-html="headerData.content">

                    </div>
                  </el-tab-pane>
                  <el-tab-pane label="评论" name="second">
                      <service-comment :serviceId="headerData.service_id"></service-comment>
                  </el-tab-pane>
                  <el-tab-pane label="附件" name="third">
                      <service-flie :serviceId="headerData.service_id"></service-flie>
                  </el-tab-pane>
                </el-tabs>
                <service-user :headerData="headerData"></service-user>
            </div>
            <service-right :type="DataMoni" :headerData="headerData" @getServiceId="getServiceId"></service-right>
        </div>
        <floating-div></floating-div>


    </div>
</template>

<script>
import FloatingDiv from '@/components/floating'
import ServiceRight from '@/views/service/serviceDataRight'
import ServiceImg from '@/views/service/serviceDataImg'
import ServiceComment from '@/views/service/serviceDataComment'
import ServiceUser from '@/views/service/serviceDataUser'
import ServiceFlie from '@/views/service/serviceDataFlie'
import {HttpClient} from "../../utils/HttpUtils";
import cfg from '../../../config/app'
export default {
  data(){
    return{
        activeName:'second',
        value2: 4,
        DataMoni:[
          {
            title:"胆太大!男子为图方便 将马路双···",
            username:"李超",
            kan:"56k+"
          }
        ],
      headerData: {},
      service_id: this.$route.query.id
    }
  },
  components:{
    FloatingDiv,
    ServiceRight,
    ServiceImg,
    ServiceComment,
    ServiceUser,
    ServiceFlie
  },
  created() {
    //console.log(this.$route.query)
    this.getHeaderData(this.service_id);
  },
  methods: {
    /**
     * 获取咨询商家弹窗值
     */
      getDialogVisible(value) {
        console.log(111,value)
        this.dialogVisible = value;
      },
      handleClick(tab, event) {
        console.log(tab, event);
      },
    /**
     *先关服务子组件回调
     */
      getServiceId(id) {
        console.log(id)
          this.getHeaderData(id);
      },
    /***
     * 获取服务详情页头部数据
     * @param service_id
     */
      getHeaderData(service_id) {
      /*this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'services/getInfo',{
        token: window.localStorage.getItem('token'),
        service_id:service_id
      }).then(res=>{
        console.log(res)
      })*/
        this.HttpClient.post('/services/getInfo',{
          service_id:service_id
        }).then(res=>{
          console.log(res)
          if(res.data.code === 200){
            this.headerData = res.data.data;
          }else{
            this.$message.error('获取详情信息失败');
          }
        })
      },
      handleShowEdit(item) {
        return null;
      }
    }
}
</script>

<style lang="css">
.font_service_color{
  margin-top: 33px;
}
.font_service_color>p:nth-child(1){
  font-size: 20px;
  float: left;
  font-weight: 800;
}
.font_service_color>p:nth-child(2){
  float: right;
  margin-top: 10px;
}
.service_dis_flex>li{
  border:1px solid #15bafe;
  color:#15bafe;
  padding: 0px 4px 0 4px;
  border-radius: 3px;
  margin-right: 2px;
  font-size: 12px !important;
}
.service_dis_flex{
  display: flex;
}
.service_titile_header_size{
  font-size: 17px;
}
.service_right_body>li>div>img{
  width: 100%;
}
.service_bat_color{
  margin-top: 30px;
  color:#888888;
}
.service_color_font{
  color:#888888;
}
.service_titile_header_font{
  font-size: 14px;
  color:#000;
}
.service_right_body>li>div:nth-child(2){
  width: 160px;
  padding-left:10px;
}
.service_right_body>li>div:nth-child(1){
  width: 150px;
  height: 110px;
  overflow: hidden;
}
.service_right_body>li{
  width: 100%;
  display: flex;
  margin-bottom: 10px;
}
.service_box_DetailsVideo{
  width: 100%;
}
.service_re_ul>li>img{
  position: relative;
  top:2px;
}
.service_re_ul>li:nth-child(1){
  font-size: 13px;
  margin-right: 20px;
}
.service_re_ul{
  display: flex;
  margin-top:13px;
}
.service_img_block{
  width: 100%;
  display: flex;
  margin-top: 15px;
}
.service_img_block>li{
  margin-right: 15px;
}
.service_praise_left{

}
.service_praise_left>.praise_ctrl>.praise_ctrl_box:nth-child(1){
  margin-bottom: 6px;
}
.service_praise_left>.praise_ctrl>.praise_ctrl_box:nth-child(3){
  margin-top: 6px;
}
.service_presca_body>div{
  font-size: 15px;
  margin-left: 5px;
}
/* .service_presca_body{
  width: 100%;
  float: left;
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
} */
.serice_box_right>div>span{
  position: relative;
  top:-2px;
}
.serice_box_right>div{
  float: left;
  margin-left: 10px;
}
.serice_box_momy>p{
  float: left;
}
.serice_box_right{
  float: right;
  position: relative;
  top:30px;
}
.serice_box_momy>p{
  font-size: 40px;
  font-weight: 600;
  color:#000;
}
.service_box_kx{
  width: 440px;
}
.service_box_img_Deta{
  width: 100%;
  display: flex;
  justify-content: space-between;
  margin-bottom: 30px;
}
.service_box_datals{
  width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
}
.service_box_body{
  width:855px;
}
.service_box_data{
  width: 320px;
}
@media screen and (max-width:1200px){
  .service_box_datals{
    width: 960px;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
  }
  .service_box_body{
    width:684px;
    margin: 0 auto;
  }
  .service_box_data{
    width: 256px !important;
  }
}
</style>
