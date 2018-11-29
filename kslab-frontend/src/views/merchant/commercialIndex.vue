<template>

  <div class="commercialIndex appBackground">
    <commerInfoHeader></commerInfoHeader>

    <div class="commercialIndex_box width_1200">
      <div class="commercialIndex_box_chart">
        <div class="commercialIndex_box_chart_fuel">
          <div class="commercialIndex_fuel_box">


            <div class="commercialIndex_box_chart_fuel_schedule" :style="'top:'+(100-data.fuel%100)+'%'">
              <div class="commercialIndex_box_chart_fuel_schedule_toDay">
                <span>今日增长{{data.fuel_increase>=0?'+'+data.fuel_increase:data.fuel_increase}}</span>
                <p><i></i></p>
              </div>
            </div>
          </div>
          <div class="commercialIndex_box_chart_fuel_mask">

            <div class="commercialIndex_box_chart_fuel_mask_title">
              <p>商家燃料量</p>
              <span><i></i>燃料量代表您当前的综合影响力</span>
            </div>

            <div class="commercialIndex_box_chart_fuel_mask_line">

              <ul>
                <li v-for="(item,index) in fuel" :key="index"><i></i>{{item}}<span>mj</span></li>
              </ul>

            </div>

            <div class="commercialIndex_box_chart_fuel_mask_nbm"><p>{{data.fuel===null?0:data.fuel}}<span>mJ</span></p></div>

          </div>
        </div>

        <div class="commercialIndex_box_statistics">

          <ul>
            <li>
              <div>
                <p>{{praiseTotal}}</p>
                <span>被赞次数</span>
              </div>
              <i class="commercialIndex_icon icon icon-ziyuan10"></i>

              <div class="prompt">
                <el-tooltip placement="left" effect="light" popper-class="prompt_box">
                  <div slot="content"><p class="prompt_text">此处被赞数，是所有上传的文章、视频、百科、问题被点赞次数相加所得次数。</p></div>
                  <i class="icon icon-ziyuan32"></i>
                </el-tooltip>
              </div>
            </li>
            <li>
              <div>
                <p>{{uploadTotal}}</p>
                <span>上传量</span>
              </div>
              <i class="commercialIndex_icon icon icon-ziyuan33"></i>

              <div class="prompt">
                <el-tooltip placement="left" effect="light" popper-class="prompt_box">
                  <div slot="content"><p class="prompt_text">此处上传量，是根据上传的文章、视频、百科、问题总数量相加所得。</p></div>
                  <i class="icon icon-ziyuan32"></i>
                </el-tooltip>
              </div>
            </li>
            <li>
              <div>
                <p>{{viewsTotal}}</p>
                <span>浏览量</span>
              </div>
              <i class="commercialIndex_icon icon icon-ziyuan37"></i>

              <div class="prompt">
                <el-tooltip placement="left" effect="light" popper-class="prompt_box">
                  <div slot="content"><p class="prompt_text">此处浏览量，是根据所有上传的文章、视频、百科、问题浏览量相加所得。</p></div>
                  <i class="icon icon-ziyuan32"></i>
                </el-tooltip>
              </div>
            </li>
          </ul>

        </div>

      </div>

      <div class="commercialIndex_box_center">
        <ul>
          <li>
            <div>
              <p>{{store.praise}}<span>/次好评</span></p>
              <p>商城</p>
            </div>
            <div>
              <el-progress :stroke-width="27" :percentage="store.percent" color="#009efb" :show-text="false"></el-progress>
              <p>{{store.percent}}%<span>好评率</span></p>
            </div>
          </li>

          <li>
            <div>
              <p>{{activity.praise}}<span>/次好评</span></p>
              <p>活动</p>
            </div>
            <div>
              <el-progress :stroke-width="27" :percentage="activity.percent" color="#55ce63" :show-text="false"></el-progress>
              <p>{{activity.percent}}%<span>好评率</span></p>
            </div>
          </li>

          <li>
            <div>
              <p>{{service.praise}}<span>/次好评</span></p>
              <p>服务</p>
            </div>
            <div>
              <el-progress :stroke-width="27" :percentage="service.percent" color="#ffbc34" :show-text="false"></el-progress>
              <p>{{service.percent}}%<span>好评率</span></p>
            </div>
          </li>

        </ul>

      </div>


      <div class="commercialIndex_box_main">
        <div class="commercialIndex_box_main_left">
          <div class="commercialIndex_box_main_left_fans">
            <div class="commercial_main_left_title">
              <div>
                <p>{{Number(data.fans_total)}}</p>
                <span>粉丝</span>
              </div>
            </div>

            <div class="commercial_main_left_tab">

              <el-tabs v-model="activeName" @tab-click="handleClick">
                <el-tab-pane label="性别" name="sex">
                  <div class="commercial_main_left_tab_sex">

                    <div class="commercial_main_left_tab_sex_box">

                      <div :style="'width:'+femalePercent+'%'" :class="{'right_radius':malePercent<=0 && othersPercent<=0}">
                        <span>{{femalePercent}}%</span>
                        <div>
                          <p>女性</p>
                          <span></span>
                        </div>
                      </div>

                      <div :style="'width:'+malePercent+'%'" :class="{'right_radius':othersPercent<=0,'left_radius':femalePercent<=0}">
                        <span>{{malePercent}}%</span>
                        <div>
                          <p>男性</p>
                          <span></span>
                        </div>
                      </div>

                      <div :style="'width:'+othersPercent+'%'" :class="{'left_radius':malePercent<=0 && femalePercent<=0}">
                        <span>{{othersPercent}}%</span>
                          <div>
                            <p>保密</p>
                            <span></span>
                          </div>
                      </div>


                    </div>

                  </div>
                </el-tab-pane>
                <el-tab-pane label="喜好" name="second">喜好</el-tab-pane>
                <el-tab-pane label="其他" name="third">其他</el-tab-pane>
              </el-tabs>

            </div>


          </div>

          <div class="commercialIndex_box_main_left_list">
            <i><img src="/static/img/icon/commercial_activity.png" alt=""></i>
            <div class="commercialIndex_box_main_left_list_schedule">
              <span>活跃度</span>
              <el-progress :percentage="liveness" color="#ffb22b"></el-progress>
            </div>

            <div class="prompt">
              <el-tooltip placement="left" effect="light" popper-class="prompt_box">
                <div slot="content"><p class="prompt_text">根据您回复私信所耗的平均时间。</p></div>
                <i class="icon icon-ziyuan32"></i>
              </el-tooltip>
            </div>
          </div>

          <div class="commercialIndex_box_main_left_list">
            <i><img src="/static/img/icon/commercial_upload.png" alt=""></i>
            <div class="commercialIndex_box_main_left_list_schedule">
              <span>上传完整度</span>
              <el-progress :percentage="upload_integrity" color="#745af2"></el-progress>
            </div>

            <div class="prompt">
              <el-tooltip placement="left" effect="light" popper-class="prompt_box">
                <div slot="content"><p class="prompt_text">根据您上传的视频、活动、服务、淘货、商城、文章和百科的完整进行一个评分。</p></div>
                <i class="icon icon-ziyuan32"></i>
              </el-tooltip>
            </div>
          </div>

        </div>

        <div class="commercialIndex_box_main_right">

          <div class="commercialIndex_right_title">
            <div><span><img src="/static/img/icon/commercial_hot.png" alt=""></span>最热门</div>
            <div class="commercialIndex_right_select">
                <el-select v-model="hotSelect" clearable placeholder="请选择" @change="hotChange">
                    <el-option
                            v-for="item in options"
                            :key="item.value"
                            :label="item.label"
                            :value="item.value">
                    </el-option>
                </el-select>
            </div>
            <div></div>
          </div>

          <div class="commercialIndex_right_main">

            <div class="commercialIndex_right_list" v-for="(tmp,index) in hotShow" :key="index">

              <div class="commercialIndex_right_list_icon">
                <span class="commercialIndex_icon_business" v-if="Number(tmp.type)===1">商</span>
                <span class="commercialIndex_icon_encyclopedia" v-else-if="Number(tmp.type)===2">服</span>
                <span class="commercialIndex_icon_activity" v-else-if="Number(tmp.type)===3">活</span>
                <span class="commercialIndex_icon_video" v-else-if="Number(tmp.type)===4">视</span>
                <span class="commercialIndex_icon_bargain" v-else>淘</span>
              </div>

              <div class="commercialIndex_right_list_name">
                <p>{{tmp.title}}</p>
                <span>访问量：{{tmp.view_num}}</span>
              </div>

              <div class="commercialIndex_right_list_time">{{tmp.created_at}}</div>

            </div>

          </div>

        </div>

      </div>

    </div>

    <!--侧边悬浮框-->
    <floating-div></floating-div>
    <!--尾部-->
  </div>

