<template>

  <div class="merchantHomePage appBackground">

    <div class="merchantHP_title">
      <div class="merchantHP_title_top">
        <div class="merchantHP_title_img"><img src="/static/img/others_banner.jpg" alt=""></div>
        <div class="merchantHP_title_userName width_1200">
          <div class="merchantHP_title_focus">
            <span>关注了</span>
            <p>89456</p>
          </div>
          <div class="merchantHP_title_avatar">
            <img src="/static/img/avatar/avatar.jpg" alt="">
          </div>
          <div class="merchantHP_title_fans">
            <span>关注者</span>
            <p>89456</p>
          </div>
        </div>
      </div>

      <div class="merchantHP_title_bottom">
        <h2>酷耍超级科技公司</h2>
        <p>重庆   大坪</p>
        <span>一万个小时的锤炼</span>
        <div class="merchantHP_title_btm">
          <button>+关注他</button>
          <button>发私信</button>
        </div>
      </div>

    </div>

    <div class="merchantHP_center">

      <el-tabs v-model="activeName" @tab-click="handleClick">
        <el-tab-pane label="公司简介" name="about">
          <div class="merchantHP_about">
            <div class="merchantHP_tab_title">
              <span></span>
              <p>公司特色</p>
              <p>Essential information</p>
            </div>

            <div class="merchantHP_characteristic">
              高层重视，注重总结与提升 | 快速响应市场需求 | 95%的订单能够在两天内完成发货 | 需求并迅速转化为产品版本 | 连续8年中国市场占有率第一 | 需求并迅速转化为产品版本 | 连续8年中国市场占有率第一
            </div>

            <div class="merchantHP_tab_title">
              <span></span>
              <p>公司介绍</p>
              <p>Company introductionn</p>
            </div>

            <div class="merchantHP_introduction">
              <!--轮播-->
              <div class="merchantHP_introduction_swiper">
                <swiper :options="swiperOptionTop" class="gallery-top" ref="swiperTop">
                  <swiper-slide class="slide-1"><img src="/static/img/a1.png" alt=""></swiper-slide>
                  <swiper-slide class="slide-2"><img src="/static/img/a2.png" alt=""></swiper-slide>
                  <swiper-slide class="slide-3"><img src="/static/img/a3.png" alt=""></swiper-slide>
                  <swiper-slide class="slide-4"><img src="/static/img/a4.png" alt=""></swiper-slide>
                </swiper>
                <!-- swiper2 Thumbs -->
                <swiper :options="swiperOptionThumbs" class="gallery-thumbs" ref="swiperThumbs">
                  <swiper-slide class="slide-1"><img src="/static/img/a1.png" alt=""></swiper-slide>
                  <swiper-slide class="slide-2"><img src="/static/img/a2.png" alt=""></swiper-slide>
                  <swiper-slide class="slide-3"><img src="/static/img/a3.png" alt=""></swiper-slide>
                  <swiper-slide class="slide-4"><img src="/static/img/a4.png" alt=""></swiper-slide>
                </swiper>
              </div>

              <div class="merchantHP_introduction_text">
                <div class="merchantHP_introduction_title">
                  <h2>KS-LAB超级公司</h2>

                  <div class="merchantHP_introduction_rate">
                    <el-rate
                      v-model="valueRate"
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      disabled>
                    </el-rate>
                  </div>
                </div>

                <div class="merchantHP_introduction_main">
                  得力集团始创于1988年，生产各类文具和办公用品，目前已成长为国内最大的综合文具供应商。
                  2010年荣获浙江名牌产品；浙江出口名牌；中国文教体育用品行业标准化工作先进企业；2011中国民营企业制造业500强第374位；
                  2012年荣获宁波市“百强企业”称号。<br /><br />

                  得力集团始创于1988年，历经20年的探索与拼搏，目前已成长为国内最大的综合文具供应商。<br /><br />

                  得力集团从20世纪90年代以来，连续保持高速增长，2007年全球营业收入超过12亿元人民币，5000多名员工遍布全国29个省市。
                  2001年起，得力集团每年均保持1亿元的年递增速度快速发展，2005年全年实现销售收入突破7亿。
                  2007得力集团成立了泰国销售分公司，标志着得力品牌已成功进入东南亚市场，也标志着得力的战略远景：
                  “让世界每个办公室都有得力”又成功的迈进了一大步。<br /><br />

                  作为中国最大的文具供应商，得力品牌先后获得“国家免检产品”、“中国文具十大品牌”、“中国出口名牌”、“中国最畅销文具品牌”、
                  “中国驰名商标”等荣誉称号，并先后通过ISO9001、ISO14000等体系认证。在未来，得力的发展目标是成为世界领先的综合文具供应商
                  ，创建具有全球竞争力的企业。
                </div>
              </div>
            </div>
          </div>
        </el-tab-pane>

        <el-tab-pane label="商城" name="mall">

          <div class="merchantHP_mall">
            <div class="merchantHP_mall_list">
              <div class="merchantHP_tab_title">
                <span></span>
                <p>汽车</p>
              </div>
              <merchantSwiperDiv></merchantSwiperDiv>
            </div>

            <div class="merchantHP_mall_list">
              <div class="merchantHP_tab_title">
                <span></span>
                <p>摩托车</p>
              </div>
              <merchantSwiperDiv></merchantSwiperDiv>
            </div>

            <div class="merchantHP_mall_list">
              <div class="merchantHP_tab_title">
                <span></span>
                <p>无人机</p>
              </div>
              <merchantSwiperDiv></merchantSwiperDiv>
            </div>

            <div class="merchantHP_mall_list">
              <div class="merchantHP_tab_title">
                <span></span>
                <p>智能设备</p>
              </div>
              <merchantSwiperDiv></merchantSwiperDiv>
            </div>
          </div>

        </el-tab-pane>

        <el-tab-pane label="服务" name="service">

          <div class="merchantHP_service">
            <div class="merchantHP_tab_title">
              <span></span>
              <p>TA的服务</p>
              <p></p>
            </div>

            <div class="merchantHP_list">
              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img"><img src="/static/img/userActivities_img.png" alt=""></div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>
            </div>

            <div class="merchantHP_list_pagination">
              <el-pagination
                small
                layout="prev, pager, next"
                :total="50">
              </el-pagination>
            </div>


          </div>

        </el-tab-pane>

        <el-tab-pane label="活动" name="activity">

          <div class="merchantHP_activity">
            <div class="merchantHP_tab_title">
              <span></span>
              <p>TA的服务</p>
              <p></p>
            </div>

            <div class="merchantHP_list">
              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

              <div class="merchantHP_list_box">
                <div class="merchantHP_list_img">
                  <img src="/static/img/userActivities_img.png" alt="">
                  <div class="merchantHP_list_time">
                    <p>7.30</p>
                  </div>
                </div>

                <div class="merchantHP_list_text">
                  <p>马利克洗车服务</p>
                  <div><span>&yen;</span>576</div>
                </div>

                <div class="merchantHP_List_bottom">
                  <div class="merchantHP_bottom_rate">
                    <el-rate
                      v-model="valueList"
                      disabled
                      :colors="['#15bafe', '#15bafe', '#15bafe']"
                      score-template="{value}">
                    </el-rate>
                  </div>
                  <div class="merchantHP_bottom_nbm">
                    <p><i class="icon icon-ziyuan59"></i>1231</p>
                    <p><i class="icon icon-ziyuan37"></i>1324</p>
                  </div>
                </div>

              </div>

            </div>

            <div class="merchantHP_list_pagination">
              <el-pagination
                small
                layout="prev, pager, next"
                :total="50">
              </el-pagination>
            </div>


          </div>

        </el-tab-pane>

        <el-tab-pane label="TA的上传" name="upload">TA的上传</el-tab-pane>

      </el-tabs>


    </div>

    <floatingDiv></floatingDiv>
  </div>

