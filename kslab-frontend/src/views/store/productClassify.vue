<template>
    <div class="product_classify_search">
        <section>
            <div class="product_aside_nav">
                <div class="product_classify_item">
                    <div class="product_classify_head">
                        <i class="el-icon-arrow-left"></i>
                        <span class="product_classify_head_txt">所有分类</span>
                    </div>
                    <div class="product_type_nav">
                        <el-collapse v-model="activeName" accordion class="classify_first" @change="firstClick(activeName)">
                            <el-collapse-item :class="{activeColor:activeName===first.name}" :title="first.name" :name="first.name" v-for="(first,fir) in classify" :key="fir">
                                <div class="classify_second" :class="{active:secondIndex===sec}" v-for="(children,sec) in first.child" :key="sec" @click="secondClick(children.name,sec,children.id,children.pid)">{{children.name}}</div>
                            </el-collapse-item>
                        </el-collapse>
                    </div>
                </div>
                <div class="product_filtrate">
                    <div class="product_filtrate_slider">
                        <div class="product_slider_item">
                            <p class="product_slider_title">价格</p>
                            <el-slider v-model="price" :show-tooltip="false" :max="2800" range @change="priceChange"></el-slider>
                            <span class="product_slider_begin">0</span>
                            <span class="product_slider_current">{{price[0]}}-{{price[1]}}</span>
                            <span class="product_slider_end">2800</span>
                        </div>
                        <!--<div class="product_slider_item">-->
                            <!--<p class="product_slider_title">价格</p>-->
                            <!--<el-slider v-model="price" :show-tooltip="false" :max="2800" range></el-slider>-->
                            <!--<span class="product_slider_begin">0</span>-->
                            <!--<span class="product_slider_current">{{price[0]}}-{{price[1]}}</span>-->
                            <!--<span class="product_slider_end">2800</span>-->
                        <!--</div>-->
                    </div>
                    <div class="product_filtrate_rate">
                        <p class="product_rate_title">评价等级(至少)</p>
                        <el-rate v-model="rate" :allow-half="true"></el-rate>
                    </div>
                    <div class="product_filtrate_others">
                        <el-collapse v-model="activeOthers" accordion>
                            <el-collapse-item :title="item.value.property_name" :name="item.value.property_id" v-for="(item,index) in checkbox" :key="index">
                                <el-checkbox-group v-model="item[item.value.property_name]">
                                    <el-checkbox :label="label.value" v-for="(label,i) in item.value.property_comparison" :key="i"></el-checkbox>
                                </el-checkbox-group>
                            </el-collapse-item>
                        </el-collapse>
                    </div>
                </div>
            </div>
            <div class="product_search_result">
                <div class="product_crumbs">
                    <div class="product_bread_crumb">
                        <span v-for="(item,i) in breadCrumb" :key="i">
                            <span :class="{link:i===3 && breadCrumb.length>4}" @click="toClassify(item.name,i,item.id)">{{item.name}}</span>
                            <span class="el-icon-arrow-right" v-if="i<breadCrumb.length-1"></span>
                        </span>
                    </div>
                    <div class="product_sort">
                        <i class="icon" :class="{'icon-ziyuan29':isAsc,'icon-ziyuan30':!isAsc}" @click="changeSort"></i>
                        <el-select v-model="value" placeholder="默认排序">
                            <el-option
                                    v-for="item in options"
                                    :key="item.value"
                                    :label="item.label"
                                    :value="item.value">
                            </el-option>
                        </el-select>
                    </div>
                </div>
                <div class="product_show_box">
                    <ul class="product_search_list">
                        <li class="list_item" v-for="(res,i) in result" :key="i">
                            <div class="product_thumbnail" :class="{background:videoIndex===i}" @mouseenter="playVideo(res.video,i,$event)" @mouseleave="pauseVideos">
                            <router-link :to="'/home/product-detail/'+res.product_id">
                                <img class="product_thumbnail_img" :src="request.picUrl+res.show_picture+'?imageView2/1/w/200/h/200'" alt="" v-show="!(videoIndex===i)">
                                <video :src="request.picUrl+res.video" class="product_thumbnail_video" v-show="videoIndex===i" @timeupdate="updateTime"></video>
                                <div class="video_progress_box" v-show="videoIndex===i">
                                    <div class="video_progress" :style='"width:"+currentTime*40+"px"'></div>
                                </div>
                            </router-link>
                            </div>
                            <div class="product_info">
                                <p class="product_info_price" v-show="hidePayment">
                                    <span class="product_price">
                                        <i class="price_icon">¥</i>
                                        {{res.price}}
                                    </span>
                                    <span class="product_sales">{{res.sell_num}}人购买</span>
                                </p>
                                <p class="product_title"><router-link :to="'/home/product-detail/'+res.product_id">{{res.title}}</router-link></p>
                                <!--<p class="product_serial">产品编号:{{res.asin}}</p>-->
                                <span class="merchant_name">
                                    <i class="icon icon-ziyuan31"></i>
                                    <span class="product_merchant"><router-link to="">{{res.company_name}}</router-link></span>
                                </span>
                                <span class="product_rate">
                                    <el-rate
                                        v-model="res.score"
                                        disabled
                                        :colors='["#15bafe","#15bafe","#15bafe"]'
                                        score-template="{value}">
                                    </el-rate>
                                </span>
                                <p class="product_shopping_cart" v-show="hidePayment">
                                    <el-input-number v-model="res.productNum" @change="handleChange" :min="1" :max="res.stock" label="描述文字"></el-input-number>
                                    <i class="icon icon_block" @click="addToCart(res)">
                                        <i class="icon icon-ziyuan34"></i>
                                    </i>
                                </p>
                            </div>
                        </li>
                    </ul>
                    <div class="product_show_empty" v-if="result.length<=0">
                        <p class="product_empty_title">
                            <i class="icon icon-ziyuan47"></i>
                            <span class="product_empty_txt">抱歉，没有找到相关商品</span>
                        </p>
                        <div class="product_empty_suggest">
                            <p>建议您:</p>
                            <p>1.适当减少筛选条件</p>
                            <p>2.调整价格区间</p>
                            <P>3.调整评分等级</P>
                        </div>
                    </div>
                    <el-pagination
                            small
                            background
                            layout="prev, pager, next"
                            :page-count	="pageNum"
                            @current-change="currentPage"
                            @prev-click="prevPage"
                            @next-click="nextPage"
                            v-if="result.length>0">
                    </el-pagination>
                </div>
            </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
    </div>
