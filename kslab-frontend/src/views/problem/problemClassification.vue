<template>
    <div class="appBackground" v-if="headerDataIndex">

      <div class="problemClassification width_1200">

        <div class="problemClass_banner">
          <img src="../../../static/img/problemClassification_banner.jpg" alt="">
        </div>

        <div class="problemClass_box">

          <!--内容区-->
          <div class="problemClass_box_left">
            <div class="problemClass_left_main">
              <div class="problemClass_main_title">
                <span></span>{{headerDataIndex.name}} <p>+132132</p>
              </div>

              <div class="problemClass_main_text" @click="dataProblemIndex()">
                {{headerDataIndex.description}}
              </div>

              <div class="problemClass_main_bottom">
                <div class="problemClass_main_btn" @click="clickIndexProblem">
                  <i class="el-icon-edit-outline"></i>|
                  <span>我要提问</span>
                </div>

                <div class="problemClass_main_right">
                  <p>
                    <span>总问题：{{headerDataIndex.week_sum}}</span>
                    <span>总回答：{{headerDataIndex.answers_sum}}</span>
                  </p>
                  |
                  <p>
                    <span>今日问题：{{headerDataIndex.nowadays_questions_sum}}</span>
                    <span>今日回答：{{headerDataIndex.nowadays_answers_sum}}</span>
                  </p>
                </div>
              </div>

            </div>



            <div class="problemClass_left_tab">

              <el-tabs v-model="activeName" @tab-click="handleClick">
                <el-tab-pane label="最新" name="new">

                  <div class="problemClass_tab_list" v-for="(bodyList ,index) in bodyDataIndex" :key="index">
                    <div class="problemClass_list_box">

                      <div class="problemClass_list_data" @click="RouterProblem(index)">
                        <p><i class="icon icon-ziyuan39"></i>{{bodyList.like_num}}</p>
                        <p><i class="icon icon-ziyuan36" style="font-size: 14px"></i>{{bodyList.comment_num}}</p>
                        <p><i class="icon icon-ziyuan37" style="font-size: 12px"></i>{{bodyList.view_num}}</p>
                      </div>

                      <div class="problemClass_list_text">
                        <div class="problemClass_list_title" @click="RouterProblem(index)"><h4>{{bodyList.title}}</h4><p>{{bodyList.nickname}}</p></div>
                        <p class="problemClass_list_main" v-html="bodyList.content" @click="RouterProblem(index)"></p>
                        <div class="problemClass_list_bottom">
                          <div class="problemClass_list_tags">
                            <key-word :keyword="bodyList.tagsname"></key-word>
                          </div>
                          <p>{{handleDate(bodyList.created_at)}}</p>
                        </div>
                      </div>

                    </div>
                  </div>

                </el-tab-pane>
                <el-tab-pane label="热门" name="hot">

                  <div class="problemClass_tab_list" v-for="(bodyList ,index) in bodyDataIndex" :key="index">
                    <div class="problemClass_list_box">

                      <div class="problemClass_list_data" @click="RouterProblem(index)">
                        <p><i class="icon icon-ziyuan39"></i>{{bodyList.like_num}}</p>
                        <p><i class="icon icon-ziyuan36" style="font-size: 14px"></i>{{bodyList.comment_num}}</p>
                        <p><i class="icon icon-ziyuan37" style="font-size: 12px"></i>{{bodyList.view_num}}</p>
                      </div>

                      <div class="problemClass_list_text">
                        <div class="problemClass_list_title" @click="RouterProblem(index)"><h4>{{bodyList.title}}</h4><p>{{bodyList.nickname}}</p></div>
                        <p class="problemClass_list_main" v-html="bodyList.content" @click="RouterProblem(index)"></p>
                        <div class="problemClass_list_bottom">
                          <div class="problemClass_list_tags">
                            <key-word :keyword="bodyList.tagsname"></key-word>
                          </div>
                          <p>{{handleDate(bodyList.created_at)}}</p>
                        </div>
                      </div>

                    </div>
                  </div>

                </el-tab-pane>
                <el-tab-pane label="最有形象力" name="">

                  <div class="problemClass_tab_list" v-for="(bodyList ,index) in bodyDataIndex" :key="index">
                    <div class="problemClass_list_box">

                      <div class="problemClass_list_data" @click="RouterProblem(index)">
                        <p><i class="icon icon-ziyuan39"></i>{{bodyList.like_num}}</p>
                        <p><i class="icon icon-ziyuan36" style="font-size: 14px"></i>{{bodyList.comment_num}}</p>
                        <p><i class="icon icon-ziyuan37" style="font-size: 12px"></i>{{bodyList.view_num}}</p>
                      </div>

                      <div class="problemClass_list_text">
                        <div class="problemClass_list_title" @click="RouterProblem(index)"><h4>{{bodyList.title}}</h4><p>{{bodyList.nickname}}</p></div>
                        <p class="problemClass_list_main" v-html="bodyList.content" @click="RouterProblem(index)"></p>
                        <div class="problemClass_list_bottom">
                          <div class="problemClass_list_tags">
                            <key-word :keyword="bodyList.tagsname"></key-word>
                          </div>
                          <p>{{handleDate(bodyList.created_at)}}</p>
                        </div>
                      </div>

                    </div>
                  </div>

                </el-tab-pane>
              </el-tabs>

            </div>



          </div>


          <!--排行榜-->
          <div class="problemClass_box_right">
            <div class="problemClass_right_title">
              <img src="../../../static/img/leaderboard.png" alt="">
              <p>TOP10</p>
              <span>排行榜</span>
            </div>
            <div class="problemClass_right_main">

              <div class="problemClass_right_list" v-for="(rightList ,index) in rightDataIndex" :key="index">
                <div class="problemClass_level"><p>1</p></div>
                <div class="problemClass_userName">
                  <p><img src="../../../static/img/avatar/avatar.jpg" alt=""></p>
                  <span>{{rightList.nickname}}</span>
                </div>
                <div class="problemClass_lift">{{rightList.avg}}</div>
              </div>

            </div>

          </div>
        </div>

      </div>

    </div>
