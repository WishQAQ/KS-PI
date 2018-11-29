<template>
    <div class="recruitment">

      <div class="recruitment_box width_1200">
        <div class="recruitment_box_bg"></div>
        <div class="recruitment_left">
          <div class="recruitment_left_title">
            <span>人才招聘</span>
            <p>Talent recruitment</p>
          </div>

          <div class="recruitment_left_text">
            <p>KS-LAB团队真诚期待您的加入</p>
            <p>请呈递能够体现技术水平的作品至企业招聘邮箱：</p>
            <p>KS-LAB@163.com</p>
          </div>

          <div class="recruitment_left_city">

            <el-select v-model="value" placeholder="请选择">
              <el-option
                v-for="item in options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>

          </div>
        </div>

        <div class="recruitment_right">

          <el-tabs :tab-position="tabPosition">
            <el-tab-pane label="ui设计师">

              <div class="recruitment_tab">
                <div class="recruitment_tab_left">
                  <h2>ui设计师</h2>

                  <p>职位描述</p>
                  <p>1.负责公司现有的数据可视化项目的前端开发工作；</p>
                  <p>2.与产品经理、项目经理和设计团队沟通、保证项目质量和开发进度；</p>
                  <p>3.研究目前流行的可视化技术及工具；</p>
                </div>

                <div class="recruitment_tab_right">
                  <p>岗位需求</p>
                  <p>1.精通原生Javascript，熟练使用ES6；</p>
                  <p>2.熟练应用echarts、highcharts；</p>
                  <p>3.有react、canvas、svg或webgl开发经验优先；</p>
                  <p>4.熟悉nodejs/java/python之一开发经验；</p>
                  <p>5.熟悉内存泄漏的排查,且提供解决方案；</p>
                  <p>6.有独立设计、开发公共组件库经验；</p>
                  <p>7.了解数据可视化；</p>
                  <p>8.关注新技术，关注用户体验，热爱分享，具有创新精神及团队协作精神；</p>
                </div>
              </div>

            </el-tab-pane>
            <el-tab-pane label="web前端工程师" v-for="(workList ,index) in workPersonnel" :key="index">

              <div class="recruitment_tab">
                <div class="recruitment_tab_left">
                  <h2>{{workList.name}}</h2>

                  <p>职位描述</p>
                  <p>1.负责公司现有的数据可视化项目的前端开发工作；</p>
                  <p>2.与产品经理、项目经理和设计团队沟通、保证项目质量和开发进度；</p>
                  <p>3.研究目前流行的可视化技术及工具；</p>
                </div>

                <div class="recruitment_tab_right">
                  <p>岗位需求</p>
                  <p>1.精通原生Javascript，熟练使用ES6；</p>
                  <p>2.熟练应用echarts、highcharts；</p>
                  <p>3.有react、canvas、svg或webgl开发经验优先；</p>
                  <p>4.熟悉nodejs/java/python之一开发经验；</p>
                  <p>5.熟悉内存泄漏的排查,且提供解决方案；</p>
                  <p>6.有独立设计、开发公共组件库经验；</p>
                  <p>7.了解数据可视化；</p>
                  <p>8.关注新技术，关注用户体验，热爱分享，具有创新精神及团队协作精神；</p>
                </div>
              </div>

            </el-tab-pane>
            <el-tab-pane label="php后台">

              <div class="recruitment_tab">
                <div class="recruitment_tab_left">
                  <h2>php后台</h2>

                  <p>职位描述</p>
                  <p>1.负责公司现有的数据可视化项目的前端开发工作；</p>
                  <p>2.与产品经理、项目经理和设计团队沟通、保证项目质量和开发进度；</p>
                  <p>3.研究目前流行的可视化技术及工具；</p>
                </div>

                <div class="recruitment_tab_right">
                  <p>岗位需求</p>
                  <p>1.精通原生Javascript，熟练使用ES6；</p>
                  <p>2.熟练应用echarts、highcharts；</p>
                  <p>3.有react、canvas、svg或webgl开发经验优先；</p>
                  <p>4.熟悉nodejs/java/python之一开发经验；</p>
                  <p>5.熟悉内存泄漏的排查,且提供解决方案；</p>
                  <p>6.有独立设计、开发公共组件库经验；</p>
                  <p>7.了解数据可视化；</p>
                  <p>8.关注新技术，关注用户体验，热爱分享，具有创新精神及团队协作精神；</p>
                </div>
              </div>

            </el-tab-pane>
            <el-tab-pane label="大数据开发工程师">

              <div class="recruitment_tab">
                <div class="recruitment_tab_left">
                  <h2>大数据开发工程师</h2>

                  <p>职位描述</p>
                  <p>1.负责公司现有的数据可视化项目的前端开发工作；</p>
                  <p>2.与产品经理、项目经理和设计团队沟通、保证项目质量和开发进度；</p>
                  <p>3.研究目前流行的可视化技术及工具；</p>
                </div>

                <div class="recruitment_tab_right">
                  <p>岗位需求</p>
                  <p>1.精通原生Javascript，熟练使用ES6；</p>
                  <p>2.熟练应用echarts、highcharts；</p>
                  <p>3.有react、canvas、svg或webgl开发经验优先；</p>
                  <p>4.熟悉nodejs/java/python之一开发经验；</p>
                  <p>5.熟悉内存泄漏的排查,且提供解决方案；</p>
                  <p>6.有独立设计、开发公共组件库经验；</p>
                  <p>7.了解数据可视化；</p>
                  <p>8.关注新技术，关注用户体验，热爱分享，具有创新精神及团队协作精神；</p>
                </div>
              </div>

            </el-tab-pane>
          </el-tabs>

        </div>

        <div class="recruitment_application">

          <el-button class="recruitment_application_button" type="primary" @click="dialogVisible = true">申请职位</el-button>

          <el-dialog :visible.sync="dialogVisible" class="recruitment_application_box" center>
            <div class="recruitment_title">
              <i class="icon icon-huaban4"></i>
            </div>

            <div class="recruitment_application_main">
              <div class="recruitment_application_list recruitment_application_list_two">
                <div class="recruitment_application_input">
                  <p>姓名</p>
                  <input type="text" v-model="name">
                </div>

                <div class="recruitment_application_input">
                  <p>应聘职位</p>
                  <el-select v-model="job" placeholder="请选择">
                    <el-option
                      v-for="item in jobOption"
                      :key="item.positions_id"
                      :label="item.name"
                      :value="item.positions_id">
                    </el-option>
                  </el-select>
                </div>
              </div>

              <div class="recruitment_application_list recruitment_application_list_two">
                <div class="recruitment_application_input">
                  <p>毕业院校</p>
                  <input v-model="school" type="text" placeholder="例：重庆大学">
                </div>

                <div class="recruitment_application_input">
                  <p>教育程度</p>
                  <el-select v-model="educationalLevel" placeholder="请选择">
                    <el-option
                      v-for="item in educationalOption"
                      :key="item.valueCulture"
                      :label="item.label"
                      :value="item.valueCulture">
                    </el-option>
                  </el-select>
                </div>
              </div>

              <div class="recruitment_application_list">
                <div class="recruitment_application_input">
                  <p>专业名称</p>
                  <input v-model="major" type="text" placeholder="例：计算机科学与技术">
                </div>
              </div>

              <div class="recruitment_application_list recruitment_application_list_two">
                <div class="recruitment_application_input">
                  <p>联系电话</p>
                  <input v-model="phone" type="text">
                </div>

                <div class="recruitment_application_input">
                  <p>邮箱</p>
                  <input v-model="email" type="email">
                </div>
              </div>

              <div class="recruitment_application_list">
                <div class="recruitment_application_input">
                  <p>特殊要求 <span>(选填)</span></p>
                  <textarea v-model="condition"></textarea>
                </div>
              </div>

              <div class="recruitment_application_list">
                <div class="recruitment_application_input">
                  <p>简历或作品</p>
                  <el-upload
                    action="http://test.kslab.com/api/article/null"
                    list-type="picture-card"
                    :limit="5"
                    :file-list="fileList"
                    :before-upload="handleBeforeUpload"
                    :before-remove="handleBeforeRemove"
                    :on-success="handleSuccess"
                    :on-preview="handlePictureCardPreview"
                    :on-remove="handleRemove">
                    <i class="el-icon-plus"></i>
                  </el-upload>
                  <el-dialog :visible.sync="dialogVisibleUpload">
                    <img width="100%" :src="dialogImageUrl" alt="">
                  </el-dialog>
                </div>
              </div>

            </div>

            <div slot="footer" class="dialog-footer">
              <el-button @click="dialogVisible = false">取 消</el-button>
              <el-button type="primary" @click="onOptionClick">确 定</el-button>
            </div>
          </el-dialog>
        </div>
      </div>
    </div>
