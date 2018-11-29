<template lang="html">
    <div class="" v-if="baikePropsHeader">
      <div class="baike_title_header_top">
          <div class="baike_praise_compont">
            <praise-div :type="comit" :index="0" letType="4"></praise-div>
          </div>
          <div class="baike_title_headline">
            <div class="baike_headline_data">
              <span></span>
              <p>{{titleHeaderTitle.title}}</p>
            </div>
            <div class="baike_headline_detail">
              <span>{{handleDate(titleHeaderTitle.created_at)}}</span>
              <span>|</span>
              <span>
                <img src="/static/img/icon/blocs.png" alt="">
                <span>{{titleHeaderTitle.view_num}}</span>
              </span>
              <span>
                <img src="/static/img/icon/date.png" alt="">
                <span>{{titleHeaderDate}}</span>
              </span>
              <ul>
                 <li @click="RouterIndexLabel(index)" v-for="(label ,index) in titleHeaderTitle.label" :key="index">{{label.name}}</li>
              </ul>
            </div>
          </div>
          <div class="baike_headline_button">
            <button type="button" name="button" class="baike_backgrond_color" @click="jumpEncPage">
              <img src="/static/img/icon/bj.png" alt="">
              <span>编辑</span>
            </button>
            <div class="float"></div>
            <span @click="handleOpenReport">
              <img src="/static/img/icon/jub.png" alt="">
              <span>举报</span>
              <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible" :serviceId="baike_id"></ReportDialog>
            </span>
            <span>
              <img src="/static/img/icon/share.png" alt="">
              <span>分享</span>
            </span>
          </div>
          <div class="baike_user_portrait" @click="RouterClick">
            <div class="baike_user_border">
               <img :src="request.picUrl + titleHeaderTitle.avatar" alt="">
            </div>
            <p>{{titleHeaderTitle.nickname}}</p>
            <p class="baike_font_width">{{titleHeaderTitle.signature}}</p>
          </div>
      </div>
    </div>
</template>

<script>
import ReportDialog from '@/components/ReportDialog'
import FormatDate from "../../utils/GetDateUtils";
import PraiseDiv from '@/components/praise'
export default {
  props:['baikePropsHeader','infoData'],
  data(){
    return{
      encyclopedia_id:null,
      flag:false,
      comit:[
        {
          type:'serviceDetails',
          praise:0,
          state:0
        }
      ],
      baike_id:null,
      reportVisible: false,
    }
  },
  components:{
    PraiseDiv,
    ReportDialog
  },
  computed:{
    titleHeaderDate:function(){
      var titleHeaderDate = new Date(this.baikePropsHeader.data.created_at)
      var timestamp = Date.parse(titleHeaderDate)
      var localStorageDate = Number(new Date())
      var parseDate = localStorageDate - timestamp
      var timeSpanStr;
      if (parseDate <= 1000 * 60 * 1) {
        timeSpanStr = '刚刚';
      }
      else if (1000 * 60 * 1 < parseDate && parseDate <= 1000 * 60 * 60) {
        timeSpanStr = Math.round((parseDate / (1000 * 60))) + '分钟前';
      }
      else if (1000 * 60 * 60 * 1 < parseDate && parseDate <= 1000 * 60 * 60 * 24) {
        timeSpanStr = Math.round(parseDate / (1000 * 60 * 60)) + '小时前';
      }
      else if (1000 * 60 * 60 * 24 < parseDate && parseDate <= 1000 * 60 * 60 * 24 * 15) {
        timeSpanStr = Math.round(parseDate / (1000 * 60 * 60 * 24)) + '天前';
      }
      return timeSpanStr
    },
    titleHeaderTitle:function(){
      if(this.baikePropsHeader == "")
      {
        return "2"
      }else{
        // console.log(this.baikePropsHeader.data)
        return this.baikePropsHeader.data
      }
    },
  },
  methods:{
    //点击修改跳转到百科修改页面进行修改。
    jumpEncPage(index){
      console.log('我要取得百科ID'+this.infoData.encyclopedia_id)
      // console.log('跳转修改百科页面')
      // console.log(this.baikePropsHeader)
      this.$router.push({
        path:'/home/uploadingModifyEncyclopedia',
        query:{
          info:this.infoData
        }
      })
    },
    // //请求需要修改的的百科详情
    // getInfo(){
    //   this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"",{
    //         token:window.localStorage.token,
    //         video_id:this.videoList[index].video_id
    //       })
    //       .then((res) => {
    //         console.log(res)
    //         this.videoList.splice(index,1);
    //       })
    // },
    RouterIndexLabel(index){
      this.$router.push({
        path:'/home/searchIndex',
        query:{
          keyword:this.titleHeaderTitle.label[index].name
        }
      })
    },
    RouterClick(){
      this.RouterLinkOther()
      // console.log(this.titleHeaderTitle.)
    },
    handleOpenReport() {
      this.reportVisible = true;
    },
    /***
     * 回调举报
     * @param value
     */
    getReportVisible(value) {
      this.reportVisible = value;
    },
    handleDate(date) {
      return FormatDate.GetDate(date);
    },
  },
  created(){
    
    this.baike_id = this.$route.query.uid
  }
}
</script>