</template>

<script>
  import floatingDiv from '@/components/floating'
  import merchantSwiperDiv from '../merchant/merchantSwiper'
  import 'swiper/dist/css/swiper.css'
  import { swiper, swiperSlide } from 'vue-awesome-swiper'


    export default {
        name: "merchantHomePage",
      components:{
        floatingDiv,
        swiper,
        swiperSlide,
        merchantSwiperDiv
      },
      data() {
        return {
          activeName: 'about',   //tab页
          valueRate: 4,          //商家评分
          valueList:3,           //服务评分

          //公司简介轮播参数
          swiperOptionTop: {
            spaceBetween: 10,
            loop: true,
            loopedSlides: 5,
            observer:true,
            observeParents:true,
            autoplay: {
              autoplay:3000
            },
            watchSlidesVisibility: true,
          },
          swiperOptionThumbs: {
            spaceBetween: 10,
            slidesPerView: 4,
            touchRatio: 0.2,
            loop: true,
            loopedSlides: 5,
            slideToClickedSlide: true,
            observer:true,
            observeParents:true,
          },
        }
      },
      methods: {
        handleClick(tab, event) {

        }
      },

      mounted() {
        this.$nextTick(() => {
          const swiperTop = this.$refs.swiperTop.swiper
          const swiperThumbs = this.$refs.swiperThumbs.swiper
          swiperTop.controller.control = swiperThumbs
          swiperThumbs.controller.control = swiperTop
        })
      }

    }
</script>

<style src="../../assets/css/merchantHomePage.css"></style>
