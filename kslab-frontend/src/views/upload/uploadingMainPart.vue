<template>
    <div class="uploading_main_item uploading_main_part">
        <div class="main_head">
            <i class="icon icon_part" style="width:22px;margin-right:11px;"></i>
            <span class="main_txt">使用零件/软件<span class="main_txt_require">(选填)</span></span>
        </div>
        <div class="main_part_detail">
            <el-input
                    placeholder="添加零件/软件名字"
                    v-model="partValue"
                    clearable
                    @keyup.enter.native="addPart">
            </el-input>
            <i class="el-icon-circle-plus" @click="addPart"></i>
            <ul class="figure_list">
                <li class="list_item" v-for="(p,index) in partList" :key="index">
                    <i class="el-icon-delete" @click="removePart(index)"></i>
                    <div class="part_info" :class="{active}">
                        <span class="part_info_name">{{p.partName}}</span>
                        <el-input
                                placeholder="输入连接..."
                                clearable
                                style="width:initial"
                                @focus="onFocus"
                                @blur="onBlur"
                                @input="valueChange(index,$event)"
                        ></el-input>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
    export default {
        props:['Source'],
        name: "uploadingMainPart",
        data(){
            return {
                partValue:'',
                partList:[],
                active:false,
            }
        },
        methods:{
            addPart(){
                if(this.partValue){
                    if(this.partList.length<15) {
                        // this.partName=this.partValue;
                        this.partList.push({partName: this.partValue, link: ''});
                        this.$emit('MainpartAcont', this.partList)
                    }else{
                        this.$message.warning('最多输入15个零件');
                    }
                }else{
                    this.$message({
                        message: '请输入零件/软件名称',
                        type: 'warning'
                    });
                }
            },
            removePart(index){
                this.partList.splice(index,1);
            },
            onFocus(){
                this.active=true;
            },
            onBlur(){
                this.active=false;
            },
            valueChange(i,val){
                this.partList[i].link=val;
            }
        },
        watch:{
          Source:function(){
            this.partList = this.Source
          }
        }
    }
</script>

<style scoped>
    .uploading_main_part .el-icon-circle-plus{
        position:relative;
        top:-2px;
        left:-45px;
    }
    .main_txt_require{
        font-size:14px;
        font-weight:normal;
    }
</style>
