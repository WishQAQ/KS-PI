    <template>
        <div>
            <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
            <div class="content">
                <p class="title">上传服务</p>
                <div class="content_contain">
                    <Category :categoryData="categoryData"></Category>
                    <div class="big-box clearfloat">
                        <div class="box">
                            <div class="box-top">置顶</div>
                            <div class="box-bot">
                                <div class="box-bot-left">
                                    <img :src="imageUrl" alt="">
                                </div>
                                <div class="box-bot-right">
                                    <div class="box-top-top">
                                        <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/" 
                                        :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"> 
                                            <img v-if="false" :src="imageUrl" class="avatar">
                                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                        </el-upload>
                                    </div>
                                    <div class="box-top-bot">保存</div>
                                </div>
                            </div>
                        </div>
                        <div class="box">
                            <div class="box-top">置顶</div>
                            <div class="box-bot">
                                <div class="box-bot-left">
                                    <img :src="imageUrl" alt="">
                                </div>
                                <div class="box-bot-right">
                                    <div class="box-top-top">
                                        <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/" 
                                        :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"> 
                                            <img v-if="false" :src="imageUrl" class="avatar">
                                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                        </el-upload>
                                    </div>
                                    <div class="box-top-bot">保存</div>
                                </div>
                            </div>
                        </div>
                        <div class="box">
                            <div class="box-top">置顶</div>
                            <div class="box-bot">
                                <div class="box-bot-left">
                                    <img :src="imageUrl" alt="">
                                </div>
                                <div class="box-bot-right">
                                    <div class="box-top-top">
                                        <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/" 
                                        :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"> 
                                            <img v-if="false" :src="imageUrl" class="avatar">
                                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                        </el-upload>
                                    </div>
                                    <div class="box-top-bot">保存</div>
                                </div>
                            </div>
                        </div>
                        <div class="box">
                            <div class="box-top">置顶</div>
                            <div class="box-bot">
                                <div class="box-bot-left">
                                    <img :src="imageUrl" alt="">
                                </div>
                                <div class="box-bot-right">
                                    <div class="box-top-top">
                                        <el-upload class="avatar-uploader" action="https://jsonplaceholder.typicode.com/posts/" 
                                        :show-file-list="false" :on-success="handleAvatarSuccess" :before-upload="beforeAvatarUpload"> 
                                            <img v-if="false" :src="imageUrl" class="avatar">
                                            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                        </el-upload>
                                    </div>
                                    <div class="box-top-bot">保存</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </template>
    
    <script>
    import BreadCrumb from "../public/BreadCrumb";
    import Category from "../public/Category";
    export default {
        name: 'PageUploadService',
        components: {BreadCrumb,Category},
        data: function() {	
            return {
                breadData: [{
                    id: 1,
                    name: '上传菜单',
                    urls: '/index',
                    icon: 'icon-home'
                },{
                    id: 2,
                    name: '上传服务',
                    urls: '/index/PageUploadService',
                    icon: 'icon-home'
                }],
                categoryData:[{
                    id:1,
                    name:'置顶',
                },{
                    id:2,
                    name:'对话',
                },{
                    id:3,
                    name:'上传',
                },{
                    id:4,
                    name:'提醒',
                }],
                imageUrl: '',
            }
        },
        methods: {
            handleAvatarSuccess(res, file) {
                this.imageUrl = URL.createObjectURL(file.raw);
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isLt2M = file.size / 1024 / 1024 < 2;
                if (!isJPG) {
                    this.$message.error('上传头像图片只能是 JPG 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 2MB!');
                }
                return isJPG && isLt2M;
            }
        }
    }
    </script>
    
<style scoped>
    .bread{
        margin: 10px;
    }
    .content{
        background: white;
        margin-left: 10px;
        margin-right: 10px;
        height: calc(100vh - 87px);
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
    .content_contain{
        padding: 30px 55px;
        box-sizing: border-box;
    }
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .box{
        width: 370px;
        /* border: 1px solid #15bafe; */
        float: left;
        margin-right: 75px;margin-top: 65px;
    }
    .box-top{
        width: 118px;height: 30px;
        border: 1px solid #15bafe;
        border-radius: 4px;
        line-height: 30px;text-align: center;
        color: #15bafe;font-size: 14px;
    }
    .box-bot{display: flex;margin-top: 15px;}
    .box-bot-left{
        width: 190px;height: 190px;
        border: 1px solid #bfbfbf;
        margin-right: 30px;
        border-radius: 4px;
    }
    .box-bot-left>img{
        width: 100%;height: 100%;
        border-radius: 4px;
    }
    .box-top-bot{
        width: 143px;height: 30px;
        border: 1px solid #15bafe;
        font-size: 14px;color: #fff;
        background: #15bafe;
        line-height: 30px;text-align: center;
        margin-top: 11px;
        border-radius: 4px;
    }
    .box-top-top{
        border: 1px solid #bfbfbf;
        border-radius: 4px;
        background: #f8f8f8;;
    }
    /* 图片上传 */
    .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 145px;
    height: 145px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 145px;
    height: 145px;
    display: block;
  }
  /* 。。。。。 */
</style>