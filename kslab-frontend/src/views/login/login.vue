<template>
  <div class="login">
    <div class="ContDivLogin">
      <!--登陆界面-->
      <div class="BackImg" v-if="loginBox">
        <!--账号登陆-->
        <div ref="loginPc" class="login_pc" v-if="loginShow">
          <!--<div class="login_mobile_mask" ref="login_mask" v-show="loginMask"><i ref="login_mobile_icon" class="icon icon-qiche"></i></div>-->

          <form class="UserForm" autocomplete="off" action="post" method="">
            <div class="login_title">
              <router-link to="/" class="login_back"><i class="icon icon-huaban10"></i></router-link>
              <div class="title_logo">
                <router-link to="/home/index"><i class="icon icon-huaban4"></i></router-link>
                <span class="title_logo_line"></span>
                <span>登陆</span>
              </div>
              <div class="login_mobile">
                <div @click="loginMobileOpen" v-show="loginMobileBtm">
                  <span>手机登陆</span><img src="/static/img/icon/shouji.png" alt="">
                </div>
              </div>
            </div>

            <!--用户名-->
            <div class="login_input">
              <div class="User_Input">
                <i class="icon icon-zhanghao"></i>
                <el-input
                  placeholder="输入账号"
                  v-model="ThisPlaceholderUser"
                  @blur="loginLineCloneUser"
                  @focus="loginUser"
                  clearable>
                </el-input>
              </div>
              <div class="login_input_line">
                <span :class="{loginInputLineUser : loginInputLIneUser,loginInputLineCloneUser : loginInputLIneCloneUser}"></span>
              </div>
            </div>

            <!--密码-->
            <div class="login_input login_password">
              <div class="User_Input">
                <i class="icon icon-ai-password"></i>
                <el-input
                  name="PasswrodInput"
                  type="password"
                  placeholder="输入密码"
                  @blur="loginLineClone"
                  @focus="loginPassword"
                  @keyup.enter.native="ClickSubit"
                  v-model="ThisPlaceholderPasword"
                  clearable>
                </el-input>
                <div class="user_forgetPassword" @click="user_forgetPassword">忘记密码</div>
              </div>
              <div class="login_input_line">
                <span :class="{loginInputLine : loginInputLIne,loginInputLineClone : loginInputLIneClone}"></span>
              </div>
            </div>
            <div class="login_break_input">
              <div class="Fuc-Code">
                <i class="icon icon-yanzhengma login_break_icon"></i>
                <el-input
                  name="rea_Code"
                  type="text"
                  spellcheck="false"
                  placeholder="输入验证码"
                  @blur="loginBreakLineClone"
                  @focus="loginBreak"
                  @keyup.enter.native="searchEnterFun"
                  v-model="code"
                  clearable>
                </el-input>

                <div class="Code_div">
                  <img :src="imgUrl" alt="">
                  <div class="login_break" @click="refresh"><span><img src="/static/img/icon/login_refresh.png" alt=""></span></div>
                </div>
              </div>

              <div class="login_input_line">
                <span :class="{loginInputLine : loginBreakLIne,loginInputLineClone : loginBreakLIneClone}"></span>
              </div>
            </div>

            <div class="login_btm">
              <router-link to="login/usersignup" class="btn_register">注册</router-link>
              <div class="btn_submit" type="submit" @click.13="ClickSubit">登陆</div>
            </div>


            <div class="Thirdparty">
              <div><i @click="handleOpenQQ" class="icon icon-qq"></i></div>
              <div><i @click="handleOpenAlipay" class="icon icon-weibo"></i></div>
              <div  @click="handleOpenWeiXin"><i class="icon icon-weixin"></i></div>
            </div>
          </form>

        </div>
        <!--手机登陆框-->
        <div class="mobileLogin" ref="loginMobile" v-if="loginMobile">
          <div class="login_title">
            <router-link to="/" class="login_back"><i class="icon icon-huaban10"></i></router-link>
            <div class="title_logo">
              <router-link to="/home/index" ><i class="icon icon-huaban4"></i></router-link>
              <span class="title_logo_line"></span>
              <span>登陆</span>
            </div>
            <div class="login_mobile" @click="loginPcOpen"><span>电脑登陆</span><img src="/static/img/icon/shouji.png" alt=""></div>
          </div>

          <!--用户名-->
          <div class="login_input">
            <div class="User_Input">
              <i class="icon icon-huaban13"></i>
              <el-input
                placeholder="输入手机号"
                v-model="ThisPlaceholderUser"
                @blur="loginLineCloneUser"
                @focus="loginUser"
                clearable>
                <el-select v-model="select" slot="prepend" placeholder="国家">
                  <el-option label="+86" value="1"></el-option>
                  <el-option label="+1" value="2"></el-option>
                  <el-option label="+30" value="3"></el-option>
                </el-select>
              </el-input>
              <div class="main_title_right"
                   @click="oldPhoneNumberOpen"
              >
                <!--@click="user_verifyIdCardOpen"  已绑定身份证-->
                <!--@click="oldPhoneNumberOpen"  未绑定身份证-->
                号码已换</div>
            </div>
            <div class="login_input_line">
              <span :class="{loginInputLineUser : loginInputLIneUser,loginInputLineCloneUser : loginInputLIneCloneUser}"></span>
            </div>
          </div>

          <!--验证码-->
          <div class="login_break_input">
            <div class="Fuc-Code">
              <i class="icon icon-yanzhengma login_break_icon"></i>
              <!--<input name="rea_Code" class="rea_Code" type="text" v-model="code" @keyup.enter="enterToLogin">-->
              <el-input
                name="rea_Code"
                type="text"
                spellcheck="false"
                placeholder="输入验证码"
                @blur="loginBreakLineClone"
                @focus="loginBreak"
                @keyup.enter.native="searchEnterFun"
                v-model="code"
                clearable>
              </el-input>

              <div class="Code_div">
                <div>获取手机验证码</div>
              </div>
            </div>

            <div class="login_input_line">
              <span :class="{loginInputLine : loginBreakLIne,loginInputLineClone : loginBreakLIneClone}"></span>
            </div>
          </div>

          <div class="login_btm">
            <router-link to="login/usersignup" class="btn_register">注册</router-link>
            <div class="btn_submit" type="submit" @click.13="ClickSubit">登陆</div>
          </div>


          <div class="Thirdparty">
            <div><i class="icon icon-qq"></i></div>
            <div><i class="icon icon-weibo"></i></div>
            <div @click="handleOpenWeiXin"><i class="icon icon-weixin"></i></div>
          </div>
        </div>
      </div>
      <!--账号登陆忘记密码-->
      <div class="user_forgetPasswordBox" v-if="user_forgetPasswordBox">
        <!--返回按钮-->
        <div class="title">
          <i class="icon icon-huaban10" @click="user_Back"></i>
        </div>
        <!--主体内容-->
        <div class="main">
          <div class="main_title">
            <div class="main_title_left"><span></span>验证手机</div>
            <div class="main_title_right"
                 @click="user_verifyIdCardOpen"
            >
                <!--@click="oldPhoneNumberOpen"  未绑定身份证-->
              号码已换</div>
          </div>
          <!--手机号-->
          <div class="main_phoneNumber">
            <i class="icon icon-huaban13"></i>
            <el-input placeholder="请输入手机号" class="input-with-select" clearable>
              <el-select v-model="userPhoneNbm" slot="prepend" placeholder="请选择">
                <el-option label="+86" value="1"></el-option>
                <el-option label="+1" value="2"></el-option>
                <el-option label="+30" value="3"></el-option>
              </el-select>
            </el-input>
          </div>
          <!--验证码-->
          <div class="main_code">
            <i class="icon icon-yanzhengma"></i>
            <el-input placeholder="请输入验证码" clearable></el-input>
            <el-button class="main_code_btm">获取短信验证码</el-button>
          </div>
          <!--确认取消按钮-->
          <div class="main_btm">
            <div class="main_btm_clone" @click="user_Back">取消</div>
            <div class="main_btm_true" @click="user_forgetPasswordTrue">确定</div>
          </div>
        </div>
      </div>
      <!--账号输入新密码-->
      <div class="user_forgetPasswordTrue" v-if="user_forgetPasswordTrueBox">
        <!--返回按钮-->
        <div class="title">
          <i class="icon icon-huaban10" @click="user_forgetPasswordTrueBack"></i>
        </div>
        <!--主体内容-->
        <div class="main">
          <div class="main_title">
            <div class="main_title_left"><span></span>输入新密码</div>
          </div>
          <!--输入密码框-->
          <div class="main_password">
            <i class="icon icon-ziyuan13"></i>
            <el-input placeholder="请输入新密码" clearable></el-input>
          </div>
          <!--确认输入密码-->
          <div class="main_password">
            <i class="icon icon-ai-password"></i>
            <el-input placeholder="确认密码" clearable></el-input>
          </div>

          <div class="main_btm">
            <div class="main_btm_clone" @click="user_Back">取消</div>
            <div class="main_btm_true">确定</div>
          </div>
        </div>
      </div>
      <!--未绑定身份证 - 输入旧手机-->
      <div class="user_oldPhoneNumber" v-if="user_oldPhoneNumber">
        <!--返回按钮-->
        <div class="title">
          <i class="icon icon-huaban10" @click="user_oldPhoneNumberBack"></i>
          <!--客服按钮-->
          <div class="serviceBtm" @click="serviceModal = ! serviceModal">
            <i class="icon icon-kefu1"></i>
            <span></span>
          </div>
        </div>
        <!--主体内容-->
        <div class="main">
          <div class="main_title">
            <div class="main_title_left"><span></span>输入旧手机</div>
          </div>
          <!--手机号-->
          <div class="main_phoneNumber">
            <i class="icon icon-huaban13"></i>
            <el-input placeholder="请输入手机号" class="input-with-select" clearable>
              <el-select v-model="userPhoneNbm" slot="prepend" placeholder="请选择">
                <el-option label="+86" value="1"></el-option>
                <el-option label="+1" value="2"></el-option>
                <el-option label="+30" value="3"></el-option>
              </el-select>
            </el-input>
          </div>

          <div class="main_btm">
            <div class="main_btm_clone" @click="user_Back">取消</div>
            <div class="main_btm_true" @click="user_verifyProblemOpen">确定</div>
          </div>
        </div>
      </div>
      <!--验证问题-->
      <div class="user_verifyProblem" v-if="user_verifyProblem">
        <div class="title">
          <i class="icon icon-huaban10" @click="user_verifyProblemClone"></i>
          <p>回答问题</p>
          <!--客服按钮-->
          <div class="serviceBtm" @click="serviceModal = ! serviceModal">
            <i class="icon icon-kefu1"></i>
            <span></span>
          </div>
        </div>
        <!--主体内容-->
        <div class="main">
          <div class="problemList">
            <p>1、之前的运营商</p>
            <div class="problemListBox">
              <el-radio-group v-model="problemList1">
                <el-radio :label="1">电信</el-radio>
                <el-radio :label="2">联通</el-radio>
                <el-radio :label="3">移动</el-radio>
                <el-radio :label="4">AT&T</el-radio>
                <el-radio :label="5">Vodafone</el-radio>
              </el-radio-group>
            </div>
          </div>
          <div class="problemList">
            <p>2、之前的订单</p>
            <div class="problemListBox">
              <el-radio-group v-model="problemList2">
                <el-radio :label="1">正确</el-radio>
                <el-radio :label="2">误导</el-radio>
                <el-radio :label="3">误导</el-radio>
                <el-radio :label="4">误导</el-radio>
                <el-radio :label="5">误导</el-radio>
              </el-radio-group>
            </div>
          </div>
          <div class="problemList">
            <p>3、之前关注过的人</p>
            <div class="problemListBox">
              <el-radio-group v-model="problemList3">
                <el-radio :label="1">误导</el-radio>
                <el-radio :label="2">误导</el-radio>
                <el-radio :label="3">正确</el-radio>
                <el-radio :label="4">误导</el-radio>
                <el-radio :label="5">误导</el-radio>
              </el-radio-group>
            </div>
          </div>
          <div class="problemList">
            <p>4、之前看过的视频</p>
            <div class="problemListBox">
              <el-radio-group v-model="problemList4">
                <el-radio :label="1">误导</el-radio>
                <el-radio :label="2">误导</el-radio>
                <el-radio :label="3">误导</el-radio>
                <el-radio :label="4">误导</el-radio>
                <el-radio :label="5">正确</el-radio>
              </el-radio-group>
            </div>
          </div>
          <div class="problemList">
            <p>5、之前是否改过密码</p>
            <div class="problemListBox">
              <el-radio-group v-model="problemList5">
                <el-radio :label="1">误导</el-radio>
                <el-radio :label="2">正确</el-radio>
                <el-radio :label="3">误导</el-radio>
                <el-radio :label="4">误导</el-radio>
                <el-radio :label="5">误导</el-radio>
              </el-radio-group>
            </div>
          </div>
        </div>
        <!--确认取消按钮-->
        <div class="main_btm">
          <div class="main_btm_clone" @click="user_Back">取消</div>
          <div class="main_btm_true" @click="user_newPhoneNumberOpen">确定</div>
        </div>
      </div>
      <!--输入新手机号-->
      <div class="user_newPhoneNumber" v-if="user_newPhoneNumber">
        <!--返回按钮-->
        <div class="title">
          <i class="icon icon-huaban10" @click="user_newPhoneNumberBack"></i>
        </div>
        <!--主体内容-->
        <div class="main">
          <div class="main_title">
            <div class="main_title_left"><span></span>输入新手机号</div>
          </div>
          <!--手机号-->
          <div class="main_phoneNumber">
            <i class="icon icon-huaban13"></i>
            <el-input placeholder="请输入新手机号" class="input-with-select" clearable>
              <el-select v-model="userPhoneNbm" slot="prepend" placeholder="请选择">
                <el-option label="+86" value="1"></el-option>
                <el-option label="+1" value="2"></el-option>
                <el-option label="+30" value="3"></el-option>
              </el-select>
            </el-input>
          </div>
          <!--验证码-->
          <div class="main_code">
            <i class="icon icon-yanzhengma"></i>
            <el-input placeholder="请输入验证码" clearable></el-input>
            <el-button class="main_code_btm">获取短信验证码</el-button>
          </div>
          <!--确认取消按钮-->
          <div class="main_btm">
            <div class="main_btm_clone" @click="user_Back">取消</div>
            <div class="main_btm_true">确定</div>
          </div>
        </div>
      </div>

      <!--验证身份证信息-->
      <div class="user_verifyIdCard" v-if="user_verifyIdCard">
        <!--返回按钮-->
        <div class="title">
          <i class="icon icon-huaban10" @click="user_verifyIdCardBack"></i>
          <!--客服按钮-->
          <div class="serviceBtm" @click="serviceModal = ! serviceModal">
            <i class="icon icon-kefu1"></i>
            <span></span>
          </div>
        </div>
        <!--主体内容-->
        <div class="main">
          <div class="main_title">
            <div class="main_title_left"><span></span>验证身份证信息</div>
          </div>
          <!--手机号-->
          <div class="main_phoneNumber">
            <i class="icon icon-huaban13"></i>
            <el-input placeholder="请输入注册手机号" class="input-with-select" clearable>
              <el-select v-model="userPhoneNbm" slot="prepend" placeholder="请选择">
                <el-option label="+86" value="1"></el-option>
                <el-option label="+1" value="2"></el-option>
                <el-option label="+30" value="3"></el-option>
              </el-select>
            </el-input>
          </div>
          <!--用户姓名-->
          <div class="main_userName">
            <i class="icon icon-xingming"></i>
            <el-input placeholder="姓名" clearable></el-input>
          </div>
          <!--身份证号码-->
          <div class="main_userName">
            <i class="icon icon-zhengjian"></i>
            <el-input placeholder="身份证号码" clearable></el-input>
          </div>
          <!--确认取消按钮-->
          <div class="main_btm">
            <div class="main_btm_clone" @click="user_Back">取消</div>
            <div class="main_btm_true" @click="user_verifyProblemOpen">确定</div>
          </div>
        </div>

      </div>

      <el-dialog title="扫描二维码" width="290px" :visible.sync="dialogFormVisible">
        <div id="qrcode" ref="qrcode" class="img_qrcode"></div>
        <div slot="footer" class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="dialogFormVisible = false">确 定</el-button>
        </div>
      </el-dialog>
      <div class="iframe_contain" v-if="iframeState" @click="iframeState=false">
        <iframe v-show="iframeState" sandbox="allow-forms allow-scripts allow-top-navigation allow-same-origin allow-popups" class="iframe" id="show-iframe"  frameborder=0 name="showHere" scrolling=auto :src="outUrl"></iframe>
      </div>
    </div>

    <!--封禁弹出框-->
    <el-dialog
      custom-class="loginBannedModal"
      :visible.sync="loginBannedModal"
      width="500px">
      <i slot="title" class="icon icon-huaban4 loginBannedModal_title"></i>
      <div class="loginBannedModal_main">
        <div class="banned_icon"><i class="icon icon-gantanhao"></i></div>
        <div class="banned_time">对不起，您的账号距离解封时间剩余<span>30</span>天</div>
        <div class="banned_message">封禁理由：内容涉及色情</div>
      </div>
    </el-dialog>

    <!--审核弹窗-->
    <el-dialog
      custom-class="loginCheckModal"
      :visible.sync="loginCheckdModal"
      width="500px">
      <i slot="title" class="icon icon-huaban4 loginCheckModal_title"></i>
      <div class="loginCheckModal_main">
        <div class="check_icon"><i class="icon icon-close-round"></i></div>
        <div class="check_time">对不起，您的审核失败</div>
        <router-link to="/login/UserSignup" class="check_btm">重新提交</router-link>
      </div>
    </el-dialog>

    <!--客服留言弹窗-->
    <el-dialog
      custom-class="serviceModal"
      :visible.sync="serviceModal"
      width="400px">
      <i slot="title" class="icon icon-huaban4 serviceModal_logo"></i>
      <div class="serviceModal_main">
        <div class="serviceModal_title">联系客服</div>
        <!--账号-->
        <div class="serviceModal_input">
          <el-input placeholder="*注册账号/电话号码"></el-input>
        </div>
        <!--详细情况-->
        <div class="serviceModal_textarea">
          <el-input
            type="textarea"
            :rows="6"
            placeholder="*请详细说明您的情况">
          </el-input>
        </div>
        <!--手机号-->
        <div class="service_phoneNumber">
          <el-input placeholder="*联系方式" class="input-with-select" clearable>
            <el-select v-model="loginContact" slot="prepend" placeholder="请选择">
              <el-option label="邮箱" value="1"></el-option>
              <el-option label="电话" value="2"></el-option>
            </el-select>
          </el-input>
        </div>
        <!--确认取消按钮-->
        <div class="main_btm">
          <div class="main_btm_clone" @click="user_Back">取消</div>
          <div class="main_btm_true" @click="user_verifyProblemOpen">确定</div>
        </div>
      </div>
    </el-dialog>


  </div>
