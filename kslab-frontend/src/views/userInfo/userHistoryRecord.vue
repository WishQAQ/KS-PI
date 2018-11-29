<template>

  <div class="appBackground">
    <!--个人页面头部-->
    <userInfoHeader-div></userInfoHeader-div>

    <div class="userHistoryRecord_box width_1200">
      <el-tabs v-model="activeName2" type="card" @tab-click="handleClick">
        <el-tab-pane label="视频记录" name="video">

          <div class="userVideo">
            <div class="userVideo_box" v-for="(item,index) in videoList" :key="index">
              <el-checkbox v-model="video_checkList[index].checkboxVal" @change="videoCheckChange(index)"></el-checkbox>

              <div class="userVideo_img">
                <img :src="item.cover" alt="" @click="vdiinfoRouter(index)">
              </div>

              <div class="userVideo_text">
                <h4 @click="vdiinfoRouter(index)">{{item.title}}</h4>
                <p>{{item.description}}</p>
                <div class="userVideo_tags">
                  <keywordInstallDiv :keyword="item.label"></keywordInstallDiv>
                </div>
                <div class="userVideo_message">
                  <span>{{item.nickname}}</span> ·
                  <span>{{item.view_num}}次浏览</span> ·
                  <span>{{item.comment_num}}条评论</span> ·
                  <span>{{item.like_num}}次点赞</span>
                </div>
              </div>

              <div class="userVideo_status">
                <div @click="deleteHis(index,1)"><span></span></div>
                <p>{{item.record_time}}</p>
              </div>

            </div>

            <div class="userVideo_bottom">
              <div class="userVideo_bottom_arr">
                <input type="checkbox" id="checkedArr" />
                <label for="checkedArr" @click="videoAllCheck">全选</label>
                <input type="checkbox" id="checkedOrr" />
                <label for="checkedOrr" @click="deleteSleVideo">删除选中</label>
              </div>
              <div class="userVideo_bottom_pages">
                <el-pagination
                  small
                  layout="prev, pager, next"
                  @current-change="handleCurrentChangeVideo"
                  :total="totalOne">
                </el-pagination>
              </div>
            </div>

          </div>


        </el-tab-pane>



        <el-tab-pane label="百科记录" name="Encyclopedia">
          <div class="userEncyclopedia">
            <div class="userEncyclopedia_box" v-for="(item,index) in encycoList" :key="index">
              <div class="userEncy_title" @click="encinfoRouter(index)"><span></span>{{item.title}}</div>
              <div class="userEncy_main">
                <div class="userEncy_check">
                  <el-checkbox v-model="encyc_checkList[index].checkboxVal" @change="encycCheckChange(index)"></el-checkbox>
                </div>

                <div class="userEncy_img" @click="encinfoRouter(index)"><img :src="item.cover" alt=""></div>

                <div class="userEncy_text">
                  <p>{{item.description}}</p>
                  <div>
                    <span>{{item.nickname}}</span> ·
                    <span>{{item.view_num}}次浏览</span> 
                  </div>
                </div>

                <div class="userEncy_status">
                  <div @click="deleteHis(index,0)"><span></span></div>
                  <p>{{item.record_time}}</p>
                </div>
              </div>
            </div>

            <div class="userEncy_bottom">
              <div class="userEncy_bottom_arr">
                <input type="checkbox" id="checkedArr1" v-model="checked" />
                <label for="checkedArr1" @click="encycAllCheck">全选</label>
                <input type="checkbox" id="checkedOrr1" v-model="checked" />
                <label for="checkedOrr1" @click="deleteSleEncyc">删除选中</label>
              </div>
              <div class="userEncy_bottom_pages">
                <el-pagination
                  small
                  layout="prev, pager, next"
                  @current-change="handleCurrentChangeEncyc"
                  :total="totalTwo">
                </el-pagination>
              </div>
            </div>
          </div>

        </el-tab-pane>
      </el-tabs>

    </div>


    <!--侧边悬浮框-->
    <floating-div></floating-div>
  <!-- 确认删除视频弹窗 -->
    <el-dialog :visible.sync="deleteVisible" width="20%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确认删除吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="deleteVisible = false">取消</el-button>
        <el-button type="primary" @click="sureDelete">确认</el-button>
      </div>   
    </el-dialog>
    <!-- 确认删除选中视频弹窗 -->
    <el-dialog :visible.sync="deletesleVisible" width="20%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确认删除选中的视频历史吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="deletesleVisible = false">取消</el-button>
        <el-button type="primary" @click="sureDeleteSle">确认</el-button>
      </div>   
    </el-dialog>
    <!-- 确认删除百科弹窗 -->
    <!-- <el-dialog :visible.sync="deleteEncycVisible" width="20%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确认删除吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="deleteEncycVisible = false">取消</el-button>
        <el-button type="primary" @click="sureDelete">确认</el-button>
      </div>   
    </el-dialog> -->
    <!-- 确认删除选中百科弹窗 -->
    <el-dialog :visible.sync="deletesleEncycVisible" width="20%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确认删除选中的百科历史吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="deletesleEncycVisible = false">取消</el-button>
        <el-button type="primary" @click="sureDeleteEncycSle">确认</el-button>
      </div>   
    </el-dialog>
  </div>

