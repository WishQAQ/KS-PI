<template>
    <div class="changePassword">
      <div class="changePassword_box">
        <div class="changePassword_title">
          <p><span></span>修改密码</p>
          <div>CHANGE  PASSWORD</div>
        </div>

        <div class="changePassword_content">
          <div class="content_box">
            <div class="content_list">
              <p>输入旧密码</p>
              <el-input type="password" class="content_input" v-model="old_password"></el-input>
            </div>
            <div class="content_list">
              <p>输入新密码</p>
              <el-input type="password" class="content_input" v-model="new_password"></el-input>
            </div>
            <div class="content_list">
              <p>确认新密码</p>
              <el-input type="password" class="content_input" v-model="again_newPassword" @blur="checkpassword"></el-input>
            </div>

            <!--确认取消按钮-->
            <div class="content_btm">
                <el-button class="content_btm_clone">
                  <router-link to="/home/userIndex">取消</router-link>
                </el-button>
              <el-button class="content_btm_submit" @click="submit()">提交</el-button>
            </div>

          </div>
        </div>

      </div>
    </div>
</template>

<script>
    export default {
      name: "changePassword",
      data(){
        return {
            old_password:null,
            new_password:null,
            again_newPassword:null,
            identical:null,
        }
      },
      methods:{
        //检查第二次输入密码是否和第一次一样。
          checkpassword(){
            if(this.again_newPassword = this.new_password){
              this.identical = true;
            }else{
              this.identical = false;
            }
          },
          submit(){
            if(this.identical = true){
                this.HttpClient.post('/usersProfile/updatePassword',{
                  old_password:this.old_password,
                  password:this.again_newPassword
                }).then((res) => {
                  console.log(res)
                  if(res.data.code === 200){
                    this.$message.success(res.data.msg)
                    localStorage.removeItem('token')
                    localStorage.removeItem('uid')
                    this.$store.commit('USERCLOSE')
                    this.$router.push({
                        path:'/login'
                      })
                  }else{
                    this.$message.error(res.data.msg)
                  }
                })
            }else{
                this.$message.error('新密码两次输入不一致')
            }
          }
      }

    }
</script>

<style lang="less">
  .changePassword{
    background-color: #f2f2f2;
    padding: 30px 0;
    display: flex;
    justify-content: center;
    align-items: center;

    @media screen and (max-width: 1200px){
      .changePassword{
        margin: 30px 40px;
      }
    }

    .changePassword_box{
      background-color: #fff;
      max-width: 1200px;
      min-width: 900px;
      margin: 0 auto;
      height: 500px;
      box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
      padding: 10px;
      /*标题*/
      .changePassword_title{
        display: flex;
        align-items: center;
        height: 50px;
        border-bottom: 1px solid #f2f2f2;
        padding-left: 20px;
        p{
          display: flex;
          align-items: center;
          font-size: 18px;
          color: #333;
          margin-right: 15px;
          span{
            width: 5px;
            height: 20px;
            background: #15befe;
            display: inline-block;
            margin-right: 10px;
          }
        }
        div{
          font-size: 18px;
          color: #f2f2f2;
          font-weight: bold;
        }
      }
      /*主体内容*/
      .changePassword_content{
        display: flex;
        justify-content: center;
        align-items: center;
        height: 88%;
        .content_box{

        }
        .content_list:not(:last-child){
          margin-bottom: 30px;
        }
        .content_list{
          display: flex;
          justify-content: center;
          align-content: center;
          p{
            font-size: 14px;
            color: #333;
            margin-right: 20px;
            display: flex;
            align-items: center;
          }
          .content_input{
            width: 250px;
            .el-input__inner{
              height: 30px;
              line-height: 30px;
            }
          }
        }

        /*确认取消按钮*/
        .content_btm{
          margin-top: 30px;
          display: flex;
          justify-content: flex-end;
          align-items: center;
          .el-button{
            border: 1px solid #15befe;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 70px;
            height: 30px;
            overflow: hidden;
            a{
              width: 70px;
              height: 30px;
              display: inline-block;
            }
          }
          /*取消按钮*/
          .content_btm_clone{
            color: #15befe;
            a{
              color: #15befe;
              display: flex;
              align-items: center;
              justify-content: center;
            }
          }
          /*提交按钮*/
          .content_btm_submit{
            color: #fff;
            background-color: #15befe;
          }
        }
      }
    }
  }
</style>
