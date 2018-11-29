<template>
  <div class="margin_top" v-if="videData" v-loading="loading">
    <section>
      <div class="mod_video">
        <div class="mod_video_show">
          <div id="video" class="mod_video_play">
            <div class="player">
              <video-player class="video-player vjs-custom-skin"
                            ref="videoPlayer"
                            :playsinline="true"
                            :options="playerOptions"
                            @play="onPlayerPlay($event)"
                            @pause="onPlayerPause($event)"
              >
              </video-player>
            </div>
          </div>
          <div class="mod_video_info">
            <praise-div :type="video" :index="0" :letType="1"></praise-div>
            <div class="video_info_detail">
              <p class="info_detail_title">{{videData.title}}</p>
              <p class="video_key_words">
                <keyword-install :keyword="videData.label"></keyword-install>
              </p>
              <p class="associated_part">
                所用零件/软件:
                <span class="associated_part_list">
                                    <a :href="u.url" v-for="(u,ui) in partUrl" :key="ui"
                                       class="associated_part_item router" target="_blank">{{u.partName}}</a>
                                    <span class="associated_part_item" v-for="(p,i) in part" :key="i+partUrl.length">{{p.partName}}</span>
                                </span>
              </p>
            </div>
            <div class="share_report">
              <p @click="shareModalShowTrue" class="share"><img src="/static/img/icon/share.png" alt="">分享</p>
              <p class="report" @click="reportModal"><span><img src="/static/img/icon/report.png" alt=""></span>举报</p>
              <ReportDialog @getReportVisible="getReportVisible" :reportVisible="reportVisible"
                            :serviceId="video_id"></ReportDialog>
              <shareModalDiv ref="shareModal"></shareModalDiv>
              <report-modal ref="reportModal"></report-modal>
            </div>
            <div class="video_views_uploadTime">
              <span class="video_views">{{videData.view_num}}次浏览</span>
              <span class="dot">·</span>
              <span class="video_uploadTime">{{handleDate(videData.created_at)}}</span>
            </div>
          </div>
          <div class="mod_video_describe">
            <div class="video_describe_head">
              <div class="describe_head_title">
                <div class="user_avatar">
                  <img :src="request.picUrl + videData.avatar" alt="" class="title_avatar">
                </div>
                <div class="head_title_info" @click="RouteUserIndex()">
                  <p class="head_title_actor">{{videData.nickname}}</p>
                  <p class="head_title_signature">
                                        <span class="describe_body_txt">{{videData.signature
}}</span>
                  </p>
                </div>
              </div>
              <div class="describe_head_btn">
                <a href="javascript:;" class="head_btn_attention" :class="{current:isCurrent}" v-if="!isFocus"
                   @click="attention">
                  +关注
                </a>
                <a href="javascript:;" class="head_btn_followed" v-if="isFocus" @click="clearAttention">
                  <i class="el-icon-success"></i>
                  已关注
                </a>
                <a href="javascript:;" class="head_btn_message" :class="{current:!isCurrent}">
                  <i class="icon icon_message"></i>
                  发私信
                </a>
              </div>
            </div>
            <div class="video_describe_body">
              <el-tabs type="border-card">
                <el-tab-pane label="介绍">
                  <span v-if="!showMore" v-html="videData.description">{{videData.description.length>168?videData.description.slice(0,167)+'...':videData.description}}</span>
                  <span v-if="showMore" v-html="videData.description"></span>
                  <button class="show_more_synopsis" :class="{more:showMore}" @click="showMoreSynopsis"
                          v-if="videData.description.length>168">
                    <i :class="{'el-icon-arrow-down':!showMore,'el-icon-arrow-up':showMore}"></i>
                  </button>
                </el-tab-pane>
                <el-tab-pane label="附件">
                  <activity-data-file :attachment="videData.attachment"></activity-data-file>
                </el-tab-pane>
              </el-tabs>
            </div>
          </div>
          <div class="mod_video_comment">
            <div class="video_comment_publish">
              <div class="article_details_comment">
                <div class="comment_avatar">
                  <img v-if="userImg" :src="request.picUrl + videData.avatar" alt="">
                  <img v-else src="/static/img/avatar/avatar.jpg" alt="">
                </div>
                <div class="comment_box">
                  <div class="comment_box_editor">
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
                  <div class="comment_box_btm">
                    <button @click="commentFontButton">提交</button>
                    <LoginWarning ref="modelDelet"></LoginWarning>
                  </div>
                </div>
              </div>
            </div>
            <div class="video_comment_figure">
              <div class="video_comment_head">
                <span class="video_comment_times" v-if="commentlist.length>0">{{commentTotal}}次评论</span>
                <span class="video_comment_sort">
                                    <i class="icon" :class="{'icon-ziyuan30':!isAsc,'icon-ziyuan29':isAsc}"
                                       @click="sortChange"></i>
                                    <el-select v-model="commentType" @change="handleCommentType" placeholder="默认排序">
                                        <el-option
                                          v-for="item in commentTypeOptions"
                                          :key="item.value"
                                          :label="item.label"
                                          :value="item.value">
                                        </el-option>
                                    </el-select>
                                </span>
              </div>
              <ul class="figure_list">
                <li class="list_item" v-for="(item,index) in videoCommentList" :key="index">
                  <div class="comment_title">
                    <div class="useratvast">
                      <img :src="request.picUrl + item.avatar" alt="" class="title_avatar">
                    </div>
                    <div class="comment_title_info">
                      <p class="comment_title_actor" @click="RouterIndexOu(index)">{{item.nickname}}</p>
                      <p class="comment_title_subtitle">{{item.signature}}</p>
                    </div>
                  </div>
                  <div class="comment_main">
                    <praise-div :type="comment" :index="index" :letType="2"></praise-div>
                    <div class="comment_main_txt" v-html="item.content">

                    </div>
                    <div class="comment_operation">
                                            <span class="comment_operation_num" @click="clickIndexComment(index)">
                                                <i class="icon icon_message"></i>
                                                <span class="comment_message_num">{{item.comment_num}}</span>
                                                条评论
                                            </span>
                      <span class="comment_operation_share cursor">
                                                <i class="icon icon-fenxiang"></i>
                                            </span>
                      <span class="comment_operation_report">
                                                <i class="icon icon-huaban" @click="reportModal"></i>
                                                <ReportDialog @getReportVisible="getReportVisible"
                                                              :reportVisible="reportVisible"
                                                              :serviceId="item.answer_id"></ReportDialog>
                                            </span>
                      <span class="comment_operation_time">
                                                <span class="comment_upload_time">{{handleDate(item.created_at)}}</span>
                                            </span>
                    </div>
                  </div>
                </li>
                <commnt-model ref="commentModal" v-if="outerVisible" :comments="commentLengthAswid"
                              :httpclosure="httpClosure"></commnt-model>
              </ul>
              <el-pagination
                background
                style="text-align: center"
                layout="prev, pager, next"
                @current-change="handleCommentPageChange"
                :page-size="5"
                :total="commentTotal">
              </el-pagination>
            </div>
          </div>
        </div>
        <!--<i class="mod_video_play"></i>-->
        <div class="mod_video_aside">
          <span class="video_aside_title">相关视频</span>
          <i class="border"></i>
          <div class="video_aside_figure">
            <ul class="aside_figure_list">
              <li class="list_item" v-for="(videoListRel ,index) in videoRelation" :key="index"
                  @click="relationRouterClick(index)">
                <a href="#">
                  <img :src="request.picUrl+videoListRel.cover" alt="" class="">
                  <span class="video_duration">3:00</span>
                </a>
                <div class="list_info">
                  <a href="#" class="list_info_title">{{videoListRel.title}}</a>
                  <p class="list_info_actor">
                    <span class="list_info_act">{{videoListRel.nickname}}</span>
                  </p>
                  <p class="list_info_views">
                    <span>{{videoListRel.view_num}}</span>
                    次观看
                  </p>
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
    <is-login ref="notLogin"></is-login>
  </div>