</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"
  import keywordInstallDiv from "@/components/keywordInstall"

  export default {
    data(){
      return{
        page:1,
        size:8,
        currentPage:null,
        totalTwo:null,
        totalOne:null,
        videoDelete:null, //视频删除标识
        encycDelete:null, //百科删除标识
        encycDeleteList:[], //需要删除的百科记录数组
        videoDeleteList:[], //需要删除的视频记录数组
        videoIndex:null, //存储视频历史删除index
        encycIndex:null,//存储百科历史删除index
        deletesleEncycVisible:false,//百科选中删除弹窗
        // deleteEncycVisible:false, //百科删除弹窗
        deletesleVisible:false,//视频选中删除弹窗
        deleteVisible:false,//公共单个删除弹窗
        encycoList:[],
        videoList:[],
        activeName2: 'video',
        checked: false,
        //视频全选  
        video_deleteList:[],//需要删除的订单数组
        video_checkList: [],
        video_allCheckTip:0,//全选标记  为全选为0，全选为1
        //百科全选  
        encyc_deleteList:[],//需要删除的订单数组
        encyc_checkList: [],
        encyc_allCheckTip:0,//全选标记  为全选为0，全选为1
      }
    },
    created(){
      //获取视频历史记录列表
      const param = {
        page_size:8,
        page:1
      }
      this.getList(param);
      // this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'my/history/videolist',{
      //     token:window.localStorage.token,
      //     page_size:this.size
      // })
      // .then((res) => {
      //     console.log(res)
      //     this.videoList = res.data.data;
      //     this.totalOne = Math.ceil(res.data.data.length/8);
      //     var video_id = null;
      //     var id = null;   
      //     for(var i = 0; i < this.videoList.length;i++){
      //         this.videoList[i].record_time = this.simplyToRelativeTime(this.timestampToTime(this.videoList[i].record_time));//处理时间
      //         this.videoList[i].cover = this.request.picUrl+this.videoList[i].cover;  //处理图片
      //         this.videoList[i].checkboxVal = false;
      //         video_id = this.videoList[i].video_id;
      //         id = i;
      //         this.video_checkList.push({
      //             checkboxVal:this.videoList[i].checkboxVal,
      //             video_id:video_id,
      //             id:id
      //         });
      //     }
      //     console.log(this.video_checkList)
      // })
    },
    methods: {
      getList(param){
        this.HttpClient.post('/my/history/videolist',param).then((res) => {
          console.log(res)
          this.videoList = res.data.data;
          this.totalOne = Math.ceil(res.data.data.length/8);
          var video_id = null;
          var id = null;   
          for(var i = 0; i < this.videoList.length;i++){
              this.videoList[i].record_time = this.simplyToRelativeTime(this.timestampToTime(this.videoList[i].record_time));//处理时间
              this.videoList[i].cover = this.request.picUrl+this.videoList[i].cover;  //处理图片
              this.videoList[i].checkboxVal = false;
              video_id = this.videoList[i].video_id;
              id = i;
              this.video_checkList.push({
                  checkboxVal:this.videoList[i].checkboxVal,
                  video_id:video_id,
                  id:id
              });
          }
          console.log(this.video_checkList)
        })
      },
      getEncycList(param){
          //获取百科历史记录列表
          this.HttpClient.post('/my/history/encyclopedialist',param).then((res) => {
              console.log(res)
              this.encycoList = res.data.data;
              this.totalTwo = Math.ceil(res.data.data.length/8);
              var encyclopedia_id = null;
              var id = null;   
              for(var i = 0; i < this.encycoList.length;i++){
                this.encycoList[i].record_time = this.simplyToRelativeTime(this.timestampToTime(this.encycoList[i].record_time));
                this.encycoList[i].cover = this.request.picUrl+this.encycoList[i].cover;  //处理图片
                this.encycoList[i].checkboxVal = false;
                encyclopedia_id = this.encycoList[i].encyclopedia_id;
                id = i;
                this.encyc_checkList.push({
                    checkboxVal:this.encycoList[i].checkboxVal,
                    encyclopedia_id:encyclopedia_id,
                    id:id
                });
              }
          })
      },
      //跳转百科详情页
      encinfoRouter(index){
        // console.log(index)
        // console.log(this.encycoList)
        // console.log(this.encycoList[index])
        this.$router.push({
          path:'/home/baikeDetail',
          query:{
            uid:this.encycoList[index].encyclopedia_id,
          }
        })
      },
      //跳转视频详情页
      vdiinfoRouter(index){
        this.$router.push({
          path:'/home/videoDetail',
          query:{
            video:this.videoList[index].video_id,
          }
        })
      },
      //删除选中
      deleteSleVideo(){
        console.log(this.video_deleteList.length)
        if(this.video_deleteList.length == 0){
          this.$message('您还未选择需要删除的视频历史')
        }else{
          this.deletesleVisible = true;
        }
      },
      //确认删除选中视频
      sureDeleteSle(){
        this.HttpClient.post('/my/history/delete',{
            list:this.video_deleteList
          })
          .then((res) => {
              console.log(res)
              if (res.data.code === 200) {
                   this.HttpClient.post('/my/history/delete',{
                      page_size:8
                    })
                    .then((res) => {
                      console.log(res)
                      this.videoList = res.data.data;
                      var video_id = null;
                      var id = null;   
                      for(var i = 0; i < this.videoList.length;i++){
                          this.videoList[i].record_time = this.simplyToRelativeTime(this.timestampToTime(this.videoList[i].record_time));//处理时间
                          this.videoList[i].cover = this.request.picUrl+this.videoList[i].cover;  //处理图片
                          this.videoList[i].checkboxVal = false;
                          video_id = this.videoList[i].video_id;
                          id = i;
                          this.video_checkList.push({
                              checkboxVal:this.videoList[i].checkboxVal,
                              video_id:video_id,
                              id:id
                          });
                      }
                      console.log(this.video_checkList)
                    })
                  this.deletesleVisible = false;
                  this.$message.success(res.data.msg)    
                  this.video_deleteList = []; 
              } else {
                  this.$message.error(res.data.msg)     
              }
          })
      },
      //视频单个选中状态改变回调
      videoCheckChange(index){
        console.log(index)
        // var curLenght = this.deleteList.length;
        if(!this.video_checkList[index].checkboxVal){
          console.log('123')
          Array.prototype.sanchu = function(val) { 
            var index = this.indexOf(val); 
            if (index > -1) { 
              this.splice(index, 1); 
            } 
          }
          this.video_deleteList.sanchu(this.video_checkList[index].video_id);
        }else{
          console.log('456')
          this.video_deleteList.push(this.video_checkList[index].video_id);
        }
        console.log(this.video_checkList) 
        console.log(this.video_deleteList)
      },
      //视频长期活动全选
      videoAllCheck(){
        if(this.video_allCheckTip == 0){
          for(let i = 0;i<this.video_checkList.length;i++){
            this.video_checkList[i].checkboxVal = true;
            this.video_deleteList.push(this.video_checkList[i].video_id);
          }
          this.video_allCheckTip = 1;
          console.log(this.video_checkList)
          console.log(this.video_deleteList)
        }else if(this.video_allCheckTip == 1){
          for(let i = 0;i<this.video_checkList.length;i++){
            this.video_checkList[i].checkboxVal = false;
            this.video_deleteList = [];
          }
          this.video_allCheckTip = 0;
          console.log(this.video_checkList)
          console.log(this.video_deleteList)
        }
      },
      //删除视频历史记录
      // deleteHis(index){
      //   this.videoDelete = 1;//标记此时点击的删除是百科
      //   this.deleteVisible = true;
      //   this.videoIndex = index;
      //   this.videoDeleteList.push(this.videoList[index].video_id);
      // },
      //删除百科历史记录
      deleteHis(index,n){
        if(n == 1){
          console.log('删除视频')
          this.videoDelete = 1;//标记此时点击的删除是百科
          this.deleteVisible = true;
          this.videoIndex = index;
          this.videoDeleteList.push(this.videoList[index].video_id);
        }else if(n == 0){
          console.log('删除百科')
          this.encycDelete = 1;//标记此时点击的删除是视频
          this.deleteVisible = true;
          this.encycIndex = index;
          this.encycDeleteList.push(this.encycoList[index].encyclopedia_id);
        }
        
      },
      //确认删除
      sureDelete(){
        if(this.videoDelete == 1 && this.encycDelete == null){ 
          // this.$message("这是删除视频历史——删除代码已注释")
          this.HttpClient.post('/my/history/delete',{
            list:this.videoDeleteList
          })
          .then((res) => {
              console.log(res)
              if (res.data.code === 200) {
                  this.deleteVisible = false;
                  this.videoList.splice(this.videoIndex,1);
                  this.$message.success(res.data.msg)   
                  this.videoDeleteList = []; //删除成功后，清空删除容器，以便下次删除使用
                  this.videoDelete == null;//恢复删除标记
              } else {
                  this.$message.error(res.data.msg)     
              }
          })
        }else if(this.videoDelete == null && this.encycDelete == 1){
          // this.$message("这是删除百科历史——删除代码已注释")
          this.HttpClient.post('/my/history/delete',{
            list:this.encycDeleteList
          })
          .then((res) => {
              console.log(res)
              if (res.data.code === 200) {
                  this.deleteVisible = false;
                  this.encycList.splice(this.encycIndex,1);
                  this.$message.success(res.data.msg)    
                  this.encycDeleteList = []; //删除成功后，清空删除容器，以便下次删除使用
                  this.encycDelete = null;//恢复删除标记
              } else {
                  this.$message.error(res.data.msg)     
              }
          })
        }
        
      },
      handleClick(tab, event) {
        this.indexLength = tab.index
        if(tab.index == 0){
          console.log("0")
        }
        else if(tab.index == 1){
          const param = {
            page:this.page,
            page_size:8
          }
          this.getEncycList(param);
          // //获取百科历史记录列表
          //  this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'my/history/encyclopedialist',{
          //     token:window.localStorage.token,
          //     page_size:8
          //  })
          //   .then((res) => {
          //     console.log(res)
          //     this.encycoList = res.data.data;
          //     var encyclopedia_id = null;
          //     var id = null;   
          //     for(var i = 0; i < this.encycoList.length;i++){
          //       this.encycoList[i].record_time = this.simplyToRelativeTime(this.timestampToTime(this.encycoList[i].record_time));
          //       this.encycoList[i].cover = this.request.picUrl+this.encycoList[i].cover;  //处理图片
          //       this.encycoList[i].checkboxVal = false;
          //       encyclopedia_id = this.encycoList[i].encyclopedia_id;
          //       id = i;
          //       this.encyc_checkList.push({
          //           checkboxVal:this.encycoList[i].checkboxVal,
          //           encyclopedia_id:encyclopedia_id,
          //           id:id
          //       });
          //     }
          //   })
        }
      },
      //百科单个选中状态改变回调
      encycCheckChange(index){
        console.log(index)
        // var curLenght = this.deleteList.length;
        if(!this.encyc_checkList[index].checkboxVal){
          console.log('123')
          Array.prototype.sanchu = function(val) { 
            var index = this.indexOf(val); 
            if (index > -1) { 
              this.splice(index, 1); 
            } 
          }
          this.encyc_deleteList.sanchu(this.encyc_checkList[index].encyclopedia_id);
        }else{
          console.log('456')
          this.encyc_deleteList.push(this.encyc_checkList[index].encyclopedia_id);
        }
        console.log(this.encyc_checkList) 
        console.log(this.encyc_deleteList)
      },
      //百科长期活动全选
      encycAllCheck(){
        if(this.encyc_allCheckTip == 0){
          for(let i = 0;i<this.encyc_checkList.length;i++){
            this.encyc_checkList[i].checkboxVal = true;
            this.encyc_deleteList.push(this.encyc_checkList[i].encyclopedia_id);
          }
          this.encyc_allCheckTip = 1;
          console.log(this.encyc_checkList)
          console.log(this.encyc_deleteList)
        }else if(this.encyc_allCheckTip == 1){
          for(let i = 0;i<this.encyc_checkList.length;i++){
            this.encyc_checkList[i].checkboxVal = false;
            this.encyc_deleteList = [];
          }
          this.encyc_allCheckTip = 0;
          console.log(this.encyc_checkList)
          console.log(this.encyc_deleteList)
        }
      },
      //删除选中百科
      deleteSleEncyc(){
        console.log(this.encyc_deleteList.length)
        if(this.encyc_deleteList.length == 0){
          this.$message('您还未选择需要删除的百科历史')
        }else{
          this.deletesleEncycVisible = true;
        }
      },
      //确认删除选中的百科
      sureDeleteEncycSle(){
        this.HttpClient.post('/my/history/delete',{
            list:this.encyc_deleteList
          })
          .then((res) => {
              console.log(res)
              if (res.data.code === 200) {
                  this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'my/history/encyclopedialist',{
                      token:window.localStorage.token,
                      page_size:8
                  })
                  .then((res) => {
                      console.log(res)
                      this.encycoList = res.data.data;
                      var encyclopedia_id = null;
                      var id = null;   
                      for(var i = 0; i < this.encycoList.length;i++){
                        this.encycoList[i].record_time = this.simplyToRelativeTime(this.timestampToTime(this.encycoList[i].record_time));
                        this.encycoList[i].cover = this.request.picUrl+this.encycoList[i].cover;  //处理图片
                        this.encycoList[i].checkboxVal = false;
                        encyclopedia_id = this.encycoList[i].encyclopedia_id;
                        id = i;
                        this.encyc_checkList.push({
                            checkboxVal:this.encycoList[i].checkboxVal,
                            encyclopedia_id:encyclopedia_id,
                            id:id
                        });
                      }
                    })
                  this.deletesleEncycVisible = false;
                  this.$message.success(res.data.msg)    
                  this.encyc_deleteList = []; 
              } else {
                  this.$message.error(res.data.msg)     
              }
          })
      },
      //时间转换为多久之前，
      simplyToRelativeTime(time) {
          // var cuttime = new Date('2018-10-24 14:47:14')
          var cuttime = new Date(time)
          let lasttime = Math.round(cuttime.getTime() / 1000); //将时间转化为秒
          // console.log(lasttime)
          console.log("触发了")
      　　let currentUnixTime = Math.round((new Date()).getTime() / 1000);       // 当前时间的秒数
      　　let deltaSecond = currentUnixTime - parseInt(lasttime, 10);            // 当前时间与要转换的时间差（ s ）
      　　let result;
      　　if (deltaSecond < 60) {
      　　　　result = deltaSecond + '秒前';
      　　} else if (deltaSecond < 3600) {
      　　　　result = Math.floor(deltaSecond / 60) + '分钟之前';
      　　} else if (deltaSecond < 86400) {
      　　　　result = Math.floor(deltaSecond / 3600) + '小时之前';
      　　} else if(deltaSecond < 2592000){
      　　　　result = Math.floor(deltaSecond / 86400) + '天之前';
      　　}else{
             result = Math.floor(deltaSecond /2592000 ) + '个月之前';
      }
          return result;
          console.log('结果：'+result)
      },
      timestampToTime(timestamp){
        var date = new Date(timestamp);//时间戳为13位的话不需乘1000
        var Y = date.getFullYear() + '-';
        var M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        var D = date.getDate() + ' ';
        var h = date.getHours() + ':';
        var m = date.getMinutes() + ':';
        var s = date.getSeconds();
        return Y+M+D+h+m+s;
      },
      // 视频记录分页
      handleCurrentChangeVideo(value){
        console.log(value)
        this.currentPage = parseInt(value);
        let param = {
          page_size:8,
          page:this.currentPage 
        }
        this.getList(param);
      },
      // 百科记录分页
      handleCurrentChangeEncyc(value){
        console.log(value)
        this.currentPage = parseInt(value);
        let param = {
          page_size:8,
          page:this.currentPage
        }
        this.getEncycList(param);
      }
    },
    watch: {
      "checkedNames": function() {
        if (this.checkedNames.length == this.checkedArr.length) {
          this.checked = true
        } else {
          this.checked = false
        }
      }
    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      keywordInstallDiv
    }
  }
