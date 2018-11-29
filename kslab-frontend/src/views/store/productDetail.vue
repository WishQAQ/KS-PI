<template>
    <div class="product_detail">
        <section>
            <div class="product_detail_box">
                <div class="product_detail_show">
                    <div class="product_preview">
                    <product-rack :video="details.video" :image="details.show_picture"></product-rack>
                    <div class="product_preview_info">
                        <div class="product_info_shelf">
                            <p class="product_title">{{details.title}}</p>
                            <p class="product_rate">
                                <keyword-install :keyword="details.tags"></keyword-install>
                                <el-rate
                                        v-model="details.score"
                                        disabled
                                        :colors="['#15bafe','#15bafe','#15bafe']"
                                        score-template="{value}">
                                </el-rate>
                            </p>
                            <div class="product_others">
                                <div class="product_serial">
                                    <p class="product_serial_title">商品编号</p>
                                    {{details.asin}}
                                </div>
                                <div class="product_comment">
                                    <p class="product_comment_title">累计评论</p>
                                    {{comment}}
                                </div>
                                <div class="product_sales">
                                    <p class="product_sales_title">售出</p>
                                    {{details.sell_num}}份
                                </div>
                            </div>
                            <p class="product_merchant">
                                <i class="icon icon-ziyuan31"></i>
                                <router-link to="/merchantHomePage"><span class="merchant_name">{{details.name}}</span></router-link>
                                <i class="icon icon-ziyuan36"></i>
                            </p>
                        </div>
                        <div class="product_operating_space" v-show="hidePayment">
                            <div class="shopping_cart">
                                <el-input-number v-model="purchase" @change="handleChange" :min="1" :max="details.stock"></el-input-number>
                                <span class="shopping_cart_stock">(库存:{{details.stock}})</span>
                                <div class="total_price">¥<span class="product_price">{{details.price}}</span></div>
                            </div>
                            <span class="add_to_shopping_cart" :class="{active:isActive}" @mouseenter="changeActive($event)" @click="addToCart">
                                <i class="icon icon-ziyuan34"></i>
                                添加购物车
                            </span>
                            <span class="immediately" :class="{active:!isActive}" @mouseenter="changeActive($event)" @click="buyNow">
                                立即购买
                            </span>
                        </div>
                        <div class="share_report">
                            <p @click="shareModalShowTrue" class="share"><img src="/static/img/icon/share.png" alt="">分享</p>
                            <p class="report" @click="reportModal"><span><img src="/static/img/icon/report.png" alt=""></span>举报</p>
                            <shareModalDiv ref="shareModal"></shareModalDiv>
                            <report-modal ref="reportModal"></report-modal>
                        </div>
                    </div>
                </div>
                <div class="product_information">
                    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
                        <el-tab-pane label="商品详情" name="detail">
                            <div class="product_details">
                                {{details.description}}
                                <img :src="img" alt="" v-for="(img,index) in details.img" :key="index" class="product_details_img">
                            </div>
                        </el-tab-pane>
                        <el-tab-pane name="comment">
                            <span slot="label">评论<span class="comment_quantity">{{details.comment}}</span></span>
                            <activity-data-comment :type="product" :activeId="id"></activity-data-comment>
                        </el-tab-pane>
                        <el-tab-pane label="附件" name="accessory">
                            <activity-data-file :attachment="details.attachment"></activity-data-file>
                        </el-tab-pane>
                    </el-tabs>
                </div>
                    <div class="product_relevant" v-if="relevantProduct.length>0">
                        <div class="product_relevant_header">相关商品</div>
                        <ul class="product_relevant_list">
                            <li class="product_relevant_item" v-for="(relevant,index) in relevantProduct" :key="index">
                                <img :src="relevant.show_picture+'?imageView2/1/w/190/h/190'" alt="" class="product_relevant_img">
                                <p class="product_relevant_title">
                                    <router-link :to="'/home/product-detail/'+relevant.product_id">{{relevant.title}}</router-link>
                                </p>
                                <p class="product_relevant_price" v-show="hidePayment">¥{{relevant.price}}</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <aside class="product_relevant">
                    <div class="relevant_box">
                        <el-tabs v-model="activeRelevant" type="card" @tab-click="handleClick">
                            <el-tab-pane label="相关视频" name="relevantVideo">
                                <ul class="relevant_video_list">
                                    <li class="relevant_video_list_item" v-for="video in relevantVideo" :key="video.video_id">
                                        <div class="relevant_video_img">
                                            <img :src="request.picUrl+video.cover" alt="">
                                        </div>
                                        <div class="relevant_video_detail">
                                            <p class="relevant_detail_title" :title="video.title">
                                                <a href="javascript:;" @click="toDetails(video.video_id,'video')">{{video.title.length>15?video.title.slice(0,15):video.title}}</a>
                                            </p>
                                            <p class="relevant_detail_actor">{{video.nickname}}</p>
                                            <p class="relevant_detail_views">{{video.view_num>1000?(video.view_num/1000).tofixed(1)+'K+':video.view_num}}次浏览</p>
                                        </div>
                                    </li>
                                </ul>
                            </el-tab-pane>
                            <el-tab-pane label="学海无涯" name="relevantEncyclopedia">
                                <ul class="relevant_encyclopedia_list">
                                    <li class="relevant_encyclopedia_list_item" v-for="encyclopedia in relevantQuestion.encyclopedias" :key="encyclopedia.encyclopedia_id">
                                        <div class="encyclopedia_preview">
                                            <img :src="request.picUrl+(encyclopedia.cover.indexOf('?')===-1?
                                                encyclopedia.cover+'?imageView2/1/w/124/h/94':
                                                encyclopedia.cover+'|imageView2/1/w/124/h/94')" alt="">
                                        </div>
                                        <div class="encyclopedia_txt">
                                            <p class="relevant_encyclopedia_title">
                                                <a href="javascript:;" class="relevant_title_link" @click="toDetails(encyclopedia.encyclopedia_id,'encyclopedia')">
                                                    {{encyclopedia.title.length>23?encyclopedia.title.slice(0,23)+'...':encyclopedia.title}}
                                                </a>
                                            </p>
                                            <p class="relevant_encyclopedia_info">
                                                <span class="relevant_encyclopedia_dot">·</span>
                                                <span class="relevant_encyclopedia_views">{{encyclopedia.view_num>10000?(encyclopedia.view_num/10000).toFixed(1):encyclopedia.view_num}}次观看</span>
                                                <span class="relevant_encyclopedia_dot">·</span>
                                                <span class="relevant_encyclopedia_date">{{Tools.GetDate(encyclopedia.created_at)}}前</span>
                                            </p>
                                        </div>
                                    </li>
                                    <li class="relevant_encyclopedia_list_item" v-for="question in relevantQuestion.questions" :key="question.question_id">
                                        <p class="relevant_encyclopedia_title">
                                            <span class="relevant_encyclopedia_rectangle"></span>
                                            <a href="javascript:;" class="relevant_title_link" @click="toDetails(question.question_id,'question')">{{question.title}}</a>
                                        </p>
                                        <keyword-install :keyword="question.tagsname"></keyword-install>
                                        <p class="relevant_encyclopedia_info">
                                            <span class="relevant_encyclopedia_actor">{{question.nickname}}</span>
                                            <span class="relevant_encyclopedia_dot">·</span>
                                            <span class="relevant_encyclopedia_views">{{question.view_num>10000?(question.view_num/10000).toFixed(1)+'万':question.view_num}}次观看</span>
                                            <span class="relevant_encyclopedia_dot">·</span>
                                            <span class="relevant_encyclopedia_date">{{Tools.GetDate(question.created_at)}}前</span>
                                        </p>
                                    </li>
                                </ul>
                            </el-tab-pane>
                        </el-tabs>
                    </div>
                </aside>
            </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
    </div>
