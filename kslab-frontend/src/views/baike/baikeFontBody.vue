<template lang="html">
  <div class="" v-if="baikeProps">
    <div class="baike_body_html_left">
      <div class="">
        <!--简介-->
        <!-- {{headerTwolevel}} -->
      <div class="baike_title_cont">
            <span>
              <span></span>
              <div class="baike_title_henrf">
                <div class="">
                  简介
                </div>
                <hr class="hr_display" />
              </div>
            </span>
            <!--简介-->
            <div class="baike_title_cont_font" v-html="baikeProps.data.content"></div>
        </div>
        <div class="baike_content_body" v-for="(onelevel ,index) in headerOnelevel" :key="index">
            <span>
              <span class="baike_odiv_blue"></span>
              <div class="baike_title_henrf">
                <div class="baike_left_margin">
                  {{onelevel.name}}
                </div>
                <hr class="hr_display" />
              </div>
            </span>
            <div class="" v-for="(onelist ,index) in onelevel.next" :key="index">
              <p class="font_margin">{{onelist.name}}</p>
              <p v-html="onelist.content"></p>
            </div>
        </div>
      </div>
      <p class="baike_body_finish">The End</p>
      <!--文档下载-->
      <div class="baike_body_fild">
        <div class="baike_body_button">
            附件
        </div>
        <activity-data-file :attachment="baikeProps.data.attachment"></activity-data-file>
      </div>
      <!--参考文献-->
      <div class="baike_body_fild matgtop">
        <div class="baike_body_button">
            参考文献
        </div>
        <div class="baike_body_download_font">
           <ul>
              <li v-for="(item ,index) in baikeProps.data.source" :key="index">
                <span>{{item.name}}</span>
                <span>
                  <img src="/static/img/icon/router.png" alt="">
                </span>
                <span class="baike_font_left">{{item.link}}</span>
              </li>
           </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import ActivityDataFile from '@/views/activity/actvityDataFlie'
export default {
    props:['baikeProps'],
    data(){
      return{

      }
    },
    computed:{
      //一级目录导出
      headerOnelevel : function(){
        console.log(this.baikeProps)
        return this.baikeProps.arr
      },
      // headerTwolevel : function(){
      //   for(var i = 0;i<this.baikeProps.arr.next;i++){
      //     if(this.baikeProps.arr.first[i].catalog_id == this.baikeProps.arr.next[0].pid){
      //
      //       return console.log(this.baikeProps.arr.first[i])
      //     }
      //   }
      //   return console.log(this.baikeProps.arr.first[i])
      // }
    },
    created(){
      console.log(this.baikeProps)
    },
    components:{
      ActivityDataFile
    }
}
</script>

<style lang="less">

.fileClass{
  float: right;
  display: inline-block;
  margin-top: 15px;
}

.problemDetails_list_annex_list>p>.icon{
  color:#15befe !important;
  font-size:25px;
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


.floa_Right{
  float: right;
}
.baike_title_cont_font{
  word-wrap: break-word;
}
.font_margin{
  font-size: 17px;
  font-weight: bold;
  margin-top: 10px;
  margin-bottom: 10px;
}
.baike_left_margin{
  margin-left: 10px;
}
.baike_odiv_blue{
  position: relative !important;
  top:35px !important;
}
.baike_title_henrf{
  display: flex;
  align-items: center;
  flex: 1;
}
.baike_content_body>span{
  font-size: 20px;
  font-weight: bold;
}
.baike_content_body>span>span{
  display: inline-block;
  background-color: #15befe;
  width: 10px;
  height: 25px;
  position: relative;
  top:5px;
  left:-17px;
}
.baike_title_cont_font{
  font-size: 14px;
  text-indent:25px;
  line-height: 25px;
  margin-top: 5px;
  word-wrap:break-word;
}
.baike_second_levelcont{
  font-size: 16px;
}
.hr_display{
  margin-left: 15px;
  display: inline-block;
  position: relative;
  flex:1;
  border-top:0.5px solid #e7e6e6;
  border-bottom:1px solid #FFF;
  border-left:1px solid #FFF;
  border-right:1px solid #FFF;
}
.baike_title_cont>span{
  font-size: 20px;
  font-weight: bold;
  overflow: hidden;
  display: flex;
  align-items: center;
}
.baike_title_cont>span>span{
  display: inline-block;
  background-color: #15befe;
  width: 10px;
  height: 25px;
  margin-right: 10px;
}
.baike_body_download_font>ul>li>span>img{
  position: relative;
  top:5px;
}
.matgtop{
  margin-top: 40px;
}
.baike_body_download_font{
  border-top: 1px solid #e6e6e6;
}
.baike_body_download_font>ul>li{
  padding: 5px;
  font-size: 14px;
  margin-top: 8px;
  overflow: hidden;
}
.baike_body_download_font>ul{
  width: 100%;
}
.baike_body_download>ul>li>span{
  font-size: 14px;
  display: inline-block;
  margin-bottom: 5px;
}
.baike_body_download>ul>li>img{
  position: relative;
  top:3px;
  margin-right: 10px;
}
.baike_body_download>ul{
  width: 100%;
}
.baike_body_download>ul>li{
  border-bottom:1px dashed #e5e5e5;
  padding: 5px;
  margin-top: 10px;
}
.baike_body_download{
  width: 100%;
  border-top:1px solid #e6e6e6;
}
.baike_body_button{
  width: 85px;
  border-top:2px solid #15befe;
  border-left:1px solid #e6e6e6;
  border-right: 1px solid #e6e6e6;
  text-align: center;
  font-size: 14px;
  padding: 6px;
  position:relative;
  top:2px;
  z-index: 99;
  background-color: #FFF;
}
.baike_body_finish{
  text-align: center;
  font-size: 16px;
  margin-right: 150px;
  margin-top: 30px;
}
.baike_body_html_left>div>div>img{
  margin-top: 10px;
}
.baike_body_html_left>div>div>h2{
  font-size: 14px;
  margin-bottom: 10px;
  margin-top: 10px;
}
.baike_body_html_left{
  width: 800px;
  margin-top: 5px;
  padding-top: 10px;
}
.baike_body_html{
}
</style>
