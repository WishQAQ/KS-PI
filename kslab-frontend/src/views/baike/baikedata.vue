<template>
    <div class="">
      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="最新" name="first">
            <ul class="baike_Node_class">
               <li v-for="(data ,index) in DateSrotMessage" :key="index" @click="onclickDalit(index)">
                 <div class="_img_width">
                    <img :src="request.picUrl+data.cover" alt="">
                 </div>
                 <p class="baike_p_title">{{data.title}}</p>
                 <keywordInstallDiv class="lable" :keyword="data.label_name"></keywordInstallDiv>
                 <!-- <ul class="baike_ul_li">
                    <li v-for="(list ,index) in data.label_name" :key="index">
                      {{list}}
                    </li>
                 </ul> -->
                 <div class="baike_body_font">
                    <p class="font_length" v-html="data.content"></p>
                 </div>
                 <ul class="baike_ul_icon">
                    <li>
                      <img style="position: relative;top:3px;" src="/static/img/icon/blocs.png" alt="">
                      <span style="position: relative;top:3px;">{{data.view_num}}</span>
                    </li>
                    <li>
                      <img src="/static/img/icon/none_dc.png" alt="">
                      <span>{{data.like_num}}</span>
                    </li>
                    <li>
                      <img src="/static/img/icon/data.png" alt="">
                      <span>{{data.created_at}}</span>
                    </li>
                 </ul>
               </li>
            </ul>
        </el-tab-pane>
        <el-tab-pane label="热门" name="second">
          <ul class="baike_Node_class">
             <li v-for="(VumListCont ,index) in reverseMessage" :key="index" @click="onclickDalitReve(index)">
               <div class="_img_width">
                  <img :src="'http://cdn.kushualab.com/'+VumListCont.cover" alt="">
               </div>
               <p class="baike_p_title">{{VumListCont.title}}</p>
               <ul class="baike_ul_li">
                 <li v-for="(list ,index) in VumListCont.label_name" :key="index">
                   {{list}}
                 </li>
               </ul>
               <div class="baike_body_font">
                  <p class="font_length" v-html="VumListCont.content">
                  </p>
               </div>
               <ul class="baike_ul_icon">
                  <li>
                    <img style="position: relative;top:3px;" src="/static/img/icon/blocs.png" alt="">
                    <span style="position: relative;top:3px;">{{VumListCont.view_num}}</span>
                  </li>
                  <li>
                    <img src="/static/img/icon/none_dc.png" alt="">
                    <span>{{VumListCont.like_num}}</span>
                  </li>
                  <li>
                    <img src="/static/img/icon/data.png" alt="">
                    <span>{{VumListCont.created_at}}</span>
                  </li>
               </ul>
             </li>
          </ul>
        </el-tab-pane>
        <el-tab-pane label="最有影响力" name="third">
          <ul class="baike_Node_class">
             <li v-for="(dateLink ,index) in DateLocaStroghr" :key="index" @click="onclickDalitLocastr(index)">
               <div class="_img_width">
                  <img :src="'http://cdn.kushualab.com/'+dateLink.cover" alt="">
               </div>
               <p class="baike_p_title">{{dateLink.title}}</p>
               <ul class="baike_ul_li">
                 <li v-for="(list ,index) in dateLink.label_name" :key="index">
                   {{list}}
                 </li>
               </ul>
               <div class="baike_body_font">
                  <p class="font_length" v-html="dateLink.content"></p>
               </div>
               <ul class="baike_ul_icon">
                  <li>
                    <img style="position: relative;top:3px;" src="/static/img/icon/blocs.png" alt="">
                    <span style="position: relative;top:3px;">{{dateLink.view_num}}</span>
                  </li>
                  <li>
                    <img src="/static/img/icon/none_dc.png" alt="">
                    <span>{{dateLink.like_num}}</span>
                  </li>
                  <li>
                    <img src="/static/img/icon/data.png" alt="">
                    <span>{{dateLink.created_at}}</span>
                  </li>
               </ul>
             </li>
          </ul>
        </el-tab-pane>
      </el-tabs>
    </div>
</template>

