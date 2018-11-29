<template>

  <div class="appBackground">
    <!--个人页面头部-->
    <userInfoHeader-div></userInfoHeader-div>

    <div class="shopping width_1200">
      <!--tab页-->
      <!--<el-checkbox-group v-model="checkList">-->
        <el-tabs v-model="activeName" type="border-card" @tab-click="handleClick">
          <el-tab-pane label="已完成订单" name="completeOrder">
            <div class="completeOrder">
              <div class="hd">
                <div class="info">信息</div>
                <div class="price">单价</div>
                <div class="num">数量</div>
                <div class="all">小计</div>
                <div class="stauts">状态</div>
                <div class="do">操作</div>
              </div>
              <div class="orderlist" v-for="(item,index) in tableList1" :key="index">
                <!-- <div class="time">2018-11-05 14:23</div> -->
                <div class="data">
                  <div class="info_data">
                    <el-checkbox class="chek" v-model="checkList[index].checkboxVal" @change="checkChange(index)"></el-checkbox>
                    <div>
                      <!-- <p style="font-size:12px;color:#a0a0a0;">订单编号：23425324235</p> -->
                      <div class="time">
                        <p style="font-size:12px;color:#a0a0a0;margin-right:15px;">订单编号：{{item.order_no}}</p>
                        <p style="font-size:12px;color:#a0a0a0;">下单时间： {{item.created_at}}</p>
                      </div>
                      <div class="btn">
                        <div class="center">
                          <img class="img" :src="item.product_picture" alt="" @click="ducinfoRouter(index)">
                        </div>
                        <div class="right">
                          <p class="pone" @click="ducinfoRouter(index)">{{item.product_title}}</p>
                          <p class="ptwo">商品编号：{{item.product_asin}}</p>
                          <div class="business">
                            <span @click="alothersRouter(index)">{{item.product_nickname}}</span>
                            <div class="contact">
                              <img src="/static/img/icon/others.png" alt="">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="price_data">
                    <div style="height:60px;color:#666666;">￥{{item.price}}</div>
                  </div>
                  <div class="num_data">
                    <div style="height:60px;color:#666666;">x{{item.quantity}}</div>
                  </div>
                  <div class="all_data">
                    <div style="height:60px;color:#666666;">￥{{item.total_price}}</div>
                  </div>
                  <div class="stauts_data">
                    <div style="height:60px;color:#15bafe;" v-if="item.is_comment == 1">已评价</div>
                    <div style="height:60px;color:#fb3939;" v-if="item.is_comment == 0" @click="evaluate(index)">未评价</div>
                    <div style="height:60px;color:#666666;" v-if="false" >商家已退款</div>
                  </div>
                  <div class="do_data">
                    <div class="delet" style="height:60px;line-height: 60px;margin-top:35px;color:#666666;" @click="deleteOrder(index)">删除</div>
                  </div>
                </div>
              </div>

            </div>
            <!-- <el-table ref="multipleTable" :data="tableData3" tooltip-effect="dark" style="width: 100%" @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="55"></el-table-column>
              <el-table-column label="信息" width="120">
                <template slot-scope="scope">{{ scope.row.date }}</template>
              </el-table-column>
              <el-table-column prop="name" label="单价" width="120"></el-table-column>
              <el-table-column  prop="address" label="数量"></el-table-column>
              <el-table-column prop="name" label="单价" width="120"></el-table-column>
            </el-table> -->
            <div class="bot">
              <div style="margin-top: 20px">
                <el-button type="primary" @click="allCheck">全选</el-button>
                <el-button @click="deleteSle">删除选中</el-button>
              </div>
              <el-pagination
                @current-change="handleCurrentChange"
                :page-size="1"  
                layout="prev, pager, next"
                :total="total" >
              </el-pagination>
            </div>

          </el-tab-pane>


          <!--配送信息-->

        <el-tab-pane label="待收货订单" name="distribution">
          <div class="completeOrder">
              <div class="hd">
                <div class="info">信息</div>
                <div class="price" style="width:11%">单价</div>
                <div class="num" style="width:11%">数量</div>
                <div class="all" style="width:11%">小计</div>
                <div class="stauts" style="width:11%">状态</div>
                <div class="do" style="width:16%">操作</div>
              </div>
              <div class="orderlist" v-for="(item,index) in tableList2" :key="index">
                <!-- <div class="time">2018-11-05 14:23</div> -->
                <div class="data">
                  <div class="info_data" style="padding-left:10px;">
                    <div>
                      <!-- <p style="font-size:12px;color:#a0a0a0;">订单编号：23425324235</p> -->
                      <div class="time">
                        <p style="font-size:12px;color:#a0a0a0;margin-right:15px;">订单编号：{{item.order_no}}</p>
                        <p style="font-size:12px;color:#a0a0a0;">下单时间： {{item.created_at}}</p>
                      </div>
                      <div class="btn">
                        <div class="center">
                          <img class="img" :src="item.product_picture" alt="" @click="ducInfoRouter(index)">
                        </div>
                        <div class="right">
                          <p class="pone" @click="ducInfoRouter(index)">{{item.product_title}}</p>
                          <p class="ptwo">商品编号：{{item.product_asin}}</p>
                          <div class="business">
                            <span @click="alothersRouter(index)">{{item.product_nickname}}</span>
                            <div class="contact">
                              <img src="/static/img/icon/others.png" alt="">
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="price_data">
                    <div style="height:60px;color:#666666;">￥{{item.price}}</div>
                  </div>
                  <div class="num_data">
                    <div style="height:60px;color:#666666;">x{{item.quantity}}</div>
                  </div>
                  <div class="all_data">
                    <div style="height:60px;color:#666666;">￥{{item.total_price}}</div>
                  </div>
                  <div class="stauts_data">
                    <div style="height:60px;color:#15bafe;" v-if="item.status == 2">已发货</div>
                    <div style="height:60px;color:#fb3939;" v-if="item.status == 1">未发货</div>
                    <div style="height:60px;color:#666666;" v-if="item.status == 55">商家已退款</div>
                  </div>
                  <div class="do_data">
                    <div class="operation" style="height:60px;line-height: 60px;margin-top:35px;color:#666666;">
                      <span style="text-decoration:underline;" v-if="item.status == 2" @click="confirmReceipt(index)">确认收货</span>
                      <span style="text-decoration:underline;" v-if="item.status == 2" @click="logisticsInfo(index)">查看物流</span>
                      <span style="text-decoration:underline;" v-if="item.status == 55">确认已退款</span>
                    </div>
                  </div>
                </div>
              </div>

            </div>

        </el-tab-pane>

      </el-tabs>
      <!--</el-checkbox-group>-->

    </div>
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
    <!-- 确认收货弹窗 -->
    <el-dialog :visible.sync="confirmReceiptVisible" width="25%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确定已经收到货了吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="confirmReceiptVisible = false">取消</el-button>
        <el-button type="primary" @click="sure">确认</el-button>
      </div>   
    </el-dialog>
    <!-- 商品物流 -->
    <el-dialog :visible.sync="logisticsVisible" width="35%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="commodity_info">
        <img :src="product_picture" alt="">
        <div>
          <P style="font-size:14px;color:#000;margin-bottom:9px;">{{product_title}}</P>
          <P style="font-size:12px;color:#666666">货运单号：{{LogisticCode}}</P>
          <P style="font-size:12px;color:#666666">承运人：{{ShipperName}}</P>
        </div>
      </div>
      <div class="til">物流动态</div>
      <div class="time_drs">
        <div v-for="(item,index) in logistics" :key="index" :class="index == (logistics.length-1) ? 'noc':'gl'">
          <div class="spot_blue" v-if="index == 0"></div>
          <div class="spot_gray" v-if="index !== 0"></div>
          <p style="text-align: start">{{item.AcceptTime}}</p>
          <p>{{item.AcceptStation}}</p>
        </div>
      </div>
      
    </el-dialog>

    <!--侧边悬浮框-->
    <floating-div></floating-div>
    <!-- 确认删除弹窗 -->
    <el-dialog :visible.sync="deleteVisible" width="20%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确认删除这个订单吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="deleteVisible = false">取消</el-button>
        <el-button type="primary" @click="sureDelete">确认</el-button>
      </div>   
    </el-dialog>
    <!-- 确认删除选中弹窗 -->
    <el-dialog :visible.sync="deletesleVisible" width="20%" center>
      <div class="logo">
        <img src="/static/img/logo/logo_sm.png" alt="">
      </div>
      <div class="tub">
        <img src="/static/img/icon/notPass.png" alt="">
        <p>确认删除选中的订单吗？</p>
      </div>
      <div class="btn3">
        <el-button @click="deletesleVisible = false">取消</el-button>
        <el-button type="primary" @click="sureDeleteSle">确认</el-button>
      </div>   
    </el-dialog>
  </div>