</template>

<script>

    import FloatingDiv from '@/components/floating'

    export default {
        name: "productClassify",
        data(){
            return {
                width:$(window).width(),
                classify:[],//分类类表（后两级）
                activeName:'',//分类大类选中值
                secondIndex:null,//分类子类选中值下标
                price:[0,2800],//价格
                rate:0,//评分
                activeOthers:'',//属性手风琴当前展开项选中值
                breadCrumb:[],//面包屑
                result:[],//返回数据
                isAsc:false,//是否升序
                currentTime:0,//进度条
                videoIndex:null,//当前视频下标
                options: [{
                    value: '价格',
                    label: '价格'
                }, {
                    value: '评分',
                    label: '评分'
                }, {
                    value: '销量',
                    label: '销量'
                }],//排序方法选项
                value:'',//排序方法
                checkbox:[],//选择属性
                section:[],//区间属性
                pageNum:0,
                page:1,//当前显示页
                hidePayment:false,//隐藏支付相关
            }
        },
        components:{
            FloatingDiv,
        },
        methods:{
            changeSort(){//升降序改变事件
                this.isAsc = !this.isAsc;
            },
            firstClick(name){//分类父类单击事件
                if(name) {
                    this.color=false;
                    let i=null;
                    this.classify.forEach((item,index)=>{
                       if(item.name=this.activeName){
                           i=index
                       }
                    });
                    this.$route.query.fourthly=name;
                    this.$route.query.fifth='';
                    this.$route.query.category_id=this.classify[i].id;
                    this.$route.query.prevId=null;
                    this.$route.query.active=0;
                    this.getType()
                }else{
                    this.color=true;
                }
            },
            secondClick(name,i,id,pid){//分类子类单击事件
                if(name){
                    this.$route.query.fifth=name;
                    this.$route.query.prevId=pid;
                    this.$route.query.category_id=id;
                    this.$route.query.active=1;
                    this.getType()
                }
            },
            priceChange(){
                this.getProduct()
            },
            handleChange(value) {//购物车数量改变事件
                console.log(value);
            },
            addToCart(product){//添加至购物车
                console.log(product);
                this.HttpClient.post('/shoppingCart/addProducts',{ product_id:product.product_id,quantity:product.productNum})
                    .then(res=>{
                        console.log(res);
                        let {code,msg} = res.data;
                        if(code===-1){
                            this.$message.warning('登录失效，请重新登录！')
                        }else if(code===200){
                            this.$message.success(msg);
                        }else{
                            this.$message.warning(msg);
                        }
                    })
            },
            toClassify(t,i,id){//面包屑跳转
                if(i===3 && this.breadCrumb.length>4){
                    this.$route.query.fourthly=t;
                    this.$route.query.fifth='';
                    this.$route.query.category_id=id;
                    this.$route.query.prevId=null;
                    this.$route.query.active=0;
                    this.getType()
                }
            },
            /***************************视频播放*************************/
            playVideo(video,index,event){//播放视频
                if(video) {
                    this.videoIndex = index;
                    let $myVid=$(event.currentTarget).find("video");
                    this.currentTime=0;
                    $myVid[0].currentTime=0;
                    $myVid[0].play();
                }else{
                    this.videoIndex=null;
                }
            },
            // pauseVideo(){
            //     this.videoIndex = null;
            //     $('.product_thumbnail_video')[0].pause();
            //     // event.currentTarget.pause();
            // },
            pauseVideos(){//暂停并重置所有视频
                let $video=$('.product_thumbnail_video');
                for(let item of $video){
                    item.currentTime=0;
                    item.pause();
                }
                this.currentTime=0;
                this.videoIndex=null;
            },
            updateTime(e){//播放进度
                this.currentTime=e.target.currentTime;
                if(e.target.currentTime>=5){
                    e.target.currentTime=0;
                    e.target.pause();
                    this.videoIndex=null;
                }
            },
            /****分页****/
            currentPage(val){//页码按钮单击事件
                this.page=val;
                this.getProduct()
            },
            prevPage(val){//上一页
                // this.$message.warning('当前页:'+val);
            },
            nextPage(val){//下一页
                // this.$message.warning('当前页:'+val);
            },
            /****获取分类数据接口****/
            getType(){
                let type=this.$route.query;
                console.log(type);
                this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'category/getCcList',{
                    params: {
                        type: type.active,
                        category_id:type.category_id
                    }
                })
                    .then((res)=>{
                        this.classify=res.data.categories;
                        //初始分类选中项
                        this.activeName = type.fourthly;
                        this.breadCrumb.length=0;
                        this.breadCrumb.push({name:type.type,id:null});
                        this.breadCrumb.push({name:type.second,id:null});
                        this.breadCrumb.push({name:type.thirdly,id:null});
                        this.breadCrumb.push({name:type.fourthly,id:type.category_id});
                        let properties=[];
                        let index=null;
                        for(let i in this.classify){
                            if(this.classify[i].name===type.fourthly){
                                index=i;
                                break;
                            }
                        }
                        if(type.fifth){
                            this.classify[index].child.forEach((item,index)=>{
                                if(item.name===type.fifth){
                                    this.secondIndex=index;
                                }
                            });
                            // this.secondIndex=this.classify[index].children.indexOf(type.fifth);
                            this.breadCrumb.pop();
                            this.breadCrumb.push({name:type.fourthly,id:type.prevId});
                            this.breadCrumb.push({name:type.fifth,id:type.category_id});
                            properties=this.classify[index].child[this.secondIndex].properties;
                        }else{
                            this.secondIndex=null;
                            properties=this.classify[index].properties
                        }
                        this.checkbox.length=0;
                        this.section.length=0;
                        properties.forEach((item)=>{
                            let name=item.property_name;
                            let obj={};
                            if(item.rule===1){
                                obj[name]=[];
                                obj.value=item;
                                this.checkbox.push(obj)
                            }else if(item.rule===2){
                                obj[name]=[];
                                obj.value=item;
                                this.section.push(obj)
                            }
                        });
                        this.getProduct();
                        console.log(res);
                    })
                    .catch((err)=>{
                        console.log(err);
                    });
            },
            /*****获取分类页商品数据****/
            getProduct(){
                let id=this.$route.query.category_id,
                    order=0,
                    sort='',
                    properties=[],
                    page=this.page,
                    size=16;
                console.log(this.value);
                if(this.width<=1180){
                    size=15
                }
                if(this.value==='价格'){
                    order=1
                }else if(this.value==='评分'){
                    order=2
                }else if(this.value==='销量'){
                    order=3
                }
                if(this.isAsc){
                    sort='asc'
                }else{
                    sort='desc'
                }
                console.log(this.checkbox);
                console.log(this.section);
                this.checkbox.forEach((item)=>{
                    console.log(item[item.value.property_name]);
                    if(item[item.value.property_name]){

                    }
                    let {property_id,rule} = item.value;
                    properties.push({property_id:property_id,type:rule,val:item[item.value.property_name]});
                });
                this.section.forEach((item)=>{
                    let {property_id,rule,property_name} = item.value;
                    properties.push({property_id:property_id,type:rule,val:item[property_name]});
                });
                console.log(properties);
                this.HttpClient.get('/products/categoryPage/getProducts',
                    {
                        // category_id:id,
                        order:order,
                        sort:sort,
                        price:this.price,
                        score:this.rate,
                        properties:properties,
                        page:page,
                        size:size
                    })
                    .then(res =>{
                        console.log(res);
                        let {code,data,page_num} = res.data;
                        if(code===1030){
                            this.result.length=0
                        }else if(code===200){
                            data.forEach((item=>{
                                item.productNum=1;
                                item.score=Number(item.score);
                            }));
                            this.result=data;
                            this.pageNum=page_num
                        }
                })
            }
        },
        created(){
            this.getType();
        },
        mounted(){
            const that = this;
            window.onresize = function temp() {
                that.width = $(window).width();
            };
        },
        watch:{
            rate:function(){//评分变动
                this.getProduct()
            },
            value:function(){//排序方法
                this.getProduct()
            },
            isAsc:function(){//升降序切换
                this.getProduct()
            },
            checkbox:{//选择属性筛选
                handler:function(){
                    console.log(this.checkbox);
                    this.getProduct()
                },
                deep:true
            },
            section:{//区间属性筛选
                handler:function(){
                    this.getProduct()
                },
                deep:true
            },
            width:function(){
                this.getProduct()
            }
        }
    }
