<template>

  <div class="problemIndex">

    <div class="problemIndex_box">
      <div class="problemIndex_title">
        <div :class="{ problemIndex_title_list:true}" v-for="(prolist ,index) in problemListCiasll" @click="iconClickRouter(index)" :key="index">
          <el-badge :value="9" :max="99" class="item">
            <div class="problemIndex_title_icon">
              <i class="icon icon-xinxinicon"></i>
            </div>
          </el-badge>
          <h2>{{prolist.name}}</h2>
          <div class="problemIndex_title_text">
            <p><i class="icon icon-ziyuan19"></i>{{prolist.questions_sum}}</p>
            <p><i class="icon icon-ziyuan27"></i>{{prolist.answers_sum}}</p>
          </div>
        </div>
      </div>

      <div class="problemIndex_main">
        <div class="problemIndex_main_title">
          <p><span></span>问坛</p>
          <span>QUESTION</span>
        </div>

        <div class="problemIndex_main_box">

          <el-tabs v-model="activeName" @tab-click="handleClick">
            <el-tab-pane label="最新" name="new">

              <div class="problemIndex_tab_list" v-for="(problemList ,index) in problemData" :key="index" @click="RouterDetails(index)">
                <div class="problemIndex_list_box">

                  <div class="problemIndex_list_data">
                    <p><i class="icon icon-ziyuan39"></i>{{problemList.like_num}}</p>
                    <p><i class="icon icon-ziyuan36" style="font-size: 14px"></i>{{problemList.comment_num}}</p>
                    <p><i class="icon icon-ziyuan37" style="font-size: 12px"></i>{{problemList. view_num}}</p>
                  </div>

                  <div class="problemIndex_list_text">
                    <div class="problemIndex_list_title"><h4>{{problemList.title}}</h4><p>{{problemList.nickname}}</p></div>
                    <p class="problemIndex_list_main" v-html="problemList.content"></p>
                    <div class="problemIndex_list_bottom">
                      <key-wrod :keyword="problemList.tagsname"></key-wrod>
                      <p>{{problemList.created_at}}</p>
                    </div>
                  </div>

                </div>
              </div>

            </el-tab-pane>

            <el-tab-pane label="热门" name="hot">

              <div class="problemIndex_tab_list" v-for="(problemList ,index) in problemData" :key="index" @click="RouterDetails(index)">
                <div class="problemIndex_list_box">

                  <div class="problemIndex_list_data">
                    <p><i class="icon icon-ziyuan39"></i>{{problemList.like_num}}</p>
                    <p><i class="icon icon-ziyuan36" style="font-size: 14px"></i>{{problemList.comment_num}}</p>
                    <p><i class="icon icon-ziyuan37" style="font-size: 12px"></i>{{problemList. view_num}}</p>
                  </div>

                  <div class="problemIndex_list_text">
                    <div class="problemIndex_list_title"><h4>{{problemList.title}}</h4><p>{{problemList.nickname}}</p></div>
                    <p class="problemIndex_list_main">{{problemList.content}}</p>
                    <div class="problemIndex_list_bottom">
                      <key-wrod :keyword="problemList.tagsname"></key-wrod>
                      <p>{{problemList.created_at}}</p>
                    </div>
                  </div>

                </div>
              </div>

            </el-tab-pane>

            <el-tab-pane label="未回答" name="unanswered">

              <div class="problemIndex_tab_list" v-for="(problemList ,index) in problemData" :key="index" @click="RouterDetails(index)">
                <div class="problemIndex_list_box">

                  <div class="problemIndex_list_data">
                    <p><i class="icon icon-ziyuan39"></i>{{problemList.like_num}}</p>
                    <p><i class="icon icon-ziyuan36" style="font-size: 14px"></i>{{problemList.comment_num}}</p>
                    <p><i class="icon icon-ziyuan37" style="font-size: 12px"></i>{{problemList. view_num}}</p>
                  </div>

                  <div class="problemIndex_list_text">
                    <div class="problemIndex_list_title"><h4>{{problemList.title}}</h4><p>{{problemList.nickname}}</p></div>
                    <p class="problemIndex_list_main">{{problemList.content}}</p>
                    <div class="problemIndex_list_bottom">
                      <key-wrod :keyword="problemList.tagsname"></key-wrod>
                      <p>{{problemList.created_at}}</p>
                    </div>
                  </div>

                </div>
              </div>

            </el-tab-pane>
            <el-tab-pane label="最有影响力" name="theMostInfluential">

              <div class="problemIndex_tab_list" v-for="(problemList ,index) in problemData" :key="index" @click="RouterDetails(index)">
                <div class="problemIndex_list_box">

                  <div class="problemIndex_list_data">
                    <p><i class="icon icon-ziyuan39"></i>{{problemList.like_num}}</p>
                    <p><i class="icon icon-ziyuan36" style="font-size: 14px"></i>{{problemList.comment_num}}</p>
                    <p><i class="icon icon-ziyuan37" style="font-size: 12px"></i>{{problemList. view_num}}</p>
                  </div>

                  <div class="problemIndex_list_text">
                    <div class="problemIndex_list_title"><h4>{{problemList.title}}</h4><p>{{problemList.nickname}}</p></div>
                    <p class="problemIndex_list_main">{{problemList.content}}</p>
                    <div class="problemIndex_list_bottom">
                      <key-wrod :keyword="problemList.tagsname"></key-wrod>
                      <p>{{problemList.created_at}}</p>
                    </div>
                  </div>

                </div>
              </div>

            </el-tab-pane>
          </el-tabs>


        </div>

      </div>

    </div>
    <floating-Div></floating-Div>
  </div>

