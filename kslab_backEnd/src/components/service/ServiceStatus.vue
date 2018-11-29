<template>
    <div class="serviceStatus">
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>

      <div class="service_main">
        <div class="service_title">
          <div class="title">服务状态</div>
          <div class="refresh" @click="handleRefresh"><i class="iconfont icon-shuaxin"></i><span>刷新</span></div>
        </div>

        <div class="service_header">
          <div class="service_select">
            <el-select v-model="value" placeholder="状态选择" @change="handleChangeStateSearch($event)">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value"
                >
              </el-option>
            </el-select>
          </div>

          <div class="service_search">
            <div>
              <el-input placeholder="服务名称" v-model="serviceName" class="input-with-select">
                <el-button slot="append" icon="el-icon-search" @click="handleServiceName"></el-button>
              </el-input>
            </div>

            <!-- <div>
              <el-input placeholder="公司对外名称" v-model="companyName" class="input-with-select">
                <el-button slot="append" icon="el-icon-search"></el-button>
              </el-input>
            </div> -->
          </div>
        </div>

        <div class="service_content">

          <el-table
            :data="tableData"
            :border="true"
            style="width: 100%">
            <el-table-column
              sortable
              label="服务ID"
              align="center"
              width="65"
              prop="id"
              >
            </el-table-column>
            <el-table-column
              label="服务名称"
              align="center"
              prop="title"
              width="180">
            </el-table-column>
            <el-table-column
              label="城市"
              align="center"
              prop="city_name"
              width="180">
            </el-table-column>
            <el-table-column
              label="公司对外名称"
              align="center"
              prop="company_name"
              width="240">
            </el-table-column>

            <el-table-column
              label="价格"
              align="center"
              width="100"
              prop="price"
              sortable>
            </el-table-column>

            <el-table-column
              label="浏览人数"
              align="center"
              width="120"
              prop="view_num"
              sortable>
            </el-table-column>

            <el-table-column
              label="用户评价分数"
              align="center"
              width="140"
              prop="score"
              sortable>
            </el-table-column>

            <el-table-column
              label="状态"
              align="center"
              prop="status"
              :filters="[{text: '已删除', value:0 },{text: '正常', value:1 }, {text: '下架', value: 2}, {text: '待提交 ', value:3 },{text: '未通过', value: 4},{text: '待审核', value: 5}]"
              :filter-method="filterSecondary"
              width="100">
            </el-table-column>

            <el-table-column
              label="操作"
              align="center"
              class-name="service_scope">
              <template slot-scope="scope">
                <div class="service_btm">
                  <div>预览服务</div>
                  <div>基本信息</div>
                  <div>添加备注</div>
                  <div style="color: red">下架</div>
                  <div>结束服务</div>
                  <div>恢复</div>
                  <div>查看评价</div>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </div>

      <!--备注弹窗-->
      <el-dialog
        :visible.sync="remarkDialog"
        width="470px"
        custom-class="remarkDialog">
        <span slot="title" class="remarkDialog_title"><i class="iconfont icon-huaban4"></i></span>
        <div class="remarkDialog_main">
          <div class="remarkTitle">内容</div>
          <div class="remarkInput">
            <el-input
              type="textarea"
              :rows="3"
              placeholder="请输入内容"
              v-model="textarea">
            </el-input>
          </div>
          <div class="remarkTitle">历史</div>
          <div class="remarkHistory">
            <div>
              <div class="remarkHistoryUser"><i class="iconfont icon-dian"></i><p>大颗颗</p><span>2018/08/07 15:20</span></div>
              <p>联系了对方 愿意长期合作 联系了对方 愿意长期合作</p>
            </div>
          </div>

        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="remarkDialog = false">取 消</el-button>
          <el-button type="primary" @click="remarkDialog = false">提 交</el-button>
        </span>
      </el-dialog>

      <!--基本信息弹窗-->
      <el-dialog
        :visible.sync="basicInfoDialog"
        width="700px"
        custom-class="basicInfoDialog">
        <span slot="title" class="basicInfoDialog_title"><i class="iconfont icon-huaban4"></i></span>
        <div class="basicInfoDialog_main">

          <div class="main_list">
            <div class="main_list_input">
              <p>板块：</p>
              <div>汽车</div>
            </div>
            <div class="main_list_input">
              <p>二级目录：</p>
              <div>改装</div>
            </div>
          </div>

          <div class="main_list">
            <div class="main_list_input">
              <p>城市：</p>
              <div>重庆</div>
            </div>
            <div class="main_list_input">
              <p>详细地址：</p>
              <div>重庆渝中区英利国际2号楼11-5</div>
            </div>
          </div>

          <div class="main_list">
            <div class="main_list_input">
              <p>负责人：</p>
              <div>大颗颗</div>
            </div>
            <div class="main_list_input">
              <p>电话：</p>
              <div>12312341234</div>
            </div>
          </div>

          <div class="upload">
            <div class="protocol">
              <el-upload
                action="https://jsonplaceholder.typicode.com/posts/"
                list-type="picture-card"
                :on-preview="handlePictureCardPreview"
                :on-remove="handleRemove">
                <i class="el-icon-plus"></i>
              </el-upload>
              <div class="el-upload__text">上传的安全协议</div>
              <el-dialog :visible.sync="dialogVisible">
                <img width="100%" :src="dialogImageUrl" alt="">
              </el-dialog>
            </div>

            <div class="annex">
              <el-upload
                action="https://jsonplaceholder.typicode.com/posts/"
                list-type="picture-card"
                :on-preview="handlePictureCardPreview"
                :on-remove="handleRemove">
                <i class="el-icon-plus"></i>
              </el-upload>
              <div class="el-upload__text">上传的附件<br />图片为此公司现场的图片，或者计划书等</div>
              <el-dialog :visible.sync="dialogVisible">
                <img width="100%" :src="dialogImageUrl" alt="">
              </el-dialog>
            </div>
          </div>
        </div>
      </el-dialog>

      <!--结束服务弹窗-->
      <el-dialog
        :visible.sync="endDialog"
        width="470px"
        custom-class="endDialog">
        <span slot="title" class="endDialog_title"><i class="iconfont icon-huaban4"></i></span>
        <div class="endDialog_main">
          <el-input
            type="textarea"
            :rows="3"
            placeholder="请输入结束服务原因"
            v-model="endTextarea">
          </el-input>
          <div class="endDialog_text">确定结束服务吗？此操作将导致服务下架。</div>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="endDialog = false">取 消</el-button>
          <el-button type="primary" @click="endDialog = false">提 交</el-button>
        </span>
      </el-dialog>

      <!--下架弹窗-->
      <el-dialog
        :visible.sync="obtainedDialog"
        width="470px"
        custom-class="obtainedDialog">
        <span slot="title" class="obtainedDialog_title"><i class="iconfont icon-huaban4"></i></span>
        <div class="obtainedDialog_main">
          <i class="iconfont icon-warning-circle"></i>
          <p>确定下架商品吗？</p>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="obtainedDialog = false">取 消</el-button>
          <el-button type="primary" @click="obtainedDialog = false">提 交</el-button>
        </span>
      </el-dialog>

    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb';
  export default {
    name: "ServiceStatus",
    components: {
      BreadCrumb,
    },
    data(){
      return{
        // 面包屑
        breadData: [{
          id: 1,
          name: '服务',
          urls: '/index/service/service',
          icon: 'icon-home'
        }, {
          id: 2,
          name: '服务状态',
          urls: '/index/service/serviceStatus',
          icon: 'icon-home'
        }],

        // 筛选下拉
        options: [{
          value:'',
          label:'全部'
        },{
          value:'0',
          label:'已删除'
        },{
          value:'1',
          label:'正常'
        },{
          value:'2',
          label:'下架'
        },{
          value:'3',
          label:'待提交'
        },{
          value:'4',
          label:'未通过'
        },{
          value:'5',
          label:'待审核'
        }],
        value: '',

        serviceName:null, // 搜索服务名称
        // companyName:'', // 搜索公司对外名称

        // 表格
        tableData: [],

        basicInfoDialog: false, // 基本信息弹窗
        dialogImageUrl: '',
        dialogVisible: false,

        textarea:'',

        remarkDialog: false,  // 备注信息弹窗

        endDialog: false,  // 结束服务弹窗
        endTextarea:'',

        obtainedDialog: false ,  // 下架弹窗
        state:null, //状态搜索暂存的状态值
        serviceTitle:null, //服务标题搜索暂存标题
      }
    },
    mounted(){
      this.getServiceList(this.state,this.serviceTitle);
    },
    methods:{
      //刷新页面
      handleRefresh(){
        window.location.reload();
      },
      //根据服务标题请求数据
      handleServiceName(){
        console.log(this.state,this.serviceName)
          this.getServiceList(this.state,this.serviceName);
      },
      //根据状态请求数据
      handleChangeStateSearch(e){
          this.state = e;
          this.getServiceList(this.state,this.serviceName);
      },
      //请求服务列表数据
      getServiceList(state,serviceTitle){
          this.HttpClient.post('/admin/services/lists',{
              status:state,
              title:serviceTitle,
          })
          .then(res=>{ 
              console.log(res)
              this.tableData = res.data.data.data;
              if(res.data.code === 200){
                  this.state = null;
                  this.serviceName = null;
              }
          })
      },
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
  .serviceStatus{
    .bread{
      margin: 10px;
    }
    .service_main {
      margin-left: 10px;
      margin-top: 10px;
      background: #fff;
      height: calc(100vh - 87px);
      width: calc(100vw - 240px);
      border-radius: 2px;

      .service_title {
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
      .service_header{
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 30px 25px;

        /*搜索框*/
        .service_search{
          display: flex;
          align-items: center;
          >div{
            margin-left: 30px;
          }
        }
      }

      /*表格*/
      .service_content{
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

    /*备注弹窗*/
    .remarkDialog{
      .el-dialog__body{
        padding: 0 20px;
      }
      .remarkDialog_title{
        display: flex;
        align-items: center;
        padding-bottom: 10px;
        i{
          font-size: 24px;
          color: #15bafe;
        }
      }
      .remarkDialog_main{
        .remarkTitle{
          text-align: left;
          margin-bottom: 5px;
        }
        .remarkInput{
          margin-bottom: 20px;
        }
        .remarkHistory{
          max-height: 270px;
          overflow: auto;
          >div:not(:last-child){
            margin-bottom: 15px;
          }
          .remarkHistoryUser{
            display: flex;
            align-items: center;
            margin-bottom: 5px;
            i{
              color: #15bafe;
              margin-right: 5px;
            }
            p{
              font-size: 14px;
              color: #222;
              margin-right: 8px;
            }
            span{
              font-size: 12px;
              color: #15bafe;
            }
          }
          .remarkHistoryUser~p{
            text-align: left;
            font-size: 12px;
            color: #666;
            padding-left: 20px;
          }
        }


      }


    }

    /*基本信息弹窗*/
    .basicInfoDialog{
      .el-dialog__body{
        padding: 0 20px 30px 20px;
      }
      .basicInfoDialog_title{
        display: flex;
        align-items: center;
        padding-bottom: 10px;
        i{
          font-size: 24px;
          color: #15bafe;
        }
      }

      .basicInfoDialog_main{
        .main_list{
          display: flex;
          align-items: center;
          justify-content: space-around;
          margin: 15px 0;
          .main_list_input:not(:nth-child(1)){
            margin-left: 50px;
          }
          .main_list_input{
            display: flex;
            align-items: center;
            flex: 1;
            color: #000;
            font-size: 14px;
            p{
              width: 90px;
              text-align: justify;
            }
            div{
              border: 1px solid #e6e6e6;
              padding: 10px 10px;
              min-height: 15px;
              flex: 1;
              text-align: center;
            }
          }
        }

        /*预览框*/
        .upload{
          display: flex;
          align-items: center;
          justify-content: space-between;
          >div:not(:nth-child(1)){
            margin-left: 30px;
          }
          >div{
            padding: 5px 10px;
            min-height: 160px;
            flex: 1;
            border: 1px solid #dedede;
            text-align: left;

            .el-upload--picture-card{
              width: 80px;
              height: 80px;
              line-height: 80px;
            }
            .el-upload-list--picture-card .el-upload-list__item{
              width: 80px;
              height: 80px;
              line-height: 80px;
              margin: 0;
            }

            .el-upload__text{
              text-align: center;
            }

            .el-upload-list--picture-card .el-progress{
              width: 70px;
              .el-progress-circle{
                width: 70px !important;
                height: 70px !important;
              }
            }

          }
        }

      }
    }

    /*结束服务弹窗*/
    .endDialog{
      .el-dialog__body{
        padding: 0 20px;
      }
      .endDialog_title{
        display: flex;
        align-items: center;
        padding-bottom: 10px;
        i{
          font-size: 24px;
          color: #15bafe;
        }
      }
      .endDialog_main{
        .endDialog_text{
          display: flex;
          justify-content: center;
          align-items: center;
          height: 75px;
          border: 1px solid #dedede;
          margin-top: 10px;
          border-radius: 4px;
          font-size: 14px;
          color: #aaa;
        }
      }
    }

    /*下架弹窗*/
    .obtainedDialog{
      .el-dialog__body{
        padding: 0 20px;
      }
      .obtainedDialog_title{
        display: flex;
        align-items: center;
        padding-bottom: 10px;
        i{
          font-size: 24px;
          color: #15bafe;
        }
      }

      .obtainedDialog_main{
        text-align: center;
        i{
          margin-bottom: 20px;
          color: #15bafe;
          font-size: 80px;
        }
        p{
          margin: 10px 0;
          font-size: 14px;
          color: #222;
        }
      }

    }

  }
</style>
