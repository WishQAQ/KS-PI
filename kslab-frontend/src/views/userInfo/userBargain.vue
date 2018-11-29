<template>
    <div class="appBackground">

      <!--个人页面头部-->
      <userInfoHeader-div></userInfoHeader-div>

      <div class="userBargain width_1200">

        <el-tabs v-model="activeName2" type="card" @tab-click="handleClick">
          <el-tab-pane label="商品管理" name="commodity">

            <div class="userBargain_commodity">
              <div class="userBargain_title">
                <div>商品</div>
                <div>
                  <el-select @change="handleStockChange" v-model="stockValue" placeholder="库存数量">
                    <el-option
                      v-for="item in stockOptions"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </div>
                <div>
                  <el-select @change="handlePriceChange" v-model="priceValue" placeholder="单价">
                    <el-option
                      v-for="item in priceOptions"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </div>
                <div>
                  <el-select @change="handleScoreChange" v-model="scoreValue" placeholder="评分">
                    <el-option
                      v-for="item in scoreOptions"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </div>
                <div>
                  <el-select @change="handleStatusChange" v-model="statusValue" placeholder="状态">
                    <el-option
                      v-for="item in statusOptions"
                      :key="item.value"
                      :label="item.label"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </div>
                <div>操作</div>
              </div>


              <div class="userBargain_main_list" v-for="(item, index) in marketData" :key="index">
                <div>
                  <div class="userBargain_list_img"><img :src="Tools.handleImg(item.show_picture?item.show_picture[0].path:[])" alt=""></div>
                  <div class="userBargain_list_text">
                    <h4>{{item.title}}</h4>
                    <p>{{item.description}}</p>
                  </div>
                </div>
                <div>{{item.stock}}</div>
                <div>&yen;{{item.price}}</div>
                <div>
                  <el-rate
                    v-bind:value="item.score/2"
                    disabled
                    :colors="['#15bafe','#15bafe','#15bafe']"
                    score-template="{value}">
                  </el-rate>
                </div>
                <div>
                  <span><img :src="item.status===1?'/static/img/icon/user_by.png':
                                    item.status===2?'/static/img/icon/userActivitier_useUp.png':
                                    item.status===3?'/static/img/icon/user_wait.png':
                                    item.status===4?'/static/img/icon/userActivitier_cancel.png':''
                    " alt=""></span>
                  <p>{{item.status===1?'正常':item.status===2?'已下架':item.status===3?'待审核':item.status===4?'未通过':''}}</p>
                </div>
                <div class="userBargain_operating">
                  <div @click="lowerModal(item.asin)" v-if="item.status===1">
                    <div class="userBargain_operating_obtained"></div>
                    <span>下架</span>
                  </div>
                  <div @click="handleJumpToComment(item.asin)" v-if="item.status===1 || item.status===2">
                    <div class="userBargain_operating_evaluation"></div>
                    <span>查看评价</span>
                  </div>
                  <div @click="handleJumpEdit(item.asin)" v-if="item.status===1 || item.status===2 || item.status===3 || item.status===4">
                    <div class="userBargain_operating_modify"></div>
                    <span>修改</span>
                  </div>
                  <div @click="deleteModal(item.asin)" v-if="item.status===1 || item.status===2 || item.status===3 || item.status===4">
                    <div class="userBargain_operating_delete"></div>
                    <span>删除</span>
                  </div>
                  <div @click="upModal(item.asin)" v-if="item.status===2">
                    <div class="userBargain_operating_shelf"></div>
                    <span>上线</span>
                  </div>
                </div>
              </div>
              <div class="userBargain_main_bottom">
                <el-pagination
                  layout="prev, pager, next"
                  @change="handlePage"
                  :total="total">
                </el-pagination>
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="订单详情" name="order">
            <div class="userBargain_order">
              <div class="userBargain_order_title">
                <div class="userBargain_order_filter">
                  <div class="userBargain_order_filter_left">
                    <el-date-picker
                      v-model="orderTime"
                      type="daterange"
                      @change="handleSelectDate"
                      :default-time="['00:00:00', '23:59:59']"
                      range-separator="至"
                      start-placeholder="开始日期"
                      end-placeholder="结束日期">
                    </el-date-picker>
                  </div>
                  <div class="userBargain_order_filter_right">
                    <span>订单号查询</span>
                    <input type="number" @change="handleSelectByOrder">
                  </div>
                </div>
              </div>

              <div class="userBargain_order_title_list">
                <el-table
                  :data="orderData"
                  :default-sort = "{prop: 'date', order: 'descending'}"
                  :filter-method="filterHandler"
                  style="width: 100%">
                  <el-table-column
                    prop="order"
                    width="300"
                    label="订单信息">
                    <template slot-scope="scope">
                      <div class="orderText">
                        <div class="order_img"><img :src="Tools.handleImg(scope.row.show_picture?scope.row.show_picture[0].path:'')" alt=""></div>
                        <div class="order_text">
                          <h4>{{scope.row.title}}</h4>
                          <p>订单编号：{{scope.row.order_no}}</p>
                        </div>
                      </div>
                    </template>
                  </el-table-column>
                  <el-table-column
                    label="单价">
                    <template slot-scope="scope">
                      <p>&yen;{{scope.row.price}}</p>
                    </template>
                  </el-table-column>
                  <el-table-column
                    label="数量">
                    <template slot-scope="scope">
                      <p>x{{scope.row.quantity}}</p>
                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="totalPrice"
                    label="总价">
                    <template slot-scope="scope">
                      <p>&yen;{{scope.row.sum}}</p>
                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="created_at"
                    sortable
                    label="下单时间">
                  </el-table-column>
                  <el-table-column
                    prop="district"
                    label="城市">
                  </el-table-column>
                  <el-table-column
                    prop="status"
                    :filters="[{ text: '已打款', value: '已打款' }, { text: '已发货', value: '已发货' }, { text: '未发货', value: '未发货' }, { text: '已退款', value: '已退款' }]"
                    :filter-method="filterTag"
                    filter-placement="bottom-end"
                    label="状态">
                    <template slot-scope="scope">
                      <el-tag
                        :style="scope.row.status===1||scope.row.status===2?{color:'#404040'}:{color:'#ffffff !important'}"
                        :color="
                         scope.row.status===1?'#F2F2F2 ':
                        scope.row.status===2?'#FF9900':
                        scope.row.status===4?'#15BAFE':
                        scope.row.status===5?'#00CC00':
                        scope.row.status===6?'#FF0000':
                        scope.row.status===7?'#FF0000':'#FF0000'"
                        disable-transitions>{{
                        scope.row.status===1?'未付款 ':
                        scope.row.status===2?'已付款未发货':
                        scope.row.status===3?'已发货未收货':
                        scope.row.status===4?'已收货':
                        scope.row.status===5?'删除':
                        scope.row.status===6?'失效 ':
                        scope.row.status===7?'已退款':''
                        }}</el-tag>
                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="operating"
                    width="150"
                    label="操作">
                    <template slot-scope="scope">
                      <div class="orderOperating">
                        <el-button v-if="scope.row.status === 7 || scope.row.status === 1"  class="operatingBtm" @click="handleGetReceivePerson(scope.$index)">收件人详情</el-button>
                        <el-button v-if="scope.row.status === 2 || scope.row.status === 1" class="operatingBtm" @click="handleAddLogistics(scope.$index)">添加物流</el-button>
                        <el-button v-if="scope.row.status !== 2 && scope.row.status !== 1" class="operatingBtm" @click="handleSearchLogistics(scope.row.logistics_no,scope.$index)">查看物流</el-button>


                        <el-dropdown v-if="scope.row.status !== 7 && scope.row.status !== 1" trigger="click">
                        <span class="el-dropdown-link">
                          更多<i class="el-icon-arrow-down el-icon--right"></i>
                        </span>
                          <el-dropdown-menu slot="dropdown" >
                            <el-dropdown-item><span class="recipientBtm" @click="handleGetReceivePerson(scope.$index)">收件人详情</span></el-dropdown-item>
                            <el-dropdown-item><span class="recipientBtm" @click="refund = true">退款</span></el-dropdown-item>
                          </el-dropdown-menu>
                        </el-dropdown>
                      </div>
                    </template>
                  </el-table-column>

                </el-table>
              </div>

            </div>
          </el-tab-pane>
          <el-tab-pane  label="添加淘货" name="uploadingBargains">
          </el-tab-pane>
        </el-tabs>
      </div>

      <!--侧边悬浮框-->
      <floating-div></floating-div>
      <lower-modal ref="marketLower" @confirm="handleLowerMarket"></lower-modal>
      <delete-modal ref="marketDelete" @confirm="handleDeleteMarket"></delete-modal>

      <!--添加物流框-->
      <el-dialog
        title="添加物流"
        :visible.sync="addLogistics"
        width="30%">
        <div class="logisticsModal">
          <p>
            <span>承运人:</span>
            <el-input
              placeholder="请输入承运人"
              v-model="logisticsAddUserName"
              clearable>
            </el-input>
          </p>
          <p>
            <span>快递单号:</span>
            <el-input
              placeholder="请输入快递单号"
              v-model="logisticAddCode"
              clearable>
            </el-input>
          </p>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="addLogistics = false">取 消</el-button>
          <el-button type="primary" @click="AddLogistics">确 定</el-button>
        </span>
      </el-dialog>


      <!--查看物流框-->
      <el-dialog
        title="查看物流"
        :visible.sync="viewLogistics"
        width="30%">
        <div class="viewLogistics">
          <div class="viewLogistics_message">
            <p>承运人: <span>{{logisticsUserName}}</span></p>
            <p>快递单号: <span>{{LogisticCode}}</span></p>
            <el-button class="modifyLoginsticsBtm" @click="handleEditLogistics(editIndex)">修改物流</el-button>
          </div>
          <div class="logisticsDynamic">
            <p class="logisticsDynamic_title">物流动态</p>
            <div class="logisticsDynamicBox">
              <el-steps :style="{height: LogisticsData.Traces?LogisticsData.Traces.length*114.5+'px':0}" direction="vertical" :active="1">
                <el-step v-for="(item, index) in LogisticsData.Traces" :key="index"></el-step>
              </el-steps>
              <div class="right_step">
                <div class="right_step_item" v-for="(item, index) in traces" :key="index">
                  <p class="right_step_item_time">{{item.AcceptTime}}</p>
                  <p class="right_step_item_remark">{{item.AcceptStation}}</p>
                </div>
              </div>
            </div>
          </div>
        </div>

        <el-dialog
          width="30%"
          title="修改物流"
          :visible.sync="modifyLogistics"
          append-to-body>
            <div class="logisticsModal">
              <p>
                <span>承运人:</span>
                <el-input
                  placeholder="请输入承运人名称"
                  v-model="logisticsAddUserName"
                  clearable>
                </el-input>
              </p>
              <p>
                <span>快递单号:</span>
                <el-input
                  placeholder="请输入快递单号"
                  v-model="logisticAddCode"
                  clearable>
                </el-input>
              </p>
            </div>
            <span slot="footer" class="dialog-footer">
              <el-button @click="modifyLogistics = false">取 消</el-button>
              <el-button type="primary" @click="EditLogistics">确 定</el-button>
            </span>
        </el-dialog>
      </el-dialog>

      <!--收件人详情-->
      <el-dialog
        title="收件人详情"
        :visible.sync="recipient"
        width="30%">
        <div class="recipientModal">
          <p>姓名：{{receivePerson.conducts}}</p>
          <p>电话：{{receivePerson.telphone}}</p>
          <p>地址：{{receivePerson.detail}}</p>
          <div class="contactRecipient">
            <el-button>联系收件人</el-button>
          </div>
        </div>
      </el-dialog>

      <!--退款框-->
      <el-dialog
        title="填写退款原因"
        :visible.sync="refund"
        width="30%">
        <div class="refundModal">
          <textarea placeholder="输入退款原因"></textarea>
          <div class="refundBottom">
            <p>退款金额：</p>
            <el-input
              placeholder="请输入退款金额"
              clearable>
            </el-input>
          </div>
        </div>
        <span slot="footer" class="dialog-footer">
              <el-button @click="refund = false">取 消</el-button>
              <el-button type="primary" @click="refund = false">确 定</el-button>
            </span>
      </el-dialog>

      <up-modal ref="marketUp" @confirm="handleUpMarket"></up-modal>

    </div>
