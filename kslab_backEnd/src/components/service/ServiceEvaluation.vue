<template>
    <div class="serviceEvaluation">
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <div class="serviceEvaluation_main">

        <div class="service_title">
          <div class="title">评分</div>
        </div>

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
                <div>5.5</div>
                <div>23</div>
                <div>123</div>
                <div>12</div>
                <div>35</div>
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
                <div>1234</div>
                <div>123</div>
                <div>12</div>
                <div>35</div>
                <div>123</div>
              </div>

            </div>
          </div>
        </div>

        <div class="score_table">
          <div class="score_table_header">
            <div class="score_header_time">
              <el-date-picker
                v-model="scoreTime"
                type="daterange"
                range-separator="至"
                start-placeholder="开始日期"
                end-placeholder="结束日期">
              </el-date-picker>
            </div>

            <div class="service_search">
              <div>
                <el-input placeholder="服务名称" v-model="serviceName" class="input-with-select">
                  <el-button slot="append" icon="el-icon-search"></el-button>
                </el-input>
              </div>

              <div>
                <el-input placeholder="昵称" v-model="nickName" class="input-with-select">
                  <el-button slot="append" icon="el-icon-search"></el-button>
                </el-input>
              </div>
            </div>
          </div>

          <div class="score_table_content">

            <el-table
              :data="tableData"
              :border="true"
              style="width: 100%">
              <el-table-column
                label="ID"
                align="center"
                width="65"
                sortable>
                <template slot-scope="scope">
                  <span>{{ scope.row.id}}</span>
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
                label="类别"
                align="center"
                :filters="[{text: '汽车', value: '汽车'}, {text: '摩托车', value: '摩托车'}, {text: '无人机', value: '无人机'}, {text: '智能设备', value: '智能设备'}]"
                :filter-method="filterSecondary"
                width="85">
                <template slot-scope="scope">
                  <p>{{ scope.row.category}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="二级目录"
                align="center"
                width="100">
                <template slot-scope="scope">
                  <p>{{ scope.row.directory}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="服务名称"
                align="center"
                width="125">
                <template slot-scope="scope">
                  <p>{{ scope.row.seviceName}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="城市"
                align="center"
                width="80">
                <template slot-scope="scope">
                  <p>{{ scope.row.city}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="评论内容"
                align="center"
                width="250">
                <template slot-scope="scope">
                  <p>{{ scope.row.evaluation}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="打分"
                align="center"
                width="80"
                sortable>
                <template slot-scope="scope">
                  <p>{{ scope.row.score}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="禁用类别"
                align="center"
                :filters="[
                {text: '不友善', value: '不友善'},
                {text: '无效评论', value: '无效评论'},
                 {text: '故意装怪', value: '故意装怪'},
                 {text: '色情', value: '色情'}
                 ]"
                :filter-method="filterSecondary"
                width="115">
                <template slot-scope="scope">
                  <p>{{ scope.row.sisableCategory}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="评论时间"
                align="center"
                width="125"
                sortable>
                <template slot-scope="scope">
                  <p>{{ scope.row.time}}</p>
                </template>
              </el-table-column>

              <el-table-column
                label="通过状态"
                align="center"
                width="90">
                <template slot-scope="scope">
                  <p><i class="iconfont icon-dian"></i> {{ scope.row.status}}</p>
                </template>
              </el-table-column>


              <el-table-column
                label="操作"
                align="center"
                class-name="service_scope">
                <template slot-scope="scope">
                  <div class="service_btm">
                    <div>禁用</div>
                    <div>删除</div>
                    <div>预览</div>
                    <div>恢复</div>
                  </div>
                </template>
              </el-table-column>
            </el-table>

          </div>
        </div>

        <div class="score_table_nbm">
          数量：150
        </div>

      </div>

      <!--禁用弹窗-->
      <el-dialog
        width="470px"
        custom-class="disableDialog"
        :visible.sync="disableDialog">
        <span slot="title" class="disableDialog_title"><i class="iconfont icon-jinyong"></i>禁用</span>
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

      <!--删除弹窗-->
      <DeleteModal></DeleteModal>

      <!--预览弹窗-->
      <el-dialog
        width="470px"
        custom-class="previewDialog"
        :visible.sync="previewDialog">
        <span slot="title" class="previewDialog_title"><i class="iconfont icon-chakan"></i>预览</span>
        <div class="previewDialog_box">
          <div class="box_top">
            <p>评价内容：</p>
            <div class="box_input">
              <el-input type="textarea" :row="3"></el-input>
            </div>
          </div>

          <div class="box_bottom">
            <p>图片：</p>
            <div class="photo">
              <div @click="bigPhoto = true"><img src="../../assets/image/cilun.jpg" alt=""></div>
              <div @click="bigPhoto = true"><img src="../../assets/image/cilun.jpg" alt=""></div>
              <div @click="bigPhoto = true"><img src="../../assets/image/cilun.jpg" alt=""></div>
            </div>
          </div>

          <el-dialog
            custom-class="bigPhoto"
            :visible.sync="bigPhoto"
            width="35%"
            append-to-body>
              <div class="bigPhoto"><img src="../../assets/image/cilun.jpg" alt=""></div>
          </el-dialog>

        </div>
        <span slot="footer" class="dialog-footer">
        <el-button @click="previewDialog = false">取 消</el-button>
        <el-button type="primary">确 定</el-button>
      </span>
      </el-dialog>

    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb'
  import DeleteModal from '@/components/public/modalDelete'

  export default {
    name: "ServiceEvaluation",
    components:{
      BreadCrumb,
      DeleteModal
    },
    data(){
      return{
        breadData:[{
          id: 1,
          name: '服务',
          urls: '/index/service/service',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '评价',
          urls: '/index/service/serviceEvaluation',
          icon: 'icon-home'
        }],
        scoreTime:'', // 表格时间
        serviceName:'', // 搜索服务名称
        nickName:'',  // 昵称搜索


        // 表格
        tableData: [{
          id: '1',
          nickName: '大颗颗',
          category:'汽车',
          directory:'改装',
          seviceName:'如何给汽车加油',
          city:'重庆',
          evaluation:'卧槽，你实在是太他妈的帅了 ',
          score: '5',
          sisableCategory: '不友善',
          time: '2018.11.27',
          status: '已通过',
        }, {
          id: '2',
          nickName: '大颗颗',
          category:'汽车',
          directory:'改装',
          seviceName:'如何给汽车加油',
          city:'重庆',
          evaluation:'卧槽，你实在是太他妈的帅了 ',
          score: '5',
          sisableCategory: '不友善',
          time: '2018.11.27',
          status: '已通过',
        }],

        disableDialog:false, // 禁用弹窗
        disableDialogRadio: null, //禁用单选框

        previewDialog: false,  // 预览弹窗
        bigPhoto: false,  // 预览大图

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
  .serviceEvaluation{
    .bread{
      margin: 10px;
    }
    .serviceEvaluation_main{
      margin-left: 10px;
      margin-top: 10px;
      background: #fff;
      height: calc(100vh - 87px);
      width: calc(100vw - 240px);
      border-radius: 2px;
      padding: 0 40px;
      box-sizing: border-box;
      text-align: left;

      .service_title{
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 70px;
        border-bottom: 2px solid #f2f2f2;
        margin-bottom: 30px;
        .title {
          font-size: 20px;
          color: #222;
        }
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


      /*表格*/
      .score_table{
        margin-top: 50px;
        margin-bottom: 30px;

        /*头部*/
        .score_table_header{
          display: flex;
          align-items: center;
          justify-content: space-between;

          /*搜索框*/
          .service_search{
            display: flex;
            align-items: center;
            >div{
              margin-left: 30px;
            }
          }

        }

        /*表格主体*/
        .score_table_content{
          margin-top: 30px;
          .el-table{
            thead{
              color: #fff;
              th,tr{
                background-color: #15bafe;
              }
            }
          }

          /*操作按钮*/
          .service_scope{
            padding: 0;
            .cell{
              line-height: unset;
              .service_btm{
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

      /*数量*/
      .score_table_nbm{
        display: inline-block;
        background: #15bafe;
        height: 40px;
        padding: 0 30px;
        line-height: 40px;
        text-align: center;
        margin: 0 auto 40px 0;
        color: #fff;
        font-size: 14px;
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

    /*预览弹窗*/
    .previewDialog{
      .previewDialog_title{
        display: flex;
        border-bottom: 1px solid #e8e8e8;
        padding-bottom: 10px;
        i{
          margin-right: 10px;
        }
      }
      .previewDialog_box{
        text-align: left;
        /*评价*/
        .box_top{
          margin-bottom: 20px;
          p{
            font-size: 14px;
            color: #222;
            margin-bottom: 10px;
          }
        }
        /*图片*/
        .box_bottom{
          p{
            font-size: 14px;
            color: #222;
            margin-bottom: 10px;
          }
          .photo{
            box-sizing: border-box;
            width: 100%;
            padding: 10px;
            border: 1px solid #dedede;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            border-radius: 4px;

            div{
              cursor: pointer;
              overflow: hidden;
              margin: 5px;
              width: 126px;
              height: 110px;
              display: flex;
              justify-content: center;
              align-items: center;
              img{
                width: 100%;
              }
            }

          }

        }
      }
    }
  }
  /*查看大图*/
  .bigPhoto{
    width: 100%;
    img{
      width: 100%;
    }
  }
</style>
