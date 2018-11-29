<template>
    <div class="merchantWarehouse appBackground">
      <commerInfoHeader></commerInfoHeader>


        <div class="merchantWarehouse_box width_1200">

          <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
            <el-tab-pane label="销量分析" name="SalesVolume">

              <div class="merchant_salesVolume">

                <div class="salesVolume_chart">
                  <!--折线图-->
                  <div class="salesVolume_chart_line">
                    <div class="salesVolume_chart_line_title">
                      <div class="salesVolume_title_left">
                        <p>趋势</p>
                        <span>产品销售总量月份曲线统计图</span>
                      </div>

                      <div class="salesVolume_title_right">
                          <el-date-picker
                                  v-model="activeMonth"
                                  type="month"
                                  size="small"
                                  value-format="M"
                                  :placeholder="date"
                                  @change="getMonthData">
                          </el-date-picker>
                      </div>

                    </div>

                    <ve-line :data="chartData" :settings="chartSettings" :legend-visible="false" :colors="colors" :options="options"></ve-line>
                  </div>


                  <!--饼状图-->
                  <div class="salesVolume_chart_pan">



                  </div>

                </div>

                <div class="salesVolume_table">

                  <div class="salesVolume_table_title">

                    <div class="salesVolume_title_time">
                      <el-date-picker
                        v-model="timeRange"
                        clearable
                        type="daterange"
                        range-separator="至"
                        value-format="yyyy-MM-dd"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                        @change="getSalesDetail">
                      </el-date-picker>
                    </div>
                    <div class="salesVolume_title_dropdown">

                      <el-select v-model="type" clearable placeholder="产品类型" @visible-change="getType" @change="getSalesDetail">
                        <el-option
                          v-for="item in options"
                          :key="item.id"
                          :label="item.name"
                          :value="item.id">
                        </el-option>
                      </el-select>

                      <el-select v-model="valueSex" clearable placeholder="卖家性别" @change="getSalesDetail">
                        <el-option
                          v-for="item in optionsSex"
                          :key="item.valueSex"
                          :label="item.labelSex"
                          :value="item.valueSex">
                        </el-option>
                      </el-select>
                    </div>
                    <div class="salesVolume_title_input">

                      <input type="text" placeholder="输入产品编号" v-model="asin">
                      <button type="submit" class="salesVolume_btn" @click="searchSalesDetail"><i class="icon icon-ziyuan25"></i></button>

                    </div>

                  </div>

                  <div class="salesVolume_table_main">

                    <el-table
                      :data="tableData"
                      style="width: 100%">
                      <el-table-column
                        prop="title"
                        label="商品名称"
                        align="center">
                      </el-table-column>
                      <el-table-column
                        prop="asin"
                        label="商品编号"
                        align="center"
                        width="150">
                      </el-table-column>
                      <el-table-column
                        prop="price"
                        align="center"
                        label="单价"
                        width="100">
                        <template slot-scope="scope">
                            ¥{{scope.row.price}}
                        </template>
                      </el-table-column>
                      <el-table-column
                        prop="quantity"
                        align="center"
                        label="卖出数量"
                        width="150">
                      </el-table-column>
                      <el-table-column
                        prop="total_price"
                        align="center"
                        label="总价"
                        width="140">
                        <template slot-scope="scope">
                            ¥{{scope.row.total_price}}
                        </template>
                      </el-table-column>
                      <el-table-column
                        prop="score"
                        align="center"
                        label="评分数"
                        width="258">

                        <template slot-scope="scope">
                          <el-rate
                            v-model="scope.row.score"
                            disabled
                            :colors="['#15bafe','#15bafe','#15bafe']"
                            score-template="{value}">
                          </el-rate>
                        </template>

                      </el-table-column>
                    </el-table>


                    <!--分页器-->
                    <div class="salesVolume_table_main_btm" v-if="totalPage">
                      <el-pagination
                        layout="prev, pager, next"
                        :page-count="totalPage"
                        @current-change="pageChange"
                        @prev-click="prevPage"
                        @next-click="nextPage">
                      </el-pagination>
                    </div>


                  </div>

                </div>

              </div>

            </el-tab-pane>

            <el-tab-pane label="商品管理" name="management">

              <div class="management_table">

                <el-table
                  :data="managementData"
                  style="width: 100%"
                  :default-sort = "{prop: 'stockQuantity', order: 'descending'}"
                >
                  <el-table-column
                    label="商品"
                    prop="product"
                    align="center"
                    class-name="product">
                    <template slot-scope="scope">
                      <div class="product_img">
                        <img :src="request.picUrl+scope.row.show_picture[0]" alt="">
                      </div>
                      <div class="product_text">
                        <p class="productName"><a :href="'/home/product-detail/'+scope.row.product_id">{{scope.row.title}}</a></p>
                        <p class="productNbm">商品编号：{{scope.row.asin}}</p>
                      </div>
                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="stock"
                    label="库存数量"
                    align="center"
                    width="100"
                    sortable>
                  </el-table-column>
                  <el-table-column
                    prop="sell_num"
                    label="销量"
                    align="center"
                    width="100"
                    sortable>
                  </el-table-column>
                  <el-table-column
                    prop="price"
                    label="单价"
                    align="center"
                    width="100"
                    sortable>
                  </el-table-column>
                  <el-table-column
                    prop="score"
                    label="评分"
                    align="center"
                    width="100"
                    sortable>
                    <template slot-scope="scope">
                      <div class="productRate">
                        <el-rate
                          v-model="scope.row.score"
                          disabled
                          score-template="{value}">
                        </el-rate>
                      </div>
                    </template>
                  </el-table-column>
                  <el-table-column
                    width="150px"
                    align="center"
                    :render-header="renderProductStatus">
                    <template slot-scope="scope">
                        <div class="productStatus" v-if="scope.row.status===1">
                            <div><img src="/static/img/icon/user_by.png" alt=""></div>
                            <p>已通过</p>
                        </div>
                        <div class="productStatus" v-else-if="scope.row.status===2">
                            <div><img src="/static/img/icon/user_cancel.png" alt=""></div>
                            <p>已下架</p>
                        </div>
                        <div class="productStatus" v-else-if="scope.row.status===3">
                            <div><img src="/static/img/icon/user_wait.png" alt=""></div>
                            <p>待审核</p>
                        </div>
                        <div class="productStatus" v-else>
                            <div><img src="/static/img/icon/user_error.png" alt=""></div>
                            <p>未通过</p>
                        </div>
                    </template>

                  </el-table-column>
                  <el-table-column
                    prop="operating"
                    label="操作"
                    align="center"
                    :formatter="formatter">
                    <template slot-scope="scope">
                      <div class="productOperating">
                        <div v-if="scope.row.status===1 || scope.row.status===2">
                          <img src="/static/img/icon/userBargain_underTheShelf.png" alt="">
                          <p v-if="scope.row.status===1" @click="productSoldOut(scope.row.product_id,scope.row.status)">下架</p>
                          <p v-else-if="scope.row.status===2" @click="productPutaway(scope.row.product_id,scope.row.status)">上架</p>
                        </div>

                        <!--<div @click="dialogVisible = true">-->
                        <div>
                          <a href="javascript:;" @click="checkComment(scope.row.product_id,scope.row.title)">
                            <img src="/static/img/icon/userBargain_evaluation.png" alt="">
                            <p>查看评价</p>
                          </a>
                        </div>
                        <div @click="updateProduct(scope.row.product_id)">
                          <img src="/static/img/icon/user_modify.png" alt="">
                          <p>修改</p>
                        </div>

                        <div @click="deleteOpen(scope.row.product_id)" >
                          <img src="/static/img/icon/user_delete.png" alt="">
                          <p>删除</p>
                        </div>
                      </div>

                    </template>
                  </el-table-column>
                </el-table>
                <!--分页器-->
                <div class="salesVolume_table_main_btm" v-if="totalPage">
                    <el-pagination
                        layout="prev, pager, next"
                        :page-count="totalPage"
                        @current-change="ProductPageChange">
                    </el-pagination>
                </div>
              </div>

            </el-tab-pane>

            <el-tab-pane label="订单信息" name="order">

              <div class="order_header">
                <div class="order_date">
                    <p>下单时间</p>
                    <el-date-picker
                      v-model="orderTime"
                      type="daterange"
                      range-separator="至"
                      format="yyyy 年 MM 月 dd 日"
                      value-format="yyyy-MM-dd"
                      start-placeholder="开始日期"
                      end-placeholder="结束日期"
                      @change="orderDateChange">
                    </el-date-picker>
                </div>
                <el-autocomplete
                        v-model="orderNum"
                        clearable
                        :fetch-suggestions="querySearchAsync"
                        placeholder="请输入订单号"
                        @select="handleSelect"
                        @input="getOrderByKey"
                        @keyup.native.enter="handleSelect"
                >
                    <el-button slot="prepend" icon="el-icon-search" @click="handleSelect"></el-button>
                </el-autocomplete>
              </div>

              <div class="order_table">

                <el-table
                  :data="orderData"
                  style="width: 100%"
                  :default-sort = "{prop: 'date', order: 'descending'}">
                  <el-table-column
                    label="订单信息"
                    width="280"
                    align="left"
                    class-name="orderInformation">
                    <template slot-scope="scope">
                      <div>订单编号：{{scope.row.order_no}}</div>
                      <div class="orderName_main">
                        <div class="orderName_main_img">
                          <img :src="request.picUrl+scope.row.show_picture" alt="">
                        </div>
                        <div class="orderName_main_text">
                          <h2>{{scope.row.title}}···</h2>
                          <p>商品编号：{{scope.row.asin}}</p>
                        </div>
                      </div>
                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="price"
                    width="80"
                    align="center"
                    label="单价">
                  </el-table-column>
                  <el-table-column
                    prop="quantity"
                    width="80"
                    align="center"
                    label="数量">
                  </el-table-column>
                  <el-table-column
                    prop="total_price"
                    width="80"
                    align="center"
                    label="总价">
                  </el-table-column>
                  <el-table-column
                    prop="created_at"
                    width="160"
                    align="center"
                    :render-header="orderDateHeaderRender">
                  </el-table-column>
                  <el-table-column
                    prop="name"
                    width="100"
                    align="center"
                    sortable
                    label="城市">
                  </el-table-column>
                  <el-table-column
                    class-name="orderStatus"
                    width="150"
                    align="center"
                    :render-header="orderHeaderRender">
                    <template slot-scope="scope">
                        <div v-if="scope.row.refund===0">
                            <el-tag type="info" disable-transitions v-if="scope.row.status === 2">未发货</el-tag>
                            <el-tag type="primary" disable-transitions v-else-if="scope.row.status === 4">已发货</el-tag>
                            <el-tag type="success" disable-transitions v-else-if="scope.row.status === 5">已到货</el-tag>
                            <el-tag type="orange" disable-transitions v-else-if="scope.row.status === 6">已打款</el-tag>
                        </div>
                        <el-tag type="error" disable-transitions v-else>已退款</el-tag>
                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="operating"
                    class-name="orderOperating"
                    align="center"
                    label="操作">
                    <template slot-scope="scope">
                      <div @click="handleGetReceivePerson(scope.$index)">收件人详情</div>
                      <div v-if="scope.row.status===2" @click="handleAddLogistics(scope.$index)">添加物流</div>
                      <div v-else @click="checkLogistics(scope.row.order_id,scope.$index)">查看物流</div>
                      <div v-if="scope.row.refund===0">退款</div>
                    </template>
                  </el-table-column>
                </el-table>

                <!--分页器-->
                <div class="salesVolume_table_main_btm" v-if="totalPage">
                    <el-pagination
                        layout="prev, pager, next"
                        :page-count="totalPage"
                        @current-change="orderPageChange">
                    </el-pagination>
                </div>

              </div>

            </el-tab-pane>

            <el-tab-pane label="添加商品" name="addProduct">
              <span slot="label"><i class="el-icon-circle-plus-outline"></i> 添加商品</span>
            </el-tab-pane>

          </el-tabs>

        </div>


      <!--删除框-->
      <deleteModal-div ref="deleteModal" @confirm="confirmDelete"></deleteModal-div>
      <!--商品上下架-->
      <up-modal ref="productUp" @confirm="productPutawayConfirm"></up-modal>
      <!--侧边悬浮框-->
      <floating-div></floating-div>

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
          <el-button type="primary" @click="addLogisticsInfo">确 定</el-button>
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
    </div>
