<template>

  <div class="appBackground">
    <!--个人页面头部-->
    <userInfoHeader-div></userInfoHeader-div>

    <div class="userActivities width_1200">

      <el-tabs v-model="activeName2" type="card" @tab-click="handleClick">
        <el-tab-pane label="长期活动" name="long">

          <div class="userLong">
            <div class="userActivities_title">
              <div>活动详情</div>
              <div>价格</div>
              <div>购买票数</div>
              <div>已使用</div>
              <div>状态</div>
              <div>操作</div>
            </div>

            <div class="userActivities_list" v-for="(item,index) in tabList1" :key="index">
              <div class="userActivities_details">
                <div class="userActivities_img"><img src="/static/img/userActivities_img.png" alt=""></div>
                <div class="userActivities_text">
                  <h4>{{item.title}}</h4>
                  <p>商家：{{item.company_name}}</p>
                  <p>电话：{{item.telphone}}</p>
                  <p>地址：{{item.address}}</p>
                </div>
              </div>

              <div class="userActivities_money">&yen;{{item.total_price}}</div>

              <div class="userActivities_buy">{{item.quantity}}</div>

              <div class="userActivities_use">{{item.use_num}}</div>

              <div :class="choiceUrl(index)">
                <p></p>
                <span v-if="item.mm_status == 0">已退款</span>
                <span v-if="item.mm_status == 1">进行中</span>
                <span v-if="item.mm_status == 2">已用完</span>
                <span v-if="item.mm_status == 3">已取消</span>
                <span v-if="item.mm_status == 4">已结束</span>
                <!-- <span v-if="going(index)">进行中</span>
                <span v-if="runOut(index)">已用完</span>
                <span v-if="item.active_status == 4">已取消</span>
                <span v-if="item.refund == 1">已退款</span>
                <span v-if="end(index)">已结束</span> -->
              </div>

              <div class="userActivities_operating">
                <el-button class="userOperating_btm_view" type="text" @click="seeCod(index)">查看活动码</el-button>
                <el-button class="userOperating_btm_comment" type="text" :class="item.use_num > 0 ? 'yes':'no'" @click="evaluate(index)">评论</el-button>
                <el-button class="userOperating_btm_refund" type="text" :class="item.quantity > item.use_num > 0 ? 'yes':'no'" @click="refund(index)">申请退款</el-button>
                <el-button class="userOperating_btm_delete" type="text" :class="item.quantity == item.use_num > 0 ? 'no':'yes'" @click="deleteact(index)">删除</el-button>
              </div>

            </div>
          </div>

        </el-tab-pane>

        <el-tab-pane label="定时活动" name="timing">

          <div class="userTiming">
            <div class="userActivities_title">
              <div>活动详情</div>
              <div>开始时间</div>
              <div>价格</div>
              <div>购买票数</div>
              <div>已使用</div>
              <div>状态</div>
              <div>操作</div>
            </div>

            <div class="userActivities_list">
              <div class="userActivities_details">
                <div class="userActivities_img"><img src="/static/img/userActivities_img.png" alt=""></div>
                <div class="userActivities_text">
                  <h4>阿姆斯特朗回旋撤展活动</h4>
                  <p>商家：李超超超好</p>
                  <p>电话：023-12345678</p>
                  <p>地址：重庆渝中区大坪英利国际2-11</p>
                </div>
              </div>

              <div class="userActivities_time userTiming_three_time">2018/08/31</div>

              <div class="userActivities_money">&yen;600</div>

              <div class="userActivities_buy">12</div>

              <div class="userActivities_use">6</div>

              <div class="userActivities_status userStatus_conduct">
                <p></p>
                <span>进行中</span>
              </div>

              <div class="userActivities_operating">
                <el-button class="userOperating_btm_view" type="text">查看活动码</el-button>
                <el-button class="userOperating_btm_comment" type="text">评论</el-button>
                <el-button class="userOperating_btm_refund" type="text">申请退款</el-button>
                <el-button class="userOperating_btm_delete" type="text" disabled>删除</el-button>
              </div>

            </div>

            <!-- <div class="userActivities_list">
              <div class="userActivities_details">
                <div class="userActivities_img"><img src="/static/img/userActivities_img.png" alt=""></div>
                <div class="userActivities_text">
                  <h4>阿姆斯特朗回旋撤展活动</h4>
                  <p>商家：李超超超好</p>
                  <p>电话：023-12345678</p>
                  <p>地址：重庆渝中区大坪英利国际2-11</p>
                </div>
              </div>

              <div class="userActivities_time userTiming_three_ten">2018/08/31</div>

              <div class="userActivities_money">&yen;600</div>

              <div class="userActivities_buy">12</div>

              <div class="userActivities_use">6</div>

              <div class="userActivities_status userStatus_useUp">
                <p></p>
                <span>已用完</span>
              </div>

              <div class="userActivities_operating">
                <el-button class="userOperating_btm_view" type="text" disabled>查看活动码</el-button>
                <el-button class="userOperating_btm_comment" type="text">评论</el-button>
                <el-button class="userOperating_btm_refund" type="text" disabled>申请退款</el-button>
                <el-button class="userOperating_btm_delete" type="text">删除</el-button>
              </div>

            </div> -->

            <!-- <div class="userActivities_list">
              <div class="userActivities_details">
                <div class="userActivities_img"><img src="/static/img/userActivities_img.png" alt=""></div>
                <div class="userActivities_text">
                  <h4>阿姆斯特朗回旋撤展活动</h4>
                  <p>商家：李超超超好</p>
                  <p>电话：023-12345678</p>
                  <p>地址：重庆渝中区大坪英利国际2-11</p>
                </div>
              </div>

              <div class="userActivities_time">2018/08/31</div>

              <div class="userActivities_money">&yen;600</div>

              <div class="userActivities_buy">12</div>

              <div class="userActivities_use">6</div>

              <div class="userActivities_status userStatus_cancel">
                <p></p>
                <span>已取消</span>
              </div>

              <div class="userActivities_operating">
                <el-button class="userOperating_btm_view" type="text" disabled>查看活动码</el-button>
                <el-button class="userOperating_btm_comment" type="text" disabled>评论</el-button>
                <el-button class="userOperating_btm_refund" type="text" disabled>申请退款</el-button>
                <el-button class="userOperating_btm_delete" type="text">删除</el-button>
              </div>

            </div> -->

            <!-- <div class="userActivities_list">
              <div class="userActivities_details">
                <div class="userActivities_img"><img src="/static/img/userActivities_img.png" alt=""></div>
                <div class="userActivities_text">
                  <h4>阿姆斯特朗回旋撤展活动</h4>
                  <p>商家：李超超超好</p>
                  <p>电话：023-12345678</p>
                  <p>地址：重庆渝中区大坪英利国际2-11</p>
                </div>
              </div>

              <div class="userActivities_time">2018/08/31</div>

              <div class="userActivities_money">&yen;600</div>

              <div class="userActivities_buy">12</div>

              <div class="userActivities_use">6</div>

              <div class="userActivities_status userStatus_refund">
                <p></p>
                <span>已退款</span>
              </div>

              <div class="userActivities_operating">
                <el-button class="userOperating_btm_view" type="text" disabled>查看活动码</el-button>
                <el-button class="userOperating_btm_comment" type="text">评论</el-button>
                <el-button class="userOperating_btm_refund" type="text" disabled>申请退款</el-button>
                <el-button class="userOperating_btm_delete" type="text">删除</el-button>
              </div>

            </div> -->

            <!-- <div class="userActivities_list">
              <div class="userActivities_details">
                <div class="userActivities_img"><img src="/static/img/userActivities_img.png" alt=""></div>
                <div class="userActivities_text">
                  <h4>阿姆斯特朗回旋撤展活动</h4>
                  <p>商家：李超超超好</p>
                  <p>电话：023-12345678</p>
                  <p>地址：重庆渝中区大坪英利国际2-11</p>
                </div>
              </div>

              <div class="userActivities_time">2018/08/31</div>

              <div class="userActivities_money">&yen;600</div>

              <div class="userActivities_buy">12</div>

              <div class="userActivities_use">6</div>

              <div class="userActivities_status userStatus_over">
                <p></p>
                <span>已结束</span>
              </div>

              <div class="userActivities_operating">
                <el-button class="userOperating_btm_view" type="text" disabled>查看活动码</el-button>
                <el-button class="userOperating_btm_comment" type="text">评论</el-button>
                <el-button class="userOperating_btm_refund" type="text" disabled>申请退款</el-button>
              <el-button class="userOperating_btm_delete" type="text" @click="deleteModal =! deleteModal">删除</el-button>
              </div>

            </div> -->

          </div>

        </el-tab-pane>
        <deleteModal v-if="deleteModal"></deleteModal>
        <refundModal v-if="refundModal" ></refundModal>
        <evaluationModal v-if="evaluationModal"></evaluationModal>
        <activityCodeModal v-if="activityCodeModal" :codNumber="codNumber"></activityCodeModal>
      </el-tabs>

    </div>

    <!--侧边悬浮框-->
    <floating-div></floating-div>
    <!-- 评价弹框 -->
    <el-dialog title="评价" :visible.sync="centerDialogVisible" width="40%" center>
      <el-input type="textarea" :rows="2" placeholder="请输入评价内容" v-model="textarea"></el-input>
      <div class="pic_hd">
        <img style="margin-right:10px;" src="/static/img/icon/img.png" alt="">
        <span style="margin-right:5px;">图片</span>
        <span style="font-size:12px;color:#737373;">（最多五张，每张不超过1M,格式限于:jpeg,png,jpg）</span>
      </div>
      <div class="up_img">
          <el-upload
            action="http://test.kslab.com/api/article/null"
            list-type="picture-card"
            ref="uploads"
            :limit="5"
            :multiple="true"
            :on-error="hanldeUpError"
            :on-success="handleUpSuccess"
            :before-upload="handleBeforeUpload"
            :before-remove="handleBeforeRemove"
            :on-change="handleUpChange"
            :on-remove="handleRemove">
            <i class="el-icon-plus"></i>
          </el-upload>
          <div class="up_remark" :style="fileList2.length>0?{display:'none'}:{}">
          </div>
        </div>
        <div class="pin_sub">
          <div class="block">
            <span class="demonstration">评分：</span>
            <el-rate v-model="value1"></el-rate>
          </div>
          <div class="btn2">
            <el-button @click="centerDialogVisible == true">取消</el-button>
            <el-button type="primary" @click="submit">提交</el-button>
          </div>
        </div>
    </el-dialog>
    <!-- 确认删除弹窗 -->
    <el-dialog :visible.sync="deleteVisible" width="25%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确认删除吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="deleteVisible == true">取消</el-button>
        <el-button type="primary" @click="sureDelete">确认</el-button>
      </div>   
    </el-dialog>
    <!-- 申请退款弹窗 -->
    <el-dialog :visible.sync="refundVisible" width="25%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>共有{{surplusTicket}}张，{{refundAmount}}元可退。</p>
        <p>是否确定退款？</p>
      </div>
      <div class="btn3">
        <el-button @click="deleteVisible == true">取消</el-button>
        <el-button type="primary" @click="sureRefund">确认</el-button>
      </div>   
    </el-dialog>
  </div>