</template>

<script>
    export default {
      name: "recruitment",
      components: {
      },
      data() {
        return {
          tabPosition: 'left',
          dialogVisible: false,
          options: [{
            value: '选项1',
            label: '重庆'
          }, {
            value: '选项2',
            label: '北京'
          }, {
            value: '选项3',
            label: '上海'
          }],
          value: '重庆',

          // 应聘职位
          jobOption: [{
            valuePosition: '选项1',
            label: 'UI设计师'
          }, {
            valuePosition: '选项2',
            label: 'WEB前端工程师'
          }, {
            valuePosition: '选项3',
            label: 'PHP后台开发'
          }],

          // 教育程度
          educationalOption: [{
            valueCulture: '大专',
            label: '大专'
          }, {
            valueCulture: '本科',
            label: '本科'
          }, {
            valueCulture: '研究生',
            label: '研究生'
          }, {
            valueCulture: '博士',
            label: '博士'
          }],
          valueCulture: '',
          fileList: [],
          fileFilesFileList: [], // 附件列表
          beforeFilesFileList: [], //上传之后，删除之前的fileList,
          // 上传附件
          dialogImageUrl: '',
          dialogVisibleUpload: false,
          workPersonnel:'',     //需要人才
          name:null,     //名字
          educationalLevel: '', //教育程度
          job: '', // 应聘职位
          major: '', // 专业
          phone: '', // 电话
          email: '', // 邮箱
          school: '', // 学校
          condition: '', //特殊要求
          serial_number: null, //生成上传文件唯一值
        };
      },
      created() {
        this.serial_number = this.Tools.GetNumber();
        this.HttpClient.post('/footer/positions/list')
          .then(res =>{
            console.log(res.data)
            if(res.data.code === 200) {
              this.jobOption = res.data.data;
            }
          })
      },
      methods: {
        handleRemove(file, fileList) {
          console.log(file, fileList);
        },
        handlePictureCardPreview(file) {
          this.dialogImageUrl = file.url;
          this.dialogVisible = true;
        },
        onOptionClick(){
          //this.dialogVisible = false;
          const param = {
            name: this.name,
            positions_id: this.job,
            school: this.school,
            education: this.educationalLevel,
            major: this.major,
            phone: this.phone,
            email: this.email,
            demand: this.condition,
            attachment: this.serial_number
          };
          console.log(param)
          this.HttpClient.post('/footer/positions/applied', param)
            .then(res =>{
              if(res.data.code === 200) {
                this.name = '';
                this.job = '';
                this.school = '';
                this.educationalLevel = '';
                this.major = '';
                this.phone = '';
                this.email = '';
                this.condition = '';
                this.serial_number = '';
                this.$message.success('提交成功');
              }else {
                this.$message.error(res.data.msg);
                this.serial_number = this.Tools.GetNumber();
              }
            })
        },
        handleBeforeUpload(file) {
          const isLt5M = file.size / 1024 / 1024 < 5;
          const fileType = file.name.split('.')[1];
          if(fileType !== 'jpg' && fileType !== 'doc' && fileType !== 'png' && fileType !== 'pdf'){
            this.$message.error('文档类型只能为txt、doc、docx');
            return false;
          }
          if (!isLt5M) {
            this.$message.error('上传文件大小不能超过5M!')
            return false;
          }
          var FromData = new FormData();
          //文章上传图片接口
          //FromData.append('token', window.localStorage.token);
          FromData.append('attachment', file);
          FromData.append('serial_number', this.serial_number);
          this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'footer/positions/uploadattachment', FromData)
            .then((res) => {
              //console.log(res)
              if (res.data.code === 200) {
                this.fileFilesFileList.push(res.data.path)
                this.$message.success(res.data.msg)
                //console.log(this.fileList)
              } else {
                this.$message.error(res.data.msg)
                return false
              }

            })
        },
        async handleBeforeRemove(file, fileList) {
          const isLt5M = file.size / 1024 / 1024 < 5;
          const fileType = file.name.split('.')[1];
          if(fileType !== 'jpg' && fileType !== 'doc' && fileType !== 'png' && fileType !== 'pdf'){
            this.$message.error('文档类型只能为txt、doc、docx');
            return false;
          }
          if (!isLt5M) {
            this.$message.error('上传文件大小不能超过5M!')
            return false;
          }
          let index = this.beforeFilesFileList.map(item => item.name).indexOf(file.name)
          console.log(index)
          let urls = this.fileFilesFileList[index];
          console.log(urls)
          await this.HttpClient.post('/services/destroyFile', {url: urls}).then(res => {
            if (res.data.code === 200) {
              this.fileFilesFileList.splice(index, 1);
            } else {
              file.status = false;
              this.$message.error('删除失败');
              return false;
            }
          });
        },
        handleSuccess(response, file, fileList) {
          this.beforeFilesFileList = fileList;
        }
      },
    }