</template>

<script>
  import ReportDialog from '@/components/ReportDialog'
  import LoginWarning from "@/components/loginWarningModal"
  import FormatDate from "../../utils/GetDateUtils";
  import CommntModel from '@/components/commentModal'
  import 'video.js/dist/video-js.css'
  import 'vue-video-player/src/custom-theme.css'
  import 'videojs-contrib-hls.js/src/videojs.hlsjs'
  import KeywordInstall from '@/components/keywordInstall'
  import IsLogin from '@/components/isLogin'
  import FloatingDiv from '@/components/floating'
  import PraiseDiv from '@/components/praise'
  import ReportModal from '@/components/reportModal'
  import ShareModalDiv from '@/components/shareModal'
  import ActivityDataFile from '@/views/activity/actvityDataFlie'

  import {quillEditor} from 'vue-quill-editor'
  import * as Quill from 'quill'  //引入编辑器

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

  import {container, ImageExtend, QuillWatch} from 'quill-image-extend-module'

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
    name: "videoDetail",
    data() {
      return {
        reportVisible: false,
        video: [
          {
            'type': 'video',
            id: this.$route.query.video,
            praise: 0,
            state: 0
          }
        ],
        comment: [],
        praiseTimes: 0,
        trampleTimes: 0,
        loading: true,
        isCurrent: true,
        isFocus: false,
        part: [],
        partUrl: [],
        synopsis: '被视为天赋异禀的少年武者萧炎，九岁时母亲被人追杀致死，父亲讳莫如深，萧炎将母亲留给他的戒指视为珍宝从不离身。萧炎的功力一直到十五岁仍然没有进步，早已订好婚约的家族也来退婚，令萧家蒙受奇耻大辱。萧炎无意中唤醒了戒指被视为天赋异禀的少年武者萧炎，九岁时母亲被人追杀致死，父亲讳莫如深，萧炎将母亲留给他的戒指视为珍宝从不离身。萧炎的功力一直到十五岁仍然没有进步，早已订好婚约的家族也来退婚，令萧家蒙受奇耻大辱。萧炎无意中唤醒了戒指被视为天赋异禀的少年武者萧炎，九岁时母亲被人追杀致死，父亲讳莫如深，萧炎将母亲留给他的戒指视为珍宝从不离身。萧炎的功力一直到十五岁仍然没有进步，早已订好婚约的家族也来退婚，令萧家蒙受奇耻大辱。萧炎无意中唤醒了戒指',
        showMore: false,
        content: null,     //文本框内容
        updateUrl: '',
        /*editorOption: {
          modules: {
            toolbar: {
              container: toolbarOptions,
              handlers: {
                'image': function () {  // 劫持原来的图片点击按钮事件
                  QuillWatch.emit(this.quill.id)
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
              start: () => {
              },  //自定义开始上传触发事件
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
        },*/
        editorOption: {
          modules: {
            toolbar: {
              container: toolbarOptions,
              handlers: {
                'image': function (value) {
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
        commentTypeOptions: [{
          value: 1,
          label: '评论时间'
        }, {
          value: 2,
          label: '点赞人数'
        }],
        value: '',
        isAsc: false,
        videData: {},  //详情页数据
        videoRelation: null,  //视频相关
        playerOptions: {
          playbackRates: [0.7, 1.0, 1.5, 2.0], //播放速度
          autoplay: false, //如果true,浏览器准备好时开始回放。
          controls: true, //控制条
          preload: 'auto', //视频预加载
          muted: false, //默认情况下将会消除任何音频。
          loop: false, //导致视频一结束就重新开始。
          language: 'zh-CN',
          aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
          fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
          sources: [{
            type: '',
            src: 'https://video-dev.github.io/streams/x36xhzz/x36xhzz.m3u8'
          }],
          poster: "http://static.smartisanos.cn/pr/img/video/video_03_cc87ce5bdb.jpg", //你的封面地址
          width: document.documentElement.clientWidth,
          height: 420,
          notSupportedMessage: '此视频暂无法播放，请稍后再试' //允许覆盖Video.js无法播放媒体源时显示的默认信息。
        },
        like: null,   //视频点赞数
        commentlist: null,     //视频评论列表
        commentLength: null,      //评论列表数
        outerVisible: false,
        commentLengthAswid: null, //视频id
        httpClosure: {
          //视频回复列表
          reply: this.request.axiosPort + this.request.axiosApi + 'videos/reply/list',
          //视频添加回复接口
          add: this.request.axiosPort + this.request.axiosApi + 'videos/add/reply',
          //评论查看对话
          info: this.request.axiosPort + this.request.axiosApi + 'videos/reply/info',
        },
        statusJstas: false,   //状态判断
        video_id: null,
        userImg: null,
        commentPage: 1, //评论页数
        commentPageSize: 5, //评论条数
        videoCommentList: [], //视屏评论列表
        commentType: 1, //1根据创建时间 2根据点赞数
        commentOrder: 1, //1.逆序，其他为正序
        videoId: '', //视屏id
        commentTotal: null, //评论总条数
      }
    },
    components: {
      IsLogin,
      FloatingDiv,
      PraiseDiv,
      ReportModal,
      ShareModalDiv,
      ActivityDataFile,
      KeywordInstall,
      CommntModel,
      LoginWarning,
      ReportDialog
    },
    created() {
      this.videoId = this.$route.query.video;
      console.log(this.videoId)
      if (window.localStorage.token) {
        console.log("you")
        this.userImg = true
      } else {
        console.log("wu")
        this.userImg = false
      }

      this.videoDataCont();
      this.video_id = this.$route.query.video;
      const param = {
        video_id: this.videoId,
        page_size: this.commentPageSize,
        page: this.commentPage,
        type: this.commentType,
        order: this.commentOrder
      };
      this.getVideoCommentList(param);
    },
    methods: {
      // 打开举报框
      handleOpenReport() {
        this.reportVisible = true;
      },
      /***
       * 回调举报
       * @param value
       */
      getReportVisible(value) {
        this.reportVisible = value;
      },
      RouteUserIndex() {
        this.RouterLinkOther(this.videData.uid)
      },
      handleDate(date) {
        return FormatDate.GetDate(date);
      },
      clickIndexComment(index) {
        if (this.outerVisible == false) {
          this.commentLengthAswid = this.commentlist[index].answer_id
          this.outerVisible = true
        } else {
          this.outerVisible = false
        }
      },
      likeIndexClick() {
        this.HttpClient.post('/videos/upvote', {
          token: window.localStorage.token,
          source_id: this.videData
        })
      },
      //暂停时
      onPlayerPause() {

      },
      //播放时
      onPlayerPlay() {

      },
      videoDataCont() {
        //相关视频数据接口
        this.HttpClient.post('/videos/relation', {
          video_id: this.$route.query.video
        })
          .then((res) => {
            // console.log(res)
          })

        //视频详情数据口子
        this.HttpClient.post('/videos/info', {
          video_id: this.$route.query.video
        })
          .then((res) => {
            console.log(res)
            this.videData = res.data.data
            console.log(this.videData.like_num)
            this.video[0].praise = this.videData.like_num
            this.videData.attachment = res.data.data.attachment;
            this.playerOptions.sources = this.request.picUrl + this.videData.video_url
            this.playerOptions.poster = this.request.picUrl + this.videData.cover

            //此视频详情点赞数量

            //判断用户是否关注此视频发布者
            this.HttpClient.post('/other/isfollow', {
              uid: this.videData.uid,
              token: window.localStorage.token
            })
              .then((res) => {
                // console.log(res)
                if (res.data.status === 1) {
                  this.isFocus = true;
                } else {
                  this.$refs.notLogin.showModal = false;
                }
              })

            //视频评论列表
            this.HttpClient.post('/videos/comment', {
              video_id: this.$route.query.video
            })
              .then((res) => {
                console.log(this.commentlist)
                this.commentlist = res.data.data.data
                console.log(this.commentlist)
                for (var i = 0; i < this.commentlist.length; i++) {
                  this.comment.push({
                    type: 'comment',
                    name: this.commentlist[i].nickname,
                    id: this.commentlist[i].answer_id,
                    praise: this.commentlist[i].like_num,
                    state: 0
                  })
                  console.log(this.comment)
                }
                console.log(this.commentlist)
                this.commentLength = res.data.data.length
              })
            //循环剔除无链接和有链接
            for (var i = 0; i < this.videData.source.length; i++) {
              if (this.videData.source[i].link == "") {
                this.part.push({
                  partName: this.videData.source[i].name
                })
              } else {
                this.partUrl.push({
                  partName: this.videData.source[i].name,
                  url: this.videData.source[i].link
                })
              }
            }
            this.loading = false
            // console.log(this.videData)
          })

        //获取右边相关视频口子
        this.HttpClient.post('/videos/relation', {
          video_id: this.$route.query.video
        })
          .then((res) => {
            this.videoRelation = res.data.data
            console.log(this.videoRelation)
          })
      },
      //点击关注
      attention() {
        if (this.isFocus == false) {
          this.HttpClient.post('/other/changefollow', {
            uid: this.videData.uid,
            token: window.localStorage.token
          })
            .then((res) => {
              this.$message({
                message: res.data.msg,
                type: 'success'
              });
              if (res.data.code === 200) {
                this.isFocus = true;
              } else {
                this.$refs.notLogin.showModal = false;
              }
            })
            .catch((err) => {
              this.userIfStatus(err)
            })
        }
      },
      clearAttention() {
        //已关注点击取消
        if (this.isFocus == true) {
          this.HttpClient.post('/other/changefollow', {
            uid: this.videData.uid,
            token: window.localStorage.token
          })
            .then((res) => {
              this.$message({
                message: res.data.msg,
                type: 'success'
              });
              if (res.data.code === 200) {
                this.isFocus = false;
              } else {
                this.$refs.notLogin.showModal = true;
              }
            })
        }
      },
      report() {
        this.$confirm('确认举报该评论?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$message({
            type: 'success',
            message: '已举报!'
          });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消!'
          });
        });
      },
      shareModalShowTrue() {
        if (!this.$refs.shareModal.modelDelete) {
          this.$refs.shareModal.show();
        }
      },
      reportModal() {
        this.reportVisible = true
        let token = window.localStorage.getItem('token');
        // this.$ajax.post('http://test.kslab.com/api/islogin',{
        //     token:token
        // })
        //     .then((res)=>{
        //         console.log(res);
        //         console.log(res.data);
        //         if(res.data.code===200) {
        //             if(!this.$refs.reportModal.modelReport){
        //                 this.$refs.reportModal.modelReport=true
        //             }
        //         }else{
        //             this.$message.warning('你还没有登录')
        //         }
        //     })
        //     .catch(function(res){
        //         console.log(res);
        //     });
      },
      showMoreSynopsis() {
        this.showMore = !this.showMore;
      },
      /**编辑器**/
      onEditorBlur() {//失去焦点事件
      },
      onEditorFocus() {//获得焦点事件
      },
      onEditorChange(e, decimalNum) {//内容改变事件
        //this.content = event.html
        console.log(this.content)
        let lengthcontent = this.content;
        function removeHTMLTag(str) {
          //var str;
          str = str.replace(/<\/?[^>]*>/g, ''); //去除HTML tag
          str = str.replace(/[ | ]*\n/g, '\n'); //去除行尾空白
          str = str.replace(/\n[\s| | ]*\r/g, '\n'); //去除多余空行
          str = str.replace(/ /ig, '');//去掉
          return str;
        }
        console.log(removeHTMLTag(lengthcontent).length)
        e.quill.deleteText(decimalNum, 1);//保留 strValue 的 前 decimalNum 位字符，
        this.$emit('Quescthon', this.content)
        console.log(this.content);
        if (removeHTMLTag(lengthcontent).length < 1001) {

        } else {
          this.$message.error('字数超过限制');
        }
      },
      /*****
       * 提交视屏评论
       */
      commentFontButton() {
        //添加视频评论
        if (window.localStorage.token) {
          if (this.content == null || this.content == '') {
            console.log("内容不能为空哦");
            this.$message.warning('评论内容不能为空！')
          }else {
            const param = {
              video_id: this.videoId,
              content: this.content
            };
            this.HttpClient.post('/videos/add/comment', param)
              .then((res) => {
                console.log(res)
                if (res.data.code === 200) {
                  const quill = this.$refs['myQuillEditor'].quill;
                  quill.container.querySelector('.ql-editor').innerHTML = '';
                  this.commentPage = 1;
                  const commentParam = {
                    video_id: this.videoId,
                    page_size: this.commentPageSize,
                    page: this.commentPage,
                    type: this.commentType,
                    order: this.commentOrder
                  };
                  this.getVideoCommentList(commentParam);
                } else {
                  this.$message.error(res.data.msg);
                }
              })
          }
        } else {
          this.$refs.modelDelet.modelDelet = true
        }
      },
      /******
       * 评论列表排序
       */
      sortChange() {
        this.isAsc = !this.isAsc;
        if(this.commentOrder === 1){
          this.commentOrder = null;
        }else {
          this.commentOrder = 1;
        }
        const param = {
          video_id: this.videoId,
          page_size: this.commentPageSize,
          page: this.commentPage,
          type: this.commentType,
          order: this.commentOrder
        };
        this.getVideoCommentList(param);
      },
      relationRouterClick(index) {
        console.log(this.videoRelation[index].video_id)
        this.$router.push({
          path: '/home/videoDetail',
          query: {
            video: this.videoRelation[index].video_id
          }
        })
      },
      RouterIndexOu(index) {
        this.RouterLinkOther(this.commentlist[index].uid)
      },
      /*****
       * 提交评论时富文本编辑框上传图片
       * @param file
       */
      beforeContentUpload(file) {
        var FromData = new FormData()
        //文章上传图片接口
        FromData.append('token', window.localStorage.token)
        FromData.append('images', file)
        FromData.append('serial_number', this.Tools.GetNumber());
        this.$ajax.post(this.request.axiosPort + this.request.axiosApi + 'uploadTestImg', FromData)
          .then((res) => {
            console.log(res)
            if (res.data.code === 200) {
              let quill = this.$refs.myQuillEditor.quill;
              let length = quill.getSelection().index;
              quill.insertEmbed(length, 'image', res.data.path)
              quill.setSelection(length + 1)
              this.$message.success(res.data.msg)
              //console.log(this.fileList)
            } else {
              this.$message.error(res.data.msg)
              return false
            }

          })
      },
      getVideoCommentList(param) {
        this.HttpClient.post('/videos/comment', param)
          .then(res =>{
            if(res.data.code === 200) {
              this.videoCommentList = res.data.data.data;
              this.commentTotal = res.data.data.total;
            }else {
              this.videoCommentList = [];
            }
          })
      },
      /******
       * 评论翻页
       */
      handleCommentPageChange(value) {
        console.log(value)
        this.commentPage = value;
        const param = {
          video_id: this.videoId,
          page_size: this.commentPageSize,
          page: this.commentPage,
          type: this.commentType,
          order: this.commentOrder
        };
        this.getVideoCommentList(param);
      },
      handleCommentType(value) {
        this.commentType = value;
        const param = {
          video_id: this.videoId,
          page_size: this.commentPageSize,
          page: this.commentPage,
          type: this.commentType,
          order: this.commentOrder
        };
        this.getVideoCommentList(param);
      }
    },
    watch: {
      $route(to, from) {
        this.part = []
        this.partUrl = []
        this.videoDataCont()
      }
    }
  }
