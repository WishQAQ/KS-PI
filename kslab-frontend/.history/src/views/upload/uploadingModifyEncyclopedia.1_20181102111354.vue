<template>
    <div class="main_box uploading_background">
        第二版
        <section>
            <div class="mod_uploading mod_uploading_encyclopedia">
                <nav class="uploading_encyclopedia_nav">
                    <el-tabs type="border-card" v-model="activeName">
                        <el-tab-pane label="基本信息" name="1">
                            <div class="uploading_encyclopedia_step uploading_encyclopedia_step_1">STEP.1 修改百科基本信息</div>
                            <div class="uploading_encyclopedia_info">
                                <div class="encyclopedia_info_cover">
                                    <el-upload
                                            class="encyclopedia_cover_box"
                                            action="http://test.kslab.com/api/article/null"
                                            list-type="picture-card"
                                            drag
                                            :limit="1"
                                            :multiple="true"
                                            :file-list="fileList3"
                                            :on-preview="handlePictureCardPreview"
                                            :on-remove="handleRemove"
                                            :before-upload="beforeAvatarUpload"
                                            :on-change="handleChange"
                                            :on-success="handleSuccess"
                                            :on-error="handleError"
                                            :on-exceed="handleExceed">
                                        <div class="uploading_tips" @dragover.prevent="onDragover" @dragleave="dragLeave">
                                            <i class="el-icon-plus" v-show="!dragOver"></i>
                                            <p class="encyclopedia_cover_describe" v-show="!dragOver">添加封面图</p>
                                            <p class="encyclopedia_cover_suggest" v-show="!dragOver">推荐640×640像素,JPG/PNG,1M以内</p>
                                            <div class="el-upload__txt" v-show="dragOver && !dragDone">松开图片以上传</div>
                                        </div>
                                    </el-upload>
                                    <el-dialog :visible.sync="dialogVisible">
                                        <img width="100%" :src="dialogImageUrl" alt="">
                                    </el-dialog>
                                </div>
                                <div class="encyclopedia_info_details mod_uploading_main">
                                    <!-- 添加标题组件 -->
                                    <!-- <uploading-main-title :mainTxt="title" :encData="encData" @ArticletitleName="EncyclopediaTitle"></uploading-main-title> -->
                                    <!-- ****** -->
                                    <div class="uploading_main_item uploading_main_title">
                                        <div class="main_head">
                                            <i class="icon icon_title"></i>
                                            <span class="main_txt">标题</span>
                                        </div>
                                        <input type="text" class="main_title_input" placeholder="标题限定25字以内" v-model="articleTitleName" maxlength="25" >
                                        <div class="mod_uploading_date">
                                        </div>
                                    </div>
                                    <!-- ******* -->
                                    <div class="uploading_main_item uploading_main_kw">
                                        <div class="main_head">
                                            <i class="icon icon_file"></i>
                                            <span class="main_txt">关键词</span>
                                        </div>
                                        <div class="main_tag_add">
                                            <div class="main_tag_add_box" :class="{active: dynamicTags.length>0}">
                                                <el-input
                                                        class="input-new-tag"
                                                        v-model="inputValue"
                                                        ref="saveTagInput"
                                                        size="small"
                                                        @keyup.enter.native="handleInputConfirm"
                                                >
                                                </el-input>
                                                <div class="floatRight">
                                                    <i class="el-icon-circle-plus" :class="{active:dynamicTags.length>0}" @click="handleInputConfirm"></i>
                                                    <el-tag
                                                            :key="tag"
                                                            v-for="tag in dynamicTags"
                                                            closable
                                                            size="small"
                                                            style="margin-right:5px;"
                                                            :disable-transitions="false"
                                                            @close="handleClose(tag)">
                                                        {{tag}}
                                                    </el-tag>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <uploading-main-content @Quescthon="EncyclopediaQuertp" :neirData="contentData" ></uploading-main-content>
                                    <uploading-main-type-detail @ActiveTypeValue="EncyclopediaTypeValue"></uploading-main-type-detail>
                                </div>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="创建目录" name="2">
                            <div class="uploading_encyclopedia_step uploading_encyclopedia_step_2">STEP.2 创建目录</div>
                            <div class="uploading_create_catalogue">
                                <div class="catalogue_list">
                                    <ul class="first_level">
                                        <li class="list_item" v-for="(handline,index) in firstLevel" :key="index">
                                            <span class="first_level_txt" :class="{active:activeIndex===index}" @click.stop="firstClick(index,$event)">{{handline.name}}</span>
                                            <i class="el-icon-delete" @click="removeFirst(index)"></i>
                                            <ul class="second_level">
                                                <li class="second_level_txt" :class="{active:activeIndex2===(index+'-'+index2)}" v-for="(tmp,index2) in handline.next" :key="index2" @click="secondClick(index,index2,$event)">
                                                    {{tmp.name}}
                                                    <i class="el-icon-delete" @click="removeSecond(index,index2)"></i>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                                <div class="catalogue_compile">
                                    <div class="first_level_input">
                                        <div class="main_head">
                                            <i class="icon icon_catalogue"></i>
                                            <span class="main_txt">一级目录</span>
                                            <span class="main_txt_describe">(不可修改)</span>
                                        </div>
                                        <input type="text" placeholder="标题限定15字以内" v-model="firstValue" @keyup.13="addFirst">
                                        <i class="el-icon-circle-plus" @click="addFirst"></i>
                                    </div>
                                    <div class="second_level_input">
                                        <div class="main_head">
                                            <i class="icon icon_catalogue2"></i>
                                            <span class="main_txt">二级目录</span>
                                            <span class="main_txt_describe">(可选)</span>
                                        </div>
                                        <input type="text" placeholder="标题限定15字以内" v-model="secondValue" @keyup.13="addSecond">
                                        <i class="el-icon-circle-plus" @click="addSecond"></i>
                                    </div>
                                </div>
                            </div>
                        </el-tab-pane>
                        <el-tab-pane label="编辑百科" name="3">
                            <div class="uploading_encyclopedia_step uploading_encyclopedia_step_3">STEP.3 编辑百科</div>
                            <div class="uploading_compile_encyclopedia">
                                <div class="catalogue_list">
                                    <ul class="first_level">
                                        <li class="list_item" v-for="(handline,index) in firstLevel" :key="index">
                                            <span class="first_level_txt" :class="{active:activeIndex===index}" @click.stop="firstClick(index,$event)">{{handline.name}}</span>
                                            <ul class="second_level">
                                                <li class="second_level_txt" :class="{active:activeIndex2===(index+'-'+index2)}" v-for="(tmp,index2) in handline.next" :key="index2" @click="secondClick(index,index2,$event)">
                                                    {{tmp.name}}
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                                <div class="compile_encyclopedia_detail">
                                    <div class="compile_encyclopedia_content" v-if="firstLevel.length>0">
                                        <div class="main_head">
                                            <i class="icon_rectangle"></i>
                                            <span class="main_txt">{{currentValue}}</span>
                                        </div>
                                        <quill-editor
                                                class="encyclopedia_editor"
                                                v-model="content"
                                                ref="myQuillEditor"
                                                :options="editorOption"
                                                @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
                                                @change="onEditorChange($event)">
                                        </quill-editor>
                                    </div>
                                    <!-- <uploading-main-file @uploadingEncy='uploadingEncyClick'></uploading-main-file> -->
                                    <uploadingEncycMainFile id="uploading_main_file" :attachments="this.dataAtomUirl.attachment" v-on:getFile="getFile" :bkID="this.bkID"></uploadingEncycMainFile>
                                    <div class="uploading_main_item uploading_main_part">
                                        <div class="main_head">
                                            <i class="icon icon_part" style="width:22px;height:20px;margin-right:11px;"></i>
                                            <span class="main_txt">参考文献</span>
                                        </div>
                                        <div class="main_part_detail">
                                            <el-input
                                                    placeholder="添加文献名字"
                                                    v-model="partValue"
                                                    clearable
                                                    @keyup.enter.native="addPart">
                                            </el-input>
                                            <i class="el-icon-circle-plus" @click="addPart"></i>
                                            <ul class="figure_list">
                                                <li class="list_item" v-for="(part,index) in partList" :key="index">
                                                    <i class="el-icon-delete" @click="removePart(index)"></i>
                                                    <div class="part_info" :class="{active}">
                                                        <span class="part_info_name">{{part.name}}</span>
                                                        <el-input
                                                                placeholder="输入连接(选填)"
                                                                clearable
                                                                style="width:initial"
                                                                @focus="onFocus"
                                                                @blur="onBlur"
                                                                @input="getPartLink($event,index)"
                                                        ></el-input>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </el-tab-pane>
                    </el-tabs>
                </nav>
                <div class="mod_uploading_confirm" v-if="activeName<3">
                    <a href="javascript:;" class="uploading_confirm_cancel" @click="goBack">取消</a>
                    <a href="javascript:;" class="uploading_confirm_release active" @click="tabNext">下一步</a>
                </div>
                <div class="uploading_submit" v-if="activeName==='3'">
                    <a href="javascript:;" class="submit_btn" :class="{active:activeName<3}" @click="submit">
                        <i class="icon icon_release"></i>
                        发布百科
                    </a>
                </div>
            </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
        <!--<protocol-div ref="protocol"></protocol-div>-->
    </div>
