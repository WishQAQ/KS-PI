<template>
    <div>
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <div class="content">
        <p class="title">活动被修改</p>
        <div>
          <div class="conditions">
            <el-input class="select_normal" v-model="searchObj.activityName" placeholder="活动名称" size="mini"> </el-input>
            <el-input class="search_length" v-model="searchObj.companyName" placeholder="商家对外名称" size="mini">
              <el-button slot="append" @click="search" icon="el-icon-search"></el-button>
            </el-input>
        </div>
        <div class="tables">
            <el-table
              :data="tableData"
              border
              :stripe="true"
              style="width: 100%">
              <el-table-column
                prop="id"
                label="ID"
                width="50">
              </el-table-column>
              <el-table-column
                prop="title"
                label="活动名称"
                min-width="200">
              </el-table-column>
              <el-table-column
                prop="city_name"
                label="城市"
                width="80">
              </el-table-column>
              <el-table-column
                prop="company_name"
                label="商家对外名称"
                width="120">
              </el-table-column>
              <el-table-column
                prop="preModificationState"
                label="修改前状态"
                width="120">
              </el-table-column>
              <el-table-column
                prop="modificationTime"
                label="修改时间"
                width="120">
              </el-table-column>
              <el-table-column
                label="操作"
                width="240"
                fixed="right">
                <template slot-scope="scope">
                  <el-button size="small" type="text" @click="viewActivity">预览活动</el-button>
                  <el-button size="small" type="text" @click="passModal(scope.$index)">通过</el-button>
                  <el-button size="small" type="text" @click="rejectInfo(scope.$index)">驳回</el-button>
                  <el-button size="small" type="text" @click="basicInfo(scope.$index)">基本信息</el-button>
                </template>
              </el-table-column>
            </el-table>
          </div>
        </div>
      </div>
      <!-- 通过弹窗 -->
      <el-dialog :visible.sync="passVisible" width="400px">
        <div>
          <span>确定通过吗？</span>
        </div>
        <div slot="footer">
          <el-row class="row_e">
            <el-button size="small" @click="passVisible = false">取消</el-button>
            <el-button size="small" type="primary" @click="pass">提交</el-button>
          </el-row>
        </div>
      </el-dialog>
      <!-- 驳回弹窗 -->
      <el-dialog :visible.sync="rejectVisible" width="400px">
        <div slot="title" class="dialog_head_title">
          <span>驳回</span>
        </div>
        <div>
          <p class="space_bottom">驳回理由</p>
          <el-input v-model="rejectReason" type="textarea" rows="3" max="300px" class="reject_input space_bottom" clearable size="mini"/>
          <p class="space_bottom">驳回类别选择</p>
          <div>
            <el-button size="small" v-for="reject in rejectData" @click="handleReject(reject)" :key="reject.id" :class="reject.id===rejectValue?'btns_s':'btns'">
              {{reject.name}}
            </el-button>
          </div>
        </div>
        <div slot="footer">
          <el-row class="row_e">
            <el-button class="btn_deletes" size="small" @click="rejectVisible = false">取消</el-button>
            <el-button type="primary" size="small"  class="btn_delete" @click="reject">提交</el-button>
          </el-row>
        </div>
      </el-dialog>
      <!-- 基本信息弹窗 -->
      <el-dialog :visible.sync="basicInfoVisible" width="700px">
        <div slot="title" class="dialog_head_title">
          <span>基本信息</span>
        </div>
        <el-form label-width="100px">
          <el-form-item label="活动开始时间" class="form_item">
            <el-input v-model="basicInfoObj.active_date_start" readonly></el-input>
          </el-form-item>
          <el-form-item label="活动结束时间" class="form_item">
            <el-input v-model="basicInfoObj.active_date_end" readonly></el-input>
          </el-form-item>
          <el-form-item label="报名截止日期" class="form_item">
            <el-input v-model="basicInfoObj.registration_deadline" readonly></el-input>
          </el-form-item>
          <el-form-item label="模块" class="form_item">
            <el-input v-model="basicInfoObj.folder_name" readonly></el-input>
          </el-form-item>
          <el-form-item label="二级目录" class="form_item">
            <el-input v-model="basicInfoObj.folder_name" readonly></el-input>
          </el-form-item>
          <el-form-item label="城市" class="form_item">
            <el-input v-model="basicInfoObj.city_name" readonly></el-input>
          </el-form-item>
          <el-form-item label="详细地址" class="form_item">
            <el-input v-model="basicInfoObj.address" readonly></el-input>
          </el-form-item>
          <el-form-item label="活动负责人" class="form_item">
            <el-input v-model="basicInfoObj.promotee" readonly></el-input>
          </el-form-item>
          <el-form-item label="电话" class="form_item">
            <el-input v-model="basicInfoObj.telphone" readonly></el-input>
          </el-form-item>
          <el-form-item label="结束时间" class="form_item">
            <el-input v-model="basicInfoObj.active_date" readonly></el-input>
          </el-form-item>
          <el-form-item label="安全协议" class="form_item">
            <el-button type="primary"	size="medium">下载</el-button>
          </el-form-item>
          <el-form-item label="附件" class="form_item">
            <el-button type="primary"	size="medium">下载</el-button>
          </el-form-item>
        </el-form>
        <div slot="footer">
          <el-row class="row_e">
            <el-button class="btn_deletes" @click="basicInfoVisible = false">关闭</el-button>
          </el-row>
        </div>
      </el-dialog>
    </div>
