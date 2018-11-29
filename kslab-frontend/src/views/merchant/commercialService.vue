<template>

  <div class="commercialService appBackground service_start_table">
    <CommercialHead></CommercialHead>


    <div class="commercialService_box width_1200">

      <el-tabs v-model="activeName2" type="card" @tab-click="handleClick">
        <el-tab-pane label="已开始" name="first">

          <!--<el-table
            :data="tableData"
            class="start_table"
            style="width: 100%">
            <el-table-column
              label="主题"
              fixed
              width="250">
              <template slot-scope="scope">
                <div class="theme_head">
                  <img class="theme_img" src="http://cdn.kushualab.com/images/encyclopedias/20181012/15393096849254.png">
                  <span>123123123123123123123</span>
                </div>
              </template>
            </el-table-column>
            <el-table-column
              prop="number"
              label="关注人数"
              width="80">
            </el-table-column>
            <el-table-column
              prop="money"
              label="价格"
              width="150">
            </el-table-column>
            <el-table-column
              width="120"
              prop="addTime"
              label="创建时间">
            </el-table-column>
            <el-table-column label="总评分" width="170">
              <template slot-scope="scope">
                <el-rate
                  v-model="scopeValue"
                  disabled
                  :colors="['#15bafe', '#15bafe', '#15bafe']">
                </el-rate>
              </template>
            </el-table-column>
            <el-table-column
              label="状态"
              width="130">
              <template slot-scope="scope">
                <div class="commerciaStatus_icon">
                  <img src="/static/img/icon/userFalse.png" alt="">
                </div>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="190">
              <template slot-scope="scope">
                <div class="operate">
                  <p class="operate_edit">修改</p>
                  <p class="operate_edit">下架</p>
                </div>

                <el-dialog
                  title="提示"
                  :visible.sync="dialogVisible"
                  width="300px">
                  <span>此操作会导致活动立即下架<br />您是否确定？</span>
                  <span slot="footer" class="dialog-footer">
                  <el-button size="small" @click="dialogVisible = false">取 消</el-button>
                  <el-button size="small" type="primary" @click="dialogVisible = false">确 定</el-button>
                </span>
                </el-dialog>

              </template>
            </el-table-column>
          </el-table>-->
          <table class="start_table">
            <thead class="start_table_head">
              <th class="th1">主题</th>
              <th class="th2">关注人数</th>
              <th class="th3">价格</th>
              <th class="th4">创建时间</th>
              <th class="th5">总评分</th>
              <th class="th6">
                <el-dropdown trigger="click" @command="handleCommand">
                  <span class="el-dropdown-link">
                    {{statusLabel}}<i class="el-icon-arrow-down el-icon--right"></i>
                  </span>
                  <el-dropdown-menu slot="dropdown">
                    <el-dropdown-item command="1">正常</el-dropdown-item>
                    <el-dropdown-item command="2">未通过</el-dropdown-item>
                    <el-dropdown-item command="3">待审核</el-dropdown-item>
                    <el-dropdown-item command="6">已暂停</el-dropdown-item>
                  </el-dropdown-menu>
                </el-dropdown>
              </th>
              <th class="th7">操作</th>
            </thead>
            <tbody class="start_table_body">
              <tr v-for="(item, index) in serviceData" :key="index">
                <td class="td1">
                  <div class="td_theme">
                    <img class="td_theme_img" :src="handleImg(item.images?JSON.parse(item.images)[0].path:[])">
                    <p class="td_theme_title">{{item.title}}</p>
                  </div>
                </td>
                <td class="td2">
                  <p>{{item.view_num}}</p>
                </td>
                <td class="td3">
                  <p>{{item.price}}</p>
                </td>
                <td class="td4">
                  <p>{{item.created_at}}</p>
                </td>
                <td class="td5">
                  <el-rate
                    v-bind:value="item.score/2"
                    disabled
                    :colors="['#15bafe', '#15bafe', '#15bafe']">
                  </el-rate>
                </td>
                <td class="td6">
                  <p class="status_p" :class="
                    item.status===0?'bk_red':
                    item.status===1?'bk_blue':
                    item.status===2?'bk_hui':
                    item.status===3?'bk_yellow':
                    item.status===4?'bk_hui':
                    item.status===5?'bk_red':'bk_blue'
                  ">{{item.status===0?'删除':
                    item.status===1?'正常':
                    item.status===2?'下架':
                    item.status===3?'待审核':
                    item.status===4?'未通过':
                    item.status===5?'正在审核':
                    item.status===6?'已暂停':''
                    }}</p>
                </td>
                <td class="td7">
                  <div class="operate">
                    <p class="operate_edit" @click="handleJumpEdit(item.service_id)">修改</p>
                    <p class="operate_down" @click="handleDown(item.service_id)">下架</p>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>

          <div class="pagination">
            <el-pagination
              background
              @current-change="handlePageChange"
              layout="prev, pager, next"
              :total="total">
            </el-pagination>
          </div>

        </el-tab-pane>

        <el-tab-pane label="已结束" name="second">
          <table class="start_table">
            <thead class="start_table_head">
            <th class="th1">主题</th>
            <th class="th2">关注人数</th>
            <th class="th3">价格</th>
            <th class="th4">创建时间</th>
            <th class="th6">下架时间</th>
            <th class="th5">总评分</th>
            <th class="th7">操作</th>
            </thead>
            <tbody class="start_table_body">
            <tr v-for="(item, index) in serviceData" :key="index">
              <td class="td1">
                <div class="td_theme">
                  <img class="td_theme_img" :src="handleImg(item.images?JSON.parse(item.images)[0].path:[])">
                  <p class="td_theme_title">{{item.title}}</p>
                </div>
              </td>
              <td class="td2">
                <p>{{item.view_num}}</p>
              </td>
              <td class="td3">
                <p>{{item.price}}</p>
              </td>
              <td class="td4">
                <p>{{item.created_at}}</p>
              </td>
              <td class="td5">
                <p>{{item.expired_time}}</p>
              </td>
              <td class="td6">
                <el-rate
                  v-bind:value="item.score/2"
                  disabled
                  :colors="['#15bafe', '#15bafe', '#15bafe']">
                </el-rate>
              </td>
              <td class="td7">
                <div class="operate">
                  <p class="operate_edit" @click="handleJumpToEvaluate(item.service_id,item.title)">查看评价</p>
                  <p class="operate_down" @click="handleDeleteService(item.service_id)">删除</p>
                </div>
              </td>
            </tr>
            </tbody>
          </table>


          <div class="pagination">
            <el-pagination
              background
              @current-change="handlePageChange"
              layout="prev, pager, next"
              :total="total">
            </el-pagination>
          </div>

        </el-tab-pane>

        <el-tab-pane name="third">
          <span slot="label" @click="handleJumpToUpService">+上传服务</span>
        </el-tab-pane>
      </el-tabs>

    </div>
    <delete-modal :modelDelete="deleteVisible" @deleteModal="deleteModal"></delete-modal>

    <Floating></Floating>
  </div>

