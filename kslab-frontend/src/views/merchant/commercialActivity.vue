<template>
   <div class="commercialActivity appBackground">
      <user-index-header></user-index-header>
      <div class="commerTabs">
        <el-tabs v-model="activeName2" type="card" @tab-click="handleClick">
          <el-tab-pane label="已上线" name="first">
            <div class="commer_odiv_div">
             <table class="commer_table">
                <tr class="table_title_commer">
                   <td>主题</td>
                   <td>出售票数</td>
                   <td>关注人数</td>
                   <td>报名截止时间</td>
                   <td>活动开始时间</td>
                   <td>状态</td>
                   <td>操作</td>
                </tr>
                <tr v-for="(line,index) in activityList" :key="index" >
                  <td>{{line.title}}</td>
                  <td>{{line.sale_num}}</td>
                  <td>{{line.view_num}}</td>
                  <td>{{line.registration_deadline}}</td>
                  <td>{{line.active_date}}</td>
                  <td class="commer_img_td">
                    <div class="" v-if="line.status===1">
                      <el-button type="primary">正常</el-button>
                    </div>
                    <div class="" v-else-if="line.status===2">
                      <el-button type="warning" disabled>待审核</el-button>
                    </div>
                    <div class="" v-else-if="line.status===3">
                      <el-button type="danger">未通过</el-button>
                    </div>
                    <div class="" v-else-if="line.status===5">
                      <el-button type="black">停止报名</el-button>
                    </div>
                    <div class="" v-else-if="line.status===6">
                      <el-button type="info">已暂停</el-button>
                    </div>
                  </td>
                  <td class="flex_commer_td">
                    <router-link :to="'/home/commercialDetailActivity/'+line.active_id+'/'+line.title">查看报名</router-link>
                    <a>验票</a>
                    <a @click="updateActivity(line.active_id)">修改</a>
                    <el-button type="text" @click="endActivity(line.active_id,line.status)" v-if="line.status!==5 && line.status!==6">停止报名</el-button>
                    <el-button type="text" @click="endActivity(line.active_id,line.status)" v-else>恢复报名</el-button>
                    <a @click="cancelActivity(line.active_id)">取消活动</a>
                  </td>
                </tr>
             </table>
             <el-pagination
                layout="prev, pager, next"
                :page-count="totalPage"
                @current-change="pageChange"
                @prev-click="prevPage"
                @next-click="nextPage"
                v-if="totalPage">
             </el-pagination>
            </div>
          </el-tab-pane>
          <el-tab-pane label="已结束" name="second">
            <div class="commer_odiv_div">
             <table class="commer_table">
                <tr class="table_title_commer">
                   <td>主题</td>
                   <td>报名人数</td>
                   <td>总收入</td>
                   <td>结束时间</td>
                   <td>总评分</td>
                   <td>操作</td>
                </tr>
                <tr v-for="(end,index) in activityEnd" :key="index" >
                  <td>{{end.title}}</td>
                  <td>{{end.sale_num}}</td>
                  <td>¥{{end.total_money}}</td>
                  <td>{{end.registration_deadline}}</td>
                  <td class="commer_img_td">
                    <el-rate
                      v-model="end.score"
                      disabled
                      :colors="['#15befe', '#15befe', '#15befe']">
                    </el-rate>
                  </td>
                  <td class="flex_commer_td">
                    <router-link :to="'/home/commercialDetailActivity/'+end.active_id+'/'+end.title">查看报名</router-link>
                    <p :id='index'   @click='checkComment(end.active_id,end.title)'>查看评论</p>
                    <el-button type="text" @click="deleteActivity(end.active_id)">删除</el-button>
                  </td>
                </tr>
             </table>
             <el-pagination
                     layout="prev, pager, next"
                     :page-count="totalPageEnd"
                     @current-change="pageChangeEnd"
                     v-if="totalPageEnd">
             </el-pagination>
            </div>
          </el-tab-pane>
          <el-tab-pane name="link">
            <div class="commer_btn_submit" @click="commerRouterLink" slot="label">+添加活动</div>
          </el-tab-pane>
        </el-tabs>
      </div>
      <!-- <commer-end :type="EndFalse"></commer-end> -->
   </div>
</template>

