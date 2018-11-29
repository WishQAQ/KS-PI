<template>
  <transition name="el-fade-in-linear">
      <div class="commentModal" v-show="showCommentModal_clone">

        <div class="commentModal_box">

          <div class="commentModal_box_title">
            <div>{{commetreply.length}}条评论</div>
            <div></div>
            <div class="commentModal_closeModal icon icon-close" @click="showCommentModal_clone = !showCommentModal_clone"></div>
          </div>

          <div class="commentModal_box_main">

            <!--循环回复列表-->
            <div v-for="(commetlist ,index) in commetreply" class="commentModal_box_main_list" :key="index" :id="index">
              <div class="commentModal_box_main_list_left">
                <praise-div :type="article_details_title" :index="0"></praise-div>
              </div>

              <div class="commentModal_box_main_list_right">
                <div class="commentModal_box_avatar">
                  <div class="commentModal_box_avatar_box">
                    <img :src="commetlist.from_avatar" alt="">
                  </div>
                  <div class="flex_div">
                      <p v-if='commetlist.from_name'>
                        {{commetlist.from_name}}
                        <span>回复了</span>
                      </p>
                      <p>
                        {{commetlist.to_name}}
                      </p>
                  </div>
                </div>

                <div class="commentModal_box_text">
                  <p>{{commetlist.content}}</p>
                </div>

                <div class="commentModal_box_bottom">
                  <div class="commentModal_replyBtm" @click="userReply(index)">回复</div>
                  <div class="commentModal_dialogueBtm" @click="reply(index)" v-if="commetlist.from_name">查看对话</div>
                  <div class="commentModal_reportBtm" @click="reportModal = !reportModal">举报</div>
                </div>


                <el-collapse-transition>
                  <div class="commentModal_box_input" v-if="replyonClick == index">
                    <div class="commentModal_box_input_box">
                      <input type="text" v-html="commetlist.from_name" :placeholder="cont" v-model="contentDiled">
                    </div>
                    <div class="commentModal_box_input_btm">
                      <div class="commentModal_clone" @click="replyNull">取消</div>
                      <div class="commentModal_commit" @click="secondReply">确认</div>
                    </div>
                  </div>
                </el-collapse-transition>

              </div>
            </div>

          </div>
          <div class="commentModal_box_bottom_input">
            <div>
              <input type="text" placeholder="写下你的评论···" v-model="contentBody">
            </div>
            <div class="commentModal_box_bottom_input_btm" @click="issueClick">发布</div>
          </div>
        </div>





        <transition name="el-zoom-in-center">
          <div class="commentModal_box commentModal_box_more" v-show="showCommentModal_more">

            <div class="commentModal_box_title">
              <div class="commentModal_box_more_return el-icon-upload2" @click="showCommentModal_more = !showCommentModal_more"></div>
              <div class="commentModal_box_more_clone icon icon-close" @click="showCommentModal_more = !showCommentModal_more"></div>
            </div>

            <div class="commentModal_box_main">

              <div v-for="(threeReplyList ,index) in threeReply" class="commentModal_box_main_list" :key="index">
                <div class="commentModal_box_main_list_left">
                  <praise-div :type="article_details_title" :index="0"></praise-div>
                </div>

                <div class="commentModal_box_main_list_right">
                  <div class="commentModal_box_avatar">
                    <div class="commentModal_box_avatar_box">
                      <img src="/static/img/avatar/avatar.jpg" alt="">
                    </div>
                    <p v-if='threeReplyList.from_name'>
                      {{threeReplyList.from_name}}
                      <span>回复了</span>
                    </p>
                    <p>
                      {{threeReplyList.to_name}}
                    </p>
                  </div>

                  <div class="commentModal_box_text">
                    <p>
                      {{threeReplyList.content}}
                    </p>
                  </div>

                  <div class="commentModal_box_bottom">
                    <div class="commentModal_reportBtm" @click="reportModal = !reportModal">举报</div>
                  </div>
                </div>
              </div>
            </div>
          </div>

        </transition>

        <reportModal v-if="reportModal"></reportModal>
    </div>
  </transition>
</template>

<script>

  import PraiseDiv from '@/components/praise'
  import reportModal from '@/components/reportModal'
    export default {
      props:['comments','httpclosure'],
      data(){
          return{
            showCommentModal_clone: true,
            showCommentModal_more: false,
            reportModal: false,
            article_details_title: [{
              praise:'10',
              state:0
            }],
            commetreply:[],  //评论回复列表
            contentBody:'',  //发布内容
            judgeFont:null,
            replyonClick:null,   //回复下标
            replyonDilsd:null,   //点击后当前下标id
            contentDiled:null,
            userToid:null,        //被回复人名字
            fromName:'',    //回复人名字
            threeReply:[],   //查看回复总容器
            cont:null
          }
      },
      components: {
        PraiseDiv,
        reportModal
      },
      methods:{
        //文章回复列表接口
        commentButton(index){
          this.HttpClient.post(this.httpclosure.reply,{
            answer_id:this.comments
          })
          .then((res) => {
            console.log(res)
            var arr = []
            for(var i=0;i<res.data.data.length;i++){
              if(res.data.data[i].from_uid != null){
                this.fromName = res.data.data[i].from_name
              }else{

              }
            }
            this.commetreply = res.data.data
          })
        },
        //文章添加回复接口
        issueClick(){
          this.HttpClient.post(this.httpclosure.add,{
            answer_id:this.comments,
            token:window.localStorage.token,
            content:this.contentBody,
          })
          .then((res) => {
            console.log(res)
          })
        },
        //评论查看对话
        reply(index){
          this.showCommentModal_more = !this.showCommentModal_more
          this.HttpClient.post(this.httpclosure.info,{
            answer_id:this.comments,
            uid_1:this.commetreply[index].from_uid,
            uid_2:this.commetreply[index].to_uid
          })
          .then((res) => {
            this.threeReply = res.data.data
          })
        },
        secondReply(){
          this.HttpClient.post(this.httpclosure.add,{
            answer_id:this.replyonDilsd,
            token:window.localStorage.token,
            content:this.contentDiled,
            reply_to_id:this.userToid
          })
          .then((res) => {

          })
        },
        userReply(index){
          this.replyonClick = index
          this.cont = '回复 '+this.commetreply[index].to_name
          this.replyonDilsd = this.commetreply[index].answer_id
          this.userToid = this.commetreply[index].to_uid
        },
        replyNull(){
          this.replyonClick = null
        }
      },
      created(){
        this.commentButton()
      }
    }
</script>

<style src="../assets/css/modalBox.css"></style>