</script>

<style src="../../assets/css/recruitment.css"></style>

<style lang="less">
  /*申请职位按钮*/
  .recruitment_application_button{
    position: absolute;
    right: 0;
    bottom: 2%;
  }
  .recruitment_application_box{
    position: relative;
    left: -60px;

    .el-dialog{
      min-width: 600px;
      margin-top: 3% !important;

      /*关闭按钮*/
      .el-dialog__headerbtn{
        top: 10px !important;
        z-index: 1;
      }
    }
    /*标题logo*/
    .recruitment_title{
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      border-bottom: 1px solid #dcdcdc;
      padding-left: 22px;
      .icon{
        font-size: 24px;
        color: #15bafe;
      }
    }

    /*主体内容*/
    .recruitment_application_main{

      .recruitment_application_list{
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;

        .recruitment_application_input{
          flex: 1;
          p{
            margin-bottom: 5px;
            span{
              font-size: 12px;
              color: #999;
            }
          }
          input{
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            width: 100%;
            height: 30px !important;
            border: 1px solid #dcdfe6 !important;
            padding: 0 10px !important;
            line-height: 30px !important;
            border-radius: 4px;
          }
          .el-input__icon{
            line-height: 30px !important;
          }

          /*文本域*/
          textarea{
            resize: none;
            width: 100%;
            height: 60px;
            padding: 10px;
            border: 1px solid #dcdfe6 !important;
            border-radius: 4px;
            -moz-box-sizing: border-box;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
          }

          /*上传框*/
          div{
            max-height: 150px;
            overflow: auto;
          }
          /*.dialogVisibleUpload{*/
            /*width: 120px !important;*/
            /*height: 120px !important;*/
            /*line-height: 120px !important;*/
          /*}*/

          /*.el-upload-list__item{*/
            /*width: 120px !important;*/
            /*height: 120px !important;*/
            /*line-height: 120px !important;*/
          /*}*/
        }
      }

      .recruitment_application_list_two{
        .recruitment_application_input{
          input{
            width: 260px !important;
          }
        }
        .recruitment_application_input:nth-child(1){
          margin-right: 40px !important;
        }
      }


    }
  }
</style>