</template>

<script>
  import FloatingDiv from "@/components/floating"
  import userInfoHeaderDiv from "@/components/userInfoHeader"

  // javascript
  import '../../assets/js/userInfo.js'
  export default {
    data(){
      return{
        product_title:'',
        product_picture:'',
        LogisticCode:null,
        ShipperName:null,
        currentPage:null,
        page: 1,
        size: 8,
        total:null,
        logistics:[],
        index:null, //确认收货时 存储的index值
        order_id:null,
        value1:null,
        textarea:'',
        deletesleVisible:false,
        deleteVisible:false,
        logisticsVisible:false,
        confirmReceiptVisible:false,
        centerDialogVisible: false,
        activeName: 'completeOrder',
        //全选
        // checked: false,
        deleteList:[],//需要删除的订单数组
        checkList: [],
        allCheckTip:0,//全选标记  为全选为0，全选为1

        evaluate_star: null,
        dialogImageUrl: '',
        dialogVisible: false,
        
        fileList: [],
        fileList2: [], //组件生成的filelist,
        beforeFileList: [], //上传之后，删除之前的fileList

        tableList1: [],
        tableList2:[],
        multipleSelection: [],
        oldOrder_id : null,
      }
    },
    created() {
        const param = {
          finish:true,
          page:this.page,
          size:this.size
        };
        this.getCompletedOrderList(param);
    },
    methods: {
      /****
       * 获取已完成订单列表
       * @param param
       */
      getCompletedOrderList(param) {
          this.HttpClient.post('/web/shopCart/lists',param).then(res =>{
            console.log(res)
            this.tableList1 = res.data.data.data;
            this.total =Math.ceil( res.data.data.total/8);
            var order_id = null;
            var id = null;
            for(var i = 0; i < this.tableList1.length;i++){
              console.log(this.tableList1[i])
                  // this.tableList1[i].product_picture = this.request.picUrl+JSON.parse(this.tableList1[i].product_picture)[0].path;
                  // this.tableList1[i].product_picture = this.request.picUrl+this.tableList1[i].product_picture.split(",")[0]
                  this.tableList1[i].checkboxVal = false;
                  order_id = this.tableList1[i].order_id;
                  id = i;
                  this.checkList.push({
                    checkboxVal:this.tableList1[i].checkboxVal,
                    order_id:order_id,
                    id:id
                  });
              }
              console.log(this.checkList)
          })
      },
      //完成订单的单个删除
      deleteOrder(index){
        this.deleteVisible = true;
        this.oldOrder_id = index
      },
      //跳转已完成订单中他人主页
      alothersRouter(index){
        console.log(this.tableList1[index].product_uid)
        this.$router.push({
          path:'/home/others',
          query:{
            others:this.tableList1[index].product_uid,
          }
        })
      },
      //跳转未完成订单中他人主页
      othersRouter(index){
        this.$router.push({
          path:'/home/others',
          query:{
            others:this.tableList2[index].product_uid,
          }
        })
      },
      //跳转未完成订单商品详情页
      ducInfoRouter(index){
        this.$router.push({
          path:'/home/product-detail/:id',
          params:{
            id:this.tableList2[index].product_id,
          }
        })
      },
      //跳转已完成订单商品详情页
      ducinfoRouter(index){
        this.$router.push({
          path:'/home/product-detail/:id',
          params:{
            id:this.tableList1[index].product_id,
          }
        })
      },
      //删除选中
      deleteSle(){
        console.log(this.deleteList.length)
        if(this.deleteList.length == 0){
          this.$message('您还未选择需要删除的订单')
        }else{
          this.deletesleVisible = true;
        }
      },
      //确认删除选中
      sureDeleteSle(){
        console.log(this.deleteList)
        this.HttpClient.post('/web/shopCart/orderDestroy',{
            order_id:JSON.stringify(this.deleteList)
          })
          .then((res) => {
            if(res.data.code === 200){
              this.$message.success(res.data.msg);
              //当删除成功后，重新请求接口进行赋值
               let param = {
                  page:this.currentPage,
                  size:8
               }
               this.getCompletedOrderList(param);
               this.deletesleVisible = false;
            }else{
              this.$message.error(res.data.msg);
            }
          })
      },
      //确认删除
      sureDelete(){
        this.HttpClient.post('/web/shopCart/orderDestroy',{
            order_id:JSON.stringify(this.tableList1[this.oldOrder_id].order_id)
          })
          .then((res) => {
            if(res.data.code === 200){
              this.$message.success(res.data.msg);
              this.tableList1.splice(this.oldOrder_id,1);
              this.deleteVisible = false;
            }else{
              this.$message.error(res.data.msg);
            }
          })
      },
      //单个选中状态改变回调
      checkChange(index){
        console.log(index)
        // var curLenght = this.deleteList.length;
        if(!this.checkList[index].checkboxVal){
          console.log('123')
          Array.prototype.sanchu = function(val) { 
            var index = this.indexOf(val); 
            if (index > -1) { 
              this.splice(index, 1); 
            } 
          }
          this.deleteList.sanchu(this.checkList[index].order_id);
        }else{
          console.log('456')
          this.deleteList.push(this.checkList[index].order_id);
        }
        console.log(this.checkList) 
        console.log(this.deleteList)
      },
      //全选
      allCheck(){
        if(this.allCheckTip == 0){
          this.deleteList = [];
          for(let i = 0;i<this.checkList.length;i++){
            this.checkList[i].checkboxVal = true;
            this.deleteList.push(this.checkList[i].order_id);
          }
          this.allCheckTip = 1;
          console.log(this.checkList)
          console.log(this.deleteList)
        }else if(this.allCheckTip == 1){
          for(let i = 0;i<this.checkList.length;i++){
            this.checkList[i].checkboxVal = false;
            this.deleteList = [];
          }
          this.allCheckTip = 0;
          console.log(this.checkList)
          console.log(this.deleteList)
        }
      },
      // 点击查看物流信息
      logisticsInfo(index){
        this.product_title = this.tableList2[index].product_title;
        this.product_picture = this.tableList2[index].product_picture;
        this.logisticsVisible = true;
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"web/shopCart/logisticsInfo",{
            token:window.localStorage.token,
            logistics_no:this.tableList2[index].logistics_no
          })
          .then((res) => {
            console.log(res);
            this.logistics = res.data.data.data.Traces.reverse();
            this.ShipperName = res.data.data.data.ShipperName;
            this.LogisticCode = res.data.data.data.LogisticCode;
            console.log(this.logistics)
          })
      },
      //点击确认收货
      confirmReceipt(index){
        this.confirmReceiptVisible = true;
        this.index = index;
      },
      //弹框最终确认收货
      sure(){
         this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"web/shopCart/checkArrival",{
            token:window.localStorage.token,
            order_id:this.tableList2[this.index].order_id
          })
          .then((res) => {
            if(res.data.msg === 200){
              this.$message.success(res.data.msg);
              console.log(res);
              this.confirmReceiptVisible = false;
            }else{
              this.$message.error(res.data.msg);
            }
          })
      },
      //评价
      evaluate(index){
        this.centerDialogVisible = true;
        this.order_id = this.tableList1[index].order_id;
      },
      //点击提交评论
      submit(){
        this.$ajax.post(this.request.axiosPort+this.request.axiosApi+"web/answers/create",{
            token:window.localStorage.token,
            source_id:this.order_id,
            content:this.textarea,
            score:this.value1,
            attachment:this.fileList,
            type:8
          })
          .then((res) => {
            this.$message.success(res.data.msg)
            console.log(res);
            this.centerDialogVisible = false;
          })
      },
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
              this.tableList2 = res.data.data.data;
              for(var i = 0; i < this.tableList2.length;i++){
                  this.tableList2[i].product_picture = this.request.picUrl+JSON.parse(this.tableList2[i].product_picture)[0].path;
              } 
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
      /***
       * 翻页功能
       * @param value
       */
      handleCurrentChange(value) {
        console.log(value)
        this.currentPage = parseInt(value);
        this.page = value
        let param = {
          page: this.currentPage,
          size:8
        }
        this.getCompletedOrderList(param);
      },


    },
    components:{
      FloatingDiv,
      userInfoHeaderDiv
    }
  }
