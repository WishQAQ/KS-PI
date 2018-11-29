<template>
    <div>
      <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
      <div class="content">
        <p class="title">页面权限管理</p>
        <!--<div class="conditions">-->
          <!--<div>-->
            <!--<el-select size="mini" class="select_normal" v-model="arrayValue" placeholder="排列">-->
              <!--<el-option-->
                <!--v-for="item in arrayOptions"-->
                <!--:key="item.value"-->
                <!--:label="item.label"-->
                <!--:value="item.value">-->
              <!--</el-option>-->
            <!--</el-select>-->
            <!--<el-input-->
              <!--class="select_normal"-->
              <!--placeholder="搜索名称"-->
              <!--size="mini"-->
              <!--suffix-icon="el-icon-search"-->
              <!--v-model="search_name">-->
            <!--</el-input>-->
            <!--<el-input-->
              <!--class="select_normal"-->
              <!--placeholder="搜索方法"-->
              <!--size="mini"-->
              <!--suffix-icon="el-icon-search"-->
              <!--v-model="search_method">-->
            <!--</el-input>-->
          <!--</div>-->
          <!--<el-button @click="addVisible = true" type="primary" size="mini" icon="el-icon-circle-plus-outline">新增权限</el-button>-->
        <!--</div>-->
        <!--<div class="tabs">-->
          <!--<el-table-->
            <!--:data="tableData"-->
            <!--border-->
            <!--:stripe="true"-->
            <!--:header-row-style="{height:'40px'}"-->
            <!--:header-cell-style="{padding:0,background:'#15bafe',color:'white'}"-->
            <!--:row-style="{height:'40px'}"-->
            <!--:cell-style="{padding:0}"-->
            <!--style="width: 100%">-->
            <!--<el-table-column-->
              <!--prop="id"-->
              <!--label="ID"-->
              <!--width="50">-->
            <!--</el-table-column>-->
            <!--<el-table-column-->
              <!--label="权限名称"-->
              <!--min-width="200">-->
              <!--<template slot-scope="scope">-->
                <!--<span class="row_activity">{{scope.row.jurisdictionName}}</span>-->
              <!--</template>-->
            <!--</el-table-column>-->
            <!--<el-table-column-->
              <!--prop="description"-->
              <!--label="介绍"-->
              <!--width="200">-->
            <!--</el-table-column>-->
            <!--<el-table-column-->
              <!--prop="method"-->
              <!--label="模块和方法">-->
            <!--</el-table-column>-->
            <!--<el-table-column-->
              <!--prop="createTime"-->
              <!--label="创建时间"-->
              <!--width="120">-->
            <!--</el-table-column>-->
            <!--<el-table-column-->
              <!--prop="updateTime"-->
              <!--label="修改时间"-->
              <!--width="120">-->
            <!--</el-table-column>-->
            <!--<el-table-column-->
              <!--label="操作"-->
              <!--width="240"-->
              <!--fixed="right">-->
              <!--<template slot-scope="scope">-->
                <!--<el-button size="small" type="text">修改</el-button>-->
                <!--<el-button size="small" type="text">删除</el-button>-->
              <!--</template>-->
            <!--</el-table-column>-->
          <!--</el-table>-->
        <!--</div>-->
          <div class="user_page_jurisdiction">
              <div class="user_page_select">用户选择</div>
              <el-radio-group v-model="radioValue" fill="#15bafe" @change="getPagesList">
                  <el-radio-button label="专业商家" border></el-radio-button>
                  <el-radio-button label="普通商家" border></el-radio-button>
                  <el-radio-button label="个人用户" border></el-radio-button>
              </el-radio-group>
          </div>
          <div class="page_jurisdiction_total">
              <div class="user_page_select">页面权限</div>
              <div class="page_jurisdiction_allocation">
                  <div class="user_page_option" v-for="(page,index) in pages" :key="page.id">
                      <div class="page_name">{{page.name}}</div>
                      <div class="page_jurisdiction_select">
                          <!--<el-checkbox-group-->
                                  <!--fill="#15bafe"-->
                                  <!--v-model="page.jurisdictionSelect"-->
                                  <!--@change="jurisdictionChange(index)">-->
                              <el-checkbox v-for="item in page.jurisdiction" :label="item.id" :key="item.id" @change="jurisdictionChange">
                                  <span>{{item.label}}</span>
                                  <span>{{item.name}}</span>
                              </el-checkbox>
                          <!--</el-checkbox-group>-->
                      </div>
                  </div>
              </div>
          </div>
      </div>
      <el-dialog :visible.sync="addVisible" width="400px">
        <div slot="title" class="dialog_head_title">
          <i class="iconfont icon-edit-square examine_icon"></i>
          <span>新增权限</span>
        </div>
        <div class="jurisdiction_content">
          <div class="jurisdiction_content_item">
            <label class="el_lbl">权限名称:</label>
            <el-input class="el_input" size="mini"></el-input>
          </div>
          <div class="jurisdiction_content_item">
            <label class="el_lbl">方法:</label>
            <el-input class="el_input" size="mini"></el-input>
          </div>
          <div class="jurisdiction_content_item">
            <label class="el_lbl">介绍:</label>
            <el-input placeholder="100字以内" class="el_input_text_area" type="textarea" :autosize="{ minRows: 3, maxRows: 3}"></el-input>
          </div>
        </div>
        <div class="user_footer" slot="footer">
          <el-row class="row_e">
            <el-button class="btn_deletes" size="small" @click="addVisible = false">取消</el-button>
            <el-button type="primary" size="small"  class="btn_delete">保存</el-button>
          </el-row>
        </div>
      </el-dialog>
    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb';
    export default {
      name: "ExternalJurisdiction",
      components: {
        BreadCrumb
      },
      data () {
        return {
          arrayValue: '',
          search_name: '',
          search_method: '',
          addVisible: false,
          menuVisible: false,
          menu_id: null,
          checkedJurisdiction: [],
          breadData: [{
            id: 1,
            name: '外部管理',
            urls: '/index',
            icon: 'icon-home'
          }, {
            id: 2,
            name: '创建权限',
            urls: '/index/test',
            icon: 'icon-home'
          }],
          arrayOptions: [{
            value: 1,
            label: '按创建时间'
          }, {
            value: 2,
            label: '按修改时间'
          }, {
            value: 3,
            label: '按英文字母排列'
          }, {
            value: 4,
            label: '按ID排列'
          }],
          tableData: [{
            id: 1,
            jurisdictionName: '摩托车视屏显示',
            description: '摩托车部门的视屏表格',
            type: '数据权限',
            method: 'Activity/uploading',
            createTime: '2018/08/23',
            updateTime: '2018/09/26'
          }],
          radioValue:'专业商家',//根页面选中值
          pages:[],//页面权限列表
        }
      },
      methods: {
        /**
         * 子组件将勾选的菜单权限data传给当前页面
         * this.$store.state.menu.menu.id记录是哪一个菜单的id
         * @param data
         */
        getMenuItem:function (data) {
          console.log('data',data);
          this.menu_id = this.$store.state.menu.menu.id;
          this.checkedJurisdiction = data;
          /*console.log('219',this.$store.state.menu.menu)*/
        },
        handleSaveMenuJurisdiction: function () {
          console.log('保存：',this.menu_id ,this.checkedJurisdiction)
        },

        //获取页面列表
        getPagesList(){
            let type=2;
            if(this.radioValue==='普通商家'){
                type=1
            }else if(this.radioValue==='个人用户'){
                type=0
            }
            this.HttpClient.post('/web/role/index',{type:type})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.pages=res.data.data;
                        this.pages.map((item,index)=>{
                            item.jurisdiction=[];//添加权限列表
                            item.jurisdictionSelect=[];//添加全选分配列表
                            this.getJurisdiction(item.id,index)
                        })
                    }
                })
        },
        //获取页面权限列表
        getJurisdiction(id,index) {
            this.HttpClient.post('/web/permission/index',{role_id:id})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.pages[index].jurisdiction=res.data.data;
                        window.Vue.set(this.pages,index,this.pages[index])
                    }
                })
        },
        //权限管理
        jurisdictionChange(bool,e){
            // console.log(this.pages[index]);
            // window.Vue.set(this.pages,index,this.pages[index]);
            console.log(e.target.value);
            let status=0,
                id=Number(e.target.value);
            if(bool){
                status=1;
            }
            this.HttpClient.post('/web/permission/changeStatus',{permission_id:id,status:status})
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.$message.success(status===1?'启用成功':'禁用成功')
                    }else{
                        this.$message.error(res.data.msg)
                    }
                })
        }
      },
      created(){
          this.getPagesList()
      }
    }