</template>


<script>
  import Floating from '@/components/floating'
  import CommercialHead from '@/components/commercialInfoHeader'
  import DeleteModal from '@/components/deleteModal'
  import * as cfg from "../../../config/app";

    export default {
      name: "commercialService",
      data(){
        return {
          statusLabel: '状态',
          activeName2: 'first',
          scopeValue: 4,
          gradeValue:4,
          dialogVisible: false,
          serviceData: [],
          page: 1,
          size: 10,
          total: null,
          typeStatus: null,
          deleteVisible: false,
          deleteId: '',
        }
      },
      mounted() {
        const param = {
          page: this.page,
          size: this.size,
          status: null
        };
        this.getServiceData(param);
      },
      methods: {
        deleteModal(value) {
          if(value) {
            this.deleteService(this.deleteId)
          }
          this.deleteVisible = false;
        },
        handleClick(tab, event) {
          console.log(tab, event);
          if(tab.name === 'third') {
            this.$router.push({
              path: '/home/uploading-service'
            })
          }else if(tab.name === 'first') {
            this.typeStatus = null;
            this.page = 1;
            const param = {
              page: this.page,
              size: this.size,
              status: this.typeStatus
            };
            this.getServiceData(param);
          }else if(tab.name === 'second') {
            this.typeStatus = 2;
            this.page = 1;
            const param = {
              page: this.page,
              size: this.size,
              status: this.typeStatus
            };
            this.getServiceData(param);
          }
        },
        deleteRow(index, rows) {
          rows.splice(index, 1);
        },
        handleCommand(command) {
          switch (parseInt(command)) {
            case 1:
              this.statusLabel = '正常';
              break;
            case 2:
              this.statusLabel = '未通过';
              break;
            case 3:
              this.statusLabel = '待审核';
              break;
            case 4:
              this.statusLabel = '已暂停';
              break;
          }
        },
        /***
         * 跳转到上传服务页
         */
        handleJumpToUpService() {
          this.router.push({
            path: '/home/uploading-service'
          })
        },
        /**
         * 获取服务数据
         * @param param
         */
        getServiceData(param) {
          this.HttpClient.post('/services/index',param).then(res =>{
            console.log(res.data)
            if(res.data.code === 200){
              this.serviceData = res.data.data.data;
              this.total = res.data.count;
            }
          })
        },
        /**
         * 图片格式
         * @param url
         * @returns {string}
         */
        handleImg(url) {
          return cfg.imageUrl+url;
        },
        /***
         * 翻面
         * @param value
         */
        handlePageChange(value) {
          this.page = value;
          const param = {
            page: this.page,
            size: this.size,
            status: this.typeStatus
          };
          this.getServiceData(param);
        },
          /***
           * 查看评论页面
           * @param id
           * @param title
           */
        handleJumpToEvaluate(id,title) {
          this.$router.push({
            path: '/home/merchantViewReviews',
            query: {
              id: id,
              title:title,
              type:'service'
            }
          })
        },
        /***
         * 删除服务
         * @param id
         */
        handleDeleteService(id) {
          this.deleteVisible = true;
          this.deleteId = id;
        },
        /***
         * 确定删除
         */
        deleteService(id) {
          this.HttpClient.post('/services/destroy',{service_id:id}).then(res =>{
            if(res.data.code === 200) {
              this.$message.success(res.data.msg);
              const param = {
                page: this.page,
                size: this.size,
                status: this.typeStatus
              };
              this.getServiceData(param);
            }else{
              this.$message.error(res.data.msg)
            }
          })
        },
        /***
         * 跳转到修改服务
         * @param id
         */
        handleJumpEdit(id) {
          this.$router.push({
            path: '/home/uploading-service',
            query: {
              id: id
            }
          })
        },
        /***
         * 服务下架
         * @param id
         */
        handleDown(id) {
          this.HttpClient.post('/services/expired',{service_id:id}).then(res => {
            if(res.data.code === 200) {
              this.$message.success(res.data.msg);
              const param = {
                page: this.page,
                size: this.size,
                status: this.typeStatus
              };
              this.getServiceData(param);
            }else {
              this.$message.error(res.data.message)
            }
          })
        }
      },
      components:{
        Floating,
        CommercialHead,
        DeleteModal
      }
    }
