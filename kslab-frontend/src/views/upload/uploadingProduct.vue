<template>
    <div class="uploading_background">
        <section>
            <uploading-head></uploading-head>
            <div class="mod_uploading mod_uploading_product">
                <div class="mod_uploading_main">
                    <div class="mod_uploading_item">
                        <div class="uploading_item_img uploading_item_product_img" :class="{activeBorder:!isDrag}">
                            <el-upload
                                    action="http://test.kslab.com/api/products/null"
                                    name="img"
                                    list-type="picture-card"
                                    :file-list="imageFileList"
                                    class="main_product_img"
                                    :drag="isDrag"
                                    :limit="5"
                                    multiple
                                    :on-preview="handlePictureCardPreview"
                                    :on-remove="handleRemove"
                                    :on-change="handleChangeImg"
                                    :before-upload="beforeAvatarUpload"
                                    :on-success="handleSuccess"
                                    :on-error="handleError">
                                <i class="el-icon-plus" v-show="!isDrag"></i>
                                <div class="upload_tips" @dragover.prevent="onDragoverImg" @dragleave="dragLeaveImg" v-if="!ImgFlag">
                                    <i class="el-icon-circle-plus" v-show="!dragOverImg"></i>
                                    <span class="upload_tips_txt" v-show="!dragOverImg">(选填)</span>
                                    <div class="el-upload__text" v-show="!dragOverImg">添加封面图</div>
                                    <span class="upload_tips_suggest" v-show="!dragOverImg">推荐640×640像素,JPG/PNG,5M以内,最多上传5张</span>
                                    <span class="dragOver_txt" v-show="dragOverImg && !dragDoneImg">松开图片以上传</span>
                                </div>
                            </el-upload>
                            <div v-show="dialogVisible" class="product_img_preview">
                                <img width="100%" :src="dialogImageUrl" alt="">
                            </div>
                        </div>
                        <div class="uploading_item_video uploading_item_product_video" :class="{background:videoUrl}">
                            <el-upload
                                    v-if="!videoUrl"
                                    class="upload-demo"
                                    drag
                                    :show-file-list="false"
                                    action="http://test.kslab.com/api/products/null"
                                    :limit="1"
                                    :on-change="handleChange"
                                    :on-progress="uploadVideoProgress"
                                    :on-success="handleSuccess"
                                    :on-error="handleError"
                                    :before-upload="beforeUploadVideo">
                                <div class="upload_tips" @dragover.prevent="onDragover" @dragleave="dragLeave" v-if="!videoFlag">
                                    <i class="el-icon-upload" v-show="!dragOver"></i>
                                    <span class="upload_tips_txt" v-show="!dragOver">(选填)</span>
                                    <div class="el-upload__text" v-show="!dragOver">将视频拖到此处，或<em>点击上传</em></div>
                                    <span class="upload_tips_suggest" v-show="!dragOver">视频长度在30s以内，小于等于20MB</span>
                                    <span class="dragOver_txt" v-show="dragOver && !dragDone">松开视频以上传</span>
                                </div>
                                <el-progress v-if="videoFlag == true" type="circle" :percentage="videoUploadPercent" style="margin-top:78px;"></el-progress>
                            </el-upload>
                            <video :src="videoUrl" v-if="videoUrl" class="uploading_video_view" controls></video>
                            <i class="el-icon-delete uploading_video_delete" v-if="videoUrl" @click="deleteVideo"></i>
                        </div>
                    </div>
                    <div class="mod_uploading_describe">
                        <uploading-main-title :mainTxt="title" :titleVakue="marketData.title" @ArticletitleName="getTitle"></uploading-main-title>
                        <div class="uploading_main_item uploading_main_productNum">
                            <div class="main_head">
                                <i class="icon icon_number"></i>
                                <span class="main_txt">商品编号</span>
                            </div>
                            <input type="text" class="main_title_input" v-model="marketData.asin">
                        </div>
                        <div class="uploading_main_item uploading_main_repertory">
                            <div class="main_head">
                                <i class="icon icon_repertory"></i>
                                <span class="main_txt">库存数量</span>
                            </div>
                            <input type="text" class="main_title_input main_repertory_input" v-model="marketData.stock">
                        </div>
                        <div class="uploading_main_item uploading_main_uprice">
                            <div class="main_head">
                                <i class="icon icon_uprice"></i>
                                <span class="main_txt">商品单价</span>
                            </div>
                            <i class="icon icon_price"></i>
                            <input type="text" class="main_title_input main_uprice_input" v-model="marketData.price">
                        </div>
                        <uploading-main-tag :labeList="marketData.tags" @MainTagLength="getTags"></uploading-main-tag>
                        <!--<uploading-main-Point></uploading-main-Point>-->
                        <uploading-main-file :compile="attachment" :info="{serial_number:marketData.serial_number,source_id:source_id,type:type}"></uploading-main-file>
                        <main-item-Tips ref="question"></main-item-Tips>
                    </div>
                    <div class="uploading_main_item uploading_main_pDetail">
                        <div class="main_head">
                            <i class="icon icon_content"></i>
                            <span class="main_txt">商品详情页</span>
                            <span class="main_txt_describe">(最多5个，最大5MB)</span>
                        </div>
                        <div class="main_pDetail_editor">
                            <el-upload
                                    id="xx"
                                    style="display: none;"
                                    class="avatar-uploader up_content"
                                    action="http://test.kslab.com/api/article/null"
                                    name="img"
                                    :show-file-list="false"
                                    :before-upload="beforeContentUpload">
                            </el-upload>
                            <quill-editor
                                    v-model="content"
                                    ref="myQuillEditor"
                                    :options="editorOption"
                                    @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
                                    @change="onEditorChange($event,5000)">
                            </quill-editor>
                        </div>
                    </div>
                    <div class="uploading_main_item uploading_main_type" id="uploading_main_type">
                        <div class="main_head">
                            <i class="icon icon_type"></i>
                            <span class="main_txt">类别</span>
                        </div>
                        <div class="main_type_select">
                            <el-steps direction="vertical" :active="active">
                                <el-step></el-step>
                                <el-step></el-step>
                                <el-step></el-step>
                                <el-step></el-step>
                                <el-step></el-step>
                                <el-step></el-step>
                            </el-steps>
                            <div class="step_ctrl_box">
                                <div class="step_type">
                                    <div class="step_type_item" :class="{active:activeIndex===type.id}" v-for="(type ,index) in typeList" :key="index" @click="next('activeIndex',type.id,type.child)">
                                        <div class="step_type_img"><i class="icon" :class="type.image"></i></div>
                                        <p class="step_type_txt">{{type.name}}</p>
                                    </div>
                                </div>
                                <div class="step_first_catalog" v-show="active>=1">
                                    <div class="step_catalog">一级目录</div>
                                    <div class="step_catalog_list">
                                        <span class="step_catalog_item" :class="{active:firstCatalog===first.id}" v-for="(first,fi) in firstList" :key="fi" @click="next('firstCatalog',first.id,first.child)">
                                            {{first.name}}
                                            <i class="icon icon-gou" v-if="firstCatalog===first.id"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="step_second_catalog" v-show="active>=2">
                                    <div class="step_catalog">二级目录</div>
                                    <div class="step_catalog_list">
                                        <span class="step_catalog_item" :class="{active:secondCatalog===second.id}" v-for="(second,si) in secondList" :key="si" @click="next('secondCatalog',second.id,second.child)">
                                            {{second.name}}
                                            <i class="icon icon-gou" v-if="secondCatalog===second.id"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="step_third_catalog" v-show="active>=3">
                                    <div class="step_catalog">三级目录</div>
                                    <div class="step_catalog_list">
                                        <span class="step_catalog_item" :class="{active:thirdCatalog===third.id}" v-for="(third,ti) in thirdList" :key="ti" @click="next('thirdCatalog',third.id,third.child)">
                                            {{third.name}}
                                            <i class="icon icon-gou" v-if="thirdCatalog===third.id"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="step_fourth_catalog" v-show="active>=4">
                                    <div class="step_catalog">产品类型</div>
                                    <div class="step_catalog_list">
                                        <span class="step_catalog_item" :class="{active:fourthCatalog===fourth.id}" v-for="(fourth,foi) in fourthList" :key="foi" @click="next('fourthCatalog',fourth.id,fourth.properties)">
                                            <el-tooltip placement="top" popper-class="step_catalog_tooltip" effect="light">
                                                <div slot="content"><img src="http://cdn.kushualab.com/images/article/20181106/15414701180829.png" alt="" style="width:170px;height:128px;"></div>
                                                <p>{{fourth.name}}</p>
                                            </el-tooltip>
                                            <i class="icon icon-gou" v-if="fourthCatalog===fourth.id"></i>
                                        </span>
                                    </div>
                                </div>
                                <div class="step_property" v-show="active>=5">
                                    <div class="step_property_head">商品属性</div>
                                    <div class="step_property_list" @click="next('','','')">
                                        <div class="step_property_item" v-for="(property,index) in propertyList" :key="index">
                                            <!--单选属性-->
                                            <div class="step_property_type" v-if="property.rule===1">
                                                <div class="step_property_title">
                                                    <span class="step_property_dot"></span>
                                                    <span class="step_property_txt">{{property.property_name}}</span>
                                                </div>
                                                <div class="step_property_child">
                                                    <span class="step_child_item" :class="{active:property.radioIndex===p.pc_id}" v-for="(p,i) in property.property_comparison" :key="i" @click="selectStep(property.rule,property.property_id,p,index)">{{p.value}}</span>
                                                </div>
                                            </div>
                                            <!--多选属性-->
                                            <div class="step_property_type" v-else-if="property.rule===2">
                                                <div class="step_property_title">
                                                    <span class="step_property_dot"></span>
                                                    <span class="step_property_txt">{{property.property_name}}</span>
                                                </div>
                                                <div class="step_property_child">
                                                    <span class="step_child_item" :class="{active:property.checkboxIndex.indexOf(p.pc_id)!==-1}" v-for="(p,i) in property.property_comparison" :key="i" @click="selectStep(property.rule,property.property_id,p,index)">{{p.value}}</span>
                                                </div>
                                            </div>
                                            <!--填写属性-->
                                            <div class="step_property_type" v-else>
                                                <div class="step_property_import">
                                                    <span class="step_property_dot"></span>
                                                    <span class="step_property_txt">{{property.property_name}}</span>
                                                </div>
                                                <!--填写一个值-->
                                                <div class="step_property_input_box" v-if="property.quantity===1">
                                                    <input placeholder="请输入内容" class="step_property_input" @input="getOthersValue($event,property.id)">
                                                    <span class="step_property_line">
                                                        <span class="step_property_line_inner"></span>
                                                    </span>
                                                </div>
                                                <!--填写两个值-->
                                                <div class="step_property_input_box step_property_input_two" v-else-if="property.quantity===2">
                                                    <input placeholder="请输入内容" class="step_property_input" @input="getOthersValue($event,property.id)">
                                                    <span class="step_property_line">
                                                        <span class="step_property_line_inner"></span>
                                                    </span>
                                                    <span class="step_property_connector">~</span>
                                                    <input placeholder="请输入内容" class="step_property_input" @input="getOthersValue($event,property.id)">
                                                    <span class="step_property_line">
                                                        <span class="step_property_line_inner"></span>
                                                    </span>
                                                </div>
                                                <!--填写三个及以上值-->
                                                <div class="step_property_input_box step_property_input_other" v-else>
                                                    <div class="step_input_others" v-for="tmp in property.quantity" :key="tmp">
                                                        <input placeholder="请输入内容" class="step_property_input" @input="getOthersValue($event,property.id)">
                                                        <span class="step_property_line">
                                                            <span class="step_property_line_inner"></span>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--<mod-uploading-Confirm></mod-uploading-Confirm>-->
                <div class="mod_uploading_confirm">
                    <a href="javascript:;" class="uploading_confirm_cancel" :class="{active:!isActive}" @mouseenter="activeBtn($event)">取消</a>
                    <a href="javascript:;" class="uploading_confirm_release" :class="{active:isActive}" @mouseenter="activeBtn($event)" @click="submitData">
                        <i class="icon icon_release"></i>
                        发布
                    </a>
                </div>
            </div>
        </section>
        <!--<protocol-div ref="protocol"></protocol-div>-->
    </div>
