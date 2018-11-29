<template>
    <el-upload
            class="id_card_box"
            action="http://test.kslab.com/api/article/null"
            :show-file-list="false"
            drag
            :on-remove="handleRemove"
            :before-upload="beforeAvatarUpload"
            :on-change="handleChange"
            :on-success="handleSuccess"
            :on-error="handleError"
            :on-exceed="handleExceed">
        <img v-if="imageUrl" :src="imageUrl" class="id_card_preview">
        <div class="uploading_tips" @dragover.prevent="onDragover" @dragleave="dragLeave">
            <i class="el-icon-circle-plus" v-show="!dragOver"></i>
            <p class="id_card_describe" v-show="!dragOver">上传身份证反面</p>
            <p class="id_card_suggest" v-show="!dragOver">JPG/PNG,5M以内</p>
            <div class="el-upload__txt" v-show="dragOver && !dragDone">松开图片以上传</div>
        </div>
    </el-upload>
</template>

<script>
    export default {
        name: "uploadIdCard",
        props:['serial_number','infoData','type'],
        data(){
            return {
                imageUrl:'',
                dragOver:false,
                dragDone:false,
            }
        },
        // computed:{
        //     console.log()
        // },
        mounted(){
            console.log(this.serial_number)
            console.log(this.infoData)
        },
        methods:{
            /***************上传身份证********************/
            handleRemove(file, fileList) {
                console.log(file, fileList);
                if(fileList.length<=0){
                    this.dragOver=false;
                }
            },
            handleSuccess(res,file){
                this.$message.success('上传成功!');
                this.imageUrl = URL.createObjectURL(file.raw);
            },
            handleError(){
                this.$message.error('上传失败!')
            },
            handleExceed(){
                this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isPNG = file.type === 'image/png';
                const isLt2M = file.size / 1024 / 1024 < 5;

                if (!isJPG && !isPNG) {
                    this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
                    return false
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 5MB!');
                    return false
                }  
                // return isJPG || isPNG && isLt2M;
                var FromData = new FormData()
                //活动上传图片接口
                FromData.append('token', window.localStorage.token)
                FromData.append('id_photo', file)
                FromData.append('type',this.type)  //1正面，2反面
                FromData.append('serial_number', this.serial_number)
                console.log(FromData)
                this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'usersProfile/uploadIdCard', FromData)
                .then((res) => {
                    console.log(res)
                    if (res.data.code === 200) { 
                        this.$message.success(res.data.msg)
                        //console.log(this.fileList)
                    } else {
                        this.$message.error(res.data.msg);
                    }
                })
            },
            handleChange(file,fileList){
                if(fileList.length>0){
                    this.dragOver=true;
                    this.dragDone=true;
                }else{
                    this.dragOver=false;
                    this.dragDone=false;
                }
            },
            onDragover(){
                this.dragOver=true;
            },
            dragLeave(){
                this.dragOver=false;
            }
        }
    }
</script>

<style scoped>

</style>