<template>
    <div class="">
        <div class="service_box_datals">
            <div class="service_box_body">
                <div class="service_box_img_Deta_dis">
                  <!--图片数据-->
                  <activity-img :headerData="headerData" :activeId="headerData.active_id"></activity-img>
                </div>
                <!--tabs详情切换-->
                <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
                  <el-tab-pane label="简介" name="first"><div v-html="headerData.content"></div></el-tab-pane>
                  <el-tab-pane label="评论" name="second">
                     <activity-comment :activeId="headerData.active_id"></activity-comment>
                  </el-tab-pane>
                  <el-tab-pane label="附件" name="third">
                     <activity-flie :attachment="headerData.attachment"></activity-flie>
                  </el-tab-pane>
                </el-tabs>
                <activity-user :headerData="headerData"></activity-user>
            </div>
            <activity-right :type="DataMoni" :headerData="headerData" @getActiveId="getActiveId"></activity-right>
        </div>
        <floating-div></floating-div>
    </div>
</template>

<script>
import FloatingDiv from '@/components/floating'
import ActivityRight from '@/views/activity/activityDataRight'
import ActivityComment from '@/views/activity/activityDataComment'
import ActivityImg from '@/views/activity/actvityDataImg'
import ActivityFlie from '@/views/activity/actvityDataFlie'
import ActivityUser from '@/views/activity/activityDataUser'
import moment from 'moment'
export default {
  data(){
    return{
        active_id: this.$route.query.id,
        headerData: {},
        activeName:'third',
        Modlid:'',
        DataMoni:[
          {
            title:"胆太大!男子为图方便 将马路双···",
            username:"李超",
            kan:"56k+"
          }
        ],
        DataImg:[
          { imgstatus:"/static/img/article_banner.png"},
          { imgstatus:"/static/img/article_banner.png"},
          { imgstatus:"/static/img/article_banner.png"},
          { imgstatus:"/static/img/article_banner.png"}
        ]
    }
  },
  components:{
    FloatingDiv,
    ActivityRight,
    ActivityComment,
    ActivityImg,
    ActivityFlie,
    ActivityUser
  },
  mounted() {
    this.getHeaderData(this.active_id);
  },
  methods: {
      handleClick(tab, event) {
        //console.log(tab, event);
      },
      getActiveId(id) {
        console.log(id)
        this.getHeaderData(id);
      },
      /***
       * 获取服务详情页头部数据
       * @param active_id
       */
      getHeaderData(active_id) {
        this.HttpClient.get('/actives/detail',{
          active_id: active_id,//'dc25b01b-48cb-438f-9aea-e3866487bd90'
          time: moment().valueOf()
        }).then(res=>{
          console.log(res)
          if(res.data.code === 200){
            this.headerData = res.data.data;
          }else{
            this.$message.error('获取详情信息失败');
          }
        })
      }
    }
}
</script>

<style lang="css">
.service_box_body>.el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
  background-color:#FFF;
  border-top: 2px solid #15befe;
  border-bottom: 0;
  border-left: 1px solid #e4e7ed;
}
.service_box_body>.el-tabs--card>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.el-tabs__nav>.el-tabs__item{
  border-left: 0;
}
.service_box_body>.el-tabs--card>.el-tabs__header .el-tabs__nav{
  border:0;
}
/*--------------------*/
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
  margin-left: 20px;
  margin-right: 25px;
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
.service_box_img_Deta_dis{
  width: 100%;
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
</style>