<script>
import keywordInstallDiv from "@/components/keywordInstall"
export default {
  props:['dataList'],
  components:{
      keywordInstallDiv,
    },
  data(){
    return{
      activeName: 'first',
      VumList:null,
      datelist:null, //一来拿到的最新的时间
      lengthDate:null  //个数
    }
  },
  mounted(){

  },
  methods:{
    handleClick(tab, event) {
      console.log(tab, event);
    },
    //最新百科排序
    onclickDalit(index){
      console.log(this.DateSrotMessage)
      console.log(this.DateSrotMessage[index])
      //计算属性返回的数组添加下标
      this.$router.push({
        path:'/home/BaikeDetail',
        query:{
          info:this.DateSrotMessage[index],
          uid:this.DateSrotMessage[index].encyclopedia_id
        }
      })
    },
    //热门百科排序
    onclickDalitReve(index){
      //计算属性返回的数组添加下标
      this.$router.push({
        path:'/home/BaikeDetail',
        query:{
          info:this.reverseMessage[index],
          uid:this.reverseMessage[index].encyclopedia_id
        }
      })
    },
    //最有影响力的百科排序
    onclickDalitLocastr(index){
      //计算属性返回的数组添加下标
      this.$router.push({
        path:'/home/BaikeDetail',
        query:{
          info:this.DateLocaStroghr[index],
          uid:this.DateLocaStroghr[index].encyclopedia_id
        }
      })
    }
  },
  computed:{
      //最热排序
      reverseMessage:function(){
        console.log(this.dataList)
      if(this.dataList == "")
      {

      }else{
        function sortc(a,b){
          return b.view_num - a.view_num
        }
        var DataList = JSON.stringify( this.dataList )
        var listSort = JSON.parse( DataList )
        listSort.sort(sortc)

        var DataList = JSON.stringify( listSort )
        var listSort = JSON.parse( DataList )
        var Arr = new Array()
        for(var i=0;i<listSort.length;i++){
          var DateList = new Date(listSort[i].created_at)
          var TimeDate = Date.parse(DateList)
          var LocalDate = Number(new Date())
          var newDateTime = LocalDate - TimeDate
          var timeSpanStr;
          if (newDateTime <= 1000 * 60 * 1) {
            timeSpanStr = '刚刚';
          }
          else if (1000 * 60 * 1 < newDateTime && newDateTime <= 1000 * 60 * 60) {
            timeSpanStr = Math.round((newDateTime / (1000 * 60))) + '分钟前';
          }
          else if (1000 * 60 * 60 * 1 < newDateTime && newDateTime <= 1000 * 60 * 60 * 24) {
            timeSpanStr = Math.round(newDateTime / (1000 * 60 * 60)) + '小时前';
          }
          else if (1000 * 60 * 60 * 24 < newDateTime && newDateTime <= 1000 * 60 * 60 * 24 * 15) {
            timeSpanStr = Math.round(newDateTime / (1000 * 60 * 60 * 24)) + '天前';
          }
           Arr.push(timeSpanStr)
           listSort[i].created_at = Arr[i]
        }
      }
      return listSort
    },
      //最新排序
      DateSrotMessage:function(){
        if(this.dataList == ""){

        }else{
          var thisDate = this.dataList
          var thisDataLiken;
          var DateArrNew = new Array();
          var ArrRetunr = new Array();
          for(var a=0;a<thisDate.length;a++){
             var DateNew = thisDate[a].created_at
             var butDate = Date.parse(new Date(DateNew))
             thisDate[a].created_at = butDate
             var StringArr = JSON.stringify(thisDate[a])
             var ArrObject = JSON.parse( StringArr )
             ArrRetunr.push(ArrObject)
             var contDateNew = ArrRetunr[a].created_at
             DateArrNew.push(contDateNew)
             DateArrNew.sort(function(a,b){
               return b-a
             })
             //添加时间进入数组
             function Srotlength(a,b){
               return b.created_at - a.created_at
             }
             ArrRetunr.sort(Srotlength)
          }
          for(var k=0;k<DateArrNew.length;k++)
          {
            var Timen =DateArrNew[k]
            var LocasDate = Number(new Date());
            var nowDate = LocasDate - Timen
            var timeSpanStr;
            if (nowDate <= 1000 * 60 * 1) {
              timeSpanStr = '刚刚';
            }
            else if (1000 * 60 * 1 < nowDate && nowDate <= 1000 * 60 * 60) {
              timeSpanStr = Math.round((nowDate / (1000 * 60))) + '分钟前';
            }
            else if (1000 * 60 * 60 * 1 < nowDate && nowDate <= 1000 * 60 * 60 * 24) {
              timeSpanStr = Math.round(nowDate / (1000 * 60 * 60)) + '小时前';
            }
            else if (1000 * 60 * 60 * 24 < nowDate && nowDate <= 1000 * 60 * 60 * 24 * 15) {
              timeSpanStr = Math.round(nowDate / (1000 * 60 * 60 * 24)) + '天前';
            }
            ArrRetunr[k].created_at = timeSpanStr
          }
        }
       return ArrRetunr
      },
      DateLocaStroghr:function(){
        if(this.dataList == ""){

        }else{
          var thisDate = this.dataList
          var thisDataLiken;
          var DateArrNew = new Array();
          var ArrRetunr = new Array();
          for(var a=0;a<thisDate.length;a++){
             var DateNew = thisDate[a].created_at
             var butDate = Date.parse(new Date(DateNew))
             thisDate[a].created_at = butDate
             var StringArr = JSON.stringify(thisDate[a])
             var ArrObject = JSON.parse( StringArr )
             ArrRetunr.push(ArrObject)
             var contDateNew = ArrRetunr[a].created_at
             DateArrNew.push(contDateNew)
             DateArrNew.sort(function(a,b){
               return b-a
             })
             //添加时间进入数组
             function Srotlength(a,b){
               return b.like_num - a.like_num
             }
             ArrRetunr.sort(Srotlength)
          }
          for(var k=0;k<DateArrNew.length;k++)
          {
            var Timen =DateArrNew[k]
            var LocasDate = Number(new Date());
            var nowDate = LocasDate - Timen
            var timeSpanStr;
            if (nowDate <= 1000 * 60 * 1) {
              timeSpanStr = '刚刚';
            }
            else if (1000 * 60 * 1 < nowDate && nowDate <= 1000 * 60 * 60) {
              timeSpanStr = Math.round((nowDate / (1000 * 60))) + '分钟前';
            }
            else if (1000 * 60 * 60 * 1 < nowDate && nowDate <= 1000 * 60 * 60 * 24) {
              timeSpanStr = Math.round(nowDate / (1000 * 60 * 60)) + '小时前';
            }
            else if (1000 * 60 * 60 * 24 < nowDate && nowDate <= 1000 * 60 * 60 * 24 * 15) {
              timeSpanStr = Math.round(nowDate / (1000 * 60 * 60 * 24)) + '天前';
            }
            ArrRetunr[k].created_at = timeSpanStr
          }
        }
       return ArrRetunr
      }
    },
  }
