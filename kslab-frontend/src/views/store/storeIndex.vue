<template>
    <div class="store_index appBackground">
        <section>
            <div class="type_nav_960" @click="secondClick">
                <div class="nav_item" :class="{active:typeIndex===i}" v-for="(t,i) in type" :key="i" @click="typeClick(t.name,i)">
                    <div class="nav_type_img_box">
                        <i class="icon" :style="'background:url('+t.pic+') center center no-repeat'"></i>
                    </div>
                    <p class="nav_type_txt">{{t.name}}</p>
                </div>
            </div>
            <transition name="secondNav">
                <div class="store_nav_head" v-if="typeIndex!==null">
                    <div class="store_nav_head_list">
                        <ul class="store_nav_list">
                            <li class="nav_list_item" :class="{active:secondIndex===index}" v-for="(tmp,index) in type[typeIndex].child" :key="index" @click="secondClick(tmp,index,$event)">
                                {{tmp.name}}
                            </li>
                        </ul>
                    </div>
                    <div class="thirdly_nav" v-if="secondIndex!==null">
                        <div class="type_floating" :style="'left:'+left+'px'">
                            <ul class="thirdly_nav_list">
                                <li class="thirdly_nav_item" :class="{active:defaultSelected===tIndex}" v-for="(tItem,tIndex) in type[typeIndex].child[secondIndex].child" :key="tIndex" @mouseenter="thirdlySelected(tItem.name,tIndex)">
                                    {{tItem.name}}
                                    <i class="el-icon-arrow-right"></i>
                                </li>
                            </ul>
                            <div class="fourthly_nav" v-if="thirdlyIndex!==null">
                                <ul class="fourthly_nav_list">
                                    <li class="fourthly_nav_item" v-for="(fItem,fIndex) in type[typeIndex].child[secondIndex].child[thirdlyIndex].child" :key="fIndex">
                                        <div class="fourthly_menu" @click="fourthlyClick(fItem.name,fItem.id)">{{fItem.name}}</div>
                                        <ul class="fifth_nav_list">
                                            <li class="fifth_nav_item" v-for="(fifItem,fifIndex) in fItem.child.length>6?fItem.child.slice(0,6):fItem.child" :key="fifIndex" @click.stop="fifthClick(fItem.name,fifItem.name,fItem.id,fifItem.id)">
                                                <i class="el-icon-arrow-right"></i>
                                                {{fifItem.name}}
                                            </li>
                                            <li class="fifth_nav_item fifth_nav_item_more" v-if="fItem.child.length>6" @click="fourthlyClick(fItem.name,fItem.id)">查看更多...</li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="borderBottom"></div>
                </div>
            </transition>
            <div class="store_index_body" @click="secondClick">
                <div class="recommend_product">
                    <div class="recommend_title">
                        <i class="icon icon_recommend"></i>
                        <span class="recommend_title_txt">推荐商品</span>
                    </div>
                    <div class="recommend_product_list">
                        <ul class="figure_list"  @mouseleave="pauseVideos">
                            <li class="product_list_item" v-for="(rec,index) in recommend" :key="index">
                                <div class="product_thumbnail" :class="{background:videoIndex===index}" @mouseenter="playVideo(rec.video,index,$event,'recommend')" @mouseleave="pauseVideos">
                                    <router-link :to="'/home/product-detail/'+rec.product_id">
                                        <img class="product_thumbnail_img" :src="'http://cdn.kushualab.com/'+rec.show_picture" alt="" v-show="!(videoIndex===index)">
                                        <video :src="'http://cdn.kushualab.com/'+rec.video" class="product_thumbnail_video" v-show="videoIndex===index" @timeupdate="updateTime"></video>
                                        <div class="video_progress_box" v-show="videoIndex===index">
                                            <div class="video_progress" :style='"width:"+currentTime*40+"px"'></div>
                                        </div>
                                    </router-link>
                                </div>
                                <div class="product_info">
                                    <p class="product_sell_info" v-show="hidePayment">
                                        <span class="product_price"><span class="product_price_symbol">¥</span>{{Number(rec.price).toFixed(2)}}</span>
                                        <span class="product_sales">{{rec.sell_num}}人购买</span>
                                    </p>
                                    <p class="product_title"><router-link :to="'/home/product-detail/'+rec.product_id" :title="rec.title">{{rec.title.length>26?rec.title.slice(0,26)+'...':rec.title}}</router-link></p>
                                    <!--<p class="product_serial">-->
                                        <!--<span class="product_serial_txt">产品编号:</span>-->
                                        <!--<span class="product_serial_num">{{rec.asin}}</span>-->
                                    <!--</p>-->
                                    <span class="merchant_name">
                                        <i class="icon icon_merchant"></i>
                                        <span class="product_merchant"><router-link to="/merchantHomePage">{{rec.name}}</router-link></span>
                                    </span>
                                    <span class="product_rate">
                                        <el-rate
                                                v-model="rec.score"
                                                disabled
                                                :colors='["#15bafe","#15bafe","#15bafe"]'
                                                disabled-void-color="#ccc"
                                                score-template="{value}">
                                        </el-rate>
                                    </span>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="type_nav">
                        <div class="nav_item" :class="{active:typeIndex===i}" v-for="(t,i) in type" :key="i" @click="typeClick(t.name,i)">
                            <div class="nav_type_img_box">
                                <i class="icon" :style="'background:url('+t.pic+') center center no-repeat'"></i>
                            </div>
                            <p class="nav_type_txt">{{t.name}}</p>
                        </div>
                        <div></div>
                        <div></div>
                    </div>
                </div>
                <div class="hot_product">
                    <div class="hot_title">
                        <i class="icon icon_hot"></i>
                        <span class="hot_title_txt">热门商品</span>
                    </div>
                    <div class="hot_product_list">
                        <ul class="figure_list" @mouseleave="pauseVideos">
                            <li class="product_list_item" v-for="(h,index) in hot" :key="index">
                                <div class="product_thumbnail" :class="{background:hotIndex===index}" @mouseenter="playVideo(h.video,index,$event,'hot')" @mouseleave="pauseVideos">
                                    <router-link :to="'/home/product-detail/'+h.product_id">
                                        <img class="product_thumbnail_img" :src="'http://cdn.kushualab.com/'+h.show_picture" alt="" v-show="!(hotIndex===index)">
                                        <video :src="'http://cdn.kushualab.com/'+h.video" class="product_thumbnail_video" v-show="hotIndex===index" @timeupdate="updateTime"></video>
                                        <div class="video_progress_box" v-show="hotIndex===index">
                                            <div class="video_progress" :style='"width:"+currentTime*40+"px"'></div>
                                        </div>
                                    </router-link>
                                </div>
                                <div class="product_info">
                                    <p class="product_sell_info" v-show="hidePayment">
                                        <span class="product_price"><span class="product_price_symbol">¥</span>{{Number(h.price).toFixed(2)}}</span>
                                        <span class="product_sales">{{h.sell_num}}人购买</span>
                                    </p>
                                    <p class="product_title"><router-link :to="'/home/product-detail/'+h.product_id" :title="h.title">{{h.title.length>26?h.title.slice(0,26)+'...':h.title}}</router-link></p>
                                    <!--<p class="product_serial">-->
                                        <!--<span class="product_serial_txt">产品编号:</span>-->
                                        <!--<span class="product_serial_num">{{h.asign}}</span>-->
                                    <!--</p>-->
                                    <span class="merchant_name">
                                        <i class="icon icon_merchant"></i>
                                        <span class="product_merchant"><router-link to="/merchantHomePage">{{h.name}}</router-link></span>
                                    </span>
                                    <span class="product_rate">
                                        <el-rate
                                                v-model="h.score"
                                                disabled
                                                :colors='["#15bafe","#15bafe","#15bafe"]'
                                                disabled-void-color="#ccc"
                                                score-template="{value}">
                                        </el-rate>
                                    </span>
                                </div>
                            </li>
                        </ul>
                    </div>
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
        name: "storeIndex",
        data(){
            return {
                recommend:'',
                hot:'',
                videoIndex:null,
                hotIndex:null,
                currentTime:0,//播放进度
                type:[
                    {
                        name:'汽车',
                        pic:'/static/img/icon/car_1.png',
                        child:[
                            {
                                name:'汽车零件',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'电池',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',fifth:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',fifth:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',fifth:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',fifth:['保养零件','刹车']},
                                            {name:'灯泡',fifth:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',fifth:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',fifth:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',fifth:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'油',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'雨刮片',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'灯泡',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'配件和汽车护理',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'工具',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',fifth:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'性能改装',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            },
                            {
                                name:'雨刮片',
                                child:[
                                    {
                                        name:'车载技术',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车清洁',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'饰品',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'汽车维修',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'润滑剂和添加剂',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'零部件',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                    {
                                        name:'锁和个人保护设备',
                                        child:[
                                            {name:'空调维修',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'通用雨刮片',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'电池维护',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'油漆和底漆',child:['保养零件','刹车']},
                                            {name:'灯泡',child:['保养零件','刹车','发动机零件','悬挂和转向']},
                                            {name:'胶粘剂，胶带和密封剂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动']},
                                            {name:'维护液和润滑脂',child:['保养零件','刹车','发动机零件','悬挂和转向','传动','冷却和加热']},
                                            {name:'保护',child:['保养零件','刹车']},
                                        ]
                                    },
                                ]
                            }
                        ]
                    },
                    {
                        name:'摩托车',
                        pic:'/static/img/icon/motorcycle_1.png',
                        child:[]
                    },
                    {
                        name:'无人机',
                        pic:'/static/img/icon/plane_1.png',
                        child:[]
                    }
                ],
                typeIndex:null,
                secondIndex:null,
                thirdlyIndex:0,
                defaultSelected:0,
                typeTxt:'',//一级分类
                secondTxt:'',//二级分类
                thirdlyTxt:'',//三级分类
                fourthlyTxt:'',//四级分类
                fifthTxt:'',//五级分类
                secondWidth:0,
                thirdlyWidth:0,
                fourthlyWidth:0,
                floatingWidth:0,
                left:0,
                hidePayment:false,//隐藏支付相关
            }
        },
        components:{
            FloatingDiv
        },
        methods:{
            /***************************视频播放*************************/
            playVideo(video,index,event,type){//播放视频
                if(video) {
                    if(type==='recommend') {
                        this.videoIndex = index;
                    }else{
                        this.hotIndex = index
                    }
                    let $myVid=$(event.currentTarget).find('video');
                    this.currentTime=0;
                    $myVid[0].currentTime=0;
                    $myVid[0].play();
                }else{
                    this.videoIndex=null;
                    this.hotIndex=null;
                }
            },
            // pauseVideo(i){//暂停并重置当前视频
            //     this.videoIndex = null;
            //     this.hotIndex = null;
            //     let video=$('.product_thumbnail_video')[i];
            //     video.currentTime=0;
            //     video.pause();
            //     this.currentTime=0;
            // },
            pauseVideos(){//暂停并重置所有视频
                let $video=$('.product_thumbnail_video');
                for(let item of $video){
                    item.currentTime=0;
                    item.pause();
                }
                this.currentTime=0;
                this.videoIndex=null;
                this.hotIndex=null;
            },
            updateTime(e){//播放进度
                if(e.target.currentTime>=5){
                    e.target.currentTime=0;
                    e.target.pause();
                    this.videoIndex=null;
                    this.hotIndex=null;
                }
                this.currentTime=e.target.currentTime;
            },
            /***************************分类搜索*************************/
            typeClick(type,i){
                this.typeIndex=i;
                this.typeTxt=type;
                console.log(this.typeTxt);
            },
            secondClick(sec,i,e){
                if(i>=0) {
                    if(this.secondIndex===i){
                        this.secondIndex=null;
                    }else {
                        this.secondIndex = i;
                        this.secondTxt = sec.name;
                        this.secondWidth = parseFloat(getComputedStyle(e.currentTarget)['width']);
                        this.thirdlyTxt=sec.child[0].name;
                        console.log(this.thirdlyTxt);
                        console.log(this.secondIndex);
                        console.log(this.secondTxt);
                    }
                }else{
                    this.secondIndex=null
                }
            },
            thirdlySelected(th,i){
                this.thirdlyIndex=i;
                this.thirdlyTxt=th;
                this.defaultSelected=i;
                console.log(this.thirdlyTxt);
            },
            fourthlyClick(four,id){
                this.fourthlyTxt=four;
                console.log(this.fourthlyTxt);
                this.$router.push({
                    name: 'productClassify',
                    query: {
                        type:this.typeTxt,
                        second:this.secondTxt,
                        thirdly:this.thirdlyTxt,
                        fourthly:this.fourthlyTxt,
                        fifth:this.fifthTxt,
                        active:0,
                        category_id:id,
                        prevId:null
                    }
                })
            },
            fifthClick(four,fif,pid,id){
                this.fourthlyTxt=four;
                this.fifthTxt=fif;
                console.log(this.fifthTxt);
                this.$router.push({
                    name: 'productClassify',
                    query: {
                        type:this.typeTxt,
                        second:this.secondTxt,
                        thirdly:this.thirdlyTxt,
                        fourthly:this.fourthlyTxt,
                        fifth:this.fifthTxt,
                        active:1,
                        category_id:id,
                        prevId:pid
                    }
                })
            },
            // toClassify(){
            //     this.$router.push({
            //         name: 'productClassify',
            //         params: {
            //             type:this.typeTxt,
            //             second:this.secondTxt,
            //             thirdly:this.thirdlyTxt,
            //             fourthly:this.fourthlyTxt,
            //             fifth:this.fifthTxt
            //         }
            //     })
            // }
        },
        watch:{
            secondIndex:function(val,oldVal){//分类下拉框显示位置
                this.$nextTick(function () {
                    // DOM 更新了
                    this.floatingWidth=$('.type_floating').width();
                    let index=this.secondIndex;
                    let sWidth=this.secondWidth;
                    let fWidth=this.floatingWidth;
                    console.log(index, sWidth, fWidth);
                    if(index*sWidth+fWidth<=1200){
                        this.left=index*sWidth;
                    }else if(index*sWidth<fWidth){
                        this.left=((index+0.5)*sWidth+fWidth/2)<1200?(index+0.5)*sWidth-fWidth/2:1200-fWidth;
                    }else{
                        this.left=(index+1)*sWidth-fWidth
                    }
                })
            }
        },
        mounted(){
            /****获取初始数据****/
            this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'products/list')
                .then((res)=>{
                    let {code,data,msg} =res.data;
                    if(code===200){
                        this.recommend=data.promotedProducts.slice(0,10);
                        this.hot=data.hotProducts.slice(0,10);
                        console.log(res);
                    }
                })
                .catch((err)=>{
                    console.log(err);
                });
            /****获取类别列表****/
            let token=window.localStorage.getItem('token');
            this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'category/getList',{
            params: {
                    token: token
                }
            })
                .then((res)=>{
                    let {code,data} = res.data;
                    if(code===200) {
                        this.type = data;
                    }
                    console.log(res);
                })
                .catch((err)=>{
                    console.log(err);
                })
        },
    }