</template>

<script>

    import FloatingDiv from '@/components/floating'
    import ProtocolDiv from '@/views/upload/protocol'
    import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
    import UploadingMainContent from '@/views/upload/uploadingMainContent'
    import UploadingMainTypeDetail from '@/views/upload/uploadingMainTypeDetail'
    // import UploadingMainFile from '@/views/upload/uploadingMainFile'
    import uploadingEncycMainFile from '@/views/upload/uploadingEncycMainFile'


    var toolbarOptions = [
        ['bold','italic','underline','strike'],
        ['blockquote','code-block'],
        [{'header':1},{'header':2}],
        [{'list':'ordered'},{'list':'bullet'}],
        [{'script':'sub'},{'script':'super'}],
        [{'indent':'-1'},{'indent':'+1'}],
        [{'direction':'rtl'}],
        [{'size':['small',false,'large','huge']}],
        [{'header':[1,2,3,4,5,6,false]}],
        [{'color':[]},{'background':[]}],
        [{'font':[]}],
        [{'align':[]}],
        ['clear']
    ];

    export default {
        name: "uploadingModifyEncyclopedia",
        data(){
            return {
                bkID:null,//百科ID
                fileData:null,
                timeData:null,
                cat_id:null,//提交时 百科ID
                Id:null,//提交时需要的参数
                articleTitleName:'',//修改文章标题
                infoData:{}, //百科详情
                contentData:'',  //富文本内容
                encData:{},//个人中心修改百科传过来的数据
                dialogImageUrl:'',
                dialogVisible:false,
                title:'标题',
                dynamicTags: [],  //装关键字的容器
                inputValue:'',
                activeName:'1',
                dragOver:false,
                dragDone:false,
                firstValue:'',
                firstLevel:[],
                secondValue:'',
                secondIndex:0,
                currentValue:'',
                activeIndex:0,
                activeIndex2:"0-0",

                content:null,
                editorOption:{
                    modules:{
                        toolbar:toolbarOptions
                    }
                },
                partValue:'',
                partList:[],//零件数组
                active:false,
                titleDate:null,    //标题数据
                richFont:null,      //富文本数据
                categoryDate:null,       //类别数据
                cdnImg:null,         //第一面上传图片返回path
                encyclopedia_id:null,   //一级上传成功返回encyclopedia_id百科ID
                EncyFile:[], //附件数组
                fileList3: [],
                dataAtomUirl:{
                  token:window.localStorage.token,
                  category_id:null,
                  title:null,
                  description:null,
                  video_url:Number(new Date())+1,
                  cover:Number(new Date())+2,
                  video_length:null,
                  label:null,
                  is_course:null,
                  source:null,
                  attachment:Number(new Date())+3,
                  http:this.request.axiosPort+this.request.axiosApi+'videos/upload'
                }, //数据打包
            }
        },
        components:{
            FloatingDiv,
            ProtocolDiv,
            UploadingMainTitle,
            UploadingMainContent,
            UploadingMainTypeDetail,
            // UploadingMainFile,
            uploadingEncycMainFile,
        },
        mounted(){
            this.getData();
            // this.$refs.protocol.handleTimer()
            // this.$refs.protocol.handleTimer();
        },
        methods:{
            handleRemove(file, fileList) {
                console.log(file, fileList);
                if(fileList.length<=0){
                    this.dragOver=false;
                }
            },
            uploadingEncyClick(msg){

              this.EncyFile.push(msg)
              console.log(this.EncyFile)
            },
            handleSuccess(){
                this.$message.success('上传成功!')
            },
            handleError(){
                this.$message.error('上传失败!')
            },
            handleExceed(){
                this.$message.warning(`当前限制选择 1 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`)
            },
            handlePictureCardPreview(file) {
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            beforeAvatarUpload(file) {
                const isJPG = file.type === 'image/jpeg';
                const isPNG = file.type === 'image/png';
                const isLt2M = file.size / 1024 / 1024 < 1;

                if (!isJPG && !isPNG) {
                    this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
                }else{
                  var FontDate = new FormData()
                  FontDate.append('token',window.localStorage.token)
                  FontDate.append('image_path',file)
                  FontDate.append('serial_number',Number(new Date()))
                  this.timeData = Number(new Date());
                  var FileImg = file
                  this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'encyclopedias/uploadimage',FontDate)
                  .then((res) => {
                    console.log(res)
                    this.cdnImg = res.data.path
                    console.log(this.cdnImg)
                  })
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 5MB!');
                }
                return isJPG || isPNG && isLt2M;
            },
            /**************************************添加关键词********************************************/
            handleClose(tag) {
                this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
            },
            handleInputConfirm() {
                let inputValue = this.inputValue;
                if (inputValue) {
                    if(this.dynamicTags.length<3){
                        this.dynamicTags.push(inputValue);
                        // console.log(this.dynamicTags)
                    }else{
                        this.$message({
                            message: '最多添加三个关键词',
                            type: 'warning'
                        });
                    }
                }else{
                    this.$message({
                        message:'请添加关键词内容',
                        type:'warning'
                    })
                }
                this.inputValue = '';
            },
            goBack(){
               this.$router.go(-1)
            },
            tabNext(){
                // console.log(this.dialogImageUrl,this.richFont,this.dynamicTags,this.infoData.data.encyclopedia_id)
                // console.log(this.articleTitleName)
                // console.log(this.activeName)
                // if(this.activeName = '1'){
                //     this.activeName='2';
                //     this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/encyclopedias/edit',{
                //         token:window.localStorage.token,
                //         encyclopedia_id:this.infoData.data.encyclopedia_id,
                //         category_id:1,
                //         cover:this.timeData,
                //         content:this.richFont,
                //         label:this.dynamicTags,
                //     })
                //     .then((res) => {
                //         console.log(res)
                //         this.activeName         
                //     })
                //     //切换到目录tab
                //     var shuzu = [];
                //     for (var i in this.infoData.arr) {
                //         shuzu.push(this.infoData.arr[i]);
                //     }
                //     console.log(shuzu);
                //     this.firstLevel = shuzu;
                //     console.log(this.activeName+'/pppppppppppppppppp')
                // }else if(this.activeName === '2' ){
                //     this.activeName='3';
                //     console.log("切换到TABLE3")
                // }else{
                //     console.log("该提交了")
                // }



                    if(parseInt(this.activeName)<2){   
                        this.activeName=""+(parseInt(this.activeName)+1);
                            this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/encyclopedias/edit',{
                                token:window.localStorage.token,
                                encyclopedia_id:this.infoData.data.encyclopedia_id,
                                category_id:1,
                                cover:this.timeData,
                                content:this.richFont,
                                label:this.dynamicTags,
                            })
                            .then((res) => {
                                console.log(res)
                                this.activeName         
                            })
                            //切换到目录tab
                            var shuzu = [];
                            for (var i in this.infoData.arr) {
                                shuzu.push(this.infoData.arr[i]);
                            }
                            console.log(shuzu);
                            this.firstLevel = shuzu;
                        }else if(parseInt(this.activeName) < 3){
                              this.activeName=""+(parseInt(this.activeName)+1);
                            console.log("fuck") 
                            
                        }else if(parseInt(this.activeName) == 3){
                        }
                    
            },
            // 提交目录和附件
            submit(){
                console.log(this.firstLevel)
                var timestamp = Date.parse(new Date())+1;
                console.log(timestamp)
                  this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/addcatalog',{
                    token:window.localStorage.token,
                    encyclopedia_id:this.Id,
                    catelog:this.firstLevel,
                    source:this.partList,
                    attachment:this.bkID
                  })
                  .then((res) => {
                      console.log(res)
                    if(res.data.code != 200){ 
                      this.$message.error(res.data.msg)  
                    }else{
                      this.$message.success(res.data.msg)
                      this.$router.go(-1)
                    }
                  })
            },
            //删除一级目录
            removeFirst(index){
                this.firstLevel.splice(index,1);
                this.secondIndex=this.firstLevel.length-1;
                this.currentValue=this.firstLevel[index-1].name;
                console.log(this.secondIndex);
            },
            addFirst(){
              //添加一级目录
                const newFirst={name:this.firstValue,next:[],content:''};
                if(this.firstLevel.length < 3){
                  this.firstLevel.push(newFirst);
                  this.secondIndex=this.firstLevel.length-1;
                  this.currentValue=this.firstValue;
                  this.activeIndex=this.secondIndex;
                  this.activeIndex2=this.secondIndex+"-"+0;
                }else{
                  this.$message.warning('只能上传三条一级目录');
                }
            },
            firstClick(index,event){
              //选择一级目录
                this.secondIndex=index;
                this.activeIndex=index;
                this.activeIndex2=index+"-"+"null";
                this.currentValue=this.firstLevel[index].name;
                this.content = this.firstLevel[index].content
            },
            addSecond(){
              //添加二级目录
                if(this.firstLevel.length>0){
                    if(this.firstLevel[this.secondIndex].next.length < 3){
                      this.firstLevel[this.secondIndex].next.push({name:this.secondValue,content:''});
                      this.currentValue=this.firstLevel[this.secondIndex].name+" · "+this.secondValue;
                      this.activeIndex2=this.secondIndex+"-"+(this.firstLevel[this.secondIndex].next.length-1);
                    }else{
                      this.$message.warning('只能添加三条二级目录')
                    }
                }else{
                    this.$message.warning('请先添加一级目录！')
                }
            },
            removeSecond(index,index2){
                //删除二级
                this.firstLevel[index].next.splice(index2,1);
                console.log(this.firstLevel[index].next.length);
                if(this.firstLevel[index].next.length>0){
                    this.currentValue=this.firstLevel[index].name+" · "+this.firstLevel[index].next[index2-1]
                }else{
                    this.currentValue=this.firstLevel[index].name
                }
            },
            secondClick(index,index2,event){
              //选择二级
                this.activeIndex=index;
                this.activeIndex2=index+"-"+index2;
                this.currentValue=this.firstLevel[index].name+" · "+this.firstLevel[index].next[index2].name;
                this.content = this.firstLevel[index].next[index2].content
            },
            /***********************************文档编辑器**********************************/
            onEditorBlur(){//失去焦点事件
            },
            onEditorFocus(){//获得焦点事件
            },
            onEditorChange(){//内容改变事件
              let IndexList = this.activeIndex2.split('-')
              if(IndexList[1] != "null"){
                this.firstLevel[IndexList[0]].next[IndexList[1]].content = this.content
                console.log(this.firstLevel)
              }else{
                console.log("1")
                this.firstLevel[IndexList[0]].content = this.content
              }
            },
            /**********************************参考文献************************************/
            //添加参考文献
            addPart(){
                if(this.partValue){
                    // this.partName=this.partValue;
                    this.partList.push({name:this.partValue,link:''});
                    console.log(this.partValue)
                    // this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'encyclopedias/uploadattachment',{
                    //     token:window.localStorage.token,
                    //     attachment:
                    // })
                    // .then((res) => {
                    //     console.log(res)
                    // })
                }else{
                    this.$message({
                        message: '请输入零件/软件名称',
                        type: 'warning'
                    });
                }
            },
            removePart(index){
                this.partList.splice(index,1);
            },
            onFocus(){
                this.active=true;
            },
            onBlur(){
                this.active=false;
            },
            getPartLink(e,i){//获取零件链接
                this.partList[i].link=e;
                console.log(this.partList)
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
            },
            //接口事件开始
            EncyclopediaTitle(msg){
              //创建第一面提交数据包并进行双向数据绑定
              this.titleDate = msg
              console.log(this.titleDate)
            },
            EncyclopediaQuertp(msg){
              //富文本数据
              this.richFont = msg
              console.log(this.richFont)
            },
            EncyclopediaTypeValue(msg){
              this.categoryDate = msg
              console.log(this.categoryDate)
            },
            getData(){               

                    // 取到路由带过来的参数 
                    let routerQuery = this.$route.query.info
                    console.log(routerQuery)
                    // 将数据放在当前组件的数据内
                    this.encData = routerQuery;
                    this.dialogImageUrl = this.request.picUrl+routerQuery.cover;  //图片地址
                    this.articleTitleName = routerQuery.title  //标题
                    console.log(this.dialogImageUrl)
                    this.fileList3 = [{name:'111',url:this.dialogImageUrl}]
                    this.dynamicTags = routerQuery.label_name;                    //关键词
                    //获取百科ID
                    var id = routerQuery.encyclopedia_id;
                    this.Id  = id
                    this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'my/encyclopedias/info',{
                        token:window.localStorage.token,
                        encyclopedia_id:id,
                    })
                    .then((res) => {
                        console.log(res)
                        this.infoData = res.data;
                        this.contentData = res.data.data.content;
                        this.cat_id = res.data.data.category_id;
                        this.EncyFile = res.data.data.attachment;
                        this.bkID = res.data.data.encyclopedia_id
                    }) 
            },
            //获取子组件向父组件传的附件
            getFile(file){
                console.log(file);
                this.fileData = file;
            }
        }
    }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
<style scoped src="../../assets/css/userUploadCenter.css"></style>
<style scoped>
    .main_box{
        background:#f2f2f2;
    }
    .mod_uploading{
        position:relative;
        padding-bottom:0;
        box-shadow:none;
        border:none;
    }
    .el-icon-caret-right{
        position:absolute;
        top:-12px;
        left:-10px;
        color:#f0f;
        font-size:62px;
    }
    .uploading_encyclopedia_nav{
        margin-bottom:17px;
    }
    .mod_uploading.mod_uploading_encyclopedia .mod_uploading_confirm{
        position:absolute!important;
        bottom:50px;
        right:37px;
        width:100%;
    }
    /* ******* */
    .userUpload .el-tabs__header{
    margin-bottom: 0 !important;
  }
  .userUpload .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background-color: #fff;
    color: #222 !important;
    font-size: 14px;
  }
  .userUpload .el-tabs--card>.el-tabs__header .el-tabs__item{
    font-size: 14px;
    color: #9f9f9f;
  }
</style>