<script>
import CommerEnd from '@/views/merchant/commercialEnd'
import UserIndexHeader from '@/components/commercialInfoHeader'
export default {
   data(){
     return{
       activeName2: 'first',//当前标签页
       EndFalse:false,
       activityList:[],//已上线活动列表
       currentPage:1,//当前页
       totalPage:0,//已上线活动总页数
       activityEnd:[],//已结束活动列表
       currentPageEnd:1,//已结束页当前页
       totalPageEnd:0,//已结束活动总页数
     }
   },
   components:{
     UserIndexHeader,
     CommerEnd
   },
   methods:{
     handleClick(tab, event) {
       console.log(tab, event);
     },
     //查看评论
     checkComment(id,title){
       this.$router.push({
        path:'/home/merchantViewReviews',
        query:{id:id,title:title,type:'activity'}
       })
     },
     //修改活动
     updateActivity(id){
         // this.HttpClient.get('/actives/editDetail',{active_id:id})
         //     .then(res=>{
         //         console.log(res);
         //         let {code,data} = res.data;
         //         if(code===200){
         //             this.$store.dispatch('getActivityUploadData',data).then(res =>{
         //                 console.log(this.$store.state.activityUpload.activityUploadData)
         //                 this.$router.push({
         //                     path:'/home/uploading-activity',
         //                     query:{active_id:id}
         //                 });
         //             });
         //         }
         //     })
         this.$router.push({
             path:'/home/uploading-activity',
             query:{active_id:id}
         });
     },
     //取消/恢复报名
     endActivity(id,status){
       this.$confirm(status===5?'确定恢复报名吗？':'此操作会导致用户无法再购买，但已购用户可以继续使用', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.changeActivityStatus(id)
        }).catch(() => {
          this.$message({
            type: 'info',
            message:status===5?'已取消恢复':'已取消结束'
          });
        });
     },
     //删除活动
     deleteActivity(id){
        this.HttpClient.post('/actives/delActive',{active_id:id})
            .then(res=>{
                console.log(res);
            })
     },
     //上传活动
     commerRouterLink(){
       this.$router.push({
         path:'/home/uploading-activity'
       })
     },

     //分页当前页改变
     pageChange(p){
         this.currentPage=p;
         this.getActivity(1)
     },

     //点击上一页
     prevPage(){},

     //点击下一页
     nextPage(){},

     //已结束当前页改变事件
     pageChangeEnd(p){
         this.currentPageEnd=p;
         this.getActivity(2)
     },

     //获取活动列表
     getActivity(status){
         /***
          * status:1已上线
          *        2已结束
          ***/
         this.HttpClient.get('/company/getActives',{status:status,page:status===1?this.currentPage:this.currentPageEnd})
             .then(res=>{
                 console.log(res);
                 let {code,data,page_num} = res.data;
                 if(code===200){
                     if(status===1){
                         this.activityList=data;
                         this.totalPage=page_num;
                     }else{
                         this.activityEnd=data;
                         this.totalPageEnd=page_num;
                     }
                 }else{
                     if(status===1){
                         this.activityList=[];
                         this.totalPage=0;
                     }else{
                         this.activityEnd=[];
                         this.totalPageEnd=0;
                     }
                 }
             })
     },

     //停止、恢复报名
     changeActivityStatus(id){
         console.log(id);
         this.HttpClient.post('/company/changeActiveSignUp',{active_id:id})
             .then(res=>{
                 console.log(res);
                 if(res.data.code===200){
                    this.$message.success(res.data.msg);
                    this.getActivity(1)
                 }
             })
     },

     //取消活动
     cancelActivity(){
         this.HttpClient.post('/company/cancelActive',{active_id:id})
             .then(res=>{
                 console.log(res);
                 if(res===200){
                    this.$message.success('活动取消成功！');
                    this.getActivity(1)
                 }
             })
     }
   },
   created(){
        this.getActivity(1)
   },
   watch:{
        activeName2:function(){
            if(this.activeName2==='second'){
                this.getActivity(2)
            }
        }
   }
}
</script>

<style lang="css">
  .commerTabs #tab-link{
    background-color: #15bafe;
    color: #fff;
  }
  .commer_btn_submit{

  }
  .commerTabs .el-tabs__header{
    margin-bottom: 0 !important;
  }
  .commerTabs .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background-color: #fff;
    color: #222 !important;
    font-size: 14px;
  }
  .commerTabs .el-tabs--card>.el-tabs__header .el-tabs__item{
    font-size: 14px;
    color: #9f9f9f;
  }
.commerTabs>.el-tabs>.el-tabs__content{
  background-color: #fff;
}
.commerTabs>.el-tabs>.el-tabs__header{
  margin: 0;
}
.commer_img_td>div>.el-button{
  width: 60px;
  padding: 6px 6px;
  font-size: 12px;
  border-radius: 7px;
}
.flex_commer_td>.el-button--text{
  padding: 0px;
  font-size: 12px;
}
.commercialActivity{
  position: relative;
}
.commer_img_td>img{
  position: relative;
  top:7px;
}
.commer_odiv_div{
  border:1px solid #dedede;
  position:relative;
  border-top: none;
}
.flex_commer_td>p{
  cursor: pointer;
}
.flex_commer_td{
  display: flex;
  padding: 15px;
  text-align: center;
  justify-content: space-between;
}
.commer_table>tr>td{
  text-align: center;
}
.commer_table{
  width: 100%;
}
.table_title_commer>td{
  font-size: 16px;
  font-weight: 500;
  padding: 15px;
}
.commerTabs{
  width: 1200px;
  margin: 0 auto;
  position: relative;
}
.commer_odiv_div .el-pagination{
    text-align:center;
}

.el-button--black{
    color:#fff;
    background:#000;
    border-color:#000;
}
</style>