</script>

<style scoped>
    .product_classify_search{
        padding-top:30px;
        padding-bottom:30px;
    }
    .product_classify_search section{
        width:1200px;
        margin:0 auto;
    }
    .product_classify_search .product_aside_nav{
        display:inline-block;
        width:200px;
    }
    .product_classify_search .product_aside_nav .product_classify_item{
        width:100%;
        color:#fff;
        overflow:hidden;
        background:#37313f;
        border-top-right-radius:5px;
        border-top-left-radius:5px;
    }
    .product_classify_search .product_aside_nav .product_classify_head{
        height:40px;
        line-height:40px;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        border-bottom:1px solid #666;
    }
    .product_classify_search .product_aside_nav .el-icon-arrow-left{
        cursor:pointer;
        margin-left:13px;
        margin-right:18px;
    }
    /********************侧边导航筛选***************************/
    .product_classify_search .product_aside_nav .product_filtrate{
        background:#f2f2f2;
    }
        /***拖动条***/
    .product_classify_search .product_aside_nav .product_slider_item{
        position:relative;
        padding:17px 20px 35px 14px;
        border-bottom:1px solid #e1e1e1;
    }
    .product_classify_search .product_aside_nav .product_slider_title{
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #37313f;
    }
    .product_classify_search .product_aside_nav .product_slider_begin{
        position:absolute;
        left:11px;
    }
    .product_classify_search .product_aside_nav .product_slider_current{
        position:absolute;
        left:68px;
    }
    .product_classify_search .product_aside_nav .product_slider_end{
        position:absolute;
        right:8px;
    }
        /***评分***/
    .product_classify_search .product_aside_nav .product_filtrate_rate{
        padding:17px 14px;
        border-bottom:1px solid #e1e1e1;
    }
    .product_classify_search .product_aside_nav .product_rate_title{
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #37313f;
        margin-bottom:9px;
    }
    /*****************展示区************************/
    .product_classify_search .product_search_result{
        display:inline-block;
        width:978px;
        margin-left:18px;
        vertical-align:top;
    }
    .product_classify_search .product_search_result .product_crumbs{
        width:100%;
        height:28px;
        border-bottom:1px solid #eee;
        display:flex;
        justify-content:space-between;
    }
    .product_classify_search .product_search_result .product_crumbs .link{
        cursor:pointer;
        font-weight:800;
    }
    .product_classify_search .product_search_result .product_crumbs .link:hover{
        color:#15bafe;
    }
    .product_classify_search .product_search_result .product_crumbs .icon{
        cursor:pointer;
        color:#15bafe;
        serviceComment-select:none;
    }
    .product_sort .el-select{
        width:83px;
        height:22px;
        vertical-align:top;
    }
    /**********商品列表***************/
    .product_classify_search .product_search_result .product_show_box{
        margin-top:9px;
    }
    .product_classify_search .product_show_box .product_search_list{
        display:flex;
        flex-wrap:wrap;
        flex: 4;
        justify-content:flex-start;
    }
    .product_classify_search .product_show_box .product_search_list .list_item{
        /*min-width:235px;*/
        max-width:244.5px;
        margin-bottom:14px;
        padding:16px 17px;
        flex: 1;
        transition:box-shadow .2s ease-in-out, -webkit-box-shadow .2s ease-in-out;
    }
    .product_classify_search .product_show_box .product_search_list .list_item:hover{
        box-shadow:-3px 0 5px 0 rgba(160, 160, 160, 0.16), 3px 0 5px 0 rgba(160, 160, 160, 0.16), 0 3px 5px 0 rgba(160, 160, 160, 0.16), 0 -3px 5px 0 rgba(160, 160, 160, 0.16);
    }
    .product_classify_search .product_search_list .list_item .product_thumbnail{
        display:block;
        position:relative;
        width:200px;
        height:200px;
        text-align:center;
        overflow:hidden;
        margin:0 auto;
    }
    .product_classify_search .product_search_list .list_item .product_thumbnail.background{
        background:#222;
    }
    .product_classify_search .product_search_list .list_item .product_thumbnail_video{
        /*width:200px;*/
        height:200px;
        /*object-fit:fill;*/
    }
    .product_classify_search .product_search_list .list_item .video_progress_box{
        position:absolute;
        bottom:0;
        width:200px;
        height:5px;
        background:#999;
    }
    .product_classify_search .product_search_list .list_item .video_progress{
        height:5px;
        background:#15bafe;
    }
    .product_classify_search .product_search_list .product_info{
        margin-top:9px;
    }
    .product_classify_search .product_search_list .product_info_price{
        display:flex;
        justify-content:space-between;
    }
    .product_classify_search .product_search_list .product_price{
        font-size: 20px;
        font-weight: normal;
        letter-spacing: 0;
        color: #222222;
    }
    .product_classify_search .product_search_list .product_price .price_icon{
        font-size:14px;
    }
    .product_classify_search .product_search_list .product_sales{
        font-size: 12px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 30px;
        letter-spacing: 0;
        color: #a0a0a0;
    }
    .product_classify_search .product_search_list .product_title{
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 18px;
        letter-spacing: 0;
        color: #000000;
        word-break:break-all;
    }
    /*.product_classify_search .product_search_list .product_serial{*/
        /*font-size: 12px;*/
        /*font-weight: normal;*/
        /*font-stretch: normal;*/
        /*line-height: 20px;*/
        /*letter-spacing: 0;*/
        /*color: #a0a0a0;*/
        /*margin-bottom:10px;*/
    /*}*/
    .product_classify_search .product_search_list .merchant_name{
        vertical-align:middle;
    }
    .product_classify_search .product_search_list .product_rate{
        float:right;
    }
    .product_classify_search .product_search_list .product_shopping_cart{
        /*display:flex;*/
        /*justify-content:space-between;*/
        /*align-content: center;*/
        margin-top:18px;
    }
    .product_classify_search .product_search_list .icon_block{
        display:inline-block;
        position:relative;
        top:-9px;
        float:right;
        width:39px;
        height:39px;
        line-height:39px;
        color:#15bafe;
        text-align:center;
        border-radius:50%;
        vertical-align:middle;
    }
    .product_classify_search .product_search_list .icon_block:hover{
        background-color:#15bafe;
    }
    .icon-ziyuan34{
        cursor:pointer;
        line-height:39px;
        font-size:24px;
        color:#15bafe;
    }
    .product_classify_search .product_search_list .icon_block:hover .icon-ziyuan34{
        color:#fff;
    }
    /***无商品数据***/
    .product_classify_search .product_show_box .product_show_empty{
        width:228px;
        margin:100px auto 0;
    }
    .product_classify_search .product_show_box .product_empty_title{
        color:#15bafe;
        font-size:16px;
    }
    .product_classify_search .product_show_box .icon-ziyuan47{
        font-size:18px;
    }
    .product_classify_search .product_show_box .product_empty_suggest{
        margin-left:24px;
        color:#888;
    }
    /***分页条***/
    .product_classify_search .product_show_box .el-pagination{
        text-align:center;
    }