</script>

<style>

  .commercialService_box #tab-third{
    background-color: #15befe;
    color: #fff;
  }

  .commercialService_box .el-tabs__header{
    margin-bottom: 0 !important;
  }
  .commercialService_box .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background-color: #fff;
    color: #222 !important;
    font-size: 14px;
  }
  .commercialService_box .el-tabs--card>.el-tabs__header .el-tabs__item{
    font-size: 14px;
    color: #9f9f9f;
  }
  .commercialService_box .el-tabs__content{
    border: 1px solid #ebebeb;
    border-top: none;
  }
  .commercialService_box{
    padding-bottom: 20px;
  }
  .commercialService #tab-upload{
    background-color: #15bafe;
    color: #fff;
  }

 /* .commercialService .el-tabs__header{
    margin: 0 !important;
  }

  .commercialService .el-table__header,
  .commercialService .el-table__body{
    width: 100% !important;
  }



  .commercialService .el-table th > .cell{
    border-left: solid 1px #15befe !important;
    margin-right: -1px !important;
  }

  .commercialService.el-table td, .el-table th{
    padding: 20px 0 !important;
    font-size: 16px !important;
    color: #222 !important;
  }

  .commercialService td,
  .commercialService th{
    text-align: left;
  }
  .commercialService .pagination{
    text-align: center;
    padding-top: 20px;
    padding-bottom: 20px;
    background-color: #fff;
  }

  .commercialService .el-dialog{
    box-shadow: none !important;
    background-color: #f2f2f2;
  }

  .commercialService .el-dialog__body{
    padding: 30px 0;
    margin: 30px 0 0px 0;
    background-color: #fff;
    font-size: 16px;
    color: #666;
  }

  .commercialService .el-table{
    padding: 0 25px !important;
  }

  .commercialService .el-dialog__header{
    background-color: #15bafe !important;
  }
  .commercialService .el-dialog__header span{
    color: #fff !important;
    font-size: 20px;
  }

  .commercialService .el-button--small{
    border: none !important;
  }


  .commercialService .el-dialog__headerbtn{
    border: 2px solid #fff;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    font-size: 14px;
    text-align: center;
  }
  .commercialService .el-dialog__headerbtn i{
    color: #fff !important;
  }


  .operating_left{
    margin-right: 30px;
    color: #15bafe;
    font-size: 14px;
  }
  .operating_right{
    font-size: 14px;
    color: #666;
  }*/