</template>

<script>
  import commerInfoHeader from '../../components/commercialInfoHeader'
  import FloatingDiv from "@/components/floating"

    export default {
      name: "commercialIndex",
      components:{
        commerInfoHeader,
        FloatingDiv,
      },
      data() {
        return {
          width:(document.documentElement.offsetWidth || document.body.offsetWidth)+17,//屏幕宽度,
          activeName: 'sex',
          data:{},//数据集合
          fuel:[100,80,60,40,20,0],//燃料坐标
          praiseTotal:0,
          uploadTotal:0,
          viewsTotal:0,
          store:{praise:0,total:0,percent:0}, //商品评价
          activity:{praise:0,total:0,percent:0},//活动评价
          service:{praise:0,total:0,percent:0},//服务评价
          malePercent:0,//男粉丝占比
          femalePercent:0,//女粉丝占比
          othersPercent:0,//保密粉丝占比
          hotSelect:'',//热门类别
          options:[
              {value:1,label:'商品'},
              {value:2,label:'服务'},
              {value:3,label:'活动'},
              {value:4,label:'视频'},
          ],//热门类别选项
          hotShow:[],//热门展示
          //活跃度
          liveness:0,
          //上传完整度
          upload_integrity:0,
        };
      },
      methods: {
        handleClick(tab, event) {

        },
        hotChange(){//热门类别改变事件
            console.log(this.hotSelect);
            let type;
            if(this.hotSelect===''){
                type=0
            }else{
                type=this.hotSelect
            }
            this.HttpClient.post('/web/user/hot',{type:type})
                .then(res =>{
                    console.log(res);
                    let {code,data} = res.data;
                    if(code===200){
                        this.hotShow=data.data;
                    }
                })
        }
      },
      created(){
          this.HttpClient.post('/web/user/company')
              .then(res =>{
                  console.log(res);
                  let {code,data} = res.data;
                  if(code === 200){
                      this.data = data;
                      /****燃料数据****/
                      // this.data.fuel=1450;
                      let num=parseInt(data.fuel/100)*100;
                      let arr=[];
                      arr.unshift(num);
                      arr.unshift(num+20);
                      arr.unshift(num+40);
                      arr.unshift(num+60);
                      arr.unshift(num+80);
                      arr.unshift(num+100);
                      this.fuel=arr;
                      /****数据统计****/
                      //总被赞数
                      this.praiseTotal=Number(data.question_like)+Number(data.article_like)+Number(data.video_like)+Number(data.encyc_like);
                      //总上传量
                      this.uploadTotal=Number(data.question)+Number(data.article_total)+Number(data.video_total)+Number(data.encyc_total);
                      //总浏览量
                      this.viewsTotal=Number(data.question_view)+Number(data.article_view)+Number(data.video_view)+Number(data.encyc_view);
                      /****评价****/
                      //商品评价
                      this.store.praise=Number(data.products_score_praise);
                      this.store.total=Number(data.products_score_answers);
                      this.store.percent=this.store.total>0?Number((this.store.praise/this.store.total).toFixed(1))*100:0;
                      //活动评价
                      this.activity.praise=Number(data.actives_score_praise);
                      this.activity.total=Number(data.actives_score_answers);
                      this.activity.percent=this.activity.total>0?Number((this.activity.praise/this.activity.total).toFixed(1))*100:0;
                      //服务评价
                      this.service.praise=Number(data.services_score_praise);
                      this.service.total=Number(data.services_score_answers);
                      this.service.percent=this.service.total>0?Number((this.service.praise/this.service.total).toFixed(1))*100:0;
                      /****粉丝数量****/
                      let male=Number(data.fans_male),
                          female=Number(data.fans_female),
                          others=Number(data.fans_other),
                          total=Number(data.fans_total);
                      this.malePercent=total>0?(male/total*100).toFixed(1):0;
                      this.femalePercent=total>0?(female/total*100).toFixed(1):0;
                      this.othersPercent=total>0?(others/total*100).toFixed(1):0;
                      // this.malePercent=100;
                      // this.femalePercent=0;
                      // this.othersPercent=0;
                      //活跃度
                      this.liveness=Number(data.liveness);
                      //上传完整度
                      this.upload_integrity=Number(data.upload_integrity)
                  }
              });

          /***热门***/
          this.hotChange()
      },
      mounted(){
        const that = this;
          window.onresize = function temp() {
            that.width = (document.documentElement.offsetWidth || document.body.offsetWidth)+17;
              console.log(that.width);
          };
      },
      watch:{
        width:function(){
          let praiseTotal=Number(this.data.question_like)+Number(this.data.article_like)+Number(this.data.video_like)+Number(this.data.encyc_like),
              uploadTotal=Number(this.data.question)+Number(this.data.article_total)+Number(this.data.video_total)+Number(this.data.encyc_total),
              viewsTotal=Number(this.data.question_view)+Number(this.data.article_view)+Number(this.data.video_view)+Number(this.data.encyc_view);
          if(this.width<=960){
              this.praiseTotal=praiseTotal>1000?(praiseTotal/1000).toFixed(1)+'K':praiseTotal;
              this.uploadTotal=uploadTotal>1000?(uploadTotal/1000).toFixed(1)+'K':uploadTotal;
              this.viewsTotal=viewsTotal>1000?(viewsTotal/1000).toFixed(1)+'K':viewsTotal
          }else{
              this.praiseTotal=praiseTotal;
              this.uploadTotal=uploadTotal;
              this.viewsTotal=viewsTotal
          }
        }
      }
    }
</script>

<style src="../../assets/css/commercialIndex.css"></style>
