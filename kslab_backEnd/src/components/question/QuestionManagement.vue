<template>
    <div class="questionManagement">
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>

      <div class="question_main">
        <div class="question_title">
          <div class="title">问题管理</div>
        </div>

        <div class="question_header">
          <div class="question_select">
            <el-select v-model="value" placeholder="类型">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </div>

          <div class="question_search">
            <div>
              <el-input placeholder="昵称搜索" v-model="nickNameSearch" class="input-with-select">
                <el-button slot="append" icon="el-icon-search"></el-button>
              </el-input>
            </div>

            <div>
              <el-input placeholder="题目搜索" v-model="topicSearch" class="input-with-select">
                <el-button slot="append" icon="el-icon-search"></el-button>
              </el-input>
            </div>
          </div>
        </div>

        <div class="question_content">

          <el-table
            :data="tableData"
            :border="true"
            style="width: 100%">
            <el-table-column
              label="ID"
              align="center"
              width="65"
              prop="id"
              sortable>
            </el-table-column>
            <el-table-column
              label="问题题目"
              align="center"
              width="180">
              <template slot-scope="scope">
                <p>{{ scope.row.questionTitle}}</p>
              </template>
            </el-table-column>

            <el-table-column
              label="昵称"
              align="center"
              width="100">
              <template slot-scope="scope">
                <p>{{ scope.row.nickName}}</p>
              </template>
            </el-table-column>

            <el-table-column
              label="用户名"
              align="center"
              width="100">
              <template slot-scope="scope">
                <p>{{ scope.row.userName}}</p>
              </template>
            </el-table-column>

            <el-table-column
              label="字数"
              align="center"
              width="80">
              <template slot-scope="scope">
                <p>{{ scope.row.number}}</p>
              </template>
            </el-table-column>

            <el-table-column
              label="所属板块"
              align="center"
              width="110">
              <template slot-scope="scope">
                <p>{{ scope.row.plate}}</p>
              </template>
            </el-table-column>

            <el-table-column
              label="子类"
              align="center"
              :filters="[{text: '基本理论知识', value: '基本理论知识'}, {text: '发动机', value: '发动机'}]"
              :filter-method="filterSecondary"
              prop="subSection"
              width="130">
            </el-table-column>

            <el-table-column
              label="用户类别"
              align="center"
              :filters="[{text: '商家', value: '商家'}, {text: '用户', value: '用户'}]"
              :filter-method="filterSecondary"
              prop='category'
              width="130">
            </el-table-column>

            <el-table-column
              label="创建时间"
              align="center"
              width="130"
              prop="time"
              sortable>
            </el-table-column>

            <el-table-column
              label="通过状态"
              align="center"
              :filters="[{text: '未通过', value: '未通过'}, {text: '已通过', value: '已通过'}]"
              :filter-method="filterSecondary"
              width="120">
              <template slot-scope="scope">
                <p><i class="iconfont icon-dian"></i>{{ scope.row.status}}</p>
              </template>
            </el-table-column>

            <el-table-column
              label="审核状态"
              align="center"
              :filters="[{text: '未审核', value: '未审核'}, {text: '已审核', value: '已审核'}]"
              :filter-method="filterSecondary"
              prop="review"
              width="120">
            </el-table-column>

            <el-table-column
              label="操作"
              align="center"
              class-name="question_scope">
              <template slot-scope="scope">
                <div class="question_btm">
                  <div>批准</div>
                  <div>驳回</div>
                  <div>修改</div>
                  <div style="color: red">删除</div>
                  <div>预览</div>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>

      <!--驳回弹窗-->
      <el-dialog
        width="470px"
        custom-class="disableDialog"
        :visible.sync="disableDialog">
        <span slot="title" class="disableDialog_title"><i class="iconfont icon-jinyong"></i>驳回</span>
        <div class="disable_dialog_box">
          <div class="disable_dialog_left">理由：</div>
          <div class="disable_dialog_right">
            <el-input
              type="textarea"
              resize="none"
              :rows="4">
            </el-input>
          </div>
        </div>
        <div class="disable_dialog_box">
          <div class="disable_dialog_left">类别：</div>
          <div class="disable_dialog_right">
            <el-radio border v-model="disableDialogRadio" label="1">无效评论</el-radio>
            <el-radio border v-model="disableDialogRadio" label="2">故意装怪</el-radio>
            <el-radio border v-model="disableDialogRadio" label="3">色情</el-radio>
            <el-radio border v-model="disableDialogRadio" label="4">不友善</el-radio>
          </div>
        </div>
        <span slot="footer" class="dialog-footer">
        <el-button @click="disableDialog = false">取 消</el-button>
        <el-button type="primary">确 定</el-button>
      </span>
      </el-dialog>

      <!--批准弹窗-->
      <el-dialog
        :visible.sync="approveDialog"
        width="470px"
        custom-class="approveDialog">
        <span slot="title" class="approveDialog_title"><i class="iconfont icon-huaban4"></i></span>
        <div class="approveDialog_main">
          <i class="iconfont icon-warning-circle"></i>
          <div class="approveDialog_text">确认批准吗？</div>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="approveDialog = false">取 消</el-button>
          <el-button type="primary" @click="approveDialog = false">提 交</el-button>
        </span>
      </el-dialog>

      <!--删除弹窗-->
      <DeleteModal></DeleteModal>

    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb';
  import DeleteModal from '@/components/public/modalDelete'

  export default {
    name: "questionStatus",
    components: {
      BreadCrumb,
      DeleteModal
    },
    data(){
      return{
        // 面包屑
        breadData: [{
          id: 1,
          name: '问题',
          urls: '/index/question/question',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '问题管理',
          urls: '/index/question/questionManagement',
          icon: 'icon-home'
        }],

        // 筛选下拉
        options: [{
          value:'选项一',
          label:'全部'
        },{
          value:'选项二',
          label:'长期'
        }],
        value: '',

        nickNameSearch:'', // 昵称搜索
        topicSearch:'', // 题目搜索

        // 表格
        tableData: [{
          id: '1',
          questionTitle: '如何给汽车加油',
          nickName:'大颗颗',
          userName: '一个大颗颗',
          number:'50',
          plate:'汽车',
          subSection: '基本理论知识',
          category:'商家',
          time:'2018.11.28',
          status:'正常',
          review:'未审核',
        }, {
          id: '2',
          questionTitle: '如何给汽车加油',
          nickName:'大颗颗',
          userName: '一个大颗颗',
          number:'50',
          plate:'汽车',
          subSection: '基本理论知识',
          category:'商家',
          time:'2018.11.28',
          status:'正常',
          review:'未审核',
        }],

        disableDialog: false, // 驳回弹窗
        disableDialogRadio: null,

        textarea:'',

        remarkDialog: false,  // 备注信息弹窗

        approveDialog: false,  // 批准弹窗

        obtainedDialog: false ,  // 下架弹窗
      }
    },

    methods:{
      filterPlate(value, row, column) {
        const property = column['property'];
        return row[property] === value;
      },
      filterSecondary(value, row, column) {
        const property = column['property'];
        return row[property] === value;
      },

      handleRemove(file, fileList) {
        console.log(file, fileList);
      },
      handlePictureCardPreview(file) {
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
    }
  }
</script>

<style lang="less">
  .questionManagement{
    .bread{
      margin: 10px;
    }
    .question_main {
      margin-left: 10px;
      margin-top: 10px;
      background: #fff;
      height: calc(100vh - 87px);
      width: calc(100vw - 240px);
      border-radius: 2px;

      .question_title {
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 70px;
        border-bottom: 2px solid #f2f2f2;
        padding: 0 40px;
        .title {
          font-size: 20px;
          color: #222;
        }
        /*刷新*/
        .refresh {
          cursor: pointer;
          span {
            display: inline-block;
            margin-left: 10px;
          }
        }
      }

      /*头部*/
      .question_header{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 30px 25px;

        /*搜索框*/
        .question_search{
          display: flex;
          align-items: center;
          >div{
            margin-left: 30px;
          }
        }
      }

      /*表格*/
      .question_content{
        padding: 0 30px;

        .el-table{
          thead{
            color: #fff;
            th,tr{
              background-color: #15bafe;
            }
          }
        }

        /*操作按钮*/
        .question_scope{
          padding: 0;
          .cell{
            line-height: unset;
            .question_btm{
              display: flex;
              align-items: center;
              div:not(:last-child){
                border-right: 1px solid #ebeef5;
              }
              div{
                min-height: 47px;
                height: 100%;
                flex: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                cursor: pointer;
              }
            }
          }
        }
      }
    }

    /*驳回弹窗*/
    .disableDialog{
      .disableDialog_title{
        display: flex;
        border-bottom: 1px solid #e8e8e8;
        padding-bottom: 10px;
        i{
          margin-right: 10px;
        }
      }
      .disable_dialog_box:not(:last-child){
        margin-bottom: 20px;
      }
      .disable_dialog_box{
        display: flex;
        align-items: flex-start;
        justify-content: center;
        /*单选框*/
        .disable_dialog_right{
          display: flex;
          flex-wrap: wrap;
          align-items: center;
          justify-content: center;
          width: 275px;
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

    /*批准弹窗*/
    .approveDialog{
      .approveDialog_title{
        display: flex;
        align-items: center;
        i{
          font-size: 24px;
          color: #15bafe;
        }
      }
      .approveDialog_main{
        text-align: center;
        i{
          font-size: 80px;
          color: #15bafe;
        }
        p{
          font-size: 14px;
          color: #000;
          margin-top: 20px;
        }
      }
    }

  }
</style>