</template>

<script>
  import FloatingDiv from "@/components/floating"
  import DeleteModal from "@/components/deleteModal"
  import LowerModal from "@/components/lowerModal"
  import UpModal from "@/components/upModal"
  import userInfoHeaderDiv from "@/components/userInfoHeader"
  import moment from 'moment'
    export default {
      name: "userBargain",
      components:{
        FloatingDiv,
        userInfoHeaderDiv,
        DeleteModal, // 删除弹窗
        LowerModal,  // 下架弹窗
        UpModal, // 上架弹窗
      },
      data(){
        return{
          userBargainRate: 3.5,
          activeName2: 'commodity',
          stockValue: '',
          stockOptions: [{
            value: 1,
            label: '由低到高'
          },{
            value: 2,
            label: '由高到低'
          }],
          priceValue: '',
          priceOptions: [{
            value: 1,
            label: '由低到高'
          },{
            value: 2,
            label: '由高到低'
          }],
          scoreValue: '',
          scoreOptions: [{
            value: 1,
            label: '由低到高'
          },{
            value: 2,
            label: '由高到低'
          }],
          statusValue: '',
          statusOptions: [{
            value: 1,
            label: '正常'
          },{
            value: 2,
            label: '已下架'
          },{
            value: 3,
            label: '待审核'
          },{
            value: 4,
            label: '审核失败'
          }],
          pickerOptions1: {
            disabledDate(time) {
              return time.getTime() > Date.now();
            },
          },
          valueStartDate: '',
          valueEndDate: '',
          page: 1,
          size: 10,
          total: null,
          marketData: [],
          orderTime:'',
          orderData: [],
          deleteId: '',
          lowerId: '',

          addLogistics:false,  //添加物流框
          logisticsUserName: '', //承运人
          LogisticCode: '',
          viewLogistics:false,  //查看物流框
          modifyLogistics:false,  //修改物流框
          modifyLogisticsUserName: '',  //修改物流承运人
          modifyLogisticsOrderNumber:'', //修改快递单号
          logisticsAddUserName: '',
          logisticAddCode: '',

          recipient:false,  //收件人详情

          refund:false,  //退款框
          upId: '',
          LogisticsData: {}, //物流数据
          traces: [],  //物流数组数据
          receivePerson: {}, //收件人详细信息
          startDate: '', //开始时间
          endDate: '', //结束时间
          receiveData: {},
          editIndex: null, //修改物流index
        }
      },
      created() {
        const param = {
          page: this.page,
          size: this.size
        };
        this.getMarketList(param);
        this.getOrderList(param);
      },
      methods: {
        formatter(row, column) {
          return row.address;
        },
        filterTag(value, row) {
          return row.tag === value;
        },
        filterHandler(value, row, column) {
          const property = column['property'];
          return row[property] === value;
        },

        handleClick(tab, event) {
          console.log(tab)
          if(tab.index === '2'){
            this.$router.push({
              path:'/home/uploadingBargains'
            })
          }else if(tab.index === '1'){
            const param = {
              page: 1,
              size: 10
            };
            this.getOrderList(param)
          }else if(tab.index === '0') {
            const param = {
              page: 1,
              size: 10
            };
            this.getMarketList(param)
          }
        },
        /***
         * 获取淘货商品列表
         * @param param
         */
        getMarketList(param) {
          this.HttpClient.post('/web/user/goodsManagement',param).then(res =>{
            console.log(res.data);
            if(res.data.code === 200) {
              this.marketData = res.data.data;
              this.total = res.data.count;
            }else {
              this.marketData = [];
              this.$message.error('获取数据失败');
            }
          })
        },
        /****
         * 获取订单列表
         * @param param
         */
        getOrderList(param) {
          this.HttpClient.post('/web/user/userOrdersList',param).then(res =>{
            if(res.data.code === 200) {
              this.orderData = res.data.data;
            }else {
              //this.$message.error('')
            }
          })
        },
        /****
         * 跳转到修改页
         * @param id
         */
        handleJumpEdit(id) {
          this.$router.push({
            path: '/home/uploadingBargains',
            query: {
              id: id
            }
          })
        },
        /***
         * 删除淘货
         * @param id
         */
        handleDeleteMarket(isSingle) {
          if(isSingle) {
            this.HttpClient.post('/web/user/goodsDestroy',{asin: this.deleteId}).then(res =>{
              if(res.data.code === 200) {
                const param = {
                  page: this.page,
                  size: this.size,
                  gettwo: 1
                };
                this.getMarketList(param);
                this.$message.success(res.data.msg);
              }else {
                this.$message.error(res.data.msg);
              }
            })
          }

        },
        /*删除操作*/
        deleteModal(id){
          this.$refs.marketDelete.modelDelete=true;
          this.deleteId = id
        },
        /**下架操作**/
        lowerModal(id) {
          this.$refs.marketLower.modelDelete = true;
          this.lowerId = id;
        },
        /***
         * 上架操作
         */
        upModal(id) {
          this.$refs.marketUp.modelDelete = true;
          this.upId = id;
        },
        /**
         * 下架
         */
        handleLowerMarket(isSingle) {
          if(isSingle) {
            this.HttpClient.post('/web/user/goodsUpdateStatus',{asin: this.lowerId,status: 2}).then(res =>{
              if(res.data.code === 200) {
                const param = {
                  page: this.page,
                  size: this.size,
                  gettwo: 1
                };
                this.getMarketList(param);

                this.$message.success(res.data.msg);
              }else {
                this.$message.error(res.data.msg);
              }
            })
          }
        },
        /***
         * 上架
         */
        handleUpMarket(isSingle,num) {
          console.log(isSingle,num)
          if(isSingle && parseInt(num)>0) {
            this.HttpClient.post('/web/user/goodsUpdateStatus',{asin: this.upId,status: 1,stock: num}).then(res =>{
              if(res.data.code === 200) {
                const param = {
                  page: this.page,
                  size: this.size,
                  gettwo: 1
                };
                this.getMarketList(param);
                this.$message.success(res.data.msg);
              }else {
                this.$message.error(res.data.msg);
              }
            })
          }else{
            this.$message.error('库存数量必须大于0')
          }
        },
        /***
         * 获取库存排序
         * @param value
         */
        handleStockChange(value) {
          console.log('handleStockChange',value);
          let param;
          if(parseInt(value) === 1) {
            this.orderby = 'asc'
          }else {
            this.orderby = 'desc'
          }
          param = {
            page: this.page,
            size: this.size,
            orderby: this.orderby,
            order: 'stock',
          };
          this.getMarketList(param);
        },
        /***
         * 价格排序
         * @param value
         */
        handlePriceChange(value) {
          console.log('handlePriceChange',value);
          let param;
          if(parseInt(value) === 1) {
            this.orderby = 'asc'
          }else {
            this.orderby = 'desc'
          }
          param = {
            page: this.page,
            size: this.size,
            orderby: this.orderby,
            order: 'price',
          };
          this.getMarketList(param);
        },
        /****
         * 评分排序
         * @param value
         */
        handleScoreChange(value) {
          console.log('handleScoreChange',value);
          let param;
          if(parseInt(value) === 1) {
            this.orderby = 'asc'
          }else {
            this.orderby = 'desc'
          }
          param = {
            page: this.page,
            size: this.size,
            orderby: this.orderby,
            order: 'score',
          };
          this.getMarketList(param);
        },
        /***
         * 状态排序
         * @param value
         */
        handleStatusChange(value) {
          console.log('handleStatusChange',value);
          let param;
          if(parseInt(value) === 1) {
            this.orderby = 'asc'
          }else {
            this.orderby = 'desc'
          }
          param = {
            page: this.page,
            size: this.size,
            orderby: this.orderby,
            status: parseInt(value)
          };
          this.getMarketList(param);
        },
        handleJumpToComment(id) {
          this.$router.push({
            path: '/home/merchant-market-reviews',
            query: {
              id: id
            }
          })
        },
        /***
         * 翻页
         * @param value
         */
        handlePage(value) {
          this.page = value
          let param = {
            page: value
          }
        },
        /***
         * 查看物流
         * @param code
         * @param index
         */
        handleSearchLogistics(code, index) {
          this.viewLogistics = true;
          this.editIndex = index;
          this.HttpClient.post('/web/user/getLogisticsInfo', {logisticcode: code}).then(res =>{
            if(res.data.code === 200) {
              this.LogisticsData = res.data.data;
              this.logisticsUserName = res.data.data.ShipperName;
              this.LogisticCode = res.data.data.LogisticCode;
              const array = this.LogisticsData.Traces;
              this.traces = array.sort((a,b) =>b.AcceptTime.localeCompare(a.AcceptTime));
              console.log(this.traces)
            }else {
              this.LogisticsData = [];
              this.logisticsUserName = '';
              this.LogisticCode = '';
              this.traces = []
            }
          })
        },
        /***
         * 获取收件人信息
         * @param index
         */
        handleGetReceivePerson(index) {
          console.log(index)
          this.recipient = true;
          this.receivePerson = this.orderData[index];
        },
        /***
         * 选择时间查询
         * @param date
         */
        handleSelectDate(date) {
          console.log(date);
          let param;
          if(date === null) {
            param = {}
          }else{
            this.startDate = moment(date[0]).format('YYYY-MM-DD HH:mm:ss');
            this.endDate = moment(date[1]).format('YYYY-MM-DD HH:mm:ss');
            param = {
              start_time: this.startDate,
              end_time: this.endDate,
              page: 1
            };
          }

          this.getOrderList(param);
        },
        /***
         * 按订单号查询
         * @param e
         */
        handleSelectByOrder(e) {
          let param;
          console.log(parseInt(e.target.value),typeof parseInt(e.target.value))
          if(!isNaN(parseInt(e.target.value))) {
            param = {
              order_no: parseInt(e.target.value)
            }
          }else {
            param = {};
          }
          this.getOrderList(param);
        },
        /***
         * 打开修改物流弹窗
         * @param index
         */
        handleAddLogistics(index) {
          this.addLogistics = true;
          this.receiveData = this.orderData[index];
        },
        /**
         * 添加物流
         * @param index
         * @constructor
         */
        AddLogistics() {
          const param = {
            order_no: this.receiveData.order_no,
            carrier: this.logisticsAddUserName,
            logistics_no: this.logisticAddCode
          };
          this.HttpClient.post('/web/user/createLogistics', param).then(res =>{
            if(res.data.code === 200) {
              this.$message.success('添加成功');
              this.logisticsAddUserName = '';
              this.logisticAddCode = '';
              this.addLogistics = false;
            }else {
              this.$message.error('添加失败')
            }
          })
        },
        /***
         * 打开修改物流弹窗
         * @param index
         */
        handleEditLogistics(index) {
          this.modifyLogistics = true;
          this.receiveData = this.orderData[index];
        },
        /***
         * 修改物流
         * @constructor
         */
        EditLogistics() {
          const param = {
            order_no: this.receiveData.order_no,
            carrier: this.logisticsAddUserName,
            logistics_no: this.logisticAddCode
          };
          this.HttpClient.post('/web/user/createLogistics', param).then(res =>{
            if(res.data.code === 200) {
              this.$message.success('修改成功');
              this.logisticsAddUserName = '';
              this.logisticAddCode = '';
              this.modifyLogistics = false;
            }else {
              this.$message.error('修改失败')
            }
          })
        },
      },
    }
