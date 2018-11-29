<template>
  <div class="questionModify">
    <div class="questionModify_header">
      如何给汽车加油 - 修改
    </div>

    <div class="questionModify_main">
      <div class="questionModify_List">
        <div class="list_title">标题</div>
        <div class="list_input">
          <el-input></el-input>
        </div>
      </div>

      <div class="questionModify_List">
        <div class="list_title">详细内容</div>
        <div class="list_input list_textarea">
          <el-input type="textarea" :rows="5" resize="none"></el-input>
        </div>
      </div>

      <div class="questionModify_List">
        <div class="list_title">标签</div>
        <div class="list_input list_tags">
          <div class="tags">
            <div @click="modifyVisible = true">卡曼滤波器</div>
            <p><i class="iconfont icon-minus"></i></p>
          </div>
        </div>
      </div>


      <div class="questionModify_List">
        <div class="list_title">对应链接</div>
        <div class="list_input list_tags">
          <div class="tags">
            <div @click="modifyVisible = true">www.baidu.com</div>
            <p><i class="iconfont icon-minus"></i></p>
          </div>
        </div>
      </div>
    </div>

    <el-dialog
      custom-class="modifyDialog"
      :visible.sync="modifyVisible"
      width="400px">
      <span slot="title" class="modifyVisible_title"><i class="iconfont icon-edit-square"></i>修改</span>
      <div class="modifyVisible">
        <p>新名称：</p>
        <div>
          <el-input></el-input>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
          <el-button @click="modifyVisible = false">取 消</el-button>
          <el-button type="primary">保 存</el-button>
        </span>
    </el-dialog>
    <div class="questionModify_btm">
      <el-button>取消</el-button>
      <el-button type="primary">修改</el-button>
    </div>
  </div>
</template>

<script>
  export default {
    name: "questionModify",
    data() {
      return {
        id:'',//全局id
        imageUrl: '',
        tags:[],//标签列表
        name:'',//修改标签名称
        tag_id:'',//修改标签id
        part:[],//零件列表
        modifyVisible: false, // 修改弹框
        articleData:{
          id:'',
          title:'',
          image_path:'',
          profile:'',
          content:'',
          category_id:''
        },
      };
    },
    methods: {
      handleAvatarSuccess(res, file) {
        this.imageUrl = URL.createObjectURL(file.raw);
      },
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg';
        const isLt1M = file.size / 1024;

        if (!isJPG) {
          this.$message.error('上传图片只能是 JPG 格式!');
        }
        if (!isLt1M) {
          this.$message.error('上传图片大小不能超过 1MB!');
        }
        return isJPG && isLt1M;
      },

    },
  }
</script>

<style lang="less">
  .questionModify{
    margin-left: 10px;
    margin-top: 10px;
    background: #fff;
    width: calc(100vw - 240px);
    border-radius: 2px;
    /*头部*/
    .questionModify_header{
      border-bottom: 2px solid #f2f2f2;
      display: flex;
      align-items: center;
      height: 70px;
      padding-left: 40px;
      font-size: 20px;
      color: #222;
      overflow: auto;
    }
    /*主体内容*/
    .questionModify_main{
      padding: 30px 40px;
      /*列表*/
      .questionModify_List:not(:last-child){
        margin-bottom: 25px;
      }
      .questionModify_List{
        display: flex;
        align-items: flex-start;
        justify-content: flex-start;
        /*标题*/
        .list_title{
          font-size: 14px;
          color: #fff;
          background: #15bafe;
          padding: 0 10px;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 40px;
          min-width: 80px;
          margin-right: 40px;
        }
        /*输入框*/
        .list_input{
          /*input样式*/
          .el-input__inner{
            border-radius: 0;
          }
          /*textarea样式*/
          .el-textarea__inner{
            border-radius: 0;
          }
        }
        .list_textarea{
          width: 500px;
        }
        /*tags*/
        .list_tags{
          display: flex;
          align-items: center;
          .tags:not(:last-child){
            margin-right: 15px;
          }
          .tags{
            display: flex;
            align-items: center;
            cursor: pointer;
            div{
              display: flex;
              align-items: center;
              height: 38px;
              padding: 0 20px;
              border: 1px solid #dcdfe6;
              border-right: none;
              font-size: 14px;
              color: #999;
            }
            p{
              background: red;
              display: flex;
              justify-content: center;
              align-items: center;
              color: #fff;
              height: 40px;
              width: 35px;
            }
          }
        }
      }
    }

    /*修改弹框*/
    .modifyDialog{
      .modifyVisible_title{
        display: flex;
        border-bottom: 1px solid #e8e8e8;
        padding-bottom: 10px;
        i{
          margin-right: 10px;
        }
      }
      .modifyVisible{
        display: flex;
        align-items: center;
      }
    }
  }
</style>