</script>

<style scoped lang="less">
  .bread {
    margin: 10px;
  }
  .content {
    background: white;
    margin-left: 10px;
    margin-right: 10px;
    /*height: calc(100vh - 87px);*/
    width: calc(100vw - 221px);
    border-radius: 2px;
    padding-bottom:10px;
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
    justify-content: space-between;
    margin-right: 10px;
  }
  .select_normal{
    width: 150px;
    margin-right: 10px;
  }
  .tabs {
    margin: 20px 10px;
  }
  .dialog_head_title{
    text-align: start;
    font-size: 14px;
    border-bottom: 1px solid #f2f2f2;
    padding-bottom: 10px;
    .examine_icon{
      color: #15bafe;
    }
  }
.jurisdiction_content{
  .jurisdiction_content_item{
    display: flex;
    line-height: 28px;
    margin-left: 20px;
    margin-bottom: 10px;
    .el_lbl{
      width: 60px;
    }
    .el_input{
      width: 200px;
      margin-left: 20px;
    }
    .el_input_text_area{
      width: 200px;
      margin-left: 20px;
    }
  }
}
  .row_e{
    text-align: center;
    .btn_deletes{
      padding: 5px 15px;
      margin-right: 10px;
    }
    .btn_delete{
      padding: 5px 15px;
    }
  }

  .user_page_jurisdiction{
      display:flex;
      justify-content:flex-start;
      margin-top:20px;
      padding-bottom:10px;
      border-bottom:2px solid #ccc;

      .user_page_select{
          border:1px solid #dcdfe6;
          border-radius:4px;
          color:#fff;
          font-size:14px;
          white-space: normal;
          text-align:center;
          padding:12px 20px;
          margin:0 15px;
          line-height:1;
          background:#15bafe;
      }
  }
  .page_jurisdiction_total{
      margin:30px 0 20px 20px;

      .user_page_select{
          border:1px solid #dcdfe6;
          border-radius:4px;
          width:100px;
          color:#fff;
          font-size:14px;
          white-space: normal;
          text-align:center;
          padding:12px 20px;
          line-height:1;
          background:#15bafe;
      }

      .page_jurisdiction_allocation{
          margin-top:10px;
          padding-top:20px;
          border:1px solid #ccc;

          .user_page_option{
              margin-left:10px;
              margin-bottom:10px;

              .page_name{
                  width:100px;
                  font-size:14px;
                  padding:8px 0;
                  border:1px solid #15bafe;
                  background:linear-gradient(to bottom right,#efefef,#fff);
              }
              .page_jurisdiction_select{
                  text-align:left;
                  margin:20px 0 20px 20px;
              }
          }
      }
  }
</style>
<style>
  .el-table th>.cell{
    text-align: center;
  }
  .el-dialog__body{
    padding: 0 20px !important;
  }
</style>
