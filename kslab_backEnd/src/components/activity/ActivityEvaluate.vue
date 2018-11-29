<template>
    <div>
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <div class="content">
        <p class="title">评价</p>

        <div class="score_box">
          <div class="score_list">
            <div class="score_left">
              评分
            </div>
            <div class="score_right">
              <div class="score_right_text">
                <div>平均分</div>
                <div>汽车</div>
                <div>摩托车</div>
                <div>无人机</div>
                <div>智能设备</div>
              </div>
              <div class="score_right_text">
                <div>{{scoreObj.avarge_score}}</div>
                <div>{{scoreObj.car}}</div>
                <div>{{scoreObj.motorcycle}}</div>
                <div>{{scoreObj.plane}}</div>
                <div>{{scoreObj.device}}</div>
              </div>

            </div>
          </div>
          <div class="score_list">
            <div class="score_left">
              评论
            </div>
            <div class="score_right">
              <div class="score_right_text">
                <div>评论总数</div>
                <div>汽车</div>
                <div>摩托车</div>
                <div>无人机</div>
                <div>智能设备</div>
              </div>
              <div class="score_right_text">
                <div>{{commentObj.total}}</div>
                <div>{{commentObj.car}}</div>
                <div>{{commentObj.motorcycle}}</div>
                <div>{{commentObj.plane}}</div>
                <div>{{commentObj.device}}</div>
              </div>

            </div>
          </div>
        </div>
        <div>
          <div class="conditions">
            <el-input class="select_normal" v-model="searchObj.nickName" placeholder="昵称" size="mini"> </el-input>
            <el-input class="select_normal" v-model="searchObj.useaName" placeholder="用户名" size="mini"> </el-input>
            <el-input class="search_length" v-model="searchObj.companyName" placeholder="活动名称" size="mini">
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
                prop="nickname"
                label="昵称"
                min-width="80">
              </el-table-column>
              <el-table-column
                prop="city_name"
                label="类别"
                width="80">
              </el-table-column>
              <el-table-column
                prop="company_name"
                label="二级目录"
                width="120">
              </el-table-column>
              <el-table-column
                prop="source_title"
                label="活动名称"
                width="120">
              </el-table-column>
              <el-table-column
                prop="modificationTime"
                label="城市"
                width="120">
              </el-table-column>
              <el-table-column
                prop="comment_num"
                label="评论内容"
                width="120">
              </el-table-column>
              <el-table-column
                prop="score"
                label="打分"
                width="120">
              </el-table-column>
              <el-table-column
                prop="modificationTime"
                label="是否有图片"
                width="120">
              </el-table-column>
              <el-table-column
                prop="modificationTime"
                label="禁用类别"
                width="120">
              </el-table-column>
              <el-table-column
                prop="modificationTime"
                label="评论时间排列"
                width="120">
              </el-table-column>
              <el-table-column
                prop="modificationTime"
                label="通过状态"
                width="120">
              </el-table-column>
              <el-table-column
                label="操作"
                width="240"
                fixed="right">
                <template slot-scope="scope">
                  <el-button size="small" type="text" @click="forbiddenModal(scope.$index)">禁用</el-button>
                  <el-button size="small" type="text" @click="deleteModal(scope.$index)">删除</el-button>
                  <el-button size="small" type="text" @click="viewModal(scope.$index)">预览</el-button>
                  <el-button size="small" type="text" @click="renewModal(scope.$index)">恢复</el-button>
                </template>
              </el-table-column>
            </el-table>
            <el-pagination
                      v-if="total"
                      layout="prev, pager, next"
                      :total="total"
                      :page-size="pageSize"
                      @current-change="currentChange"
              ></el-pagination>
          </div>
        </div>
      </div>
        <!-- 删除弹窗 -->
        <el-dialog :visible.sync="deleteVisible" width="300px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="delete_icon"></i>
                <span>删除</span>
            </div>
            <div>
                <img class="boolean_delete" :src="warmImg"/>
                <p>确定删除吗？</p>
            </div>
            <div slot="footer">
            <el-row class="row_e">
                <el-button class="btn_deletes" size="small" @click="deleteVisible = false">取消</el-button>
                <el-button type="primary" size="small"  class="btn_delete" @click="remove">提交</el-button>
            </el-row>
            </div>
        </el-dialog>
        <!--禁用框-->
        <el-dialog
        width="470px"
        custom-class="disableDialog"
        :visible.sync="forbiddenVisible">
        <span slot="title" class="disableDialog_title"><i class="iconfont icon-jinyong"></i>禁用</span>
        <div class="disable_dialog_box">
            <div class="disable_dialog_left">禁用类别：</div>
            <div class="disable_dialog_right">
                <el-radio border v-model="forbiddenDialogRadio" label="1">无效评论</el-radio>
                <el-radio border v-model="forbiddenDialogRadio" label="2">故意装怪</el-radio>
                <el-radio border v-model="forbiddenDialogRadio" label="3">色情</el-radio>
                <el-radio border v-model="forbiddenDialogRadio" label="4">不友善</el-radio>
            </div>
        </div>
        <span slot="footer" class="dialog-footer">
            <el-button @click="forbiddenVisible = false">取 消</el-button>
            <el-button type="primary" @click="forbidden">确 定</el-button>
        </span>
        </el-dialog>
        <!-- 预览 -->
        <el-dialog :visible.sync="viewVisible" width="600px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="delete_icon"></i>
                <span>预览</span>
            </div>
            <div>
                <el-form label-width="80px">
                    <el-form-item label="评论内容">
                        <el-input readonly v-model="viewObj.content"></el-input>
                    </el-form-item>
                    <el-form-item v-if="viewObj.attachment" label="图片">
                        <div v-for="pic in JSON.parse(viewObj.attachment)" :key="pic.path" class="pic">
                            <img class="pic" :src="pic.path"/>
                        </div>
                    </el-form-item>
                </el-form>
            </div>
        </el-dialog>
        <!-- 恢复弹窗 -->
        <el-dialog :visible.sync="renewVisible" width="300px">
            <div slot="title" class="dialog_delete_head_title">
                <i class="delete_icon"></i>
                <span>恢复</span>
            </div>
            <div>
                <img class="boolean_delete" :src="warmImg"/>
                <p>确定恢复吗？</p>
            </div>
            <div slot="footer">
            <el-row class="row_e">
                <el-button class="btn_deletes" size="small" @click="renewVisible = false">取消</el-button>
                <el-button type="primary" size="small"  class="btn_delete" @click="renew">提交</el-button>
            </el-row>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import BreadCrumb from "../public/BreadCrumb";
    export default {
      components: {BreadCrumb},
      data () {
        return {
            deleteVisible: false,
            forbiddenVisible: false,
            viewVisible: false,
            renewVisible: false,
            viewObj: {},
            forbiddenKey: null,
            forbiddenDialogRadio: '1',
            total: '',
            warmImg: require("../../assets/image/warm.png"),
            evaluateObj: {},
            searchObj: {},
            currentPage:1,//当前页
            pageSize:25,//每页显示数量
            tableData:[],
            markTableData: [],
            scoreObj: {
                avarge_score: null,
                car: null,
                motorcycle: null,
                plane: null,
                device: null
            },
            commentObj: {
                total: null,
                car: null,
                motorcycle: null,
                plane: null,
                device: null
            },
            breadData: [{
            id: 1,
            name: '活动',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '评价',
            urls: '/index/activity-evaluate',
            icon: 'icon-home'
          }],
        }
      },
      created() {
        this.init(null);
      },
      methods: {
        search() {
            this.init(this.searchObj);
        },
        async remove() {
            let res = await this.HttpClient.post('/admin/answers/changeStatus', {answer_id: this.evaluateObj.answer_id, status: 0});
            if(res.data.code == 200){
                this.deleteVisible = false;
                this.search();
                this.$message.success(res.data.msg);
            }else {
                this.$message.error(res.data.msg);
            }
        },
        async forbidden() {
            let res = await this.HttpClient.post('/admin/answers/changeStatus', {answer_id: this.evaluateObj.answer_id, status: 3, review: this.forbiddenDialogRadio});
            if(res.data.code == 200){
                this.forbiddenVisible = false;
                this.search();
                this.$message.success(res.data.msg);
            }else {
                this.$message.error(res.data.msg);
            }
        },
        async viewModal(index) {
            this.viewVisible = true;
            this.evaluateObj = this.tableData[index];
            let res = await this.HttpClient.post('/admin/answers/preview', {id: this.evaluateObj.id});
            this.viewObj = res.data.data;
        }, 
        async renew() {
            let res = await this.HttpClient.post('/admin/answers/changeStatus', {answer_id: this.evaluateObj.answer_id, status: 1});
            if(res.data.code == 200){
                this.renewVisible = false;
                this.search();
                this.$message.success(res.data.msg);
            }else {
                this.$message.error(res.data.msg);
            }
        },
        renewModal(index) {
            this.renewVisible = true;
            this.evaluateObj = this.tableData[index];
        } ,
        forbiddenModal(index) {
            this.evaluateObj = this.tableData[index];
            this.forbiddenVisible = true;
        },
        deleteModal(index) {
            this.evaluateObj = this.tableData[index];
            this.deleteVisible = true;
        },
        async currentChange(page) {
            this.currentPage = page;
            this.search();
        },
        async init(param) {
            let params = {
                type: 4,
                page: this.currentPage
            }
            if(param) {
                params['user_name'] = param.userName;
            }
            let res = await this.HttpClient.post('/admin/answers/getList', {type: 4, page: this.currentPage});
            this.tableData = res.data.data.data;
            this.total = res.data.data.total;
            let res1 = await this.HttpClient.post('/admin/answers/averageScore', {type: 'actives'});
            this.markTableData = res1.data.data;
            let score_average = 0;
            let comment_average = 0;
            for(let i in this.markTableData) {
                score_average += parseInt(this.markTableData[i].total_score);
                comment_average += parseInt(this.markTableData[i].total_count);
                if(this.markTableData[i].name === '汽车') {
                    this.scoreObj.car = this.markTableData[i].total_score;
                    this.commentObj.car = this.markTableData[i].total_count;
                }else if(this.markTableData[i].name === '摩托') {
                    this.scoreObj.motorcycle = this.markTableData[i].total_score;
                    this.commentObj.motorcycle = this.markTableData[i].total_count;
                }else if(this.markTableData[i].name === '无人机') {
                    this.scoreObj.plane = this.markTableData[i].total_score;
                    this.commentObj.plane = this.markTableData[i].total_count;
                }else if(this.markTableData[i].name === '智能设备') {
                    this.scoreObj.device = this.markTableData[i].total_score;
                    this.commentObj.device = this.markTableData[i].total_count;
                }
            }
            this.scoreObj.avarge_score = score_average / 4;
            this.commentObj.total = comment_average / 4;
        }
      }
    }
