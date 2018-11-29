<template>
    <div class="articleModify">
      <div class="articleModify_header">
        {{articleData.title}} - 修改
      </div>

      <div class="articleModify_main">
        <div class="articleModify_List">
          <div class="list_title">标题</div>
          <div class="list_input">
            <el-input v-model="articleData.title"></el-input>
          </div>
        </div>

        <div class="articleModify_List">
          <div class="list_title">封面图片</div>
          <div class="list_input list_upload">
            <el-upload
              class="articleModify_uploader"
              action="/"
              :show-file-list="false"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload">
              <img v-if="articleData.image_path" :src="Tools.handleImg(articleData.image_path)" class="articleModify_img">
              <i v-else class="el-icon-plus articleModify-icon"></i>
            </el-upload>
            <p>(图片比例4:3，大小不超过1M)</p>
          </div>
        </div>

        <div class="articleModify_List">
          <div class="list_title">简介</div>
          <div class="list_input list_textarea">
            <el-input type="textarea" :rows="5" resize="none" v-model="articleData.profile"></el-input>
          </div>
        </div>

        <div class="articleModify_List">
          <div class="list_title">详细内容</div>
          <div class="list_input list_textarea">
            <el-input type="textarea" :rows="5" resize="none" v-model="articleData.content"></el-input>
          </div>
        </div>

        <div class="articleModify_List">
          <div class="list_title">标签</div>
          <div class="list_input list_tags">
            <div class="tags" v-for="(item,index) in tags" :key="index">
              <div @click="updateButton(item.tag_id)">{{item.name}}</div>
              <p @click="deleteTags(index,item.tag_id)"><i class="iconfont icon-minus"></i></p>
            </div>
          </div>
        </div>

        <div class="articleModify_List">
          <div class="list_title list_title_margin">使用零件、软件</div>
          <div class="list_input list_tags">
            <div class="tags">
              <div @click="updatePart(item.source_id)">万用表</div>
              <p @click="deletePart(item.source_id)"><i class="iconfont icon-minus"></i></p>
            </div>
          </div>
        </div>

        <div class="articleModify_List">
          <div class="list_title">对应链接</div>
          <div class="list_input list_tags">
            <div class="tags">
              <div>www.baidu.com</div>
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
            <el-input v-model="name"></el-input>
          </div>
        </div>
        <span slot="footer" class="dialog-footer">
          <el-button @click="modifyVisible = false">取 消</el-button>
          <el-button type="primary" @click="updateTag">保 存</el-button>
        </span>
      </el-dialog>
      <el-button type="primary" @click="submitArticle">修改</el-button>
    </div>
</template>

<script>
  export default {
    name: "ArticleModify",
    data() {
      return {
        id:'',//文章全局id
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
        },//文章详细数据
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

      //获取文章详情
      getArticleDetails(){
          this.HttpClient.post('/admin/article/getInfo',{id:this.$route.query.id})
              .then(res=>{
                  console.log(res);
                  let {code,data} = res.data;
                  if(code===200){
                      this.articleData.title=data.title;
                      this.articleData.image_path=data.image_path;
                      this.articleData.profile=data.profile;
                      this.articleData.content=data.content;
                      this.articleData.category_id=data.category_id;
                      this.tags=data.label;
                      this.part=data.source;
                  }
              })
      },

      //修改标签按钮事件
      updateButton(id){
        this.modifyVisible=true;
        this.tag_id=id
      },

      //修改标签
      updateTag(){
        this.modifyVisible=false;
        this.HttpClient.post('/admin/tags/edit',{relation_id:this.id,name:this.name,tag_id:this.tag_id})
            .then(res=>{
                console.log(res);
                if(res.data.code===200){
                    this.$message.success(res.data.msg);
                    setTimeout(()=>{
                        this.getArticleDetails()
                    },500)
                }else{
                    this.$message.error(res.data.msg)
                }
            })
      },
      // 删除标签
      deleteTags(index,id){
        this.HttpClient.post('/admin/tags/del',{relation_id:this.id,tag_id:id})
            .then(res=>{
                console.log(res);
                if(res.data.code===200){
                    this.$message.success('删除成功');
                    this.tags.splice(index,1);
                }else{
                    this.$message.error('删除成功')
                }
            })
      },
      //修改零件
      updatePart(id){
          this.modifyVisible=false;

      },
      //删除零件
      deletePart(){},
      //提交修改
      submitArticle(){
        this.HttpClient.post('/admin/article/edit',this.articleData)
            .then(res=>{
                console.log(res);
                if(res.data.code===200){
                    this.$message.success(res.data.msg)
                }else{
                    this.$message.error(res.data.msg)
                }
            })
      }
    },
    created(){
        this.articleData.id=this.$route.query.id;
        this.id=this.$route.query.articleId;
        console.log(this.id);
        this.getArticleDetails()
    },
  }
</script>

<style lang="less">
  .articleModify{
    margin-left: 10px;
    margin-top: 10px;
    background: #fff;
    width: calc(100vw - 240px);
    border-radius: 2px;
    /*头部*/
    .articleModify_header{
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
    .articleModify_main{
      padding: 30px 40px;
      /*列表*/
      .articleModify_List:not(:last-child){
        margin-bottom: 25px;
      }
      .articleModify_List{
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
        /*长标题*/
        .list_title_margin{
          margin-right: 22px;
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
        /*上传框*/
        .list_upload{
          display: flex;
          align-items: flex-end;
          /*封面图片上传*/
          .articleModify_uploader{
            margin-right: 20px;
            .el-upload {
              border: 1px dashed #d9d9d9;
              border-radius: 6px;
              cursor: pointer;
              position: relative;
              overflow: hidden;
            }
            .el-upload:hover {
              border-color: #409EFF;
            }
            .articleModify-icon {
              font-size: 28px;
              color: #8c939d;
              width: 178px;
              height: 178px;
              line-height: 178px;
              text-align: center;
            }
            .articleModify_img {
              width: 178px;
              height: 178px;
              display: block;
            }
          }
          >p{
            font-size: 12px;
            color: #999;
          }
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
