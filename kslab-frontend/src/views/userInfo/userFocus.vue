<template>

  <div class="appBackground">
    <!--个人页面头部-->
    <userInfoHeader-div></userInfoHeader-div>

    <div class="focus_bg width_1200">

      <!--左侧盒子-->
      <div class="focus">
        <div class="focus_header">
          <div class="focus_title"><span><img src="/static/img/icon/focus_title.png" alt=""></span>我的关注</div>
        </div>

        <div class="focus_box">
          <ul>
            <li v-for="(item,index) in followData"  :key="index">
              <div class="focus_box_left">
                <div class="focus_box_avatar" @click="JumpOther(index)"><img :src="item.avatar" alt=""></div>
                <div class="focus_box_avatar_text">
                  <h4 @click="JumpOther(index)">{{item.nickname}}</h4>
                  <p>{{item.focus}}关注者</p>
                  <div class="focus_box_center">{{item.signature}}</div>
                </div>
              </div>

              <div class="focus_box_right">
                <div class="texting"><i class="icon icon-ziyuan36"></i>发私信</div>
                <div class="unsubscribe" @click="handleunfollow(item.uid,index)"><i class="el-icon-error"></i>取消关注</div>
              </div>
            </li>

          </ul>

        </div>


        <!--分页符-->
        <div class="focus_box_bottom">
          <el-pagination
            @current-change="handleCurrentChange"
            layout="prev, pager, next"
           :total="total">
          </el-pagination>
        </div>


        <!--取消关注弹出框-->
        <unsubscribeModal-Div v-if="unsubscribeModal"></unsubscribeModal-Div>

    </div>

      <!--右侧盒子-->
      <div class="focus_right">
        <div>
          <p>关注了</p>
          <span>{{follow}}</span>
        </div>

        <div>
          <p>关注者</p>
          <span>{{focus}}</span>
        </div>
      </div>


    </div>
    <!--侧边悬浮框-->
    <floating-div></floating-div>

  </div>

</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"

  import unsubscribeModalDiv from "../userInfo/unsubscribeModal"

  export default {
    data(){
      return{
        unsubscribeModal: false,
        followData:[],
        allData:{},
        follow:null,
        focus:null,
        total:null,
        currentPage:null,
        page:1,
        size:8
      }
    },
    mounted(){
      // console.log(window.localStorage.getItem('token'))
      const param = {
        page:this.page,
        size:this.size
      }
      this.getList(param);
      //获取关注与被关注总数
      this.getFollowList();
    },
    methods:{
      //获取关注列表
      getFollowList(){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/followNum',{
            token:window.localStorage.getItem('token'),
        })
        .then((res) => {
            console.log(res.data.data)
            this.follow = res.data.data.follow;
            this.focus = res.data.data.focus;
        })
      },
      getList(param){
        this.HttpClient.post('/web/user/followList',param).then((res) => {
            console.log(res)
            this.followData = res.data.data.data;
            this.total = res.data.data.total;
            // this.pageCount = Math.ceil(res.data.data.data.length/this.size);
            for(var i = 0; i < this.followData.length;i++){
                  this.followData[i].avatar = this.request.picUrl+this.followData[i].avatar;         
              }
        })
      },

      //点击取消关注
      handleunfollow(uid,index){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/user/followCancel',{
            token:window.localStorage.getItem('token'),
            cancel_uid:uid
        })
        .then((res) => {
            console.log(res)
            if(res.data.msg === 200){
              this.followData.splice(index,1);
              this.follow = this.follow-1
            }else{
              this.$message.error(res.data.msg);
            }
        })
      },
      //跳转他人主页
      JumpOther(index){
        console.log(this.followData[index].uid)
        this.$router.push({
          path:'/home/others',
          query:{
            others:this.followData[index].uid
          }
        })
      },
      handleCurrentChange(value){
        console.log(value)
        this.currentPage = parseInt(value);
        let param = {
          page: this.currentPage,
          size:2
        }
        this.getList(param);
      }
    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      unsubscribeModalDiv
    }
  }
</script>

<style scoped src="../../assets/css/userFocus.css">

</style>