</template>

<script>

    import Vue from 'vue'

    import FloatingDiv from '@/components/floating'
    import ProtocolDiv from '@/views/upload/protocol'
    import UploadingMainTitle from '@/views/upload/uploadingMainTitle'
    import UploadingMainTag from '@/views/upload/uploadingMainTag'
    import MainItemTips from '@/views/upload/mainItemTips'
    import ModUploadingConfirm from '@/views/upload/modUploadingConfirm'
    import UploadingMainFile from '@/views/upload/uploadingMainFile'
    import ElCascaderMenu from 'element-ui/packages/cascader/src/menu'
    import QEditor from 'vue-quill-editor'

    var UploadingHead = {
        template:"<div class='mod_uploading_head'><div class='uploading_head_txt'>上传商品</div></div>",
        data(){
            return {}
        },
    };

    var UploadingMainPoint = {
        template:`<div class="uploading_main_item uploading_main_tag">
                    <div class="main_head">
                      <i class="icon icon_point"></i>
                      <span class="main_txt">技术要点</span>
                    </div>
                    <div class="main_tag_add_box">
                        <el-input
                            class="input-new-tag"
                            v-model="mainPointValue"
                            ref="saveTagInput"
                            size="small"
                            @keyup.enter.native="mainPointConfirm"
                        >
                        </el-input>
                        <div class="main_tag_list">
                            <i class="el-icon-circle-plus" :class="{active:dynamicTags.length>0}" @click="mainPointConfirm"></i>
                            <el-tag
                                :key="tag"
                                v-for="tag in dynamicTags"
                                closable
                                size="small"
                                style="margin-right:5px;"
                                :disable-transitions="false"
                                @close="mainPointClose(tag)">
                                {{tag}}
                            </el-tag>
                        </div>
                    </div>
                  </div>`,
        data(){
            return {
                dynamicTags:["气门推杆","推杆"],
                mainPointValue:''
            }
        },
        methods:{
            mainPointClose(tag) {
                this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
            },
            mainPointConfirm() {
                let inputValue = this.mainPointValue;
                if (inputValue) {
                    if(this.dynamicTags.length<3){
                        this.dynamicTags.push(inputValue);
                    }else{
                        this.$message({
                            message: '最多添加三个标签',
                            type: 'warning'
                        });
                    }
                }else{
                    this.$message({
                        message:'请添加标签内容',
                        type:'warning'
                    })
                }
                this.mainPointValue = '';
            },
        }
    };

    // region
    import {quillEditor} from 'vue-quill-editor'
    import * as Quill from 'quill'  //引入编辑器
    import moment from 'moment'

    //quill图片可拖拽改变大小
    import ImageResize from 'quill-image-resize-module';

    Quill.register('modules/imageResize', ImageResize);

    //quill图片可拖拽上传
    import {ImageDrop} from 'quill-image-drop-module';

    Quill.register('modules/imageDrop', ImageDrop);

    // 自定义字体大小
    let fontSize = ['10px', '12px', '14px', '16px', '18px', '20px'];
    let Size = Quill.import('attributors/style/size');
    Size.whitelist = fontSize;
    Quill.register(Size, true);

    var fonts = ['SimSun', 'SimHei', 'Microsoft-YaHei', 'KaiTi', 'FangSong', 'Arial', 'Times-New-Roman', 'sans-serif'];
    var Font = Quill.import('formats/font');
    Font.whitelist = fonts; //将字体加入到白名单

    import {container, ImageExtend, QuillWatch} from 'quill-image-extend-module'
    // import * as Vue from "autoprefixer";

    Quill.register('modules/ImageExtend', ImageExtend)

    var toolbarOptions = [
        ['italic', 'underline', 'strike', 'bold'],
        ['blockquote', 'code-block'],
        [{'list': 'ordered'}, {'list': 'bullet'}],
        [{'script': 'sub'}, {'script': 'super'}],
        [{'indent': '-1'}, {'indent': '+1'}],
        [{'direction': 'rtl'}],
        [{'size': fontSize}],
        [{'color': []}],
        [{'align': []}],
        ['image']
    ];

    export default {
        name: "uploadingProduct",
        data(){
            return {
                img_id: "",
                video_id: "",
                file_id: "",
                title: "商品名称",//标题文字
                isActive: false,
                dialogImageUrl: '',//查看图片路径
                dialogVisible: false,//是否显示查看图片模块
                videoUrl:'',//视频预览
                videoFlag:false,
                dragOver:false,//视频拖拽中
                dragDone:false,//视频拖拽完成
                isDrag:true,//是否拖拽
                ImgFlag:false,
                dragOverImg:false,//封面拖拽中
                dragDoneImg:false,//封面拖拽完成
                videoUploadPercent:0,//上传进度
                content:null,//编辑器输入内容
                /**富文本编辑器**/
                editorOption: {
                    modules: {
                        toolbar: {
                            container: toolbarOptions,
                            handlers: {
                                'image': function (value) {
                                    console.log(value);
                                    if (value) {
                                        document.querySelector('#xx input').click()
                                    } else {
                                        this.quill.format('image', false);
                                    }
                                }
                            }
                        },
                        imageDrop: true,
                        imageResize: {
                            displayStyles: {
                                backgroundColor: 'black',
                                border: 'none',
                                color: 'white'
                            },
                            modules: ['Resize', 'DisplaySize', 'Toolbar']
                        },
                        ImageExtend: {
                            loading: true,
                            name: 'img',
                            size: 1,
                            action: '',
                            response: (res) => {
                                return res.info
                            },
                            headers: (xhr) => {
                                // xhr.setRequestHeader('myHeader','myValue')
                            },  //设置请求头部
                            sizeError: () => {
                                this.$message.error('图片大小超过限制1M')
                            },  // 图片超过大小的回调
                            start: () => {}, //this.ImgStart(),//() => {},  //自定义开始上传触发事件
                            end: () => {
                            },  //自定义上传结束触发的事件，无论成功或者失败
                            error: () => {
                            },  //上传失败触发的事件
                            success: () => {
                            },  //上传成功触发的事件
                            change: (xhr, formData) => {
                                // xhr.setRequestHeader('myHeader','myValue')
                                // formData.append('token', 'myToken')
                            } //每次选择图片触发，也可用来设置头部，但比headers多了一个参数，可设置formData
                        },
                    }
                },
                theme: 'snow',
                active:0,//步骤条
                typeList:[//大类目录列表
                    {id:'汽车',image:'icon-qiche',},
                    {id:'摩托车',image:'icon-motuoche'},
                    {id:'无人机',image:'icon-wurenji--'},
                    {id:'智能设备',image:'icon-zhinengshebei'}
                ],
                firstList:[],//一级目录列表
                secondList:[],//二级目录列表
                thirdList:[],//三级目录列表
                fourthList:[],//四级目录列表
                activeIndex:null,//大类选中下标
                firstCatalog:null,//一级目录选中下标,firstList[firstCatalog]为选中值
                secondCatalog:null,//二级目录选中下标,同上
                thirdCatalog:null,//三级目录选中下标,同上
                fourthCatalog:null,//四级目录选中下标,同上
                propertyList:[
                    {title:'品牌',type:1,list:['宝马阿斯顿马丁','奔驰','迈巴赫','阿斯顿马丁','保时捷','捷豹','布加迪','玛莎拉蒂']},//属性选项列表
                    {title:'形状',type:2,list:['圆形','方形','椭圆','三角形','梯形']},
                    {title:'长度',type:3,quantity:1},
                    {title:'电压',type:3,quantity:2},
                    {title:'电压',type:3,quantity:3}
                ],
                propertyValue:{//属性获得值
                    radio:[
                        // {id:'',val:[]}
                    ],//单选
                    checkbox:[],//多选
                    inputOthers:[]//填写三个及以上值
                },
                radioIndex:null,//单选属性选中下标
                checkboxIndex:[],//多选属性选中下标
                marketData:{
                    title:'',//商品名称
                    asin:'',//商品编号
                    stock:'',//库存
                    price:'',//单价
                    tags:[],//标签
                    description:'',//详情
                    category_id:'',//类别id
                    properties:[],//属性
                    serial_number:'',//批次号
                },//商品数据
                attachment:[],//附件列表
                imageFileList:[],//已上传封面图
                source_id:'',//商品id
                type:1,//是否编辑（1：首次上传，2：编辑修改）
                categoryId:[],//修改时类别数组
                productsMapping:[],//修改时属性数组
                typeListTime:1,//typeList监听次数
            }
        },
        components:{
            FloatingDiv,
            ProtocolDiv,
            UploadingHead,
            UploadingMainTitle,
            UploadingMainTag,
            UploadingMainPoint,
            MainItemTips,
            ElCascaderMenu,
            ModUploadingConfirm,
            UploadingMainFile,
            QEditor
        },
        methods:{
            /************************上传按钮*********************************/
            //按钮样式
            activeBtn(event){
                if(!$(event.currentTarget).is(".active")){
                    this.isActive = !this.isActive;
                }
            },
            //上传数据
            submitData(){
                this.marketData.properties=[];
                if(this.propertyValue.radio.length>0){
                    this.propertyValue.radio.forEach(item=>{
                        this.marketData.properties.push(item)
                    });
                }
                if(this.propertyValue.checkbox.length>0){
                    this.propertyValue.checkbox.forEach(item=>{
                        this.marketData.properties.push(item)
                    });
                }
                if(this.propertyValue.inputOthers.length>0){
                    this.propertyValue.inputOthers.forEach(item=>{
                        this.marketData.properties.push(item)
                    });
                }
                console.log(this.marketData);
                if(this.$route.query.id){
                    this.marketData.product_id=this.$route.query.id;
                    let arr=[];
                    this.marketData.properties.map(item=>{
                        if(item.id){
                            arr.push({property_id:item.id,val:item.val})
                        }else{
                            arr.push(item)
                        }
                    });
                    console.log(arr);
                    this.marketData.properties=arr;
                    console.log(this.marketData);
                    this.HttpClient.post('/user/companies/updateCommodity',this.marketData)
                        .then(res=>{
                            console.log(res);
                            let {code,msg} = res.data;
                            if(code===200){
                                this.$message.success(msg)
                                this.$router.push({
                                    path:'/home/store-index'
                                })
                            }else{
                                this.$message.error(msg)
                            }
                        })
                }else{
                    this.HttpClient.post('/products/create',this.marketData)
                        .then(res=>{
                            console.log(res);
                            if(res.data.code===200){
                                this.$message.success(res.data.msg);
                                this.$router.push({
                                    path:'/home/store-index'
                                })
                            }else{
                                this.$message.error('上传失败，请重试！')
                            }
                        })
                }
            },
            /***********************图片上传*********************************/
            handleRemove(file, fileList) { //删除图片回调函数
                console.log(file, fileList);
                console.log(this.imageFileList);
                // if(fileList.length<=0){
                //     this.ImgFlag=false;
                // }else{
                //     this.ImgFlag=true;
                // }
                this.HttpClient.post('/services/destroyFile',{url:file.url})
                    .then(res=>{
                        console.log(res);
                        let index=null;
                        this.imageFileList.map((item,i)=>{
                            if(item.url===file.url){
                                index=i
                            }
                        });
                        console.log(index);
                        if(res.data.code===200){
                            this.imageFileList.splice(index,1);
                            this.$message.success(res.data.msg);
                            if(fileList.length<=0){
                                this.isDrag=true;
                                this.dialogVisible=false;
                                this.ImgFlag=false;
                                this.dragOverImg=false;
                                this.dragDoneImg=false;
                            }else{
                                this.dialogImageUrl=fileList[fileList.length-1].url;
                            }
                        }else{
                            // this.imageFileList.push()
                            this.$message.error('删除失败!');
                            fileList.splice(index,0,file);
                            console.log(fileList);
                        }
                    });
            },
            handleSuccess(){    //上传成功回调函数
                this.$message.success('上传成功!')
            },
            handleError(err, file, fileList){ //上传失败回调函数
                // this.$message.error('上传失败!');
                console.log(file);
                console.log(fileList);
                if(fileList.length>0){
                    this.dialogImageUrl=fileList[fileList.length-1].url;
                    console.log(this.dialogImageUrl);
                }else{
                    this.dialogVisible=false;
                }
            },
            handleChangeImg(file,fileList){ //上传状态改变(开始上传和上传成功或失败)，共调用两次
                console.log(file);
                console.log(fileList);
                if(fileList.length>0){
                    this.dragOverImg=true;
                    this.dragDoneImg=true;
                    this.isDrag=false;
                    this.dialogVisible=true;
                    this.dialogImageUrl=fileList[fileList.length-1].url;
                }else{
                    this.isDrag=true;
                    this.dragOverImg=false;
                    this.dragDoneImg=false;
                    this.ImgFlag=false;
                    this.dialogVisible=false;
                }
            },
            handlePictureCardPreview(file) { //查看已上传图片大图
                this.dialogImageUrl = file.url;
            },
            beforeAvatarUpload(file) { //开始上传之前回调函数
                const isJPG = file.type === 'image/jpeg';
                const isPNG = file.type === 'image/png';
                const isLt2M = file.size / 1024 / 1024 < 5;

                if (!isJPG && !isPNG) {
                    this.$message.error('上传头像图片只能是 JPG/PNG 格式!');
                }
                if (!isLt2M) {
                    this.$message.error('上传头像图片大小不能超过 5MB!');
                }
                var FromData = new FormData();
                //商品上传图片接口
                FromData.append('token', window.localStorage.token);
                FromData.append('pics', file);
                FromData.append('serial_number', this.marketData.serial_number);
                FromData.append('type', this.type);
                if(this.type===2){
                    FromData.append('source_id', this.source_id);
                }
                this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'products/uploadPicture', FromData)
                    .then((res) => {
                        console.log(res);
                        if (res.data.code === 200) {
                            this.imageFileList.push({url:res.data.path});
                            this.$message.success(res.data.msg);
                            console.log(this.imageFileList)
                        } else {
                            this.$message.error(res.data.msg);
                            return false
                        }
                    });
                return isJPG || isPNG && isLt2M;
            },
            onDragoverImg(){ //图片拖拽进入时
                this.dragOverImg=true;
            },
            dragLeaveImg(){ //图片拖拽松开
                this.dragOverImg=false;
            },
            /***********************************视频上传***************************/
            beforeUploadVideo(file) { //视频开始上传前
                const isLt10M = file.size / 1024 / 1024  < 10;
                if (['video/mp4', 'video/ogg', 'video/flv','video/avi','video/wmv','video/rmvb'].indexOf(file.type) == -1) {
                    this.$message.error('请上传正确的视频格式');
                    return false;
                }
                if (!isLt10M) {
                    this.$message.error('上传视频大小不能超过10MB哦!');
                    return false;
                }
                var FromData = new FormData();
                //商品上传视频接口
                console.log(this.source_id);
                FromData.append('token', window.localStorage.token);
                FromData.append('video', file);
                FromData.append('serial_number', this.marketData.serial_number);
                FromData.append('type', this.type);
                if(this.type===2){
                    FromData.append('source_id', this.source_id);
                }
                this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'products/uploadVideo', FromData)
                    .then((res) => {
                        console.log(res);
                        if (res.data.code === 200) {
                            this.videoUrl=res.data.path
                        } else {
                            this.$message.error(res.data.msg);
                            return false
                        }
                    });
            },
            uploadVideoProgress(event, file, fileList){ //视频上传进度
                this.videoFlag = true;
                this.videoUploadPercent = parseInt(file.percentage.toFixed(0));
                console.log(this.videoUploadPercent);
            },
            handleChange(file,fileList){ //视频上传状态(调用时间同图片)
                if(fileList.length>0){
                    this.dragOver=true;
                    this.dragDone=true;
                }else{
                    this.dragOver=false;
                    this.dragDone=false;
                    this.videoFlag=false;
                }
            },
            //删除视频
            deleteVideo(){
                console.log(this.videoUrl);
                this.HttpClient.post('/services/destroyFile',{url:this.videoUrl})
                    .then(res=>{
                        console.log(res);
                        if(res.data.code===200){
                            this.$message.success(res.data.msg);
                            this.videoUrl=''
                        }else{
                            this.$message.error('删除失败，请重试！')
                        }
                    })
            },
            onDragover(){ //视频拖拽时
                this.dragOver=true;
            },
            dragLeave(){ //视频拖拽完成
                this.dragOver=false;
            },
            /************************************标题**************************************/
            getTitle(title){
                console.log(title);
                this.marketData.title=title;
            },
            /************************************附件上传**********************************/
            handleFileCardPreview(file) { //上传附件查看
                this.dialogImageUrl = file.url;
                this.dialogVisible = true;
            },
            beforeFileUpload(file){ //附件上传开始前
                const isLt5M = file.size / 1024 / 1024 < 5;
                if (!isLt5M) {
                    this.$message.error('上传文件大小不能超过5M!')
                    return false;
                }
            },
            /***********************************文档编辑器**********************************/
            // region
            beforeContentUpload(file) {
                var FromData = new FormData();
                //商品上传图片接口
                FromData.append('token', window.localStorage.token);
                FromData.append('pics', file);
                FromData.append('serial_number', this.marketData.serial_number);
                FromData.append('type', this.type);
                if(this.type===2){
                    FromData.append('source_id', this.source_id);
                }
                this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'products/uploadPicture', FromData)
                    .then((res) => {
                        console.log(res);
                        if (res.data.code === 200) {
                            let quill = this.$refs.myQuillEditor.quill;
                            let length = quill.getSelection().index;
                            quill.insertEmbed(length, 'image', res.data.path);
                            quill.setSelection(length + 1);
                            this.$message.success(res.data.msg)
                            //console.log(this.fileList)
                        } else {
                            this.$message.error(res.data.msg);
                            return false
                        }

                    })
            },
            onEditorBlur(){//失去焦点事件
            },
            onEditorFocus(){//获得焦点事件
            },
            onEditorChange(e, decimalNum){//内容改变事件
                console.log(this.content)
                var lengthcontent = this.content;
                function removeHTMLTag(str) {
                    var str;
                    str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
                    str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
                    str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
                    str = str.replace(/ /ig, '');//去掉
                    return str;
                }
                console.log(removeHTMLTag(lengthcontent).length)
                e.quill.deleteText(decimalNum, 1);//保留 strValue 的 前 decimalNum 位字符，
                this.$emit('Quescthon', this.content)
                if (removeHTMLTag(lengthcontent).length < 1001) {
                    this.marketData.description = this.content;
                    console.log(this.marketData)
                } else {
                    this.$message.error('字数超过限制');
                }
            },
            // 显示宽度修改框
            _showWidthBox(event) {
                // 获取当前图片对象
                let currentImg = event.target;
                // 弹出宽度输入框
                this.$prompt('请输入宽度', '提示', {
                    inputValue: currentImg.width,
                    confirmButtonText: '确定',
                    cancelButtonText: '取消'
                }).then(({value}) => {
                    // 赋值新宽度
                    currentImg.width = value
                }).catch(() => {
                })
            },
            // 监听图片点击
            _listenerImage() {
                // 获取DOM对象
                let editor = document.getElementsByClassName('ql-editor')[0]
                let img = editor.getElementsByTagName('img')
                // 非空验证
                if (img.length === 0) {
                    return
                }
                for (let i = 0; i < img.length; i++) {
                    let currentImg = img[i];
                    // 绑定且防止重复绑定
                    currentImg.removeEventListener('dblclick', this._showWidthBox, false);
                    currentImg.addEventListener('dblclick', this._showWidthBox, false)
                }
            },
            // endregion
            /****************************分类**********************/
            //显示下一类别
            next(step,i,child){
                if(step==='activeIndex') {//大类
                    this.activeIndex = i;
                    this.firstCatalog=null;
                    this.secondCatalog=null;
                    this.thirdCatalog=null;
                    this.fourthCatalog=null;
                    this.active=1;
                    this.firstList=child;
                    let height=$('.step_type').height();
                    $('.el-step.is-vertical').first().css('height',height/2+51);
                }else if(step==='firstCatalog'){//一级目录
                    this.firstCatalog=i;
                    this.secondCatalog=null;
                    this.thirdCatalog=null;
                    this.fourthCatalog=null;
                    this.active=2;
                    this.secondList=child;
                    let height=$('.step_first_catalog').height();
                    $('.el-step.is-vertical:eq(1)').css('height',height+41);
                }else if(step==='secondCatalog'){//二级目录
                    this.secondCatalog=i;
                    this.thirdCatalog=null;
                    this.fourthCatalog=null;
                    this.active=3;
                    this.thirdList=child;
                    let height=$('.step_second_catalog').height();
                    $('.el-step.is-vertical:eq(2)').css('height',height+41);
                }else if(step==='thirdCatalog'){//三级目录
                    this.thirdCatalog=i;
                    this.fourthCatalog=null;
                    this.active=4;
                    this.fourthList=child;
                    let height=$('.step_third_catalog').height();
                    $('.el-step.is-vertical:eq(3)').css('height',height+41);
                }else if(step==='fourthCatalog'){//四级目录
                    this.fourthCatalog=i;
                    this.active=5;
                    this.marketData.category_id=i;
                    // child[1].rule=2;
                    // child[0].rule=2;
                    child.forEach(item=>{
                        if(item.rule===1){
                            item.radioIndex=null
                        }else if(item.rule===2){
                            item.checkboxIndex=[]
                        }
                    });
                    this.propertyList=child;
                    let height=$('.step_fourth_catalog').height();
                    $('.el-step.is-vertical:eq(4)').css('height',height+41);
                }else{
                    console.log(this.active);
                    console.log(this.propertyValue);
                    if(this.propertyValue.radio.length>0 || this.propertyValue.checkbox.length>0 || this.propertyValue.inputOthers.length>0){
                        this.active=6;
                    }else{
                        this.active=5;
                    }
                }
            },
            getOthersValue(e,i){ //分类属性填写值(三个及以上)
                if(this.propertyValue.inputOthers.find(function (x) {
                    return x.id === i;
                }) !== undefined){
                    this.propertyValue.inputOthers.find(function(x){return x.id===i;}).val.push(e.target.value)
                }else{
                    this.propertyValue.inputOthers.push({id:i,val:[e.target.value]});
                }
            },
            //选择属性点击事件
            selectStep(t,i,p,index){
                if(t===1){//判断是否单选
                    if(this.propertyValue.radio.length>0){//判断单选数组是否有值
                        console.log(this.propertyValue.radio.find(function (x) {
                            return x.id === i;
                        }));
                        if(this.propertyValue.radio.find(function (x) {//判断当前操作属性是否存在
                            return x.id === i;
                        }) !== undefined){
                            if(this.propertyList[index].radioIndex!==p.pc_id){//判断当前点击属性值是否为已选
                                this.propertyValue.radio.find(function (x) {
                                    return x.id === i;
                                }).val=[p.pc_id];
                                this.propertyList[index].radioIndex=p.pc_id
                            }else{
                                this.propertyList[index].radioIndex=null;
                                this.propertyValue.radio.map((item,index)=>{
                                    if(item.id===i){
                                        this.propertyValue.radio.splice(index,1)
                                    }
                                })
                            }
                        }else{
                            this.propertyValue.radio.push({id:i,val:[p.pc_id]});
                            this.propertyList[index].radioIndex=p.pc_id
                        }
                    }else{
                        this.propertyValue.radio.push({id:i,val:[p.pc_id]});
                        this.propertyList[index].radioIndex=p.pc_id;
                    }
                }else{
                    let obj=this.propertyValue.checkbox.find(function (x) {
                        return x.id === i;
                    });
                    if( obj !== undefined){
                        if(this.propertyList[index].checkboxIndex.indexOf(p.pc_id)!==-1){
                            this.propertyList[index].checkboxIndex.splice(this.propertyList[index].checkboxIndex.indexOf(p.pc_id),1);
                            obj.val.splice(obj.val.indexOf(p.pc_id),1)
                        }else {
                            this.propertyList[index].checkboxIndex.push(p.pc_id);
                            obj.val.push(p.pc_id);
                        }
                    }else{
                        this.propertyList[index].checkboxIndex.push(p.pc_id);
                        this.propertyValue.checkbox.push({id:i,val:[p.pc_id]});
                    }
                }
                Vue.set(this.propertyList, index, this.propertyList[index]);//监听对象数组，更新绑定值
                console.log(this.propertyValue);
                console.log(this.marketData);
            },

            /*******标签*******/
            getTags(tags){
                this.marketData.tags=tags;
            }
        },
        async created(){
            let id=this.$route.query.id;
            console.log(id);
            this.source_id=id;//商品id
            if(id){
                this.type=2;//是否为首次上传
                await this.HttpClient.post('/user/companies/updateInfo',{product_id:id})
                    .then(res=>{
                        console.log(res);
                        let {code,data} = res.data;
                        if(code===200){
                            // this.source_id=data.product_id;//商品id
                            this.marketData.title=data.title;//标题
                            this.marketData.asin=data.asin;//商品编号
                            this.marketData.tags=data.tagsname;//标签
                            this.marketData.price=data.price;//单价
                            this.marketData.stock=data.stock;//库存
                            this.marketData.serial_number=data.serial_number;//批次号
                            this.marketData.description=data.description;//详情
                            this.marketData.category_id=data.category_id[4];//类别id
                            this.content=data.description;//富文本内容
                            this.categoryId=data.category_id;//已选类别数组
                            //初始化已选属性数组
                            data.products_mapping.map(item=>{
                               this.productsMapping.push({id:item.property_id,val:item.val})
                            });
                            //初始化已上传图片路径
                            data.show_picture.map(item=>{
                                this.imageFileList.push({url:this.request.picUrl+item})
                            });
                            //初始化视频路径
                            if(data.video){
                                this.videoUrl=this.request.picUrl+data.video;
                            }
                            //初始化附件路径
                            data.attachment.map(item=>{
                                this.attachment.push({url:this.request.picUrl+item})
                            })
                        }
                    })
            }else{
                //生成批次号
                this.marketData.serial_number=this.Tools.GetNumber();
            }
            //获取分类列表
            this.HttpClient.get('/category/getCategoriesProperties')
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.typeList=res.data.data;
                    }
                })
        },
        mounted(){
            this.$refs.question.fixedEnd("uploading_main_type");
            // $(".mod_uploading .main_item_tips").css("width","240px");
            // this.$refs.protocol.handleTimer();
        },
        updated(){
            if(this.$route.query.id){
                $('.el-step.is-vertical').first().css('height',$('.step_type').height()/2+51);
                $('.el-step.is-vertical:eq(1)').css('height',$('.step_first_catalog').height()+41);
                $('.el-step.is-vertical:eq(2)').css('height',$('.step_second_catalog').height()+41);
                $('.el-step.is-vertical:eq(3)').css('height',$('.step_third_catalog').height()+41);
                $('.el-step.is-vertical:eq(4)').css('height',$('.step_fourth_catalog').height()+41);
            }
        },
        watch:{
            imageFileList(){
                if(this.imageFileList.length>0){
                    this.dragOverImg=true;
                    this.dragDoneImg=true;
                    this.isDrag=false;
                    this.dialogVisible=true;
                    this.dialogImageUrl=this.imageFileList[this.imageFileList.length-1].url;
                }
            },
            typeList:{
                handler(){
                    if(this.typeListTime>1){
                        return
                    }
                    if(this.$route.query.id){
                        this.active=5;
                    }
                    this.typeList.map(item=>{
                        if(item.id===this.categoryId[0]){
                            this.activeIndex=item.id;
                            this.firstList=item.child;
                        }
                    });
                    this.firstList.map(item=>{
                        if(item.id===this.categoryId[1]){
                            this.firstCatalog=item.id;
                            this.secondList=item.child;
                        }
                    });
                    this.secondList.map(item=>{
                        if(item.id===this.categoryId[2]){
                            this.secondCatalog=item.id;
                            this.thirdList=item.child;
                        }
                    });
                    this.thirdList.map(item=>{
                        if(item.id===this.categoryId[3]){
                            this.thirdCatalog=item.id;
                            this.fourthList=item.child;
                        }
                    });
                    this.fourthList.map(item=>{
                        if(item.id===this.categoryId[4]){
                            this.fourthCatalog=item.id;
                            this.propertyList=item.properties;

                        }
                    });
                    console.log('type更新了');
                    this.propertyValue.radio=[];
                    this.propertyValue.checkbox=[];
                    this.propertyValue.inputOthers=[];
                    this.propertyList.map(item=>{
                        this.productsMapping.map(tmp=>{
                            if(tmp.id===item.property_id){
                                if(item.rule===1){
                                    item.radioIndex=tmp.val[0];
                                    this.propertyValue.radio.push(tmp)
                                }else if(item.rule===2){
                                    item.checkboxIndex=tmp.val;
                                    this.propertyValue.checkbox.push(tmp)
                                }
                            }
                        })
                    });
                    this.typeListTime++
                },
                deep:true
            }
        }
    }