</script>

<style scoped>
    .store_index{
        position:relative;
        background:#f2f2f2;
    }
    .store_index .store_nav_head{
        width:100%;
        line-height:40px;
        margin-bottom:10px;
        text-align:center;
        background:#f2f2f2;
    }
    .store_index .store_nav_head .store_nav_head_list{
        animation:background .5s ease 1s forwards;
    }
    .store_index .store_nav_list{
        display:flex;
        justify-content:center;
        max-width:1200px;
        min-width: 960px;
        height:0;
        margin:0 auto;
        overflow:hidden;
        padding:0 .05px;
        animation:navShow .5s ease 1s forwards;
    }
    .store_index .store_nav_head .borderBottom{
        width:0;
        height:2px;
        margin:0 auto;
        background:#15bafe;
        animation:borderShow 1s ease-out forwards;
    }
    /******顶部导航动画********************/
    @keyframes navShow{
        0%{
            height: 0;
        }
        100%{
            height: 40px;
        }
    }
    @keyframes borderShow{
        0%{
            width:0;
        }
        99%{
            height:2px;
        }
        100%{
            width:100%;
            height:0;
        }
    }
    @keyframes background{
        0%{
            background:transparent;
        }
        100%{
            background:#15bafe;
        }
    }
    .store_index .nav_list_item{
        flex:1;
        position:relative;
        height:40px;
        line-height:40px;
        text-align:center;
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color:#fff;
        cursor:pointer;
        serviceComment-select:none;
    }
    .store_index .nav_list_item:hover{
        background:#19AAF5;
    }
    .store_index .nav_list_item.active{
        color:#15bafe;
        border-top:3px solid #484250;
        background:#fff!important;
    }
    .store_index .thirdly_nav{
        position:relative;
        width:1200px;
        margin:0 auto;
    }
    .store_index .type_floating{
        position:absolute;
        top:0;
        left:0;
        z-index:10;
    }
    .store_index .thirdly_nav_list{
        float:left;
        height:500px;
        background:#F2F5F6;
    }
    .store_index .thirdly_nav .thirdly_nav_item{
        position:relative;
        width:220px;
        height:50px;
        padding-left:23px;
        padding-right:15px;
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 50px;
        letter-spacing: 1px;
        color: #222222;
        text-align:left;
        cursor:pointer;
    }
    .store_index .thirdly_nav .thirdly_nav_item:hover,
    .store_index .thirdly_nav .thirdly_nav_item.active{
        color:#15bafe;
        background:#fff;
    }
    .store_index .thirdly_nav .thirdly_nav_item .el-icon-arrow-right{
        position:absolute;
        top:18px;
        right:0;
    }
    .store_index .fourthly_nav{
        float:left;
        width:680px;
        height:500px;
        background:#fff;
    }
    .store_index .fourthly_nav_list{
        display:flex;
        justify-content: normal;
        flex-wrap: wrap;
    }
    .store_index .fourthly_nav_list .fourthly_nav_item{
        width:170px;
        height:250px;
        padding:11px 0 0 22px;
        cursor:pointer;
    }
    .store_index .fourthly_nav_item .fourthly_menu{
        height:32px;
        padding-left:6px;
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #37313f;
        text-align:left;
        border-bottom:1px solid #eee;
    }
    .store_index .fourthly_nav_list .fourthly_menu:hover{
        color:#15bafe;
    }
    .store_index .fifth_nav_list .fifth_nav_item{
        height:23px;
        text-align:left;
        cursor:pointer;
    }
    .store_index .fifth_nav_list .fifth_nav_item:hover{
        color:#15bafe
    }
    .store_index .fifth_nav_list .fifth_nav_item_more{
        color:#15bafe;
    }
    .store_index .store_index_body{
        position:relative;
    }
    .store_index_body .recommend_product,
    .store_index_body .hot_product{
        max-width: 1200px;
      min-width: 960px;
        margin:0 auto;
        background:#fff;
        position:relative;
    }
    .store_index_body .recommend_product .recommend_title,
    .store_index_body .hot_product .hot_title{
        height:36px;
        line-height:36px;
        padding-left:29px;
    }
    .store_index_body .recommend_product .recommend_title_txt,
    .store_index_body .hot_product .hot_title_txt{
        font-size: 16px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #000000;
        vertical-align:middle;
    }
    .store_index_body .recommend_product .icon,
    .store_index_body .hot_product .icon{
        width:18px;
        height:18px;
        vertical-align:middle;
    }
    .store_index_body .hot_product{
        margin-top:45px;
    }
    .store_index_body .recommend_product_list .figure_list,
    .store_index_body .hot_product_list .figure_list{
        display:flex;
        justify-content:center;
        flex-wrap: wrap;
    }
    .store_index_body .product_list_item{
        display:inline-block;
        width:234px;
        height:320px;
        border:1px solid #ccc;
        border-bottom:none;
        border-left:none;
        margin-right:-1px;
        transition:all .1s ease-in-out;
    }
    .store_index_body .product_list_item:nth-child(5),
    .store_index_body .product_list_item:nth-child(10){
        border-right:none;
    }
    .store_index_body .product_list_item:hover{
        border:1px solid transparent;
        box-shadow: -3px 0 5px 0 rgba(160, 160, 160, 0.16),
            3px 0 5px 0 rgba(160, 160, 160, 0.16),
            0 3px 5px 0 rgba(160, 160, 160, 0.16),
            0 -3px 5px 0 rgba(160, 160, 160, 0.16);
        /*box-shadow: 1px 1px 17px 2px #e0e0e0;*/
      transform: scale(1.01);
      background: #fff;
      z-index: 1;
      margin-right: 0;
    }
    .store_index_body .product_list_item .product_thumbnail{
        position:relative;
        width:200px;
        height:200px;
        margin:14px auto 9px;
        text-align:center;
        overflow:hidden;
    }
    .store_index_body .product_list_item .product_thumbnail.background{
        background:#222;
    }
    .store_index_body .product_list_item .product_thumbnail_img{
        width:100%;
        height:100%;
        transition:all .2s ease-in-out;
    }
    .store_index_body .product_list_item .product_thumbnail_video{
        /*width:100%;*/
        height:100%;
        /*object-fit:fill;*/
    }
    .store_index_body .product_list_item .video_progress_box{
        position:absolute;
        bottom:0;
        width:200px;
        height:5px;
        background:#999;
    }
    .store_index_body .product_list_item .video_progress{
        height:5px;
        background:#15bafe;
    }
    .store_index_body .product_list_item .product_thumbnail_img:hover{
        -webkit-transform:scale(1.1);
        -moz-transform:scale(1.1);
        -ms-transform:scale(1.1);
        -o-transform:scale(1.1);
        transform:scale(1.1);
    }
    .store_index_body .product_list_item .product_info{
        width:200px;
        margin:0 auto;
    }
    .store_index_body .product_list_item .product_price{
        font-size: 16px;
        font-weight: normal;
        letter-spacing: 0;
        color: #15bafe;
    }
    .store_index_body .product_list_item .product_price .product_price_symbol{
        font-size:14px;
    }
    .store_index_body .product_list_item .product_info .product_title{
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 16px;
        letter-spacing: 0;
        color: #000000;
        margin-bottom:5px;
    }
    /*.store_index_body .product_list_item .product_info .product_serial{*/
        /*font-size: 12px;*/
        /*font-weight: normal;*/
        /*font-stretch: normal;*/
        /*line-height: 1;*/
        /*letter-spacing: 0;*/
        /*color: #a0a0a0;*/
        /*margin-bottom:8px;*/
    /*}*/
    .store_index_body .product_list_item .product_info .product_rate{
        display:inline-block;
    }
    .store_index_body .product_list_item .product_info .product_sales{
        position:relative;
        top:8px;
        float:right;
        font-size: 12px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 20px;
        letter-spacing: 0;
        color: #a0a0a0;
    }
    .store_index_body .product_list_item .product_info .merchant_name{
        vertical-align:middle;
    }
    .store_index_body .product_list_item .product_info .merchant_name .icon_merchant{
        width:20px;
        height:20px;
    }
    .store_index_body .product_list_item .product_info .merchant_name .product_merchant a{
        color:#a0a0a0;
        text-decoration:underline;
    }
    .store_index_body .product_list_item .product_info .merchant_name .product_merchant a:hover{
        color:#15bafe;
    }
    /***********************侧边类别导航***********************/
    .store_index .type_nav{
        position:absolute;
        top:0;
        left:-97px;
    }
    .store_index .nav_item{
        padding:16px 15px 7px;
        text-align:center;
        cursor:pointer;
        border-bottom:2px solid transparent;
        box-sizing:border-box;
    }
    .store_index .type_nav .nav_type_img_box{
        width:56px;
        height:56px;
        overflow:hidden;
    }
    .store_index .type_nav .icon{
        position:relative;
        width:56px;
        height:56px;
        margin-bottom:8px;
    }
    .store_index .type_nav .nav_type_txt{
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #6d6d6d;
        text-align:center;
    }
    .store_index .nav_item:hover{
        background:#fff;
    }
    .store_index .nav_item.active{
        border-bottom:2px solid #15bafe;
        background:#fff;
    }
    .store_index .nav_item:hover .icon{
        left:-56px;
        /*border-right:56px solid transparent;*/
        -webkit-filter:drop-shadow(56px 0 0 #15bafe);
        filter:drop-shadow(56px 0 0 #15bafe);
    }
    .store_index .nav_item.active .icon{
        left:-56px;
        -webkit-filter:drop-shadow(56px 0 0 #15bafe);
        filter:drop-shadow(56px 0 0 #15bafe);
    }

    /*****顶部导航(960)*****/
    .store_index .type_nav_960{
        display:none;
        margin-bottom:10px;
    }
    .store_index .type_nav_960 .nav_item{
        display:inline-block;
        padding:5px 10px;
        border:1px solid #E4E4E4;
    }
    .store_index .type_nav_960 .nav_item.active{
        border-color:#fff;
        border-bottom:2px solid #15bafe;
        background:#fff;
    }
    .store_index .type_nav_960 .nav_item:nth-child(2),
    .store_index .type_nav_960 .nav_item:nth-child(3),
    .store_index .type_nav_960 .nav_item:last-child{
        border-left:none;
    }
    .store_index .type_nav_960 .nav_type_img_box{
        display:inline-block;
    }
    .store_index .type_nav_960 .nav_type_txt{
        display:inline-block;
        font-size:14px;
    }
    .store_index .type_nav_960 .icon{
        position:relative;
        width:21px;
        height:21px;
        margin-right:8px;
    }
    .store_index .type_nav_960 .nav_item:hover .icon{
        left:-21px;
        /*border-right:56px solid transparent;*/
        -webkit-filter:drop-shadow(21px 0 0 #15bafe);
        filter:drop-shadow(21px 0 0 #15bafe);
    }
    .store_index .type_nav_960 .nav_item.active .icon{
        left:-21px;
        -webkit-filter:drop-shadow(21px 0 0 #15bafe);
        filter:drop-shadow(21px 0 0 #15bafe);
    }

    /***************960兼容****************/
    @media screen and (max-width: 1180px) and (min-width: 960px) {
        .store_index_body .product_list_item:nth-child(4),
        .store_index_body .product_list_item:nth-child(8){
            border-right:none;
        }
        .store_index_body .product_list_item:nth-child(5){
            border:1px solid #ccc;
            border-left: none;
        }
        .store_index_body .product_list_item:nth-child(9),
        .store_index_body .product_list_item:nth-child(10){
            display: none;
        }
        .store_index .type_nav{
            display:none;
        }
        .store_index .type_nav_960{
            display:block;
        }
        .appBackground{
            padding:20px 0;
        }
    }
    @media screen and (max-width: 960px) {

    }


</style>
<style>
    .store_index_body .product_list_item .product_info .product_rate .el-rate__icon{
        font-size:16px!important;
        margin-right:0!important;
    }
    .store_index_body .product_list_item .product_info .product_rate{
        position:relative;
        top:3px;
        float:right;
    }
</style>