</style>
<style lang="less">
  .bk_red{background: #FB2348}
  .bk_hui{background: #666666}
  .bk_yellow{background: #EDD600}
  .bk_blue{background: #15BAFE}
  .start_table{
    width: 100%;
  }
  /*table tr:nth-child(odd){*/
    /*background: #f2f2f2;*/
  /*}*/
  /*table tr:nth-child(even){*/
    /*background: white;*/
  /*}*/
  .start_table_head{
    width: 100%;
    th{
      background: white;
      height: 40px;
      line-height: 40px;
      text-align: center;
      color: #808080;
      border-bottom: 1px solid #f2f2f2;
    }
    .th1{
      width: 20%;
    }
    .th2{
      width: 10%;
    }
    .th3{
      width: 10%;
    }
    .th4{
      width: 15%;
    }
    .th5{
      width: 15%;
    }
    .th6{
      width: 10%;
      .status_th{
        display: flex;
      }
    }
    .th7{
      width: 20%;
    }
  }
  .start_table_body{
    tr{
      background: white;
      border-bottom: 1px solid #f2f2f2;
    }
    tr:hover{
      background: #F5F7FA;
    }
    td{
      padding-top: 10px;
      padding-bottom: 10px;
      vertical-align: middle;
      text-align: center;
    }
    .td1{
      .td_theme{
        display: flex;
        margin-left: 10px;
        justify-content: flex-start;
        align-items: center;
        .td_theme_img{
          width: 106px;
          height: 80px;
        }
        .td_theme_title{
          color: #404040;
          font-size: 12px;
          margin-left: 10px;
        }
      }
    }
    .td2{

    }
    .td3{

    }
    .td4{

    }
    .td5{

    }
    .td6{
      .status_p{
        padding: 5px 0px;
        border-radius: 5px;
        width: 70px;
        color: white;
        margin: 0 auto;
      }
    }
    .td7{
      .operate{
        display: flex;
        justify-content: center;
        p{
          cursor: pointer;
        }
        p:hover{
          color: #15bafe;
        }
        .operate_edit{
          margin-right: 20px;
        }
        .operate_down{

        }
      }
    }
  }
  .pagination{
    background: white;
    text-align: center;
    padding-top: 20px;
  }
</style>
