<template>
    <div class="merchantProductReview appBackground">

      <div class="merchantProductReview_main width_1200">
        <div class="main_title">
          <router-link to="/home/commercial-activity"><i class="el-icon-arrow-left"></i></router-link>
          <div class="main_title_text">{{title}}</div>
        </div>

        <div class="main_content">

          <el-table
            :data="tableData"
            style="width: 100%"
            :default-sort = "{prop: 'score', order: 'descending'}"
          >
            <el-table-column
              prop="name"
              width="200"
              label="用户">
                <template slot-scope="scope">
                    <div class="user_info">
                        <span class="user_avatar"><img class="avatarImg" :src="request.picUrl+scope.row.avatar+'?imageView2/1/w/46/h/46'"/></span>
                        <span>{{scope.row.name}}</span>
                    </div>
                </template>
            </el-table-column>
            <el-table-column
              prop="content"
              width="400"
              label="评价内容">
            </el-table-column>
            <el-table-column
              prop="attachment"
              width="400"
              class-name="tableImg"
              label="图片">
              <template slot-scope="scope">
                <div><img :src="request.picUrl+img+'?imageView2/1/w/70/h/70'" alt="" v-for="(img,i) in scope.row.attachment" :key="i"></div>
              </template>
            </el-table-column>
            <el-table-column
              prop="score"
              label="评分"
              width="100"
              class-name="tableRate"
              sortable>
              <template slot-scope="scope">
                <el-rate
                  v-model="scope.row.score"
                  disabled
                  score-template="{value}">
                </el-rate>
              </template>
            </el-table-column>
            <el-table-column
              prop="created_at"
              label="发布时间"
              width="100"
              sortable
              :formatter="formatter">
            </el-table-column>
          </el-table>

        </div>

      </div>

    </div>
</template>

<script>
    export default {
        name: "merchantProductReview",
      data(){
        return{
          // 活动名称
          title:this.$route.query.title,

          tableData: [{
            name: '大颗颗',
            content: '蛮好用的。我主要用来在家办公，学习。包装很简洁，做工不错，边缘很柔和没有割手感觉。指纹集成在电源键上比较合理，息屏打开也很快。键盘按着比较舒服。进入系统很智能，有语音助手，各种操种操作比较人性化···',
            created_at: '2018-10-24',
            attachment:[]
          }],

          currentPage:1,//当前页
          pageSize:5,//每页显示条数

        }
      },

      methods: {
        formatter(row, column) {
          return row.created_at;
        }
      },
      created(){
        let id=this.$route.query.id,
            type=this.$route.query.type;
        if(type==='activity'){
            this.HttpClient.get('/actives/comments',
                {
                    active_id:id,
                    page:this.currentPage,
                    size:this.pageSize
                }).then(res=>{
                console.log(res);
                let {code,data} = res.data;
                if(code===200){
                    this.tableData=data
                }
            })
        }else if(type==='product'){
            this.HttpClient.get('/products/comments',{product_id:id})
                .then(res=>{
                    console.log(res);
                    let {code,data} = res.data;
                    if(code===200){
                        this.tableData=data;
                        this.tableData.map(item=>{
                            console.log(item);
                            // item.forEach((item,index)=>{
                            //     console.log(index);
                            // })
                        })

                    }
                })
        }
      }
    }
</script>

<style lang="less">
.merchantProductReview{

  .merchantProductReview_main{
    /*标题*/
    .main_title{
      display: flex;
      align-items: center;
      height: 40px;
      a{
        height: 40px;
        background-color: #dedede;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 20px;
        color: #999;
        padding: 0 10px;
      }
      div{
        height: 100%;
        padding: 0 10px;
        background-color: #15bafe;
        color: #fff;
        font-size: 14px;
        display: flex;
        justify-content: center;
        align-items: center;
      }
    }

    /*主体内容*/
    .main_content{


       /*用户信息*/
      .user_info{
        display:flex;
        align-items:center;
        justify-content:flex-start;
        height:60px;
      }
      /*头像*/
      .user_avatar{
        display:flex;
        justify-content:center;
        align-items:center;
        width:50px;
        height:50px;
        margin-right:5px;
        border-radius:50%;
        background:#fff;
        box-shadow:2px 3px 5px #aaa;
      }
      img{
        width:46px;
        height:46px;
        /*border-radius:50%;*/
        vertical-align:middle;
      }

      /*图片 */
      .tableImg{
        .cell{
          display: flex;
          align-items: center;
          flex: 5;
          div{
            display: flex;
            justify-content: center;
            align-items: center;
            /*width: 70px;*/
            height: 70px;
            overflow: hidden;
          }
        }
      }
      /*评分*/
      .tableRate{
        i{
          font-size: 14px;
          margin-right: 0;
        }
      }
    }
  }
}
</style>