</template>

<script>
    import BreadCrumb from "../public/BreadCrumb";
    export default {
      name: "ActivityModify",
      components: {BreadCrumb},
      data () {
        return {
          passVisible: false,
          rejectVisible: false,
          basicInfoVisible: false,
          searchObj: {},
          basicInfoObj: {},
          rejectReason: '',
          activityObj: '',
          rejectValue: '',
          reviewId: '',
          breadData: [{
            id: 1,
            name: '活动',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '活动被修改',
            urls: '/index/activity-modify',
            icon: 'icon-home'
          }],
          rejectData: [],
          tableData:[]
        }
      },
      created() {
        this.init(null);
      },
      methods: {
        search() {
          console.log('search');
          this.init(this.searchObj);
        },
        viewActivity() {

        },
        passModal(index) {
          this.activityObj = this.tableData[index];
          this.passVisible = true;
        },
        async pass() {
          let res = await this.HttpClient.post('/admin/actives/changeStatus', {active_id: this.activityObj.active_id, status: 1});
          if(res.data.code == 200){
            this.passVisible = false;
            this.search();
            this.$message.success(res.data.msg);
          }else {
            this.$message.error(res.data.msg);
          }
        },
        async reject() {
          let res = await this.HttpClient.post('/admin/actives/changeStatus', {active_id: this.activityObj.active_id, status: 3, refuse: this.rejectReason, review_id: this.reviewId});
          if(res.data.code == 200){
            this.rejectVisible = false;
            this.search();
            this.$message.success(res.data.msg);
          }else {
            this.$message.error(res.data.msg);
          }
        },
        async basicInfo(index) {
          this.basicInfoVisible = true;
          this.activityObj = this.tableData[index];
          let res = await this.HttpClient.post('/admin/actives/baseInfo', {id: this.activityObj.id});
          this.basicInfoObj = res.data.data;
          console.log('basicInfo:', this.basicInfoObj);
        },
        async rejectInfo(index) {
          this.activityObj = this.tableData[index];
          let res = await this.HttpClient.post('/admin/webReview/getList', {type: 'active'});
          this.rejectData = res.data.data;
          this.rejectVisible = true;
        },
        handleReject(item) {
          this.rejectValue = item.id;
          this.reviewId = item.review_id;
        },
        async init(param) {
          let params = {
            status: 3
          }
          if(param) {
            params['title'] = param.activityName;
            params['company_name'] = param.companyName;
          }
          let res = await this.HttpClient.post('/admin/actives/lists', params);
          this.tableData = res.data.data.data;
        }
      }
    }
</script>

<style scoped>
  .space_bottom {
    margin-bottom: 20px;
  }
  .search_length {
    width: 160px;
    margin-right: 10px;
  }
  .form_layout {
    display: flex;
  }
  .form_item {
    display: inline-block;
    margin-right: 30px;
    width: 42%;
  }
  .bread{
    margin: 10px;
  }
  .content{
    background: white;
    margin-left: 10px;
    margin-right: 10px;
    height: calc(100vh - 87px);
    width: calc(100vw - 221px);
    border-radius: 2px;
  }
  .title{
    text-align: left;
    padding: 10px;
    padding-left: 20px;
    font-size: 14px;
    border-bottom: 1px solid #f2f2f2;
  }
  .conditions{
    display: flex;
    margin-left: 10px;
    margin-top: 20px;
  }
  .select_normal{
    width: 120px;
    margin-right: 10px;
  }
  .tables{
    margin: 20px 10px;
  }
  .row_activity{
    width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
  .dialog_head_title{
    height: 16px;
    border-bottom: 1px solid #cccccc;
    padding-bottom: 10px;
    text-align: left;
    font-size: 15px;
  }
  .examine_icon{
    color: #15bafe;
  }
  .up_safe{
    height: 120px;
    border: 1px solid #f2f2f2;
  }
  .up_img{
    height: 130px;
    border: 1px solid #f2f2f2;
    margin-top: 10px;
    display: grid;
  }
  .remark{
    text-align: left;
    margin-left: 10px;
  }
  .row_e{
    text-align: center;
  }
  .btn_delete{
    padding: 5px 15px;
    margin-left: 30px;
  }
  .btn_deletes{
    padding: 5px 15px;
  }
  .el-table th>.cell{
    text-align: center;
  }
  .btns{
    width: 100%;
    margin-left: 0;
    margin-bottom: 10px;
  }
  .btns_s{
    width: 100%;
    margin-left: 0;
    margin-bottom: 10px;
    color: white;
    background: #409EFF;
  }
</style>