</script>

<style src="../../assets/css/userShopping.css"></style>
<style scoped>
.hd{
  width: 100%;height: 40px;
  display: flex;
}
.info{
  width: 44%;text-align: center;line-height: 40px;
  color: #666666;
  background: #f4f4f4;
  /* border: 1px solid #000; */
}
.price, .num, .all, .stauts{
  width: 11%;text-align: center;line-height: 40px;
  color: #666666;
  background: #f4f4f4;
  /* border: 1px solid #000; */
}
.do{
  width: 16%;text-align: center;line-height: 40px;
  color: #666666;
  background: #f4f4f4;
}
.orderlist{
  border: 1px solid #e6e6e6;
  margin-top: 15px;
}
.time{
  display: flex;
  /* width: 100%;color: #666666;
  font-size: 14px;
  background: #f4f4f4;
  height: 30px;padding-left: 80px;
  line-height: 30px; */
}
.data{
  width: 100%;
  height: 131px;
  display: flex;
}
.delet:hover{
  color: #15bafe;
  cursor: pointer;
}
.info_data{
  display: flex;
  width: 44%;
  padding: 10px 0;
}
.price_data, .num_data, .all_data, .stauts_data {
   width: 11%;text-align: center;
   
}
.do_data{
  width: 16%;text-align: center;
}
.price_data, .num_data, .all_data, .stauts_data, .do_data>div{
  height: 60px;
  line-height: 60px;
  margin: auto 0;
  font-size: 14px;
  border-left: 1px solid #e6e6e6; 
}
.img{width: 120px;
  height: 90px;
  border: 1px solid #cfcfcf;
  margin-top: 3px;
}
.chek{
  margin: auto 30px;
}
.btn{
  display: flex;
}
.right{
  margin-left: 20px;
}
.pone{
  font-size:14px;
  color:#000;
  margin-bottom:10px;
  margin-top:5px;overflow: hidden;
  white-space: nowrap;width:255px;
  text-overflow: ellipsis;
}
.ptwo{
  font-size:12px;color:#666666;margin-bottom:10px;
}
.contact{
  display: flex;
  align-items: center;
}
.contact>img{
  width: 16px;
  height: 16px;
  margin: auto;
}
/* .contact{
  border: 1px solid #15bafe;
  border-radius: 3px;
  width: 78px;height: 22px;
  display: flex;align-items: center;
  padding: 0 5px;
}
.contact:hover{
  background: #15bafe;
}
.contact:hover .img_icon{
  width: 15px;
  height: 16px;
  background-image: url(/static/img/icon/shopping_service_hover.png);
  margin-right: 3px;
}
.contact:hover .contact-p{
  color:#fff;font-size: 12px;
}
.contact-p{color:#15bafe;font-size: 12px;} */
.img_icon{
  width: 15px;
  height: 16px;
  background-image: url(/static/img/icon/shopping_service.png);
  margin-right: 3px;
}
.bot{
  display: flex;justify-content: space-between;
  align-items: center;
  }
  .business{
    display: flex;
    align-items: flex-end;
    /* justify-content: flex-end; */
  }
  .business>span{
    font-size: 12px;color: #666666;
     text-decoration:underline;
    margin-right: 15px; 
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
  .operation>span:hover{
    color: #15bafe;
    cursor: pointer;
  }
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
  .commodity_info{
    display: flex;
    margin-top: 15px;
  }
  .commodity_info>img{
    width: 65px;height: 65px;border: 4px solid #e7e7e7;
    margin-right: 15px;
  }
  .til{
    margin-top:17px;
    width: 70px;
    height: 25px;
    border-left: 1px solid #e7e7e7;
    border-right: 1px solid #e7e7e7;
    border-top: 1px solid #e7e7e7;
    text-align: center;
    line-height: 25px;
    color: #000;
    font-size: 12px;
  }
  .time_drs{
    border-bottom: 1px solid #e7e7e7;
    border-top:  1px solid #e7e7e7;
    padding: 0 10px;
  }
  .time_drs>div{
    height: 50px;
  }
  .gl{
    position: relative;
    border-left: 2px solid #f0f0f0;
    font-size: 12px;
    padding-left: 20px;
  }
  .time_drs>div>p:nth-child(1){
    color: #000;
  }
  .time_drs>div>p:nth-child(2){
    color: #666666;
  }
  .time_drs>div:nth-child(1)>p{
    color: #15bafe !important;
  }
  .time_drs>div:nth-child(1){
    margin-top: 15px!important;
  }
  .spot_blue{
    width: 6px;
    height: 6px;
    background: #15bafe;
    border-radius: 50%;
    position: absolute;top: 0px;left:-4px;
  }
  .spot_gray{
    width: 6px;
    height: 6px;
    background: #d9d9d9;
    border-radius: 50%;
     position: absolute;top: 0px;left:-4px;
  }
  .noc{
    position: relative;
    border-left: 2px solid #fff;
    font-size: 12px;
    padding-left: 20px;
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
  @media screen and (max-width: 1200px) {
    .pone{
      font-size:14px;
      color:#000;
      margin-bottom:10px;
      margin-top:5px;overflow: hidden;
      white-space: nowrap;width:209px;
      text-overflow: ellipsis;
    }
    .ptwo{
      font-size:12px;color:#666666;margin-bottom:10px;
      width: 209px;
    }
  
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