</template>

<script>
  // import { TimelineLite, Back, Elastic, Expo } from "gsap"
  import QRCode from 'qrcodejs2'
export default {
    data(){
      return{
        ThisPlaceholderUser:"",
        ThisPlaceholderPasword:"",
        code:'',
        imgUrl:'',
        rediskey:null,
        loginInputLIneUser:false,  //账号线
        loginInputLIne:false,  //密码线
        loginInputLIneClone:false,  //密码线关闭
        loginInputLIneCloneUser:false,  //账号线关闭
        loginBreakLIne:false,  //验证码线
        loginBreakLIneClone:false,  //验证码线关闭
        onLoginBreak:false, // 刷新验证码
        on: true,
        loginMask:false,  // 登陆切换遮罩层
        loginMobileBtm:true,
        dialogFormVisible: false,
        iframeState: false,
        outUrl: '',
        goBackState: false,
        times: 60,
        timer: null,
        index: 0,
        loginShow:true, // 账号登陆页面
        loginMobile:false, //手机登陆页面
        select: '1',  //手机登陆页面下拉菜单
        loginBox:true, //登陆界面
        user_forgetPasswordBox:false,  //账号忘记密码
        userPhoneNbm: '1', //账号-忘记密码登陆页面
        user_forgetPasswordTrueBox:false, // 账号-输入新密码
        user_oldPhoneNumber:false,  // 未绑定身份证 - 输入旧手机
        user_verifyProblem:false,  // 回答问题
        problemList1:1, // 问题列表默认值
        problemList2:1, // 问题列表默认值
        problemList3:1, // 问题列表默认值
        problemList4:1, // 问题列表默认值
        problemList5:1, // 问题列表默认值
        user_newPhoneNumber:false, // 输入新手机号

        user_verifyIdCard:false, // 验证身份证信息

        loginBannedModal: false,  // 封禁弹窗
        loginCheckdModal: false,  // 审核失败弹窗
        loginCheckMessage: true,  // 审核中警告弹窗
        serviceModal:false,  // 联系客服弹窗
        loginContact:'1',  // 选择联系方式
       }
    },
  components: {
      QRCode,
  },
  mounted() {
    const oIframe = document.getElementById('show-iframe');
    const deviceWidth = document.documentElement.clientWidth;
    const deviceHeight = document.documentElement.clientHeight;
    // oIframe.style.width = deviceWidth + 'px';
    // oIframe.style.height = deviceHeight + 'px';
  },

  created(){
      this.refresh();
      const id = this.$route.query.logId;
      if(id) {
        this.checkLoginStatus({kslab_id: id});
      }
  },
    methods:{
      goBack(){
        this.goBackState = false;
        this.iframeState = false;
      },
      showIframe(){
        this.goBackState = true;
        this.iframeState = true;
      },

      //region
      // 登陆动画
      loginMobileOpen(){
        this.loginShow = false
        this.loginMobile = true
        // const loginPc = this.$refs.loginPc;
        // // const login_mask = this.$refs.login_mask;
        // // const login_mobile_icon = this.$refs.login_mobile_icon;
        // const loginMobile = this.$refs.loginMobile;
        //
        // const timeline = new TimelineLite();
        // timeline.to(loginPc, .8, {
        //   y:-416,
        // }).to(loginMobile, .8, {
        //   y:-416,
        // },"-=.7",);
      },
      loginPcOpen(){
        this.loginShow = true
        this.loginMobile = false
        // const loginMobile = this.$refs.loginMobile;
        // const loginPc = this.$refs.loginPc;
        // // const login_mask = this.$refs.login_mask;
        //
        // const timeline = new TimelineLite();
        // timeline.to(loginMobile, .8, {
        //   y:0,
        // }).to(loginPc, .8, {
        //   y:0,
        // },"-=.7",);

      },
      // 账号
      loginUser(){
        if(this.loginInputLIneUser==false){
          this.loginInputLIneUser = true;
          this.loginInputLIneCloneUser = false
        }
      },
      loginLineCloneUser(){
        this.loginInputLIneUser = false;
        this.loginInputLIneCloneUser = true
      },
      // 密码
      loginPassword(){
        if(this.loginInputLIne==false){
          this.loginInputLIne = true
          this.loginInputLIneClone = false
        }
      },
      loginLineClone(){
        this.loginInputLIne = false
        this.loginInputLIneClone = true
      },
      // 验证码
      loginBreak(){
        if(this.loginBreakLIne==false){
          this.loginBreakLIne = true
          this.loginBreakLIneClone = false
        }
      },
      loginBreakLineClone(){
        this.loginBreakLIne = false
        this.loginBreakLIneClone = true
      },
      //endregion
        ClickSubit(){
          console.log("1")
          this.HttpClient.post('/user/login',
             {
              username:this.ThisPlaceholderUser,
              password:this.ThisPlaceholderPasword,
              captcha:this.code,
              rediskey:this.rediskey,
              headers:{
                  'Set-Cookie': 'kslab_session=00mJH7Y7GZ1hnfwGB23IU8qMaR2DRYS10JprVl6P; expires=Mon, 10-Sep-2018 11:35:43 GMT; Max-Age=7200; path=/; httponly'
              }
             },
          )
          .then((res) => {
            if(res.data.code != 200)
            {
              console.log(res)
              this.$message.error(res.data.msg);
              this.refresh()
              this.code = ""
            }
            else{
              console.log(res)
              this.$store.commit('USERTOKEN',res.data.data.token)
              this.$store.commit('USERUID',res.data.data.uid)
              localStorage.setItem('token',res.data.data.token)
              localStorage.setItem('userInfo', JSON.stringify(res.data.data));
              this.$router.go(-1)
              window.localStorage.differentiate = res.data.data.type
            }
          }).catch((err) => {

          })
        },
        refresh(){
          var VueThis = this
          const rediskey = this.rediskey?this.rediskey:'';
          this.HttpClient.code(`/user/imgcaptcha?rediskey=${rediskey}`)
          .then(res => {
            var tokenid2 = res.headers;
            console.log(tokenid2)
            const str = res.headers['cache-control'];
            //login Header
            console.log(res)
            this.rediskey = str.split(':')[1];
            /*alert(this.rediskey)*/
            console.log(this.rediskey)
            /*this.rediskey = Rigkey.replace(/:/,"")
            console.log(this.rediskey)*/
            this.imgUrl =  'data:image/png;base64,' + btoa(new Uint8Array(res.data).reduce((data, byte) => data + String.fromCharCode(byte), ''))
          })
          .catch(err=>{
          })
        },
        searchEnterFun:function(){
          console.log(1);
        },

      handleOpenWeiXin() {
        console.log(11111)
        this.HttpClient.get('/weChatLogin').then(res=>{
          console.log(res.data);
          if(res.data.code === 200) {
            //window.open(res.data.data);
            this.iframeState = true;
            this.outUrl = res.data.data.url;
            //window.location.href=res.data.data
            /*this.timer = setInterval(() =>{
              this.times --;
              console.log(this.times)
              this.checkLoginStatus({kslab_id: res.data.data.kslab_id});
              if(this.times<1) {
                clearInterval(this.timer);
              }
            },3000)*/
            //this.checkLoginStatus({kslab_id:res.data.data.kslab_id});
          }
        })
        /*let qrcodes = document.getElementById('qrcode')//清除二维码
        console.log(qrcodes)
        if(qrcodes === null) {

        }else{
          qrcodes.innerHTML = '';
        }

        this.dialogFormVisible = true;
        console.log(11111)
        this.$nextTick (function () {
          this.qrcode();
        })*/
      },
      //检查登录状态
      checkLoginStatus(param) {
        this.HttpClient.post('/weChatLoginCheck',param).then(res=> {
          console.log(res.data)
          if(res.data.code === 200) {
            localStorage.setItem('token',res.data.data.token);
            this.$router.push({
              path: '/home/index'
            })
          }else if(res.data.code === 1321) {
            this.index++;
            if(this.index < 4) {
              this.checkLoginStatus({kslab_id: id});
            }
          }else if(res.data.code === -1) {

          }else if(res.data.code === 1322) {
            this.$router.push({
              path: '/quickRegistration',
              query: {
                id: res.data.data.log_id
              }
            })
          }
        })
      },
      handleOpenQQ() {
        this.HttpClient.get('/qqLogin').then(res =>{
          console.log(res.data)
          if(res.data.code === 200) {
            window.location.href = res.data.data.url
          }else {
            this.$message.error(res.data.msg)
          }
        })
      },
      handleOpenAlipay() {
        this.HttpClient.get('/alipayLogin').then(res =>{
          if(res.data.code === 200) {
            window.location.href = res.data.data
          }else {
            this.$message.error(res.data.msg)
          }
        })
      },
      qrcode() {
        let qrcode = new QRCode('qrcode', {
          width: 200,
          height: 200,
          text: 'dsjdskfdks'
        })
        console.log(qrcode)
      },

      // 账号忘记密码
      user_forgetPassword(){
        if (this.user_forgetPasswordBox == false){
          this.user_forgetPasswordBox = true;
          this.loginBox = false;
        }
      },
      // 取消按钮
      user_Back(){
        this.user_forgetPasswordTrueBox = false;
        this.user_forgetPasswordBox = false;
        this.user_oldPhoneNumber = false;
        this.user_verifyProblem = false;
        this.user_newPhoneNumber = false;
        this.user_verifyIdCard = false;
        this.loginBox = true;
      },
      // 输入新密码
      user_forgetPasswordTrue(){
        this.user_forgetPasswordTrueBox = true;
        this.user_forgetPasswordBox = false;
      },
      // 输入新密码返回账号忘记密码
      user_forgetPasswordTrueBack(){
        this.user_forgetPasswordTrueBox = false;
        this.user_forgetPasswordBox = true;
      },

      // 身份证未绑定 - 验证旧密码
      oldPhoneNumberOpen(){
        this.loginBox = false
        this.user_forgetPasswordBox = false
        this.user_oldPhoneNumber = true
      },
      // 验证旧密码返回上一层
      user_oldPhoneNumberBack(){
        this.user_forgetPasswordBox = true
        this.user_oldPhoneNumber = false
      },

      // 回答问题
      user_verifyProblemOpen(){
        this.user_verifyProblem = true;
        this.user_oldPhoneNumber = false;
        this.user_verifyIdCard = false;
      },
      // 回答问题返回上一层
      user_verifyProblemClone(){
        this.user_verifyProblem = false
        this.user_oldPhoneNumber = true
      },
      // 输入新手机号码
      user_newPhoneNumberOpen(){
        this.user_newPhoneNumber = true;
        this.user_verifyProblem = false;
      },
      user_newPhoneNumberBack(){
        this.user_newPhoneNumber = false;
        this.user_verifyProblem = true;
      },
      // 验证身份证信息
      user_verifyIdCardOpen(){
        this.user_verifyIdCard = true;
        this.user_forgetPasswordBox = false;
        this.loginBox = false;
      },
      // 验证身份证信息返回上一层
      user_verifyIdCardBack(){
        this.user_verifyIdCard = false;
        this.user_forgetPasswordBox = true;
      }
    },
    beforeRouteLeave(to,from,next){ //离开组件的时候触发
      document.body.removeAttribute("class","UserLoginLogin")
      next()
    },
    beforeCreate(to,from,next){
        var VueThis = this
        this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'user/imgcaptcha',{
          responseType:'arraybuffer'
        })
        .then(res => {
          var tokenid2 = res.headers
          var arr = []
          for(var i in tokenid2){
            arr.push(tokenid2[i]);
          }
          var reg2 = /([^]+)$/;
          arr[1].replace(reg2)
          var Rigkey = arr[1].replace(/redisKey/,"")
          //login Header
          this.rediskey = Rigkey.replace(/:/,"")
          this.imgUrl =  'data:image/png;base64,' + btoa(new Uint8Array(res.data).reduce((data, byte) => data + String.fromCharCode(byte), ''))
        })
        .catch(err=>{
          console.log(err)
        })
    },
}
</script>