</style>

<style>
    .product_classify_search .product_type_nav .el-collapse{
        border:none!important;
    }
    .product_classify_search .product_type_nav .el-carousel__mask,
    .product_classify_search .product_type_nav .el-cascader-menu,
    .product_classify_search .product_type_nav .el-cascader-menu__item.is-disabled:hover,
    .product_classify_search .product_type_nav .el-collapse-item__header,
    .product_classify_search .product_type_nav .el-collapse-item__wrap{
        background:#37313f!important;
        border-bottom:none!important;
    }
    .product_classify_search .product_type_nav .el-collapse-item__header,
    .product_classify_search .product_type_nav .el-collapse-item__content{
        color:#fff!important;
    }
    .product_classify_search .product_type_nav .el-collapse-item__content{
        border-left:1px solid #ccc!important;
        padding-bottom:0!important;
    }
    .product_classify_search .product_type_nav .el-collapse-item__header{
        height:40px!important;
        line-height:40px!important;
    }
    .product_classify_search .product_type_nav .el-collapse-item__arrow{
        line-height:40px!important;
    }
    .product_classify_search .product_type_nav .classify_first{
        margin-left:19px!important;
    }
    .product_classify_search .product_type_nav .classify_second{
        cursor:pointer;
        margin-left:16px!important;
        margin-bottom:7px!important;
    }
    .product_classify_search .product_type_nav .classify_first .activeColor .el-collapse-item__header,
    .product_classify_search .product_type_nav .classify_second.active{
        color:#15bafe!important;
    }
    /***********slider************/
    .product_classify_search .el-slider__runway{
        margin:10px 0!important;
        background:#fff!important;
    }
    .product_classify_search .el-slider__bar{
        background:#15bafe!important;
    }
    .product_classify_search .el-slider__button{
        border-color:#15bafe!important;
    }
    /************rate****************/
    .product_classify_search .product_filtrate_rate .el-icon-star-on{
        color:#15bafe!important;
    }
    /************others*************/
    .product_classify_search .product_aside_nav .el-collapse{
        border-bottom-color:#e1e1e1;
        padding-bottom:10px!important;
    }
    .product_classify_search .product_filtrate_others .el-collapse-item__header{
        padding-left:14px;
        border-bottom-color:#e1e1e1;
    }
    .product_classify_search .product_filtrate_others .el-collapse-item__header.is-active{
        border-bottom-color:transparent;
    }
    .product_classify_search .product_filtrate_others .el-carousel__mask,
    .product_classify_search .product_filtrate_others .el-cascader-menu,
    .product_classify_search .product_filtrate_others .el-cascader-menu__item.is-disabled:hover,
    .product_classify_search .product_filtrate_others .el-collapse-item__header,
    .product_classify_search .product_filtrate_others .el-collapse-item__wrap{
        background:#f2f2f2!important;
    }
    .product_classify_search .product_filtrate_others .el-collapse-item__arrow{
        color:#fff;
        margin-top:18px;
        margin-right:18px;
        padding:1px 0 1px 2px;
        line-height:1;
        border-radius:50%;
        background:#666;
    }
    .product_classify_search .product_filtrate_others .el-collapse-item__content{
        padding-right:18px!important;
    }
    .product_classify_search .product_filtrate_others .el-checkbox{
        display:block!important;
    }
    .product_classify_search .product_filtrate_others .el-checkbox+.el-checkbox{
        margin-left:0!important;
    }
    .product_classify_search .product_filtrate_others .el-checkbox__input{
        float:right;
    }
    .product_classify_search .product_filtrate_others .el-checkbox__input.is-checked+.el-checkbox__label{
        color:#606266!important;
    }
    .product_classify_search .product_filtrate_others .el-checkbox__input.is-checked .el-checkbox__inner,
    .product_classify_search .product_filtrate_others .el-checkbox__input.is-indeterminate .el-checkbox__inner{
        border-color:#15bafe;
        background:#15bafe;
    }
    .product_classify_search .product_search_result .el-breadcrumb__inner a:hover,
    .product_classify_search .product_search_result .el-breadcrumb__inner.is-link:hover{
        color:#15bafe!important;
    }
    .product_classify_search .product_search_result .el-breadcrumb__item:last-child .el-breadcrumb__inner,
    .product_classify_search .product_search_result .el-breadcrumb__item:last-child .el-breadcrumb__inner a,
    .product_classify_search .product_search_result .el-breadcrumb__item:last-child .el-breadcrumb__inner a:hover,
    .product_classify_search .product_search_result .el-breadcrumb__item:last-child .el-breadcrumb__inner:hover{
        color:#606266!important;
    }
    .product_classify_search .product_search_result .product_sort,
    .product_classify_search .product_search_result .el-breadcrumb{
        line-height:28px;
    }
    .product_classify_search .product_search_result .product_sort{
        height:22px;
        line-height:22px;
    }
    /*********排序下拉框***********/
    .product_crumbs .product_sort .el-input__inner{
        height:22px;
        line-height:22px;
        border:none;
        background:#f2f2f2;
        color:#888;
        font-size:12px;
        padding:0 24px 0 6px;
        text-align:center;
    }
    .product_crumbs .product_sort .el-input__icon{
        line-height:22px;
    }
    /********************展示区******************/
    .product_classify_search .product_search_list .el-rate{
        display:inline-block;
    }
    .product_classify_search .product_search_list .el-rate__icon{
        margin-right:0!important;
    }
    .product_classify_search .product_search_list .el-input-number{
        width:55px!important;
        line-height:20px!important;
    }
    .product_classify_search .product_search_list .el-input-number__decrease,
    .product_classify_search .product_search_list .el-input-number__increase{
        width:18px!important;
    }
    .product_classify_search .product_search_list .el-input__inner{
        height:22px!important;
        line-height:22px!important;
        padding-left:18px!important;
        padding-right:18px!important;
    }

    /******960兼容******/
    @media screen and (max-width: 1180px) and (min-width: 960px) {
        .product_classify_search section{
            width:960px!important;
        }
        .product_classify_search .product_search_result{
            width:710px!important;
        }
    }
</style>