<style lang="css">
.baike_font_width{
  overflow:hidden;
  text-overflow:ellipsis;
  white-space:nowrap;
}
.baike_font_left{
  margin-left: 10px;
  font-size: 12px;
  color:#a9a9a9;
}
.baike_body_html{
  display: flex;
  justify-content: space-between;
}
.oBackground_color{
  background-color: #f2f2f2;
}
.baike_user_border{
  width: 42px;
  height: 42px;
  border:1px solid #15befe;
  float: right;
  margin-left: 10px;
  border-radius: 6px;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
}
.baike_user_border>img{
  width: 100%;
  height: 100%;
}
.baike_user_portrait{
  width: 390px;
  text-align: right;
  padding-right: 16px;
}
.baike_user_portrait>p:nth-child(2){
  font-size:14px;
}
.baike_user_portrait>p:nth-child(3){
  font-size:14px;
  color:#999999;
}
.baike_backgrond_color>span{
  position: relative;
  top:-1px;
}
.baike_backgrond_color{
  color:#FFF;
  border:1px solid #15befe;
  border-radius: 3px;
  background-color: #15befe;
  padding: 5px;
  cursor: pointer;
  display: block;
  float: right;
  margin-left: 20px;
}
.baike_headline_button>span{
  margin-left: 15px;
  position: relative;
  top:10px;
  display: inline-block;;
  cursor: pointer;
}
.baike_headline_button>span>img{
  position: relative;
  top:2px;
}
.baike_headline_button{
  width: 300px;
  text-align: right;
  margin-right: 30px;
}
.baike_headline_detail>ul>li{
  margin-right: 10px;
  color:#999999;
  text-decoration:underline;
}
.baike_headline_detail>ul{
  display: flex;
  margin-left: 10px;
  margin-top: 3px;
}
.baike_headline_detail{
  margin-top: 5px;
}
.baike_headline_detail>span>img{
  position: relative;
  top:1.5px;
}
.baike_headline_detail>span{
  margin-right: 10px;
  color:#999999;
  padding-top: 3px;
}
.baike_headline_detail{
  display: flex;
}
.baike_headline_data>span{
  width: 6px;
  height: 27px;
  background-color: #15befe;
  display: inline-block;
  position: relative;
  top:5px;
  margin-right: 5px;
}
.baike_headline_data>p{
  font-size:22px;
  color:#000;
  display: inline-block;
}
.baike_headline_data{
  margin-bottom: 8px;
}
.baike_title_headline{
  width: 580px;
  margin-left: 15px;
}
.baike_praise_compont>.praise_ctrl{
  position: relative;
}
.baike_praise_compont{
}
.baike_title_header_top>div>.praise_ctrl>.praise_ctrl_box{
  width: 45px;
  height: 25px;
}
.baike_title_header_top>div>.praise_ctrl>.praise_ctrl_box>.praise_ctrl_icon_bottom{
  margin-left: 16px;
}
.baike_title_header_top>div>.praise_ctrl>.praise_ctrl_box>.praise_ctrl_icon{
  border-left-width:11px;
  border-right-width:11px;
}
.baike_title_header_top>div>.praise_ctrl>.info_ctrl_num{
  margin-left: 9px;
  font-size: 20px;
}
.baike_title_header_top{
  height: 116px;
  display: flex;
  align-items: center;
  background-color: #FFF;
}
</style>
