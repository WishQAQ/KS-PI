<template lang="html">
    <div class="">
      <user-index-header></user-index-header>
      <div class="commercialTitle width_1200">
         <div class="commercial_button">
            <div class="">
              <router-link to="/home/commercial-activity">返回</router-link>
            </div>
            <div class="">{{$route.params.title}}</div>
         </div>
         <div class="commercial_padding_right">
           <div class="commercial_border">
             <input class="commercial_input_width" type="text" placeholder="姓名、电话">
             <i class="icon icon-ziyuan25"></i>
           </div>
         </div>
      </div>
      <div class="width_1200">
         <el-table
          ref="multipleTable"
          :data="tableData3"
          tooltip-effect="dark"
          style="width: 100%"
          @selection-change="handleSelectionChange">
          <el-table-column
            type="selection"
            width="55">
          </el-table-column>
          <el-table-column
            label="联系人"
            align="center"
            width="120">
            <template slot-scope="scope">{{ scope.row.conducts }}</template>
          </el-table-column>
          <el-table-column
            prop="name"
            label="联系电话"
            align="center"
            width="120">
          </el-table-column>
          <el-table-column
            prop="address"
            label="购买票数"
            align="center"
            show-overflow-tooltip>
            <template slot-scope="scope">{{ scope.row.quantity }}</template>
          </el-table-column>
          <el-table-column
            prop="address"
            label="已使用票数"
            align="center"
            show-overflow-tooltip>
            <template slot-scope="scope">{{ scope.row.use_num }}</template>
          </el-table-column>
          <el-table-column
            prop="address"
            label="退票数"
            align="center"
            show-overflow-tooltip>
            <template slot-scope="scope">{{ scope.row.refund_num }}</template>
          </el-table-column>
          <el-table-column
            prop="address"
            label="已到账"
            align="center"
            show-overflow-tooltip>
            <template slot-scope="scope">{{ scope.row.revenues }}</template>
          </el-table-column>
          <el-table-column
            prop="address"
            label="操作"
            align="center"
            show-overflow-tooltip>
            <template slot-scope="scope">
              <div class="commercial_operation">
                  <a class="" @click="ticketCheck(1,'','ac1',1)">验票</a>
                  <a class="">退款</a>
              </div>
            </template>
          </el-table-column>
        </el-table>
        <div style="margin-top: 20px" class="table_footer">
          <el-button @click="toggleSelection(tableData3)">全选</el-button>
          <el-pagination
            layout="prev, pager, next"
            :page-count="totalPage"
            @current-change="pageChange"
            @prev-click="prevPage"
            @next-click="nextPage"
            v-if="totalPage">
          </el-pagination>
          <el-button @click="toggleSelection()">退款</el-button>
        </div>
      </div>
    </div>
</template>

<script>
import UserIndexHeader from '@/components/commercialInfoHeader'
export default {
   data(){
     return{
       tableData3: [],
       multipleSelection: [],
       currentPage:1,//当前页
       pageSize:9,//每页显示条数
       totalPage:0,//总页数
     }
   },
   components:{
     UserIndexHeader,
   },
   methods: {
      //全选
      toggleSelection(rows) {
        if (rows) {
          rows.forEach(row => {
            this.$refs.multipleTable.toggleRowSelection(row);
          });
        } else {
          this.$refs.multipleTable.clearSelection();
        }
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      //当前页改变事件
      pageChange(p){
          this.currentPage=p;
          this.getValue()
      },
      //点击上一页
      prevPage(){},
      //点击下一页
      nextPage(){},

      //获取数据
      getValue(){
          let id=this.$route.params.id;
          this.HttpClient.get('/actives/signUpList',{active_id:id,page:this.currentPage,size:this.pageSize})
              .then(res=>{
                  console.log(res);
                  let {code,data,page_num} = res.data;
                  if(code===200){
                      this.tableData3=data;
                      this.totalPage=page_num;
                  }
              })
      },

      //验票
      ticketCheck(type,order_id,code,num){
          this.HttpClient.post('/actives/checkTicket',{type,order_id,code,num})
              .then(res=>{
                  console.log(res);
                  let {code,data,msg} = res.data;
                  if(code===200){
                      console.log(data);
                  }else{
                      this.$message.error(msg)
                  }
              })
      }
   },
   created(){
       this.getValue()
   }
}
</script>

<style lang="css">
.width_1200>.el-table{
  border:1px solid #dedede;
}
.commercial_operation>div:nth-child(2){
  cursor: pointer;
}
.commercial_operation>div:nth-child(1){
  margin-right: 30px;
  cursor: pointer;
}
.commercial_operation{
  display: flex;
  margin: 0 auto;
  padding-left: 40px;
}
.commercial_border>.icon-ziyuan25{
  margin-left: 10px;
  margin-right: 10px;
  color:#2ab0f7;
  cursor: pointer;
}
.commercial_border{
  border:1px solid #2ab0f7;
  border-radius: 15px;
  padding: 1px;
  padding-left: 15px;
}
.commercial_padding_right{
  padding: 13px 10px 0 0;
}
.commercial_input_width{
  width: 120px;
  border:0;
  border-right: 1px solid #2ab0f7;
}
.commercial_button>div:nth-child(2){
  font-size: 16px;
  padding: 13px 30px 0px 30px;
}
.commercial_button>div:nth-child(1){
  color:#999999;
  background-color: #ededed;
  padding: 13px 25px 13px 25px;
  font-size: 16px;
  border-right: 1px solid #dedede;
  cursor: pointer;
}
.commercial_button{
  display: flex;
  justify-content: space-between;
  border:1px solid #dedede;
}
.commercialTitle{
  border:1px solid #dedede;
  border-bottom: 0;
  display: flex;
  justify-content: space-between;
}
.table_footer{
    display:flex;
    justify-content:space-between;
}
</style>