</template>

<script>
 import FormatDate from "../../utils/GetDateUtils";
 import KeyWord from '@/components/keywordInstall'
export default {
  data(){
    return{
      activeName: 'new',
      headerDataIndex:null,   //问题头部信息
      bodyDataIndex:null,     //问题列表数据
      rightDataIndex:null     //排行榜数据
    }
  },
  components:{
    KeyWord
  },
  methods: {
      handleDate(date) {
        return FormatDate.GetDate(date);
      },
      RouterProblem(index){
        this.$router.push({
          path:'/home/problemDetails',
          query:{
            id:this.bodyDataIndex[index].question_id
          }
        })
      },
      handleClick(tab, event) {
        if(tab.index == 0)
        {
          this.dataProblemIndexs(1)
        }else if(tab.index == 1){
          this.dataProblemIndexs(2)
        }else if(tab.index == 2){
          this.dataProblemIndexs(4)
        }
      },
      clickIndexProblem(){
        this.$router.push({
          path:'/home/uploadingQuestion'
        })
      },
      dataProblemIndex(){
        console.log(this.$route.query.menuid)
        this.HttpClient.post('/questions/getCategoryInfo',{
          menu_id:this.$route.query.menuid
        })
        .then((res) => {
          this.headerDataIndex = res.data.data
        })
      },
      dataProblemIndexs(nub){
        console.log(this.$route.query.menuid)
        this.HttpClient.post('/questions/getCategoryQuestions',{
          menu_id:this.$route.query.menuid,
          order:nub
        })
        .then((res) => {
        this.bodyDataIndex = res.data.data
        })
      },
      dataProblemRanking(){
        this.HttpClient.post('/questions/userRanking',{
          menu_id:this.$route.query.menuid
        })
        .then((res) =>{
          this.rightDataIndex = res.data.data
        })
      }
    },
    created(){
      this.dataProblemIndex()
      this.dataProblemIndexs()
      this.dataProblemRanking()
    }
}
</script>

<style src="../../assets/css/problemClassification.css"></style>
<style media="screen">
.problemClass_main_btn{
  cursor: pointer;
}
@media screen and (min-width: 1200px) {
  .problemClass_box_left{
    width: 74%;
  }
  .problemClass_list_box{
    width: 100%;
  }
}

@media screen and (max-width:1220px) and (min-width:300px) {
  .problemClass_box_left{
    width: 72%;
  }
}
@media screen and (max-width:1055px){
  .problemClass_box_left{
    width: 65%;
  }
  .problemClass_box{
    padding: 0 20px;
  }
}
</style>