</script>

<style src="@/assets/css/video.css"></style>
<style src="@/assets/css/articleDetails.css"></style>
<style>
  .comment_operation_num {
    cursor: pointer;
  }

  .comment_title_info {
    cursor: pointer;
  }

  .comment_operation_report {
    cursor: pointer;
  }

  .list_info_views {
    position: absolute;
    bottom: 0px;
  }

  .head_title_info {
    cursor: pointer;
  }

  .mod_video .user_avatar {
    width: 52px;
    height: 52px;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 5px;
  }

  .mod_video .user_avatar img {
    height: 100%;
  }

  .describe_head_title {
    display: flex;
  }

  .comment_title {
    display: flex;
  }

  .mod_video_play > .player > .video-player > #vjs_video_3 > .vjs-big-play-button {
    width: 80px !important;
    height: 70px !important;
    background-color: red !important;
  }

  .mod_video .video_aside_figure .list_item {
    width: 200px;
    height: 115px;
  }

  .margin_top {
    margin-top: 30px;
  }

  .mod_video .video_aside_figure .list_item .list_info {
    width: 155px;
    height: 109px;
  }

  .useratvast {
    width: 50px;
    height: 53px;
    overflow: hidden;
    border-radius: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .useratvast > img {
    height: 100%;
  }

  @media screen and (min-width: 1200px) {
    .praise_ctrl {
      width: 50px;
    }
  }

  @media screen and (max-width: 1499px) and (min-width: 300px) {
    .mod_video {
      width: 100%;
      padding: 0 40px;
    }

    .mod_video .mod_video_show {
      width: 65%;
    }

    .mod_video .mod_video_aside {
      width: 30%;
    }

    .mod_video .mod_video_comment .comment_box_editor {
      width: 446px;
    }

    .comment_box_btm {
      margin-top: 40px;
    }

    .praise_ctrl {
      width: 40px !important;
    }

    .mod_video .video_comment_figure .comment_operation {
      width: 85%;
    }
  }
</style>