</template>

<script>

    import FloatingDiv from '@/components/floating'
    import ReportModal from '@/components/reportModal'
    import ShareModalDiv from '@/components/shareModal'
    import ProductRack from '@/components/productRack'
    import KeywordInstall from '@/components/keywordInstall'
    import ActivityDataComment from '@/views/activity/activityDataComment'
    import ActivityDataFile from '@/views/activity/actvityDataFlie'

    export default {
        name: "productDetail",
        data(){
            return {
                width:(document.documentElement.offsetWidth || document.body.offsetWidth)+17,//屏幕宽度
                id:this.$route.params.id,//商品id
                details:{show_picture:[]},//商品详情
                comment:899,//评论总数
                picIndex:0,//详情图片下标
                showControl:true,
                isPaused:true,
                md:'',//视频封面图
                purchase:1,//购买数量
                isActive:true,//按钮是否激活
                isLogin:true,//是否登录
                relevantProduct:[
                    {
                        product_id: "sdsdfs-sdf-34-sdf",
                        show_picture: "/static/img/product/md/1_1.jpg",
                        title: "无人飞机1",
                        price: "110.00"
                    },
                    {
                        product_id: "sdsdfs-sdf-234-sdf",
                        show_picture: "/static/img/product/md/1_1.jpg",
                        title: "无人飞机2",
                        price: "112.00"
                    },
                    {
                        product_id: "sdsdfs-sdf-34-sdf",
                        show_picture: "/static/img/product/md/1_1.jpg",
                        title: "无人飞机1",
                        price: "110.00"
                    },
                    {
                        product_id: "sdsdfs-sdf-234-sdf",
                        show_picture: "/static/img/product/md/1_1.jpg",
                        title: "无人飞机2",
                        price: "112.00"
                    },
                    {
                        product_id: "sdsdfs-sdf-34-sdf",
                        show_picture: "/static/img/product/md/1_1.jpg",
                        title: "无人飞机1",
                        price: "110.00"
                    },
                    {
                        product_id: "sdsdfs-sdf-234-sdf",
                        show_picture: "/static/img/product/md/1_1.jpg",
                        title: "无人飞机2",
                        price: "112.00"
                    }
                ],//相关商品列表
                activeName:'detail',//商品信息当前激活标签页
                activeRelevant:'relevantVideo',//相关内容当前激活标签页
                relevantVideo:[],//相关视频列表
                relevantQuestion:{},//学海无涯列表
                product:'product',//评论组件调用类型
                hidePayment:false,//隐藏支付相关
            }
        },
        components:{
            FloatingDiv,
            ReportModal,
            ShareModalDiv,
            ActivityDataComment,
            ActivityDataFile,
            ProductRack,
            KeywordInstall
        },
        methods:{
            handleChange(value) {
                console.log(value);

            },
            changeActive(e){
                if(!$(e.currentTarget).is('.active')) {
                    this.isActive = !this.isActive;
                }
            },
            addToCart(){//添加至购物车
                let token=window.localStorage.getItem('token');
                this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'shoppingCart/addProducts',{
                    token: token,
                    product_id:this.id,
                    quantity:this.purchase
                }).then((res)=>{
                    console.log(res);
                    let {code,msg} = res.data;
                    if(code===-1){
                        this.$message.warning('登录失效，请重新登录！')
                    }else if(code===200){
                        this.$message.success(msg);
                    }else{
                        this.$message.warning(msg);
                    }
                }).catch((err)=>{
                    console.log(err);
                })
            },
            //立即购买
            buyNow(){
                const product={};
                product[this.id]=this.purchase;
                console.log(product);
                this.$router.push({
                    path:'/closeAccount',
                    query:{
                        product:product
                    }
                })
            },
            handleClick(){},
            shareModalShowTrue(){
                if(!this.$refs.shareModal.modelDelete){
                    this.$refs.shareModal.show();
                }
            },
            reportModal(){
                let token=window.localStorage.getItem('token');
                this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'islogin',{
                        token:token
                    })
                    .then((res)=>{
                        console.log(res);
                        console.log(res.data);
                        if(res.data.code===200) {
                            if(!this.$refs.reportModal.modelReport){
                                this.$refs.reportModal.modelReport=true
                            }
                        }else{
                            this.$message.warning('你还没有登录')
                        }
                    })
                    .catch(function(res){
                        console.log(res);
                    });
            },
            //相关跳转详情页
            toDetails(id,source){
                let query={},
                    path='';
                if(source==='video'){
                    path='/home/videoDetail';
                    query.video=id;
                }else if(source==='question'){
                    path='/home/problemDetails';
                    query.id=id
                }else if(source==='encyclopedia'){
                    path='/home/baikeDetail';
                    query.uid=id
                }
                this.$router.push({
                    path:path,
                    query:query
                })
            },
            /****商品信息****/
            getProductInfo(){
                this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'products/detail',{
                    params: {
                        product_id: this.id
                    }
                })
                    .then((res)=>{
                        console.log(res);
                        let {code,msg,productInfo,possibleLikeProducts} = res.data;
                        if(code===1164){
                            this.$message.warning('该商品已下架')
                        }else if(code===200){
                            this.details=productInfo;
                            if(productInfo.video){
                                this.picIndex=null;
                            }
                            this.relevantProduct=possibleLikeProducts;
                            /****相关内容获取****/
                            //相关视频
                            this.HttpClient.post('/goods/relatedGoodsVideo',{title:this.details.title,tags:this.details.tags})
                                .then(res=>{
                                    console.log(res);
                                    if(res.data.code===200){
                                        this.relevantVideo=res.data.data;
                                        console.log(this.relevantVideo);
                                    }
                                });
                            //学海无涯
                            console.log(this.details.title);
                            this.HttpClient.post('/products/relatedProducts',{title:this.details.title,product_id:this.id})
                                .then(res=>{
                                    console.log(res);
                                    if(res.data.code===200){
                                        this.relevantQuestion=res.data.data;
                                        console.log(this.relevantQuestion);
                                    }
                                })
                        }
                        console.log(res);
                    })
                    .catch((err)=>{
                        console.log(err);
                    });
            },
            /****评论获取****/
            getCommentData(){
                this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'products/comments',{
                    params: {
                        product_id: this.id
                    }
                }).then((res)=>{
                    let {code,current_page,data,page_num,total} = res.data;
                    // this.comment=total;//评论条数
                    console.log(res);
                }).catch((err)=>{
                    console.log(err);
                });
            }
        },
        created(){
            // let id=this.$route.params.id;
            this.getProductInfo();
            this.getCommentData()
        },
        mounted(){
            const that = this;
            window.onresize = function temp() {
                that.width = (document.documentElement.offsetWidth || document.body.offsetWidth)+17;
                console.log(that.width);
            };
        },
        //路由钩子
        beforeRouteUpdate(to,from,next){
            let index=to.path.lastIndexOf('/');
            this.id=to.path.slice(index+1);
            this.getProductInfo();
            this.getCommentData();
            next()
        },
    }
