<template>
  <div class="questionDistribution">
    <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>

    <div class="question_main">
      <div class="question_title">
        <div class="title">专业目录分配</div>
      </div>

      <div class="question_header">
        <div class="question_select">
          <div class="date_item">
            <p class="date_label">开始</p>
            <el-date-picker
              v-model="startTime"
              class="date_picker_1"
              type="date"
              size="mini"
              placeholder="选择日期">
            </el-date-picker>
          </div>
          <div class="date_item">
            <p class="date_label">截止</p>
            <el-date-picker
              v-model="endTime"
              class="date_picker_1"
              type="date"
              size="mini"
              placeholder="选择日期">
            </el-date-picker>
          </div>
        </div>

        <div class="question_search">
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
            width="280">
            <template slot-scope="scope">
              <p>{{ scope.row.questionTitle}}</p>
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
            width="180">
          </el-table-column>

          <el-table-column
            label="是否分配"
            align="center"
            :filters="[{text: '已分配', value: '已分配'}, {text: '未分配', value: '未分配'}]"
            :filter-method="filterSecondary"
            prop='distribution'
            width="130">
          </el-table-column>

          <el-table-column
            label="通过时间"
            align="center"
            width="130"
            prop="time"
            sortable>
          </el-table-column>

          <el-table-column
            label="一级目录"
            align="center"
            width="130"
            prop="firstLevel">
          </el-table-column>

          <el-table-column
            label="二级目录"
            align="center"
            width="130"
            prop="doubleLevel">
          </el-table-column>

          <el-table-column
            label="三级目录"
            align="center"
            width="130"
            prop="thirdLevel">
          </el-table-column>

          <el-table-column
            label="操作"
            align="center"
            class-name="question_scope">
            <template slot-scope="scope">
              <div class="question_btm">
                <div>添加目录</div>
                <div>预览</div>
                <div>所有目录</div>
              </div>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </div>

    <!--添加目录弹窗-->
    <el-dialog
      width="470px"
      custom-class="addDirectoryDialog"
      :visible.sync="addDirectoryDialog">
      <span slot="title" class="addDirectoryDialog_title"><i class="iconfont icon-jia-xianxingfangkuang"></i>添加目录</span>
      <div class="addDirectoryDialog_box">
        <div class="box_list">
          <div class="box_list_title">学科板块：</div>
          <div class="box_list_main">


          </div>

        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="addDirectoryDialog = false">取 消</el-button>
        <el-button type="primary">确 定</el-button>
      </span>
    </el-dialog>


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
          name: '服务',
          urls: '/index/question/question',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '专业目录分配',
          urls: '/index/question/questionDistribution',
          icon: 'icon-home'
        }],

        startTime:'',  //开始时间
        endTime:'',  //结束时间
        topicSearch:'', // 题目搜索

        // 表格
        tableData: [{
          id: '1',
          questionTitle: '如何给汽车加油',
          plate:'汽车',
          subSection: '基本理论知识',
          distribution:'已分配',
          time:'2018.11.28',
          firstLevel:'液体',
          doubleLevel:'润滑油',
          thirdLevel:'有机润滑油',
        }, {
          id: '2',
          questionTitle: '如何给汽车加油',
          plate:'汽车',
          subSection: '基本理论知识',
          distribution:'已分配',
          time:'2018.11.28',
          firstLevel:'液体',
          doubleLevel:'润滑油',
          thirdLevel:'有机润滑油',
        }],

        addDirectoryDialog: false, // 添加目录弹窗
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
  .questionDistribution{
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
      }

      /*头部*/
      .question_header{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 30px 25px;

        .question_select{
          display: flex;
          .date_item{
            display: flex;
            border: 1px solid #dcdfe6;
            border-radius: 5px;
            margin-right: 20px;
            .el-input__inner{
              border: none !important;
            }
            .date_label{
              color: #808080;
              font-size: 12px;
              height: 28px;
              line-height: 28px;
              margin-left: 10px;
            }
            .date_picker_1{
              width: 140px;
            }
          }
        }


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

    /*添加目录弹窗*/
    .addDirectoryDialog{
      .addDirectoryDialog_title{
        display: flex;
        border-bottom: 1px solid #e8e8e8;
        padding-bottom: 10px;
        i{
          margin-right: 10px;
          display: flex;
          justify-content: center;
          align-items: center;
          color: #15bafe;
          font-size: 20px;
        }
      }

    }


  }
</style>