</template>

<script>
  import floatingDiv from '@/components/floating'
  import KeyWrod from '@/components/keywordInstall'

    export default {
        name: "problemIndex",
      components:{
        floatingDiv,
        KeyWrod
      },
      data() {
        return {
          activeName: 'new',
          problemData:null,     //问题列表主页数据
          problemListCiasll:null   //问题分类页列表
        };
      },
      methods: {
        titleHeader(){
          this.HttpClient.get('/questions/homeCategory',{

          })
          .then((res) => {
            console.log(res);
            this.problemListCiasll = res.data.data
          })
        },
        iconClickRouter(index){
          this.$router.push({
            path:'/home/problemClassification',
            query:{
              menuid:this.problemListCiasll[index].menu_id
            }
          })
        },
        problemIndexCread(order){
          this.HttpClient.post('/questions/index',{
            order:order
          })
          .then((res) =>{
            this.problemData = res.data.data;

            var Vuethis = this;
            function FunctionDate(type){
              console.log(type);
              for(var i=0;i<type.length;i++){
                type[i].label_name = Vuethis.filtration(type[i].label_name)
                type[i].created_at = Vuethis.DateTime(Vuethis.finalDate(type[i]))
              }
            }
            FunctionDate(this.problemData)
          })
        },
        handleClick(tab, event) {
          let number = Number(tab.index)+1;
          this.problemIndexCread(number)
        },
        RouterDetails(index){
          this.$router.push({
            path:'/home/problemDetails',
            query:{
              id:this.problemData[index].question_id
            }
          })
        }
      },
      created(){
        this.problemIndexCread(1);
        console.log(this.problemData);
        this.titleHeader()
      }
    }
</script>

<style src="../../assets/css/problemIndex.css"></style>
<style media="screen">
  .problemIndex{
    margin-top: 20px;
  }
  @media screen and (min-width: 1200px) {
    .problemIndex_box{
      width: 1200px;
      margin: 0 auto;
    }
  }
  @media screen and (max-width:1119px) and (min-width:300px) {
    .problemIndex_box{
      width: 100%;
      margin: 0 auto;
      padding: 0 30px;
    }
  }
</style>