</script>

<style scoped>
    .product_detail{
        padding-top:80px;
    }
    .product_detail_box{
        display:flex;
        width:1200px;
        margin:0 auto;
    }
    .product_detail_box .product_detail_show{
        width:850px;
        margin-right:24px;
    }
    .product_detail_box .product_preview{
        display:inline-block;
    }
    .product_detail_box .product_information{
        display:inline-block;
        width:850px;
        margin-top:50px;
        margin-bottom:60px;
    }
    .product_detail_box .product_preview_info{
        display:inline-block;
        width:346px;
        vertical-align:top;
    }
    .product_detail_box .product_preview_info .product_title{
        font-size: 18px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 28px;
        letter-spacing: 0;
        color: #000000;
        margin-bottom:12px;
    }
    .product_detail_box .product_preview_info .product_rate{
        display:flex;
        align-items:center;
    }
    .product_detail_box .product_preview_info .product_others{
        display:flex;
        margin-top:20px;
    }
    .product_detail_box .product_preview_info .product_others div{
        flex:1;
        color: #ccc;
        border-right:1px solid #ccc;
        text-align:center;
    }
    .product_detail_box .product_preview_info .product_others p{
        color:#000;
    }
    .product_detail_box .product_preview_info .product_merchant{
        margin-top:20px;
        font-size:14px;
        color:#666;
    }
    .product_detail_box .product_preview_info .product_merchant .merchant_name{
        margin:0 -2px 0 -2px;
        vertical-align:top;
    }
    .product_detail_box .product_preview_info .product_merchant .icon-ziyuan36{
        font-size:14px;
        cursor:pointer;
    }
    .product_detail_box .product_preview_info .product_operating_space{
        margin-top:70px;
    }
    .product_detail_box .product_operating_space .shopping_cart{
        vertical-align:top;
        margin-bottom:27px;
    }
    .product_detail_box .product_operating_space .shopping_cart_stock{
        color:#999;
        font-size:14px;
        height:initial;
        border:none;
    }
    .product_detail_box .product_operating_space .total_price{
        display:inline-block;
        float:right;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing:0;
        color: #15bafe;
        vertical-align:top;
    }
    .product_detail_box .product_operating_space .product_price{
        font-size:26px;
        border:none;
    }
    .product_detail_box .product_operating_space .el-input-number{
        display:inline-block;
        width:90px!important;
    }
    .product_detail_box .product_operating_space span{
        display:inline-block;
        height:40px;
        font-size: 18px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 1px;
        line-height:40px;
        text-align:center;
        color: #15bafe;
        cursor:pointer;
        border:1px solid #15bafe;
        border-radius:5px;
    }
    .product_detail_box .product_operating_space .add_to_shopping_cart{
        width:203px;
    }
    .product_detail_box .product_operating_space .immediately{
        width:139px;
    }
    .product_detail_box .product_operating_space span.active{
        color:#fff;
        background:#15bafe;
    }
    .product_detail_box .product_operating_space .add_to_shopping_cart .icon-ziyuan34{
        font-size:20px;
        color:#15bafe;
        vertical-align:middle;
    }
    .product_detail_box .product_operating_space .add_to_shopping_cart.active .icon-ziyuan34{
        color:#fff;
    }
    .product_detail_box .share_report{
        display:flex;
        justify-content:flex-end;
        margin-top:40px;
    }
    .product_detail_box .share_report p{
        color:#888;
        cursor: pointer;
    }
    .product_detail_box .share_report .share{
        margin-right: 20px;
    }
    .product_detail_box .share_report p img{
        vertical-align:middle;
        margin-right:5px;
    }
    /*******************详情******************/
    .product_information .product_details{
        padding:0 4px;
    }
    .product_information .product_details_img{
        width:842px;
        margin:0 auto;
    }
    .product_information .comment_quantity{
        display:inline-block;
        color:#15bafe;
        margin-left:3px;
        border-radius:50%;
        vertical-align:top;
    }
    /***************************相关视频**********************/
    .product_detail_box .product_relevant{
        vertical-align:top;
    }
    .product_detail_box .product_relevant .relevant_box{
        width:320px;
    }
    .product_detail_box .product_relevant .relevant_video_list_item{
        margin-bottom:10px;
    }
    .product_detail_box .product_relevant .relevant_video_list_item:last-child{
        margin-bottom:0;
    }
    /***********************相关百科***********************/
    .product_detail_box .encyclopedia_txt{
        display:flex;
        flex-direction: column;
        justify-content: space-between;
        width:168px;
        margin-left:10px;
        vertical-align:top;
    }
    .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_list_item{
        display:flex;
        flex-wrap:wrap;
        justify-content:space-between;
        position:relative;
        padding-left:15px;
        margin-bottom:10px;
    }
    .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_title{
        width:100%;
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 20px;
        letter-spacing: 0;
        color: #000 ;
    }
    .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_content{
        font-size: 12px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 16px;
        letter-spacing: 0;
        color: #888;
        margin-bottom:5px;
    }
    .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_tags{
        margin-bottom:5px;
    }
    .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_info{
        width:100%;
        font-size: 12px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 20px;
        letter-spacing: 0;
        color: #888;
        margin-top:5px;
    }
    .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_rectangle{
        display:inline-block;
        width:0;
        height:0;
        border-width:8px 3px;
        border-style:solid;
        border-color:#15bafe;
        vertical-align:bottom;
    }
    .product_detail_box .relevant_encyclopedia_list .relevant_title_link:visited{
        /*color:#15bafe;*/
    }

    /**************************相关商品********************/
    .product_detail_box .product_relevant .product_relevant_list{
        display:flex;
        justify-content:flex-start;
        flex-wrap:wrap;
        width:850px;
    }
    .product_detail_box .product_relevant .product_relevant_item{
        width:200px;
        margin-right:10px;
        margin-bottom:23px;
    }
    .product_detail_box .product_relevant .product_relevant_item:nth-child(4),
    .product_detail_box .product_relevant .product_relevant_item:last-child{
        margin-right:0;
    }
    .product_detail_box .product_relevant .product_relevant_item:hover{
        border-color:#15bafe;
    }
    .product_detail_box .product_relevant .product_relevant_img{
        display:block;
        width:190px;
        height:190px;
        border:1px solid #f2f2f2;
        transition:all .3s;
    }
    .product_detail_box .product_relevant .product_relevant_img:hover{
        border-color:#15bafe;
    }
    .product_detail_box .product_relevant .product_relevant_header{
        font-size: 18px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 20px;
        letter-spacing: 0;
        color: #000000;
        margin-bottom:23px;
    }
    .product_detail_box .product_relevant .product_relevant_header:before{
        display:inline-block;
        content:'';
        width:6px;
        height:20px;
        margin-right:7px;
        background:#15bafe;
        vertical-align:middle;
    }
    .product_detail_box .product_relevant .product_relevant_title{
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 18px;
        letter-spacing: 0;
        color: #000000;
        margin-top:4px;
    }
    .product_detail_box .product_relevant .product_relevant_price{
        font-size: 18px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #15bafe;
        margin-top:5px;
    }
