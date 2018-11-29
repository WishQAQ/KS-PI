<template>
      <div class="changePhoneNumber">
        <div class="changePhoneNumber_box">
          <div class="changePhoneNumber_title">
            <p><span></span>修改手机</p>
            <div>Modify phone number</div>
          </div>

          <div class="changePhoneNumber_content">
            <div class="content_box">
              <div class="content_list">
                <p>输入旧手机号码</p>
                <el-input type="password" class="content_input" v-model="old_phone"></el-input>
              </div>
              <div class="content_list">
                <p>输入新手机号码</p>
                <div class="content_list_select">
                  <el-input type="password" class="content_input" v-model="new_phone">
                    <el-select v-model="select" slot="prepend">
                      <el-option label="+86" value="1"></el-option>
                      <el-option label="+1" value="2"></el-option>
                      <el-option label="+30" value="3"></el-option>
                    </el-select>
                  </el-input>
                </div>
              </div>
              <div class="content_list">
                <p></p>
                <div class="content_list_code">
                  <el-input type="password" placeholder="输入验证码" class="content_input" v-model="verification_code">
                    <template slot="append" class="code_btm" v-if="send" @click="obtainCode">获取验证码</template>
                    <template slot="append" class="code_btm" v-if="send" >已发送({{time}})</template>
                    <!-- <template slot="append" class="code_btm" @click="">获取验证码</template> -->
                  </el-input>
                </div>
              </div>

              <!--确认取消按钮-->
              <div class="content_btm">
                <el-button class="content_btm_clone">
                  <router-link to="/home/userIndex">取消</router-link>
                </el-button>
                <el-button class="content_btm_submit" @click="submit">提交</el-button>
              </div>

            </div>
          </div>

        </div>
      </div>
</template>

<script>
    export default {
        name: "changePhoneNumber",
      data(){
          return{
            select:'1',
            old_phone:null,
            new_phone:null,
            verification_code:null,
            time:60
          }
      },
      methods:{
          //获取验证码
          obtainCode(){
              this.HttpClient.post('/my/question/list',{
                  
              }).then((res) => {

              })
          }
      }
    }
</script>

<style lang="less">
  .changePhoneNumber{
    background-color: #f2f2f2;
    padding: 30px 0;
    display: flex;
    justify-content: center;
    align-items: center;

    @media screen and (max-width: 1200px){
      .changePhoneNumber{
        margin: 30px 40px;
      }
    }

    .changePhoneNumber_box{
      background-color: #fff;
      max-width: 1200px;
      min-width: 900px;
      margin: 0 auto;
      height: 500px;
      box-shadow: 1px 1px 5px 2px rgba(34,24,21,.16);
      padding: 10px;
      /*标题*/
      .changePhoneNumber_title{
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
          text-transform:uppercase
        }
      }
      /*主体内容*/
      .changePhoneNumber_content{
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
          justify-content: space-between;
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

          /*区号选择*/
          .content_list_select{
            .el-input-group__prepend{
              padding: 0;
              width: 70px;
              .el-select{
                margin: 0;
                .el-input__inner{
                  border: none;
                  height: 28px;
                  line-height: 28px;
                  padding-right: 0;
                }
                .el-input__icon{
                  line-height: 28px;
                }
              }
            }
          }

          /*验证码*/
          .content_list_code{
            .el-input-group__append{
              cursor: pointer;
              color: #fff;
              background-color: #15befe;
              border-color: #15befe;
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
