<template lang="html">
  <!-- <div class="activity_Data_file">
    <div class="problemDetails_list_annex_list" v-for="(item, index) in attachment" :key="index">
      <el-tooltip class="item" effect="light" placement="top-start" popper-class="problemDetails_content_data_img">
        <div slot="content">
          <img src="/static/img/article_details_img.png" alt="">
        </div>
        <p>
          <i class="icon icon-icon--"></i>
          <span>{{item.name}}</span>
        </p>
      </el-tooltip>
      <a :href="bindImage(item.path)">[下载]</a>
    </div>
  </div> -->
  <div class="problemDetails_list_annex" v-show="problemDetailsAnnexShow" >
    <div class="problemDetails_list_annex_list" v-for="(item, index) in attachment" :key="index">
      <el-tooltip class="item" effect="light" placement="top-start" popper-class="problemDetails_content_data_img">
        <div slot="content">
          <img v-if="item.url" :src="request.picUrl+item.url" alt="">
          <img v-else :src="request.picUrl+item.path" alt="">
        </div>
        <p>
          <i class="icon icon-icon--"></i>
          <span>{{item.name}}</span>
        </p>
      </el-tooltip>
      <a v-if="item.url" :href="bindImage(item.url)">[下载]</a>
      <a v-else :href="bindImage(item.path)">[下载]</a>
    </div>
  </div>
</template>

<script>
  import {HttpClient} from "../../utils/HttpUtils";
  import cfg from '../../../config/app'
  export default {
    props: ['attachment'],
    data() {
      return {
        attachmentData: [],
        problemDetailsAnnexShow:true
      }
    },
    created() {

    },
    methods: {
      /***
       * 格式化imgUrl
       * @param url
       * @returns {string}
       */
      bindImage(url) {
        return cfg.imageUrl + url+ '?attname=';
      }
    }
  }
</script>

<style lang="less">
/*附件预览框*/
  .problemDetails_content_data_img{
    width: 150px;
    img{
      width: 100%;
    }
  }
  .problemDetails_list_annex{
    border: 1px solid #f2f2f2;
    .problemDetails_list_annex_list{
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 5px 10px;
      cursor: pointer;
    }
    .problemDetails_list_annex_list:hover{
      background-color: #f2f2f2;
    }
  }
  .file_Dwond{
    float: right !important;
    padding-top: 2px;
    cursor: pointer;
  }
  .activity_Data_file>ul{
    overflow: hidden;
  }
  .activity_Data_file>ul>li>div{
    float: left;
    margin-right: 10px;
  }
  .activity_Data_file>ul>li{
    padding: 10px;
    border-bottom:1px dashed #CCC;
    overflow: hidden;
    margin-bottom: 10px;
  }
  .activity_Data_file>ul>li>p{
    font-size: 14px;
    color:#737373;
    float: left;
  }
  .icon_div_samll{
    width: 20px;
    height: 20px;
  }
  .activity_Data_file{
    width: 100%;
  }
  @media screen and (max-width:1180px) and (min-width:960px) {
      .activity_Data_file>ul>li>p{
        font-size:12px!important;
      }
  }
</style>