</script>

<style src="@/assets/css/uploading.css"></style>
<style src="@/assets/css/uploadService.css"></style>
<style scoped>
    .upload_tips{
        height:100%;
        line-height:initial!important;
    }
    .upload_tips_txt{
        position:absolute;
        top:10px;
        right:10px;
        color:#8c8c8c;
    }
    .el-upload-dragger .el-icon-upload{
        margin-top:72px;
    }
    .upload_tips_suggest{
        position:absolute;
        bottom:10px;
        right:60px;
        font-size:12px;
        color:#8c8c8c;
    }
    .dragOver_txt{
        display:block;
        margin-top:114px;
        font-size:14px;
    }
</style>
<style>
    .el-tooltip__popper.step_catalog_tooltip{
        border-color:#ccc!important;
    }
    .el-tooltip__popper.step_catalog_tooltip.is-light[x-placement^=top] .popper__arrow{
        border-top-color:#ccc;
    }
    .uploading_item_product_video .upload-demo .el-upload-dragger{
        border:none!important;
    }
    .uploading_item_product_video.uploading_item_video:hover{
        border:none!important;
    }
    .mod_uploading_product .upload-demo .el-upload-dragger{
        border:1px dashed #ccc!important;
    }
    .mod_uploading_product .upload-demo .el-upload-dragger:hover{
        border-color:#15bafe!important;
    }
</style>