</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"

  import deleteModal from "../../components/deleteModal"
  import refundModal from "../userInfo/refundModal"
  import evaluationModal from "./evaluationModal"
  import activityCodeModal from "../userInfo/activityCodeModal"

  export default {
    data(){
      return{
        refundAmount:null,//需退款金额
        surplusTicket:null,//剩余票数
        index:null,//删除index/退款index
        active_id:null, 
        fileList: [],
        fileList2: [], //组件生成的filelist,
        beforeFileList: [], //上传之后，删除之前的fileList
        value1:null,
        textarea:'',
        refundVisible:false,
        deleteVisible:false,
        centerDialogVisible:false,
        codNumber:null,  //活动编码
        tabList1:[],
        tabList2:[],
        activeName2: 'long',
        deleteModal: null,
        refundModal: null,
        evaluationModal: null,
        activityCodeModal: null,
      }
    },
    mounted(){
      //获取长期活动列表
      this.HttpClient.post('/web/userActives/lists',{
        active_date:false
      })
      .then((res) => {
          console.log(res)
          this.tabList1 = res.data.data.data;
      })
    },
    methods: {
      //根据状态选择状态背景
      choiceUrl(index){
        var status = this.tabList1[index].mm_status;
        if(status == 0){
          return 'userActivities_status userStatus_refund'
        }else if(status == 1){
          return 'userActivities_status userStatus_conduct'
        }else if(status == 2){
          return 'userActivities_status userStatus_useUp'
        }else if(status == 3){
          return 'userActivities_status userStatus_cancel'
        }else if(status == 4){
          return 'userActivities_status userStatus_over'
        }
      },
      //查看活动编码
      seeCod(index){
        this.activityCodeModal =! this.activityCodeModal;
        console.log(this.tabList1[index].code)
        this.codNumber = this.tabList1[index].code;
        
      },
      // handleClick(tab, event) {
      // },
      //评价
      evaluate(index){
        this.centerDialogVisible = true;
        this.active_id = this.tabList1[index].active_id;
      },
      //点击提交评论
      submit(){
        console.log('评论')
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"web/answers/create",{
            token:window.localStorage.token,
            source_id:this.active_id,
            content:this.textarea,
            score:this.value1,
            attachment:this.fileList,
            type:4
          })
          .then((res) => {
            this.$message.success(res.data.msg)
            console.log(res);
            this.centerDialogVisible = false;
          })
      },
      //删除报名的活动
      deleteact(index){
        this.deleteVisible = true;
        this.index = index;
      },
      //确认删除
      sureDelete(){
        this.HttpClient.post('/web/userActives/logicDestroy',{
          id:this.tabList1[this.index].id
        })
        .then((res) => {
            console.log(res)
            this.$message.success(res.data.msg)
            this.tabList1.splice(this.index,1)
            this.deleteVisible = false;
        })
      },
      // 申请退款
      refund(index){
        this.surplusTicket = this.tabList1[index].quantity - this.tabList1[index].use_num; //余票
        this.refundAmount = this.surplusTicket*this.tabList1[index].price; //需退钱
        this.index = index;
        this.refundVisible = true;
      },
      //确认退款
      sureRefund(){
        this.$message('没有退款接口');
        this.refundVisible = false;
      },
      // 弹框
      hanldeUpError(err, file, fileList) {
        this.$message.error(err);
      },
      handleUpSuccess(response, file, fileList){
        this.beforeFileList = fileList;
      },
      handleUpChange(file, fileList) {
        
        this.fileList2 = fileList;
      },
      async handleBeforeRemove(file, fileList) {
        
      },
      handleBeforeUpload(file) {
        
        if(file.size/1024<=1024 && (file.type === 'image/jpg' || file.type === 'image/jpeg' || file.type === 'image/png')){
          var timestamp=new Date().getTime(); //当前时间戳
          var FromData = new FormData()
          //评价上传图片接口
          FromData.append('token', window.localStorage.token)
          FromData.append('images', file)
          FromData.append('serial_number',timestamp)
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'actives/answersAttachment', FromData)
            .then((res) => {
              console.log(res)
              if (res.data.code === 200) {
                    this.fileList.push(res.data.path)
                    this.$message.success(res.data.msg)   
                  } else {
                    this.$message.error(res.data.msg)
                    console.log(res.data.msg)
                    return false
                  }
                  console.log(this.fileList)
            })
        }else{
          this.$message.warning('图片大于1M或图片格式不正确')
          return false;
        }

      },
      handleClick(tab, event) {
        this.indexLength = tab.index
        if(tab.index == 0){
          console.log("0")
        }
        else if(tab.index == 1){
          //获取待收货订单
           this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'web/shopCart/lists',{
              token:window.localStorage.token,
              finish:false
           })
            .then((res) => {
              console.log(res)
              this.tableList2 = res.data.data.data
            })
        }

      },
      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },

      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv,
      deleteModal,          // 删除
      refundModal,          // 退款
      evaluationModal,         // 评论
      activityCodeModal,    // 活动码

    }
  }
</script>

<style scoped src="../../assets/css/userActivities.css"></style>
<style scoped>
  .userActivities .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background-color: #fff;
    color: #222;
    font-size: 18px;
  }
  .userActivities .el-tabs--card>.el-tabs__header .el-tabs__item{
    color: #9f9f9f;
    font-size: 18px;
    background-color: #ededed;
  }
  .userActivities .el-tabs__header{
    margin-bottom: 0 !important;
  }
  .pic_hd{
    display: flex;align-items:flex-end;
  }
  .up_img{
    border:1px dashed  #dcdcdc;
    padding-top:10px;
    padding: 10px 10px 10px 10px;
  }
  .pic_hd{
    margin: 5px 0;
  }
  .block{
    display: flex;
  }
  .pin_sub{
    margin-top: 20px;
    display: flex;justify-content: space-between;
    align-items: center;
  }
  .yes{
    color: #409EFF !important;
  }
  .no{
    color:#cccccc !important;
    pointer-events:none;
    
  }
  .no:hover{cursor:not-allowed;}
  .logo>img{
    width: 90px;height: 15px;
  }
  .tub{
    text-align: center;
  }
  .tub>img{
    width: 80px;height: 80px;
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