</script>

<style src="../../assets/css/userHistoryRecord.css"></style>
<style>
  .userHistoryRecord_box .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background-color: #fff;
    color: #000;
    font-size: 14px;
  }
  .userHistoryRecord_box .el-tabs--card>.el-tabs__header .el-tabs__item{
    color: #9f9f9f;
    font-size: 14px;
  }
  .userHistoryRecord_box .el-tabs__content{
    background-color: #fff;
    padding-top: 20px !important;
  }
  .userHistoryRecord_box .el-tabs__header{
    margin-bottom: 0 !important;
  }
</style>
<style scoped>
.userVideo_status>div:hover{
  background: #f55959;
  border: 2px solid #f55959;
}
.userVideo_status>div:hover span{
  background-color: #fff;
}
.userEncy_status>div:hover{
  background: #f55959;
  border: 2px solid #f55959;
}
.userEncy_status>div:hover span{
  background-color: #fff;
}
.logo>img{
    width: 75px;height: 15px;
  }
  .tub{
    text-align: center;
  }
  .tub>img{
    width: 70px;height: 70px;
    margin: 15px 0;
  }
  .tub>p{
    font-size: 16px;
    color: #222222;
    margin-bottom: 10px;
  }
  .btn3{
    display: flex;justify-content: center;
  }
</style>
<style lang="less">
  .appBackground{
    .el-textarea__inner{
      height: 120px;
    }
    .el-dialog__header{
          padding: 8px 20px 10px;
    }
    .el-button+.el-button{
      margin-left: 30px;
    }
    .el-dialog--center .el-dialog__body{
      padding: 0px 25px 30px;
    }
  }
</style>