</script>

<style lang="less" scoped>
    .mark {
        margin-left: 10px;
        margin-top: 50px;
        width: 601px;
    }
    /*评分*/
      .score_box{
        .score_list{
          display: flex;
          align-items: center;
          height: 125px;
          margin-bottom: 20px;

          .score_left{
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 100px;
            background: #15bafe;
            color: #fff;
            font-size: 16px;
          }

          .score_right{
            flex: 1;
            height: 100%;

            .score_right_text{
              display: flex;
              align-items: center;
              height: 50%;
              div{
                box-sizing: border-box;
                height: 100%;
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                border: 1px solid #dedede;
                max-width: 115px;
              }
            }

          }

        }

      }
    /*禁用弹窗*/
    .disableDialog{
      .disableDialog_title{
        display: flex;
        border-bottom: 1px solid #e8e8e8;
        padding-bottom: 10px;
        i{
          margin-right: 10px;
        }
      }
      .disable_dialog_box{
        display: flex;
        align-items: flex-start;
        justify-content: center;
        flex-wrap:wrap;

          i{
              width:100%;
              font-size: 80px;
              color: #15bafe;
          }
          p{
              width:100%;
              font-size: 14px;
              color: #000;
              margin-top: 20px;
          }
          
        /*单选框*/
        .disable_dialog_right{
          display: flex;
          flex-wrap: wrap;
          align-items: center;
          justify-content: center;
          width: 275px;

          .el-radio__input{
              display: none;
            }
          /*单选框样式*/
          .el-radio:nth-child(1){
            margin-top: 0;
          }
          .el-radio.is-checked{
            background: #15bafe;
            border-color: #15bafe;
            .el-radio__label{
              color: #fff;
            }
          }
          .el-radio{
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 40px;
            width: 275px;
            margin: 10px auto;
            .el-radio__input{
              display: none;
            }
            .el-radio__label{
              padding: 0;
            }
          }
        }
      }
    }
    .pic {
        width: 100px;
        height: 100px;
        display: inline-block;
    }
  .space_bottom {
    margin-bottom: 20px;
  }
  .form_layout {
    display: flex;
  }
  .search_length {
    width: 160px;
    margin-right: 10px;
  }
  .form_item {
    display: inline-block;
    margin-right: 30px;
    width: 42%;
  }
  .bread{
    margin: 10px;
  }
  .delete_icon{
    color: #15bafe;
    font-size: 18px;
    top: 1px;
    position: relative;
  }
  .boolean_delete{
    height: 30px;
    width: 30px;
  }
  .dialog_delete_head_title{
    height: 16px;
    border-bottom: 1px solid #cccccc;
    padding-bottom: 10px;
    text-align: left;
    font-size: 15px;
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
    /*表格头*/
          .el-table__header-wrapper{
            .is-group{
              tr:nth-child(1){
                background: #15bafe;
                th{
                  background: #15bafe;
                  .cell{
                    color: #fff;
                  }
                }
              }
            }
          }
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