</script>

<style src="../../assets/css/userBargain.css"></style>
<style lang="less">
  #tab-uploadingBargains{
    background: #15befe;
    color:#fff;
  }
  .uploadingBargains a{
    width: 100%;
    height: 100%;
  }

  .userBargain_order_title_list{
    .orderText{
      display: flex;
      align-items: center;

      .order_img{
        width: 80px;
        height: 80px;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-right: 15px;
        img{
          height: 100%;
        }
      }
      .order_text{
        width: 170px;
        h4{
          height: 55px;
          font-size: 14px;
          color: #333;
          overflow: hidden;
        }
        p{
          font-size: 12px;
          color: #999;
        }
      }
    }
    .orderOperating{
      display: flex;
      align-items: center;
      justify-content: space-between;
      .el-dropdown-link{
        cursor: pointer;
      }
      .operatingBtm{
        border: none;
        padding: 0;
      }
    }
  }



  /*添加物流框*/
  .logisticsModal{
    p:nth-child(1){
      margin-bottom: 20px;
    }
    p{
      display: flex;
      align-items: center;
      justify-content: center;
      span{
        width: 70px;
        height: 20px;
        text-align: justify;
      }
      span:after{
        content:'';
        width: 100%;
        display: inline-block;
      }
      .el-input{
        width: 250px;
        margin-left: 15px;
      }
      .el-input__suffix{
        top: 10px;
      }
    }
  }

  /*查看物流框*/
  .viewLogistics{
    .viewLogistics_message{
      display: flex;
      justify-content: space-between;
      align-items: center;
      p{
        font-size: 14px;
        color: #333;

        span{
          display: inline-block;
          font-size: 12px;
          color: #999;
          padding-left: 10px;
        }
      }
      .modifyLoginsticsBtm{
        border-radius: 0;
        border-color: #15befe;
        color: #15befe;
      }
    }

    /*物流动态*/
    .logisticsDynamic{
      margin-top: 20px;
      .logisticsDynamic_title{
        display: inline-block;
        padding: 5px 15px;
        font-size: 14px;
        color: #333;
        border: 1px solid #999;
        border-bottom: none;
        font-weight: bold;
      }
      .logisticsDynamicBox{
        height: 300px;
        border-top: 1px solid #999;
        border-bottom: 1px solid #999;
        padding: 15px 0;
        display: flex;
        overflow-y: scroll;
        .el-step__icon{
          width: 12px !important;
          height: 12px !important;
          background: #409eff !important;
          font-size: 12px !important;
          top: -12px !important;
          left: 6px !important;
        }
        .el-step__icon-inner{
          display: none !important;
        }
        .right_step{
          margin-top: -11px;
          .right_step_item{
            height: 124px;
            .right_step_item_time{

            }
            .right_step_item_remark{
              height: 80px;
              text-overflow: -o-ellipsis-lastline;
              overflow: hidden;
              text-overflow: ellipsis;
              display: -webkit-box;
              -webkit-line-clamp: 4;
              line-clamp: 4;
              -webkit-box-orient: vertical;
              margin-top: 10px;
            }
          }
        }
      }
    }

  }

  /*收件人详情*/
  .recipientModal{
    p{
      font-size: 14px;
      color: #333;
      margin-bottom: 15px;
    }
    .contactRecipient{
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 20px;
      button{
        border-color: #15befe;
        border-radius: 0;
        color: #15befe;
      }
    }
  }
  .recipientBtm{
    width: 100%;
    height: 100%;
    display: inline-block;
  }


  /*退款框*/
  .refundModal{
    textarea{
      height: 150px;
      width: 96%;
      margin-bottom: 20px;
      resize:vertical;
      padding: 10px;
    }
    .refundBottom{
      display: flex;
      align-items: flex-end;
      p{
        font-size: 14px;
        color: #333;
      }
      .el-input{
        width: 200px;
        margin-left: 10px;
      }
    }
  }

</style>
