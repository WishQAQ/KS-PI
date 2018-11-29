<template>
  <div>
    <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
    <div class="content">
      <p class="title">用户角色分配</p>
      <div class="conditions">
        <div class="condition">
          <p class="user_name">姓名: <span>{{user_info.nickname}}</span></p>
          <p class="user_status">状态:</p>
          <p class="user_enable" :style="user_info.status === 2?{background:'#ff5858'}:{}" @click="handleStatus">{{user_info.status===1?'启用':'禁用'}}</p>
        </div>
      </div>
      <div class="user_edit_content">
        <div class="content_left">
          <p class="left_title">所有角色</p>
          <div class="all_role">
            <el-checkbox-group class="checkbox_all" v-model="checkedHasRole" @change="handleCheckedRoleChange">
              <el-checkbox class="checkbox_all_item" v-for="role in allRole" :label="role.id" :key="role.id" @change="changeAllCheck($event,role.id)">{{role.name}}</el-checkbox>
            </el-checkbox-group>
          </div>
        </div>
        <div class="content_right">
          <p class="right_title">已拥有角色</p>
          <div class="has_role">
            <!-- <el-checkbox class="all_check" v-model="checkAll" @change="handleCheckAllChange">全选</el-checkbox>
            <div style="margin: 15px 0;"></div> -->
            <el-checkbox-group class="checkbox_all" v-model="checkedHasRole" @change="handleCheckedRoleChange">
              <el-checkbox class="checkbox_all_item" v-for="role in hasRole" :label="role.id" :key="role.id" @change="changeHasCheck($event,role.id)">{{role.name}}</el-checkbox>
            </el-checkbox-group>
          </div>
        </div>
      </div>
      <div class="btn_group">
        <el-button size="mini">取消</el-button>
        <el-button size="mini" type="primary">确定</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import BreadCrumb from '@/components/public/BreadCrumb';
export default {
  name: "InsideUserJurisdiction",
  components: {
    BreadCrumb
  },
  data() {
    return {
      user_info:null,
      user_name:'',
      status: 1,
      checkedHasRole: [],
      breadData: [{
        id: 1,
        name: '内部管理',
        urls: '/index',
        icon: 'icon-home'
      }, {
        id: 2,
        name: '用户管理',
        urls: '/index/test',
        icon: 'icon-home'
      }, {
        id: 3,
        name: '用户角色权限分配',
        urls: '/index/test',
        icon: 'icon-home'
      }],
      old_array:[],  //存放每次更新后打钩的角色
      allRole: [],
      hasRole: [],
      newAllRole:[],  
    }
  },
  created() {
    this.getData();
  },
  methods: {
    //所有角色勾选与取消
    changeAllCheck(n,id){
      console.log(n,id,this.hasRole)
      if(n === false){
          for(let i=0;i<this.hasRole.length;i++){  //判断取消，恢复之前已选取的。
              this.checkedHasRole.push(this.hasRole[i].id)
          };
      }else{ //判断勾选，添加角色。
          this.HttpClient.post('/admin/roleuser/create',{user_id:this.select_userID,role_id:id})
          .then(res=>{
              console.log(res)
              if(res.data.code === 200){
                  this.$message.success(res.data.msg);
                  for(let i=0;i<this.allRole.length;i++){
                      if(this.allRole[i].id === id){
                          console.log(this.allRole[i]);
                          this.hasRole.push(this.allRole[i]);
                          this.checkedHasRole.push(this.allRole[i]);
                      }
                  };
              }else{
                  this.$message.error(res.data.msg);
              }
          })
      }
    },
    //已拥有角色删除
    changeHasCheck(n,id){
      console.log(n,id,this.hasRole)
      this.HttpClient.post('/admin/roleuser/destroy',{user_id:this.select_userID,role_id:id})
      .then(res=>{
          console.log(res)
          if(res.data.code === 200){
              this.$message.success(res.data.msg);
              for(let i=0;i<this.hasRole.length;i++){
                console.log(this.hasRole[i].id);
                if(this.hasRole[i].id === id){
                  console.log(this.hasRole[i]);
                  console.log(this.hasRole.indexOf(this.hasRole[i]));
                  var index = this.hasRole.indexOf(this.hasRole[i]);
                  this.hasRole.splice(index,1);
                  this.checkedHasRole.splice(index,1);
                }else{}
              }
          }else{
              for(let i=0;i<this.hasRole.length;i++){
                this.checkedHasRole.push(this.hasRole[i].id);
              };
              this.$message.error(res.data.msg);
          }
      })
      
      
      
    },
    //获取所有角色列表
    getRoleList(){
        this.HttpClient.post('/admin/role/getAll',{})
        .then(res=>{
            console.log(res)
            this.allRole = res.data.data;
            for(let i=0;i<res.data.data.length;i++){
              this.newAllRole.push({
                id:res.data.data[i].id,
                name:res.data.data[i].name
              })
            }
            console.log(this.newAllRole)
            this.allRole = this.newAllRole; //所有角色赋值
        })
    },
    handleStatus:function () {
      if(this.user_info.status === 1){
        this.user_info.status = 2;
      }else if(this.user_info.status === 2) {
        this.user_info.status = 1;
      }
    },
    handleCheckAllChange(){

    },
    handleCheckedRoleChange:function (value) {
      console.log(value)
    },
    getData(){
      this.user_info = this.$route.query.info;
      this.select_userID = this.user_info.id;
      console.log(this.user_info.roles)
      this.hasRole = this.user_info.roles;
      console.log(this.hasRole)
      console.log(this.checkedHasRole)
      this.getRoleList();
      for(let i=0;i<this.hasRole.length;i++){
        this.checkedHasRole.push(this.hasRole[i].id)
      };
      console.log(this.checkedHasRole)
    }
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
    height: calc(100vh - 103px);
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
    justify-content: space-between;
    margin-right: 10px;
    .condition{
      display: flex;
      .user_name{
        font-size: 12px;
        color: white;
        background: #15bafe;
        padding: 5px 15px;
      }
      .user_status{
        font-size: 12px;
        color: white;
        background: #15bafe;
        padding: 5px 15px;
        margin-left: 10px;
      }
      .user_enable{
        font-size: 12px;
        color: white;
        background: #15bafe;
        padding: 5px 15px;
        margin-left: 10px;
      }
      .user_forbid{
        font-size: 12px;
        color: white;
        background: #15bafe;
        padding: 5px 15px;
        margin-left: 10px;
      }
    }
  }
  .user_edit_content{
    display: flex;
    margin: 20px 10px;
    .content_left{
      width: 300px;
      .left_title{
        width: 300px;
        background: #15bafe;
        color: white;
        font-size: 12px;
        height: 28px;
        line-height: 28px;
      }
      .all_role{
        height: 400px;
        border: 1px solid #f2f2f2;
        overflow-y: auto;
        .checkbox_all{
          .checkbox_all_item{
            display: block;
            text-align: left;
            margin-left: 20px !important;
            margin-top: 10px;
          }
        }
      }
    }
    .content_right{
      width: 300px;
      margin-left: 40px;
      .right_title{
        width: 300px;
        background: #15bafe;
        color: white;
        font-size: 12px;
        height: 28px;
        line-height: 28px;
      }
      .has_role{
        height: 400px;
        border: 1px solid #f2f2f2;
        overflow-y: auto;
        .checkbox_all{
          .checkbox_all_item{
            display: block;
            text-align: left;
            margin-left: 20px !important;
            margin-top: 10px;
          }
        }
      }
    }
  }
  .btn_group{
    text-align: left;
    margin-left: 270px;
  }
</style>
