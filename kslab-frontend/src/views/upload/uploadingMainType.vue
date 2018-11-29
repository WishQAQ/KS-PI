<template>
  <div class="uploading_main_item uploading_main_type">
    <div class="main_head">
      <i class="icon icon_type"></i>
      <span class="main_txt">类别</span>
    </div>
    <div class="main_type_list">
      <ul class="figure_list">
        <li class="list_item" :class="{active:index===checkedIndex}" v-for="(tmp,index) in typeList" :key="index" @click.stop="checkedType(tmp.type,index)">
          <div class="type_list_content">
              <div class="type_content_img_box"><i class="icon" :class="tmp.img"></i></div>
              <div class="type_content_txt">
                  <p class="content_txt_title">{{tmp.type}}</p>
              </div>
              <p class="type_content_children" v-show="index===checkedIndex">{{selectedValue}}</p>
          </div>
          <div class="type_list_select_box">
              <i class="triangle_up" v-if="index===checkedIndex  && showSelect">
                  <i class="triangle_inner"></i>
              </i>
              <transition name="spread">
                  <ul class="type_list_select" v-if="index===checkedIndex  && showSelect">
                      <li class="type_select_item" v-for="(option,i) in tmp.list" :key="i" @click.stop="selectedOption(option)">
                          {{option}}
                          <span class="type_select_line"></span>
                      </li>
                  </ul>
              </transition>
          </div>

        </li>
      </ul>
    </div>
  </div>
</template>

<script>
    export default {
        name: "uploadingMainType",
        data(){
            return {
                typeList:[ //类别列表
                    {type:'汽车',img:'icon-qiche',list:['改装','维修','保养','驾驶培训','调教','交流','比赛']},
                    {type:'摩托车',img:'icon-motuoche',list:['改装','维修','保养','驾驶培训','调教','交流','比赛']},
                    {type:'无人机',img:'icon-wurenji--',list:['改装','维修','保养','驾驶培训','调教','交流','比赛']},
                    {type:'智能设备',img:'icon-zhinengshebei',list:['改装','维修','保养','驾驶培训','调教','交流','比赛']}
                ],
                checkedValue:'',//大类已选值
                checkedIndex:null,//大类已选值下标
                selectedValue:'',//小类已选值
                showSelect:false,//小类显示状态
            }
        },
        methods:{
            checkedType(type,index){//大类点击事件
                this.checkedValue=type;
                this.checkedIndex=index;
                this.showSelect=true;
                this.selectedValue='';
                this.$emit("MainType" ,this.checkedIndex)
            },
            selectedOption(val){//小类点击事件
                this.selectedValue=val;
                this.showSelect=false
            }
        }
    }
</script>

<style scoped>
    .uploading_main_type .main_type_list .type_list_content{
        position:relative;
    }
    .uploading_main_type .main_type_list .type_content_children{
        position:absolute;
        left:50%;
        width:59px;
        margin-left:-29.5px;
    }
    .mod_uploading .mod_uploading_main .main_type_list{
        margin-bottom:0!important;
    }
    .mod_uploading .main_type_list .list_item{
        width:114px!important;
        height:114px!important;
    }
    /**类别选择项**/
    .uploading_main_type .main_type_list .type_list_select_box{
        position:absolute;
        top:120px;
        left:0;
        z-index:10;
    }
    .uploading_main_type .main_type_list .type_list_select_box .triangle_up{
        position:absolute;
        top:-14px;
        left:20px;
        z-index:11;
        border-bottom-color:#e4e4e4;
    }
    .uploading_main_type .main_type_list .type_list_select_box .triangle_inner{
        top:-7px;
        left:-8px;
        border-width:8px;
    }
    .uploading_main_type .main_type_list .type_list_select_box .type_list_select{
        width:130px;
        border:1px solid #e4e4e4;
        background:#fff;
        overflow:hidden;
    }
    .uploading_main_type .main_type_list .type_list_select_box .type_select_item{
        width:100%;
        height:34px;
        line-height:34px;
        text-align:center;
    }
    .uploading_main_type .main_type_list .type_list_select_box .type_select_item:hover{
        background:#fafafa;
    }
    .uploading_main_type .main_type_list .type_list_select_box .type_select_line{
        display:block;
        width:70%;
        height:0;
        border-bottom:1px dashed #f2f2f2;
        margin:0 auto;
    }
    .uploading_main_type .main_type_list .type_list_select_box .type_select_item:last-child .type_select_line{
        border:none;
    }
    /***类别列表动画***/
    .spread-enter-active {
        animation: spread-in .5s;
    }
    .spread-leave-active {
        animation: spread-in .1s reverse;
    }
    @keyframes spread-in {
        0% {
            height:0;
        }
        100% {
            height:240px;
        }
    }
</style>