</style>

<style>
    .product_detail_box .product_preview_info .product_rate .el-rate__icon{
        font-size:22px;
        margin-right:0;
    }
    .product_detail_box .product_operating_space .el-input-number__decrease,
    .product_detail_box .product_operating_space .el-input-number__increase{
        width:30px!important;
        height:28px!important;
        line-height:28px;
        top:5px;
    }
    .product_detail_box .product_operating_space .el-input-number .el-input__inner{
        padding:0;
        height:30px;
        line-height:30px;
    }
    /******************************************标签页（详情/评论/附件）***************************/
    .product_detail_box .el-tabs--card>.el-tabs__header .el-tabs__nav{
        border:none;
    }
    .product_detail_box .el-tabs--card>.el-tabs__header .el-tabs__item{
        color:#888;
        border-top:2px solid transparent;
        border-left-color:transparent;
        border-right:1px solid transparent;
    }
    .product_detail_box .el-tabs--card>.el-tabs__header .el-tabs__item:hover{
        color:#15bafe;
    }
    .product_detail_box .el-tabs--card>.el-tabs__header .el-tabs__item:first-child{
        border-left:1px solid transparent;
    }
    .product_detail_box .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
        color:#000;
        border-top-color:#15bafe;
        border-left-color:#ccc;
        border-right-color:#ccc;
    }
    .product_detail_box .el-tabs{
        background:#fff;
    }
    .product_detail_box .el-tabs--card>.el-tabs__header{
        margin-bottom:20px!important;
        border-bottom-color:#ccc;
        background:#fff;
    }
    /*****************************相关视频/相关百科*********************/
    .product_detail_box .relevant_box .relevant_video_img,
    .product_detail_box .relevant_box .relevant_video_detail{
        display:inline-block;
    }
    .product_detail_box .relevant_box .relevant_video_img img{
        width:160px;
        height:90px;
    }
    .product_detail_box .relevant_box .relevant_video_detail{
        margin-left:13px;
        width:143px;
        vertical-align:top;
    }
    .product_detail_box .relevant_box .relevant_detail_actor{
        margin:20px 0 2px;
        color:#888;
    }
    .product_detail_box .relevant_box .relevant_detail_views{
        color:#888;
    }

    /******960兼容******/
    @media screen and (max-width:1180px) and (min-width:960px) {
        .product_detail_box{
            width:960px!important;
        }
        .product_detail_box .product_detail_show{
            width:656px!important;
        }
        .product_detail_box .product_preview_info{
            width:320px!important;
        }
        .product_detail_box .product_preview_info .product_title{
            font-size:14px!important;
            margin-bottom:0!important;
        }
        .product_detail_box .product_preview_info .product_rate .el-rate__icon{
            font-size:18px!important;
        }
        .product_detail_box .product_operating_space .shopping_cart{
            margin-bottom:20px!important;
        }
        .product_detail_box .product_operating_space .total_price{
            font-size:10px!important;
        }
        .product_detail_box .product_operating_space .product_price{
            font-size:20px!important;
        }
        .product_detail_box .product_operating_space span{
            font-size:14px!important;
        }
        .product_detail_box .product_operating_space .add_to_shopping_cart .icon-ziyuan34{
            font-size:18px!important;
        }
        .product_detail_box .product_operating_space .add_to_shopping_cart{
            width:142px!important;
            margin-right:10px;
        }
        .product_detail_box .product_operating_space .immediately{
            width:108px!important;
        }
        .product_detail_box .product_operating_space span{
            height:34px!important;
            line-height:34px!important;
        }
        .product_detail_box .share_report{
            justify-content:flex-start!important;
        }
        /******右侧相关******/
        .product_detail_box .product_relevant .relevant_box{
            width:250px!important;
        }
        .product_detail_box .el-tabs--card>.el-tabs__header .el-tabs__item{
            font-size:12px!important;
            height:30px!important;
            line-height:30px!important;
            padding:0 15px!important;
        }
        .product_detail_box .el-tabs--card>.el-tabs__header{
            margin-bottom:10px!important;
        }
        .product_detail_box .relevant_box .relevant_video_img img{
            width:120px!important;
            height:68px!important;
        }
        .product_detail_box .relevant_box .relevant_video_detail{
            margin-left:0!important;
            width:126px!important;
        }
        .product_detail_box .relevant_box .relevant_detail_actor{
            margin:0!important;
        }
        .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_list_item{
            padding-left:0!important;
        }
        .product_detail_box .encyclopedia_preview{
            width:100px!important;
            height:76px!important;
        }
        .product_detail_box .encyclopedia_preview img{
            width:100px!important;
            height:76px!important;
        }
        .product_detail_box .encyclopedia_txt{
            width:132px!important;
        }
        .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_title{
            font-size:12px!important;
        }
        .product_detail_box .relevant_encyclopedia_list .relevant_encyclopedia_info{
            left:110px!important;
        }

        /******商品详情标签******/
        .product_detail_box .product_information{
            width:660px!important;
        }

        /******相关商品******/
        .product_detail_box .product_relevant .product_relevant_header{
            font-size:12px!important;
            margin-bottom:10px!important;
        }
        .product_detail_box .product_relevant .product_relevant_header:before{
            vertical-align:top!important;
        }
        .product_detail_box .product_relevant .product_relevant_list{
            width:660px!important;
        }
        .product_detail_box .product_relevant .product_relevant_item{
            width:156px!important;
            margin-bottom:10px!important;
        }
        .product_detail_box .product_relevant .product_relevant_img{
            width:156px!important;
            height:156px!important;
        }
        .product_detail_box .product_relevant .product_relevant_title{
            font-size:12px!important;
        }
        .product_detail_box .product_relevant .product_relevant_price[data-v-4b688b70]{
            font-size:14px;
        }
    }
</style>