</script>

<style lang="css">
._img_width>img{
  width: 100%;
  height: 100%;
}
.font_length{
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 4;
  overflow: hidden;
  height: 75px;
}
.el-tabs>.el-tabs__header>.el-tabs__nav-wrap>.el-tabs__nav-scroll>.is-top{

}
.baike_ul_icon{
  width: 48%;
  float: left;
  display: flex;
}
.baike_ul_icon li span{
  margin-right: 8px;
  color:#bfbfbf;
}
.baike_ul_icon li img{
  position: relative;
  top:2px;
}
.baike_body_font{
  width: 270px !important;
  border-bottom:1px solid #c7c7c7;
  height: auto !important;
  margin-top: 10px;
  padding-bottom: 10px;
  margin-bottom: 1px;
}
.baike_body_font p{
  font-size: 13px;
  color:#747474;
}
.baike_ul_li{
  display: flex;
  margin-top: 7px;
}
.baike_ul_li>li{
  border:1px solid #15bafe;
  color:#15bafe;
  padding: 0px 5px 0px 5px;
  border-radius: 3px;
  margin-right: 5px;
}
.baike_p_title{
  font-weight: 800;
  font-size: 18px;
  overflow: hidden;
  text-overflow:ellipsis;
  white-space: nowrap;
}
.baike_Node_class{
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}
.baike_Node_class>li{
  width:570px;
  height: 170px;
  overflow: hidden;
  margin-bottom: 30px;
  cursor: pointer;
}
.baike_Node_class>li>._img_width{
  display: flex;
  justify-content: center;
  align-items: center;
  background: #f2f2f2;
}
.baike_Node_class>li>div{
  width: 260px;
  height: 170px;
  overflow: hidden;
  float: left;
  margin-right: 10px;
}
.baike_Boady_index>span{
    font-size: 25px;
    position: relative;
    top:35px;
    left:5px;
}
.baike_Boady_index{
  width: 1200px;
  margin: 0 auto;
  margin-top: 10px;
}
.baike_index_body{
  width: 1200px;
  margin: 0 auto;
  margin-top: 50px;
}
.baike_index_body>ul{
  display: flex;
  justify-content: space-between;
  position: relative;
}
.baike_index_body>ul>li{
  font-size:14px;
  font-weight: 800;
  border-bottom: 1px solid #15bafe;
  padding-bottom: 2px;
  cursor: pointer;
  position: relative;
}
.baike_index_body>ul>li>div{
  background-color: #FFF;
  box-shadow: 0px 2px 5px 0px rgba(34, 24, 21, 0.16);
  padding: 10px;
  font-weight: 0 !important;
  font-size: 10px !important;
  color:#787878;
  width: 190px;
  position:absolute;
  left: 50%;
  margin-left: -95px;
  border-bottom: 5px solid #15bafe;
}
.lable{
  height: 27px !important;
}
</style>