<style scoped src="../../assets/css/login.css"></style>
<style lang="less">
  .iframe_contain{
    width: 100vw;
    position: absolute;
    left: 0;
    height: 100vh;
    background: rgba(0, 0, 0, 0.4);
    top: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9;
  }
  .iframe {
    width: 300px;
    height: 440px;
    position: absolute;
    top: 50%;
    left: 50%;
    margin-left: -150px;
    margin-top: -220px;
  }
  .img_qrcode{
    width: 100%;
    height: 200px;
    text-align: -webkit-center;
  }
  .login{
    overflow: hidden;
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .UserLoginLogin{
    background:url("/static/img/BackImg.jpg") center center;
    background-size: cover;
    overflow: hidden;
    position: relative;
  }

  .login_pc{
    background-color: rgba(18,23,28,0.8);
    padding: 15px 0;
    width: 523px;
    height: 414px;
    position: absolute;
  }

  /*遮罩层*/
  .login_mobile_mask{
    z-index: 1;
    position: absolute;
    right: 0;
    top: 0;
    width: 0;
    height: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #15befe;
  }

  /*账号登陆*/
  .BackImg{
    position: relative;
    overflow: hidden;
    height: 400px;
  }

  /*登陆标题*/
  .login_title{
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 15px;
    position: relative;
    margin-bottom: 30px;

    /*返回上一页*/
    .login_back{
      .icon{
        font-size: 24px;
      }
    }

    /*logo*/
    .title_logo{
      display: flex;
      justify-content: center;
      align-items: center;
      position: absolute;
      left: 50%;
      margin-left: -62px;
      .title_logo_line{
        width: 1px;
        height: 20px;
        display: block;
        background-color: #15a9fe;
      }
      .icon{
        font-size: 38px;
        position: relative;
        top: -2px;
      }
    }


    /*手机登陆*/
    .login_mobile{
      display: flex;
      align-items: center;
      width: 113px;
      height: 50px;
      div{
        display: flex;
        align-items: center;
        cursor: pointer;
      }
      span{
        position: absolute;
        background: rgba(255,255,255,.1);
        color: #fff;
        right: 50px;
        display: inline-block;
        padding: 3px 15px;
        border-radius: 4px;
      }
      img{
        height: 50px;
        position: absolute;
        top: 5px;
        right: 15px;
      }
    }
  }

  /*账号登陆*/
  .login_input{
    width: 60%;
    margin: 0 auto 20px auto;
    .User_Input{
      display: flex;
      align-items: center;
      position: relative;
      .el-input{
        width: 80% !important;
      }
      .icon{
        position: absolute;
        left: 0;
        top: 3px;
        font-size: 20px;
        color: #9c9c9c;
      }
      .el-input__inner{
        padding-left: 35px;
        border: none;
        background-color: transparent;
        color: #fff;
      }
      .el-input__inner::placeholder{
        color: #ccc;
      }
      .el-input__inner:focus~.icon{
        color: #15a9fe;
      }

      /*忘记密码*/
      .user_forgetPassword{
        cursor: pointer;
        color: #15befe;
        text-decoration:underline;
      }
    }

  }

  .login_password{
    margin-bottom: 12px !important;
  }

  .login_input_line{
    height: 1px;
    span{
      display: block;
      height: 1px;
      background-color: #fff;
      width: 0;
      transition: all .5s;
    }
    .loginInputLine,
    .loginInputLineUser{
      animation: lineOpen 1s forwards;
    }
    @keyframes lineOpen{
      0%{
        width: 0;
      }
      100%{
        width: 100%;
      }
    }
    .loginInputLineClone,
    .loginInputLineCloneUser{
      animation: lineClone 1s forwards;
    }
    @keyframes lineClone{
      0%{
        width: 100%;
      }
      100%{
        width: 0;
      }
    }

  }

  /*验证码*/
  .login_break_input{
    width: 60%;
    margin: 0 auto;
    position: relative;
    .Fuc-Code{
      width: 100%;
      display: flex;
      align-items: flex-end;
      margin: 0 0 10px 0;
      .login_break_icon{
        position: absolute;
        left: 0;
        top: 13px;
        font-size: 20px;
        color: #9c9c9c;
      }

      .el-input{
        width: 50%;
        .el-input__inner{
          padding-left: 35px;
          border: none;
          background-color: transparent;
          color: #fff;
          height: 20px;
          line-height: 20px;
        }
        .el-input__inner::placeholder{
          color: #ccc;
        }
        .el-input__inner:focus~.icon{
          color: #15a9fe;
        }
      }



      .Code_div{
        display: flex;
        align-items: center;
        height: 33px;
        margin-left: 22px;
        border: 1px solid #15befe;
        border-top-left-radius: 4px;
        border-bottom-left-radius: 4px;
        border-right: none;
        img{
          border-top-left-radius: 3px;
          border-bottom-left-radius: 3px;
          height: 100%;
          width: 99px;
        }
        .login_break{
          cursor: pointer;
          height: 33px;
          padding: 0 5px;
          border: 1px solid #15a9fe;
          border-left: none;
          border-top-right-radius: 4px;
          border-bottom-right-radius: 4px;
          display: flex;
          align-items: center;
          justify-content: center;
          background: rgba(255,255,255,0.1);
          span{
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            img{
              width: 20px;
              height: 20px;
              border-radius: 0;
              color: #fff;
            }
          }

        }
        .login_break:hover{
          span{
            transform: rotate(720deg);
            transition: all 1s;
          }
        }


      }
    }
  }

  /*登陆注册按钮*/
  .login_btm{
    width: 60%;
    margin: 20px auto 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex: 2;

    /*注册按钮*/
    .btn_register{
      display: flex;
      justify-content: center;
      align-items: center;
      border: 1px solid #15a9fe;
      background: rgba(255,255,255,.1);
      border-radius: 4px;
      color: #15a9fe;
      flex: 1;
      margin-right: 12px;
      padding: 7px 0;
      cursor: pointer;
    }

    /*登陆按钮*/
    .btn_submit{
      display: flex;
      justify-content: center;
      align-items: center;
      border: 1px solid #15a9fe;
      background-color: #15a9fe;
      border-radius: 4px;
      color: #fff;
      padding: 7px 0;
      margin: 0 0 0 12px;
      flex: 1;
    }
  }

  /*快捷登录*/
  .Thirdparty{
    display: flex;
    justify-content: center;
    align-items: center;
    >div{
      margin: 0 14px;
      .icon{
        cursor: pointer;
        font-size: 38px;
        color: #616161;
        transition: all .3s;
      }
      .icon:hover{
        color: #15a9fe;
      }
    }
  }

  /*手机登陆*/
  .mobileLogin{
    z-index: 2;
    width: 523px;
    height: 414px;
    padding: 15px 0;
    background-color: rgba(18,23,28,0.8);
    text-align: center;
    position: absolute;
    /*标题*/
    .login_title{
      margin-bottom: 45px;


      .mobileLogin_title_left{
        width: 24px;
      }

      .login_mobile{
        cursor: pointer;
        img{
        }
      }
    }

    .User_Input{
      .el-input__inner{
        padding-left: 15px !important;
      }
      /*国家编号*/
      .el-input-group__prepend{
        background-color: transparent !important;
        border: none !important;
        padding: 0 0 0 35px !important;
        width: 95px;
        .el-select{
          margin: 0 !important;

          .el-input__inner{
            border-right: 1px solid #999 !important;
            border-radius: unset !important;
            height: 20px;
          }

          .el-input__icon{
            line-height: 20px !important;
          }
        }
        .el-input__inner{
          padding: 0 !important;
        }
      }

      /*号码已换*/
      .main_title_right{
        cursor: pointer;
        color: #15befe;
        text-decoration:underline;
      }
    }

    /*验证码框*/
    .login_break_input{
      .Fuc-Code{
        /*验证码按钮*/
        .Code_div{
          justify-content: center;
          border: 1px solid #15befe;
          border-radius: 4px;
          background: rgba(255,255,255,.1);
          color: #fff;
          cursor: pointer;
          padding: 0 10px;
          width: auto !important;
        }
      }
    }

    /*登陆注册按钮*/
    .login_btm{
      margin-top: 58px;
    }
  }

  /*账号忘记密码*/
  .user_forgetPasswordBox{
    width: 450px;
    height: 270px;
    background-color: rgba(18, 23, 28, 0.8);
    /*头部*/
    .title{
      padding: 0 15px;
      /*返回按钮*/
      .icon{
        color: #9c9c9c;
        font-size: 24px;
        cursor: pointer;
      }
    }
    /*主体内容*/
    .main{
      padding: 0 80px;
      /*主体标题*/
      .main_title{
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 15px;
        /*标题文字*/
        .main_title_left{
          display: flex;
          align-items: center;
          color: #fff;
          font-size: 18px;
          span{
            display: block;
            width: 5px;
            height: 20px;
            background: #15befe;
            margin-right: 10px;
          }
        }
        /*更改手机号*/
        .main_title_right{
          cursor: pointer;
          color: #fff;
          font-size: 12px;
        }
        .main_title_right:hover{
          color: #15befe;
        }
      }
      /*手机号*/
      .main_phoneNumber{
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        .icon{
          color: #9c9c9c;
          font-size: 20px;
        }
        /*下拉*/
        .el-input-group__prepend{
          background-color: transparent !important;
          border: none !important;
          padding: 0;
          width: 75px;
          .el-select{
            margin: 0 !important;
            .el-input__inner{
              height: 20px;
              line-height: 20px;
              border: none;
              border-right: 1px solid #999;
              border-radius: unset;
            }
            .el-input__icon{
              line-height: 20px;
            }
          }
        }
        /*输入框*/
        .el-input-group{
          >.el-input__inner{
            border: none;
            background-color: transparent;
            color: #fff;
          }
        }
      }
      /*验证码*/
      .main_code{
        display: flex;
        align-items: center;
        margin-bottom: 30px;
        .icon{
          font-size: 20px;
          color: #9c9c9c;
        }
        /*输入框*/
        .el-input{
          flex: 1;
          .el-input__inner{
            background-color: transparent;
            border: none;
            border-radius: unset;
            color: #fff;
          }
        }
        /*发送验证码按钮*/
        .el-button{
          width: 120px;
          height: 33px;
          background: rgba(255, 255, 255, 0.1);
          border: 1px solid #15befe;
          color: #fff;
          font-size: 14px;
          display: flex;
          justify-content: center;
          align-items: center;
          border-radius: 4px;
          padding: 0;
        }

      }
      /*确认取消按钮*/
      .main_btm{
        display: flex;
        justify-content: space-between;
        align-items: center;
        div{
          width: 130px;
          height: 35px;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid #15befe;
          border-radius: 5px;
          font-size: 14px;
          cursor: pointer;
        }
        /*取消按钮*/
        .main_btm_clone{
           background: rgba(255, 255, 255, 0.1);
           color: #15befe;
         }
        /*确认按钮*/
        .main_btm_true{
          background-color: #15befe;
          color: #fff;
        }
      }

    }
  }

  /*账户输入新密码*/
  .user_forgetPasswordTrue{
    width: 450px;
    height: 270px;
    background-color: rgba(18, 23, 28, 0.8);
    /*头部*/
    .title{
      padding: 0 15px;
      /*返回按钮*/
      .icon{
        color: #9c9c9c;
        font-size: 24px;
        cursor: pointer;
      }
    }
    /*主体内容*/
    .main {
      padding: 0 80px;
      /*主体标题*/
      .main_title {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 15px;
        /*标题文字*/
        .main_title_left {
          display: flex;
          align-items: center;
          color: #fff;
          font-size: 18px;
          span {
            display: block;
            width: 5px;
            height: 20px;
            background: #15befe;
            margin-right: 10px;
          }
        }
      }
      /*输入框*/
      .main_password{
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        .icon{
          color: #9c9c9c;
          font-size: 20px;
        }
        .el-input__inner{
          background-color: transparent !important;
          border: none;
          color: #fff;
        }
      }
      /*确认取消按钮*/
      .main_btm{
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 30px;
        div{
          width: 130px;
          height: 35px;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid #15befe;
          border-radius: 5px;
          font-size: 14px;
          cursor: pointer;
        }
        /*取消按钮*/
        .main_btm_clone{
          background: rgba(255, 255, 255, 0.1);
          color: #15befe;
        }
        /*确认按钮*/
        .main_btm_true{
          background-color: #15befe;
          color: #fff;
        }
      }
    }
  }

  /*未绑定身份证-输入旧手机*/
  .user_oldPhoneNumber{
    width: 450px;
    height: 270px;
    background-color: rgba(18, 23, 28, 0.8);
    overflow: hidden;
    position: relative;

    /*头部*/
    .title{
      padding-left: 15px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      /*返回按钮*/
      .icon{
        color: #9c9c9c;
        font-size: 24px;
        cursor: pointer;
      }
      /*客服按钮*/
      .serviceBtm{
        position: relative;
        .icon{
          position: relative;
          z-index: 1;
          padding-right: 5px;
        }
        span{
          display: block;
          width: 90px;
          height: 90px;
          background: rgba(0,0,0,.3);;
          transform: rotate(45deg);
          position: absolute;
          right: -45px;
          top: -45px;
        }
      }
    }
    /*主体内容*/
    .main {
      padding: 0 80px;
      /*主体标题*/
      .main_title {
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 15px;
        /*标题文字*/
        .main_title_left {
          display: flex;
          align-items: center;
          color: #fff;
          font-size: 18px;
          span {
            display: block;
            width: 5px;
            height: 20px;
            background: #15befe;
            margin-right: 10px;
          }
        }
      }
      /*手机号*/
      .main_phoneNumber{
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        margin-top: 40px;
        .icon{
          color: #9c9c9c;
          font-size: 20px;
        }
        /*下拉*/
        .el-input-group__prepend{
          background-color: transparent !important;
          border: none !important;
          padding: 0;
          width: 75px;
          .el-select{
            margin: 0 !important;
            .el-input__inner{
              height: 20px;
              line-height: 20px;
              border: none;
              border-right: 1px solid #999;
              border-radius: unset;
            }
            .el-input__icon{
              line-height: 20px;
            }
          }
        }
        /*输入框*/
        .el-input-group{
          >.el-input__inner{
            border: none;
            background-color: transparent;
            color: #fff;
          }
        }
      }
      /*确认取消按钮*/
      .main_btm{
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 60px;
        div{
          width: 130px;
          height: 35px;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid #15befe;
          border-radius: 5px;
          font-size: 14px;
          cursor: pointer;
        }
        /*取消按钮*/
        .main_btm_clone{
          background: rgba(255, 255, 255, 0.1);
          color: #15befe;
        }
        /*确认按钮*/
        .main_btm_true{
          background-color: #15befe;
          color: #fff;
        }
      }
    }
  }

  /*回答问题*/
  .user_verifyProblem{
    width: 670px;
    height: 620px;
    background-color: rgba(18, 23, 28, 0.8);
    position: relative;
    overflow: hidden;
    /*标题*/
    .title{
      padding-left: 15px;
      display: flex;
      align-items: flex-start;
      justify-content: space-between;
      margin-bottom: 20px;
      /*返回按钮*/
      .icon{
        color: #9c9c9c;
        font-size: 24px;
        cursor: pointer;
      }
      /*标题*/
      p{
        font-size: 18px;
        color: #fff;
        padding-top: 10px;
      }
      /*客服按钮*/
      .serviceBtm{
        position: relative;
        .icon{
          position: relative;
          z-index: 1;
          padding-right: 5px;
        }
        span{
          display: block;
          width: 90px;
          height: 90px;
          background: rgba(0,0,0,.3);;
          transform: rotate(45deg);
          position: absolute;
          right: -45px;
          top: -45px;
        }
      }
    }
    /*主体内容*/
    .main{
      padding: 0 60px;
      /*问题列表*/
      .problemList:not(:last-child){
        margin-bottom: 40px;
      }
      .problemList{
        p{
          font-size: 16px;
          color: #fff;
          margin-bottom: 10px;
        }
        .problemListBox{
          .el-radio__label{
            color: #fff;
          }
        }
      }

    }
    /*确认取消按钮*/
    .main_btm{
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 50px auto 0 auto;
      width: 45%;
      div{
        width: 130px;
        height: 35px;
        display: flex;
        justify-content: center;
        align-items: center;
        border: 1px solid #15befe;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
      }
      /*取消按钮*/
      .main_btm_clone{
        background: rgba(255, 255, 255, 0.1);
        color: #15befe;
      }
      /*确认按钮*/
      .main_btm_true{
        background-color: #15befe;
        color: #fff;
      }
    }
  }

  /*账号忘记密码*/
  .user_newPhoneNumber{
    width: 450px;
    height: 270px;
    background-color: rgba(18, 23, 28, 0.8);
    /*头部*/
    .title{
      padding: 0 15px;
      /*返回按钮*/
      .icon{
        color: #9c9c9c;
        font-size: 24px;
        cursor: pointer;
      }
    }
    /*主体内容*/
    .main{
      padding: 0 80px;
      /*主体标题*/
      .main_title{
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 15px;
        /*标题文字*/
        .main_title_left{
          display: flex;
          align-items: center;
          color: #fff;
          font-size: 18px;
          span{
            display: block;
            width: 5px;
            height: 20px;
            background: #15befe;
            margin-right: 10px;
          }
        }
        /*更改手机号*/
        .main_title_right{
          cursor: pointer;
          color: #fff;
          font-size: 12px;
        }
        .main_title_right:hover{
          color: #15befe;
        }
      }
      /*手机号*/
      .main_phoneNumber{
        display: flex;
        align-items: center;
        margin-bottom: 15px;
        .icon{
          color: #9c9c9c;
          font-size: 20px;
        }
        /*下拉*/
        .el-input-group__prepend{
          background-color: transparent !important;
          border: none !important;
          padding: 0;
          width: 75px;
          .el-select{
            margin: 0 !important;
            .el-input__inner{
              height: 20px;
              line-height: 20px;
              border: none;
              border-right: 1px solid #999;
              border-radius: unset;
            }
            .el-input__icon{
              line-height: 20px;
            }
          }
        }
        /*输入框*/
        .el-input-group{
          >.el-input__inner{
            border: none;
            background-color: transparent;
            color: #fff;
          }
        }
      }
      /*验证码*/
      .main_code{
        display: flex;
        align-items: center;
        margin-bottom: 30px;
        .icon{
          font-size: 20px;
          color: #9c9c9c;
        }
        /*输入框*/
        .el-input{
          flex: 1;
          .el-input__inner{
            background-color: transparent;
            border: none;
            border-radius: unset;
            color: #fff;
          }
        }
        /*发送验证码按钮*/
        .el-button{
          width: 120px;
          height: 33px;
          background: rgba(255, 255, 255, 0.1);
          border: 1px solid #15befe;
          color: #fff;
          font-size: 14px;
          display: flex;
          justify-content: center;
          align-items: center;
          border-radius: 4px;
          padding: 0;
        }

      }
      /*确认取消按钮*/
      .main_btm{
        display: flex;
        justify-content: space-between;
        align-items: center;
        div{
          width: 130px;
          height: 35px;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid #15befe;
          border-radius: 5px;
          font-size: 14px;
          cursor: pointer;
        }
        /*取消按钮*/
        .main_btm_clone{
          background: rgba(255, 255, 255, 0.1);
          color: #15befe;
        }
        /*确认按钮*/
        .main_btm_true{
          background-color: #15befe;
          color: #fff;
        }
      }

    }
  }

  /*验证身份证信息*/
  .user_verifyIdCard{
    width: 450px;
    height: 270px;
    background-color: rgba(18, 23, 28, 0.8);
    overflow: hidden;
    position: relative;
    /*头部*/
    .title{
      padding-left: 15px;
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      /*返回按钮*/
      .icon{
        color: #9c9c9c;
        font-size: 24px;
        cursor: pointer;
      }
      /*客服按钮*/
      .serviceBtm{
        position: relative;
        .icon{
          position: relative;
          z-index: 1;
          padding-right: 5px;
        }
        span{
          display: block;
          width: 90px;
          height: 90px;
          background: rgba(0,0,0,.3);;
          transform: rotate(45deg);
          position: absolute;
          right: -45px;
          top: -45px;
        }
      }
    }
    /*主体内容*/
    .main{
      padding: 0 80px;
      /*主体标题*/
      .main_title{
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        margin-bottom: 10px;
        /*标题文字*/
        .main_title_left{
          display: flex;
          align-items: center;
          color: #fff;
          font-size: 18px;
          span{
            display: block;
            width: 5px;
            height: 20px;
            background: #15befe;
            margin-right: 10px;
          }
        }
        /*更改手机号*/
        .main_title_right{
          cursor: pointer;
          color: #fff;
          font-size: 12px;
        }
        .main_title_right:hover{
          color: #15befe;
        }
      }
      /*手机号*/
      .main_phoneNumber{
        display: flex;
        align-items: center;
        .icon{
          color: #9c9c9c;
          font-size: 20px;
        }
        /*下拉*/
        .el-input-group__prepend{
          background-color: transparent !important;
          border: none !important;
          padding: 0;
          width: 75px;
          .el-select{
            margin: 0 !important;
            .el-input__inner{
              height: 20px;
              line-height: 20px;
              border: none;
              border-right: 1px solid #999 !important;
              border-radius: unset;
            }
            .el-input__icon{
              line-height: 20px;
            }
          }
        }
        /*输入框*/
        .el-input-group{
          >.el-input__inner{
            border: none;
            background-color: transparent;
            color: #fff;
          }
        }
      }
      /*用户姓名*/
      .main_userName{
        display: flex;
        align-items: center;
        .icon{
          font-size: 20px;
          color: #9c9c9c;
        }
        .el-input__inner{
          border: none;
          background-color: transparent;
          color: #fff;
        }
      }
      /*确认取消按钮*/
      .main_btm{
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 10px;
        div{
          width: 130px;
          height: 35px;
          display: flex;
          justify-content: center;
          align-items: center;
          border: 1px solid #15befe;
          border-radius: 5px;
          font-size: 14px;
          cursor: pointer;
        }
        /*取消按钮*/
        .main_btm_clone{
          background: rgba(255, 255, 255, 0.1);
          color: #15befe;
        }
        /*确认按钮*/
        .main_btm_true{
          background-color: #15befe;
          color: #fff;
        }
      }

    }
  }

  .login{
    /*警告弹窗清除样式*/
    >.el-dialog__wrapper{
      left: unset !important;
      top: unset !important;
      right: unset !important;
      bottom: unset !important;
    }
    .el-dialog__header{
      padding: 10px 20px 10px !important;
    }
  }

  /*封禁弹窗*/
  .loginBannedModal{
    /*标题ICON*/
    .loginBannedModal_title{
      color: #15befe;
      font-size: 22px;
    }
    .loginBannedModal_main{
      /*icon*/
      .banned_icon{
        display: flex;
        justify-content: center;
        align-items: center;
        .icon{
          font-size: 56px;
          color: #15befe;
        }
      }
      /*封禁警告*/
      .banned_time{
        text-align: center;
        font-size: 18px;
        color: #333;
        font-weight: 700;
        margin: 20px 0 10px 0;
        span{
          color: #15befe;
        }
      }
      /*封禁理由*/
      .banned_message{
        max-width: 300px;
        margin: 0 auto;
        text-align: center;
        color: #15befe;
        padding-bottom: 30px;
      }
    }
  }

  /*审核失败弹窗*/
  .loginCheckModal{
    .loginCheckModal_title{
      font-size: 22px;
      color: #15befe;
    }
    .loginCheckModal_main{
      .check_icon{
        display: flex;
        justify-content: center;
        align-items: center;
        .icon{
          font-size: 56px;
          color: red;
        }
      }
      .check_time{
        text-align: center;
        font-size: 18px;
        color: #333;
      }
      .check_btm{
        width: 120px;
        height: 30px;
        margin: 30px auto;
        background: #15befe;
        color: #fff;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 16px;
      }
    }
  }

  /*联系客服弹窗*/
  .serviceModal{
    /*清除样式*/
    .el-dialog__body{
      padding-top: 0 !important;
    }
    /*弹窗logo*/
    .serviceModal_logo{
      font-size: 20px;
      color: #15befe;
    }
    /*标题样式*/
    .serviceModal_title{
      text-align: center;
      font-size: 16px;
      color: #333;
      margin-bottom: 20px;
    }
    /*账号框*/
    .serviceModal_input{
      margin-bottom: 20px;
      .el-input__inner{
        height: 30px;
        line-height: 30px;
      }
    }
    /*文本域样式*/
    .serviceModal_textarea{
      margin-bottom: 20px;
      textarea{
        height: 140px;
        max-height: 140px;
      }
    }
    /*手机号*/
    .service_phoneNumber{
      display: flex;
      align-items: center;
      border: 1px solid #dcdfe6;
      border-radius: 4px;
      /*下拉*/
      .el-input-group__prepend{
        background-color: transparent !important;
        border: none !important;
        padding: 0;
        width: 75px;
        .el-select{
          margin: 0 !important;
          .el-input__inner{
            height: 30px;
            line-height: 30px;
            border: none;
            border-right: 1px solid #dcdfe6 !important;
            border-radius: unset;
          }
          .el-input__icon{
            line-height: 20px;
          }
        }
      }
      /*输入框*/
      .el-input-group{
        >.el-input__inner{
          border: none;
          background-color: transparent;
          color: #fff;
          height: 30px;
          line-height: 30px;
        }
      }
    }
    /*确认取消按钮*/
    .main_btm{
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin: 20px auto 0 auto;
      width: 80%;
      div{
        width: 130px;
        height: 35px;
        display: flex;
        justify-content: center;
        align-items: center;
        border: 1px solid #15befe;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
      }
      /*取消按钮*/
      .main_btm_clone{
        background: rgba(255, 255, 255, 0.1);
        color: #15befe;
      }
      /*确认按钮*/
      .main_btm_true{
        background-color: #15befe;
        color: #fff;
      }
    }
  }
</style>
