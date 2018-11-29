<template>
    <div class="appBackground commercialEvaluate">
      <CommercialHead></CommercialHead>

      <div class="commercialEvaluate_box width_1200">

        <el-table
          :data="tableData"
          :default-sort = "{prop: 'date', order: 'descending'}"
          style="width: 100%">
          <el-table-column
            align="center"
            prop="avatar"
            label="头像">
            <template slot-scope="scope" v-for="(tableDatas ,index) in tableData" >
              <img :key="index" class="avatarImg" :src="'/static/img/avatar/'+tableDatas.imageSrc" />
            </template>
          </el-table-column>
          <el-table-column
            align="center"
            prop="userName"
            label="用户名">
          </el-table-column>
          <el-table-column
            align="center"
            label="评分"
            width="140px">
            <template slot-scope="scope">
              <el-rate
                v-model="scopeValue"
                disabled
                :colors="['#15bafe', '#15bafe', '#15bafe']">
              </el-rate>
            </template>

          </el-table-column>

          <el-table-column
            align="center"
            prop="time"
            label="发布时间"
            sortable
            width="180">
          </el-table-column>

          <el-table-column
            width="300px"
            prop="evaluate"
            label="评价内容">
          </el-table-column>
          <el-table-column
            align="center"
            width="400px"
            label="图片">

          </el-table-column>

        </el-table>

        <div class="pagination" style="text-align: center;margin-top: 30px">
          <el-pagination
            layout="prev, pager, next"
            :total="50">
          </el-pagination>
        </div>

      </div>

      <Floating></Floating>
    </div>
</template>

<script>
  import Floating from '@/components/floating'
  import CommercialHead from '@/components/commercialInfoHeader'

    export default {
      name: "commercialEvaluate",

      data() {
        return {



          tableData: [{
            userName: '帅哥',
            time: '2018-7-4',
            imageSrc:'avatar.jpg',
            evaluate: '所建立的产品评价体系模型分三个层级，再细分各个维度来分析产品的健康状况。三个层级主要包括：企业高层管理者、产品线管理者（包括产',
          },
            {
              userName: '帅哥',
              time: '2018-12-2',
              imageSrc:'avatar.jpg',
              evaluate: '所建立的产品评价体系模型分三个层级，再细分各个维度来分析产品的健康状况。三个层级主要包括：企业高层管理者、产品线管理者（包括产',
            },{
              userName: '帅哥',
              time: '2018-9-8',
              imageSrc:'avatar.jpg',
              evaluate: '所建立的产品评价体系模型分三个层级，再细分各个维度来分析产品的健康状况。三个层级主要包括：企业高层管理者、产品线管理者（包括产',
            },{
              userName: '帅哥',
              time: '2018-9-32',
              imageSrc:'avatar.jpg',
              evaluate: '所建立的产品评价体系模型分三个层级，再细分各个维度来分析产品的健康状况。三个层级主要包括：企业高层管理者、产品线管理者（包括产',
            }],
          scopeValue:4,
        }
      },



      components:{
        Floating,
        CommercialHead
      }
    }
</script>

<style scoped>

  .commercialEvaluate_box .avatar{
    width: 60px;
    height: 60px;
    padding: 4px;
    background-color: #fff;
    box-shadow: 0px 0px 8px 0px
    rgba(34, 24, 21, 0.35);
    border-radius: 50%;
    margin-top: 5px;
  }

  .commercialEvaluate_box .images{
    width: 80px;
  }
  .commercialEvaluate_box .images:not(:last-child){
    margin-right: 10px;
  }

  .avatarImg{
    width: 60px;
    height: 60px;
  }

</style>