</template>


<script>
  import commerInfoHeader from '@/components/commercialInfoHeader'
  import FloatingDiv from "@/components/floating"
  import DeleteModalDiv from '@/components/deleteModal'
  import UpModal from '@/components/upModal'

  import VeLine from 'v-charts/lib/line'

  export default {
    name: "merchantWarehouse",
    components:{
      commerInfoHeader,
      FloatingDiv,
      VeLine,
      DeleteModalDiv,
      UpModal
    },
    data() {
      this.chartSettings = {
        xAxisType: 'category',
        dimension: ['day'],
        metrics: ['num'],
        labelMap: {
          'num': '日销量'
        },
      };
      this.colors = ['#15bafe'];
      this.options={
          xAxis: {
              boundaryGap:false
          },
      };

      return {
        // dialogVisible: false, //查看评价框
        // evaluateRate:'4',  //评价框评分
        date:new Date(),
        activeMonth:'',
        activeName: 'SalesVolume',
        timeRange:'',//时间范围
        options: [],//产品类型列表
        optionsSex:[{
          valueSex:1,
          labelSex:'男'
        },{
          valueSex:2,
          labelSex:'女',
        }],
        currentPage:1,//当前页
        pageSize:15,//每页显示条数
        totalPage:0,//总分页数


        // 销量分析表格数据
        tableData: [],

        // 折线图数据
        chartData: {
          columns: ['day','num'],
          rows: [
            { '日期': '1', '日销量': 8 },
            { '日期': '2', '日销量': 10 },
            { '日期': '3', '日销量': 12 },
            { '日期': '4', '日销量': 14 },
            { '日期': '5', '日销量': 16 },
            { '日期': '6', '日销量': 20 },
            { '日期': '7', '日销量': 24 },
            { '日期': '8', '日销量': 21 },
            { '日期': '9', '日销量': 18 },
            { '日期': '10', '日销量': 22 },
            { '日期': '11', '日销量': 24 },
            { '日期': '12', '日销量': 26 },
            { '日期': '13', '日销量': 28 },
            { '日期': '14', '日销量': 30 },
            { '日期': '15', '日销量': 32 },
            { '日期': '16', '日销量': 34 },
            { '日期': '17', '日销量': 36 },
            { '日期': '18', '日销量': 38 },
            { '日期': '19', '日销量': 36 },
            { '日期': '20', '日销量': 34 },
            { '日期': '21', '日销量': 32 },
            { '日期': '22', '日销量': 28 },
            { '日期': '23', '日销量': 30 },
            { '日期': '24', '日销量': 34 },
            { '日期': '25', '日销量': 38 },
            { '日期': '26', '日销量': 40 },
            { '日期': '27', '日销量': 42 },
            { '日期': '28', '日销量': 38 },
            { '日期': '29', '日销量': 36 },
            { '日期': '30', '日销量': 34 },
            { '日期': '31', '日销量': 32 },
          ]
        },

        // 商品管理表格数据
        managementData: [],

        // 订单信息表格数据
        orderData: [],


        productRate:4,
        value5: 3,
        type: '',//产品类型
        valueSex:'',//性别
        asin:'',//产品编号

        orderTime:[], //订单日期起始时间

        deleteModal:false,  //删除框

        productStatus:2,//商品上下架（1：上架，2：下架）
        headerSelect:'',//商品状态选择值
        headerOptions:[{status:2,text:'已下架'},{status:1,text:'已通过'},{status:4,text:'未通过'},{status:3,text:'待审核'}],//商品管理状态选择列
        productId:'',//选中商品id
        orderNum:'',//订单编号
        restaurants:[],//订单号关键词搜索
        orderHeader:'',//订单状态选择值
        orderOptions:[{status:1,text:'未发货'},{status:2,text:'已发货'},{status:3,text:'已退款'}],//订单状态选择列
        orderDateHeader:'',//订单下单时间选择值
        orderDateOptions:[{status:'desc',text:'最新'},{status:'asc',text:'最早'}],//订单下单时间选择列

        addLogistics:false,  //添加物流框
        logisticsUserName: '', //承运人
        LogisticCode: '',//快递单号
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
      };
    },
    methods: {
      handleClick(tab, event) {
        if(tab.index == 3){
          this.$router.push({
            path:'/home/uploadingProduct'
          })
        }
      },

      viewReviews(){
      },

      // 商品管理排序
      formatter(row, column) {
        return row.address;
      },

      //当前页改变
      pageChange(page){
          this.currentPage=page;
          this.getSalesDetail()
      },
      //点击上一页
      prevPage(){
          // console.log(2);
      },
      //点击下一页
      nextPage(){
          // console.log(3);
      },

      //获取某一月销量数据
      getMonthData(m){
          this.HttpClient.get('/products/md/getSaleNumber',{month:Number(m)})
              .then(res=>{
                  console.log(res);
                  let {code,monthSaleData} = res.data;
                  if(code===200){
                    this.chartData.rows=monthSaleData
                  }
              })
      },
      //获取销量详情
      getSalesDetail(){
          console.log(this.timeRange);
          console.log(this.type);
          console.log(this.valueSex);
          console.log(this.asin);
          let start,end;
          if(this.timeRange==='' || this.timeRange===null){
            start='';
            end='';
          }else{
            start=this.timeRange[0];
            end=this.timeRange[1]
          }
          this.HttpClient.get('/products/getSoldProducts',
            {
                start_time:start,
                end_time:end,
                category_id:this.type,
                sex:this.valueSex,
                keywords:this.asin,
                page:this.currentPage,
                size:this.pageSize
            }).then(res=>{
            console.log(res);
            let {code,data,page_num} = res.data;
            if(code===200){
                this.tableData=data;
                this.totalPage=page_num
            }else{
                this.tableData=[];
                this.totalPage=0
            }
        })
      },

      //获取产品类型数据
      getType(b){
          if(b) {
              this.HttpClient.get('/products/getFolders')
                  .then(res => {
                      console.log(res);
                      let {code, data} = res.data;
                      if (code === 200) {
                          this.options = data
                      }
                  })
          }
      },

      //搜索商品编号
      searchSalesDetail(){
          this.timeRange='';
          this.type='';
          this.valueSex='';
          this.getSalesDetail()
      },

      /*********************商品管理*************************/
      //获取商品管理页商品列表
      getProductList(){
          this.HttpClient.post('/user/companies/commodityList',{passize:this.pageSize,page:this.currentPage,orderby:'asc',status:this.headerSelect,gettwo:1})
              .then(res=>{
                  console.log(res);
                  if(res.data.code===200){
                      this.managementData=res.data.data;
                      // this.managementData.map(item=>{
                      //     item.productStatus=1
                      // });
                      this.totalPage=Math.ceil(res.data.count/this.pageSize);
                  }
              })
      },
      //在渲染表头的时候，会调用此方法，h为createElement的缩写版  添加on.change事件即可
      renderProductStatus(h, {column}) {
          return h('el-select',{
              // 'v-model':this.headerSelect,
              props:{
                  value:this.headerSelect,
                  placeholder:'状态',
                  clearable:true
              },
              on:{
                  input:value=>{
                      console.log(value);
                      this.headerSelect=value;
                      this.getProductList()
                  }
              }
          }, [
              this.headerOptions.map(item=>{
                  return h('el-option',
                      {
                          props: {
                              value: item.status,
                              label: item.text
                          }
                      })
              })

          ]);
      },
      //分页事件
      ProductPageChange(p){
          this.currentPage=p;
          this.getProductList()
      },

      //商品上下架
      productChangeStatus({status,stock}){
          let parameters={product_id:this.productId,status:status};
          if(status===1){
              parameters.stock=stock;
          }
          console.log(status);
          console.log(parameters);
          this.HttpClient.post('/user/companies/commodityUpdateStatus',parameters)
              .then(res=>{
                  console.log(res);
                  if(res.data.code===200){
                      this.$message.success(res.data.msg);
                      this.getProductList()
                  }
              })
      },
      //商品下架
      productSoldOut(id,status){
          this.productId = id;
          this.productStatus=2;
          this.productChangeStatus({status:this.productStatus})
      },
      //商品上架
      productPutaway(id,status){
          this.productId=id;
          this.productStatus=1;
          this.$refs.productUp.modelDelete=true;
      },
      //上架确认
      productPutawayConfirm(isSingle,number){
          if(isSingle){
              this.productChangeStatus({status:this.productStatus,stock:number})
          }
      },

      //查看评价
      checkComment(id,title){
          this.$router.push({
              path:'/home/merchantViewReviews',
              query:{id:id,title:title,type:'product'}
          })
      },

      //修改商品信息
      updateProduct(id){
          this.$router.push({
            path:'/home/uploadingProduct',
            query:{
                id:id
            }
          })
      },

      // 打开删除确认框
      deleteOpen(id){
          this.$refs.deleteModal.modelDelete=true;
          this.productId=id;
          console.log(id);
      },

      //响应删除框事件
      confirmDelete(isSingle){
          if(isSingle){
              console.log(this.productId);
              this.HttpClient.post('/user/companies/commodityDestroy',{product_id:this.productId})
                  .then(res=>{
                      console.log(res);
                      if(res.data.code===200){
                        this.$message.success(res.data.msg);
                        this.getProductList()
                      }
                  })
          }else{

          }
      },

      /*****************订单详情**********************/
      //获取订单列表
      getOrderList(){
          this.HttpClient.get('/orders/list',{
            status:this.orderHeader,
            page:this.currentPage,
            size:this.pageSize,
            order_time:this.orderDateHeader,
            start_time:this.orderTime[0],
            end_time:this.orderTime[1],
            order_no:this.orderNum,
          })
              .then(res=>{
                  console.log(res);
                  let {code,data,currentPage,page_num,total} = res.data;
                  if(code===200){
                      this.orderData=data;
                      // this.orderData[3].status=6;
                      // this.orderData[4].status=1;
                      // this.orderData[0].name='重庆'
                  }
              })
      },
      //时间范围改变
      orderDateChange(){
          console.log(this.orderTime);
          if(this.orderTime===null){
              this.orderTime=[];
          }
          this.getOrderList()
      },
      querySearchAsync(queryString, cb) {
          var restaurants = this.restaurants;
          var results = queryString ? restaurants.filter(this.createStateFilter(queryString)) : restaurants;
          var res=[];
          if (results.length === 0) {
              res = [{value: '暂无数据'}]
          }else{
              results.map(item=>{
                  res.push({value:item})
              });
          }
          cb(res);
          // clearTimeout(this.timeout);
          // this.timeout = setTimeout(() => {
          //     cb(res);
          // }, 3000 * Math.random());
      },
      createStateFilter(queryString) {
          return (state) => {
              return (state.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
          };
      },
      //搜索订单
      handleSelect(item) {
          console.log(item);
          console.log(this.orderNum);
          this.getOrderList()
      },
      //根据关键词获取订单号
      getOrderByKey(val){
          this.HttpClient.get('/orders/orderNoList',{order_no:val,size:100})
              .then(res=>{
                  console.log(res);
                  if(res.data.code===200){
                      this.restaurants=res.data.data;
                  }
              })
      },
      //状态栏头部渲染
      orderHeaderRender(h,{column}) {//状态
          return h('el-select',{
              props:{
                  value:this.orderHeader,
                  placeholder:'状态',
                  clearable:true
              },
              on:{
                  input:value=>{
                      console.log(value);
                      this.orderHeader=value;
                      this.getOrderList()
                  }
              }
          }, [
              this.orderOptions.map(item=>{
                  return h('el-option',
                      {
                          props: {
                              value: item.status,
                              label: item.text
                          }
                      })
              })

          ]);
      },
      orderDateHeaderRender(h,{column}){//下单时间
          return h('el-select',{
              props:{
                  value:this.orderDateHeader,
                  placeholder:'下单时间',
                  clearable:true
              },
              on:{
                  input:value=>{
                      console.log(value);
                      this.orderDateHeader=value;
                      this.getOrderList()
                  }
              }
          }, [
              this.orderDateOptions.map(item=>{
                  return h('el-option',
                      {
                          props: {
                              value: item.status,
                              label: item.text
                          }
                      })
              })

          ]);
      },
      //订单分页
      orderPageChange(p){
          this.currentPage=p;
          this.getOrderList()
      },

      //查看收件人信息
      handleGetReceivePerson(index){
          console.log(index);
          this.recipient = true;
          this.receivePerson = this.orderData[index];
      },

      //打开添加物流框
      handleAddLogistics(index) {
          this.addLogistics = true;
          this.receiveData = this.orderData[index];
      },
      //添加物流
      addLogisticsInfo() {
          const param = {
              order_id: this.receiveData.order_id,
              carrier: this.logisticsAddUserName,
              logistics_no: this.logisticAddCode
          };
          this.HttpClient.post('/orders/delivery', param).then(res =>{
              console.log(res);
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

      //查看物流
      checkLogistics(id,index) {
          this.viewLogistics = true;
          this.editIndex = index;
          this.HttpClient.get('/orders/logistics', {order_id:id,type:1}).then(res =>{
              console.log(res);
              let {code,carrier,logistics_no,logistics_info} = res.data;
              if(code === 200) {
                  this.LogisticsData = logistics_info;
                  this.logisticsUserName = carrier;
                  this.LogisticCode = logistics_no;
                  console.log(this.LogisticsData);
                  const array = this.LogisticsData.traces;
                  this.traces = array.sort((a,b) =>b.AcceptTime.localeCompare(a.AcceptTime));
                  console.log(this.traces)
              }else {
                  this.LogisticsData = [];
                  this.logisticsUserName = '';
                  this.LogisticCode = '';
                  this.traces = [];
              }
          })
      },
      //打开修改物流弹窗
      handleEditLogistics(index) {
          this.modifyLogistics = true;
          this.receiveData = this.orderData[index];
          console.log(this.receiveData);
      },
      // 修改物流
      EditLogistics() {
          console.log(1);
          const param = {
              order_id: this.receiveData.order_id,
              carrier: this.logisticsAddUserName,
              logistics_no: this.logisticAddCode,
              type:1
          };
          this.HttpClient.post('/orders/editLogistics', param).then(res =>{
              console.log(res);
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
    created(){
        let y = new Date(this.date).getFullYear(),
            m = new Date(this.date).getMonth();
        if(m<10){
            this.date=y+'-0'+m
        }else{
            this.date=y+'-'+m
        }
        this.getMonthData(m);
        this.getSalesDetail()
    },
    watch:{
        activeName(){
            this.currentPage=1;
            if(this.activeName==='management'){
                this.getProductList()
            }else if(this.activeName==='order'){
                this.getOrderList()
            }
        },
        orderNum(){
            if(this.orderNum===''){
                this.getOrderList()
            }
        }
    }

  }
</script>

<style lang="less">
  /*商品管理*/
  .management_table{
    position: relative;

    /*商品名称*/

      .product{
        .cell{
        display: flex;
        align-items: center;

          /*图片*/
          .product_img{
            width: 80px;
            height: 80px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 20px;
            img{
              width: 100%;
              height:100%;
            }
          }
          /*名称编号*/
          .product_text{
            .productName{
              font-size: 16px;
              color: #222;
              margin-bottom: 15px;
            }
            .productNbm{
              font-size: 12px;
              color: #999;
            }
          }
        }
      }

      .el-input__inner{
        color:#909399!important;
        font-weight:900!important;
        border:none!important;
      }
      .el-input__inner::placeholder{
        color:#909399!important;
        font-weight:900!important;
      }
      .el-input__inner::-webkit-input-placeholder{
          color:#909399!important;
          font-weight:900!important;
      }
      .el-input__inner::-moz-placeholder{  //不知道为何火狐的placeholder的颜色是粉红色，怎么改都不行，希望有大牛路过帮忙指点
          color:#909399!important;
          font-weight:900!important;
      }
      .el-input__inner:-ms-input-placeholder{  //由于我的IE刚好是IE9，支持不了placeholder，所以也测试不了(⊙﹏⊙)，有IE10以上的娃可以帮我试试
          color:#909399!important;
          font-weight:900!important;
      }
      .el-select .el-input .el-select__caret{
          color:#909399!important;
          font-weight:900!important;
      }


    /*评分*/
    .productRate{
      i{
        font-size: 14px;
        margin-right: 0;
      }
    }

    /*状态*/
    .productStatus{
      text-align: center;
      img{
        width: 32px;
        height: 32px;
        margin: 0 auto;
      }
    }

    /*操作*/
    .productOperating{
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      font-size: 14px;
      color: #666;
      word-wrap: unset;
      div{
        margin: 0 10px;
        cursor:pointer;
      }

      /*查看评论框*/
      /*.el-dialog__wrapper{*/
        /*display: flex;*/
        /*justify-content: center;*/
        /*align-items: center;*/
        /*.el-dialog{*/
          /*margin-top: 0 !important;*/
          /*position: relative;*/
          /*text-align: left !important;*/

          /*.el-dialog__headerbtn{*/
            /*top: 7px !important;*/
            /*z-index: 1;*/
          /*}*/
          /*.product_dialog_title{*/
            /*position: absolute;*/
            /*top: 0;*/
            /*left: 0;*/
            /*border-bottom: 1px solid #dedede;*/
            /*height: 30px;*/
            /*margin: 0 !important;*/
            /*width: 100%;*/
            /*padding-left: 15px;*/
            /*padding-top: 2px;*/
            /*padding-bottom: 2px;*/

            /*.icon{*/
              /*font-size: 24px !important;*/
            /*}*/
          /*}*/

          /*!*评论内容*!*/
          /*.product_evaluate_box:not(:last-child){*/
            /*border-bottom: 1px solid #dedede;*/
            /*padding-bottom: 10px;*/
            /*margin-bottom: 10px;*/
          /*}*/
          /*.product_evaluate_box{*/
            /*.product_evaluate_user{*/
              /*display: flex;*/
              /*justify-content: space-between;*/
              /*align-items: center;*/

              /*.product_evaluate_userName{*/
                /*display: flex;*/
                /*align-items: center;*/

                /*img{*/
                  /*width: 31px;*/
                  /*height: 31px;*/
                  /*border: 1px solid #15bafe;*/
                  /*border-radius: 4px;*/
                  /*overflow: hidden;*/
                  /*margin-right: 10px;*/
                /*}*/
                /*p{*/
                  /*font-size: 14px;*/
                  /*color: #000;*/
                /*}*/
              /*}*/

              /*.product_evaluate_rate{*/
                /*i{*/
                  /*font-size: 14px;*/
                  /*margin-right: 0;*/
                /*}*/
              /*}*/
            /*}*/

            /*.product_evaluate_time{*/
              /*font-size: 12px;*/
              /*color: #999;*/
              /*margin: 10px 0;*/
            /*}*/

            /*.product_evaluate_content{*/
              /*font-size: 16px;*/
              /*color: #666;*/
            /*}*/

            /*.product_evaluate_img_box{*/
              /*display: flex;*/
              /*align-items: center;*/
              /*flex-wrap: wrap;*/
              /*margin-top: 10px;*/
              /*.product_evaluate_img{*/
                /*width: 62px;*/
                /*height: 62px;*/
                /*display: flex;*/
                /*justify-content: center;*/
                /*align-items: center;*/
                /*margin-right: 5px;*/
                /*img{*/
                  /*width: 100%;*/
                /*}*/
              /*}*/
            /*}*/
          /*}*/
        /*}*/
      /*}*/
    }
  }

  /*订单详情*/
  .order_header{
    display: flex;
    align-items: center;
    justify-content:space-between;

    .order_date{
        display:flex;
        justify-content:flex-start;
        align-items:center;
        p{
            margin-right: 10px;
        }
    }

    .el-input-group{
        width:200px;
    }
  }

  .order_table{
      .el-input__inner{
          color:#909399!important;
          font-weight:900!important;
          border:none!important;
      }
      .el-input__inner::placeholder{
          color:#909399!important;
          font-weight:900!important;
      }
      .el-input__inner::-webkit-input-placeholder{
          color:#909399!important;
          font-weight:900!important;
      }
      .el-input__inner::-moz-placeholder{  //不知道为何火狐的placeholder的颜色是粉红色，怎么改都不行，希望有大牛路过帮忙指点
          color:#909399!important;
          font-weight:900!important;
      }
      .el-input__inner:-ms-input-placeholder{  //由于我的IE刚好是IE9，支持不了placeholder，所以也测试不了(⊙﹏⊙)，有IE10以上的娃可以帮我试试
          color:#909399!important;
          font-weight:900!important;
      }
      .el-select .el-input .el-select__caret{
          color:#909399!important;
          font-weight:900!important;
      }
      .el-table th{
          text-align:center!important;
      }
      .el-tag--success{
          color:#fff!important;
          background:#46cd17!important;
      }
      .el-tag--info{
          color:#fff!important;
          background:#cccccc!important;
      }
      .el-tag--error{
          color:#fff!important;
          background:#f55959!important;
      }
      .el-tag--primary{
          color:#fff!important;
          background:#15bafe!important;
      }
      .el-tag--orange{
          color:#fff!important;
          background:#ff9900!important;
      }
  }

  .orderInformation{
    >div{
      font-size: 12px;
      color: #999;
    }
    .orderName_main{
      display: flex;
      align-items: center;
      .orderName_main_img{
        width: 80px;
        height: 80px;
        img{
          width: 100%;
          height:100%;
        }
      }
      .orderName_main_text{
        width: 165px;
        p{
          font-size: 12px;
          color: #999;
        }
        h2{
          font-size: 14px;
          color: #333;
        }
      }
    }
  }
  .orderOperating{
    .cell{
      display: flex;
      justify-content: space-around;

      div{
          cursor:pointer;
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
<style src="../../assets/css/merchantWarehouse.css"></style>
<style>
 .merchantWarehouse_box .el-tabs__header{
    margin-bottom: 0 !important;
  }
  .merchantWarehouse_box .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background-color: #fff;
    color: #222 !important;
    font-size: 14px;
  }
  .merchantWarehouse_box .el-tabs--card>.el-tabs__header .el-tabs__item{
    font-size: 14px;
    color: #9f9f9f;
  }


  /*tab页跳转样式*/
  #tab-addProduct{
    background-color: #15bafe !important;
    color: #fff !important;
  }



 .merchantWarehouse_box  .el-tabs__content{
   background-color: #fff;
   padding: 20px;
   border: 1px solid #ebebeb;
   border-top: none;
 }
 .salesVolume_table .el-input__inner{
   height: 25px !important;
   line-height: 25px !important;
   border-radius: 50px !important;
   border: none !important;
 }

 .salesVolume_table .el-input__inner::placeholder{
   font-size: 12px;
   color: #666;
 }

 .salesVolume_table .el-input__icon{
   line-height: 19px !important;
 }
 .salesVolume_table .el-date-editor.el-input{
   width: 170px !important;
 }
 .salesVolume_table .el-date-editor .el-range-separator{
    width:auto!important;
    line-height:19px!important;
 }


 .order_header .el-date-editor .el-range-separator{
   font-size: 12px !important;
   width: 7% !important;
 }
</style>
