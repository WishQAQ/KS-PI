<template>
    <div class="PageProductCategoryList">
        <BreadCrumb class="bread" :breadData="breadData"></BreadCrumb>
        <div class="content">
            <p class="title">删除产品类型</p>
            <div class="content_contain">
                <div class="sle-til">
                    <div>汽车</div>
                    <div>摩托车</div>
                    <div>无人机</div>
                    <div>智能设备</div>                   
                </div>
                <!-- 选择器 -->
                <div class="choice">
                    <div class="block">
                        <el-cascader class="lianji" expand-trigger="hover" :options="options" v-model="selectedOptions"  @change="handleChange"  placeholder="一级目录/二级目录/三级目录"></el-cascader>
                    </div>
                    <div class="search">
                        <el-input placeholder="ID搜索" suffix-icon="el-icon-search" ></el-input>
                        <el-input placeholder="名称搜索" suffix-icon="el-icon-search" ></el-input>
                    </div>
                    <div class="time">
                        <el-select v-model="value" placeholder="请选择">
                            <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"> </el-option>
                        </el-select>
                    </div>
                </div> 
                <div class="tables">
                    <el-table   :data="tableData" border :stripe="true" :header-row-style="{height:'40px'}" :header-cell-style="{padding:0}" :row-style="{height:'40px'}" :cell-style="{padding:0}" style="width: 100%">
                        <el-table-column prop="id" label="产品类型ID" width="100"></el-table-column>
                        <el-table-column prop="firstDirectory" label="一级目录" min-width="185"></el-table-column>
                        <el-table-column prop="secondDirectory" label="二级目录" width="185"> </el-table-column>
                        <el-table-column prop="ThreeDirectory" label="三级目录" width="185"> </el-table-column>
                        <el-table-column prop="name" label="展示图片" width="300">
                            <template slot-scope="scope">
                                <div class="box">
                                    <img src="../../assets/image/koala1.jpg" alt="">
                                </div>
                            </template>
                        </el-table-column>
                        <el-table-column prop="number" label="当前类型下产品数量" width="150"></el-table-column>
                        <el-table-column prop="setTime" label="创建时间" width="150"></el-table-column>
                        <el-table-column prop="state" label="状态" width="150"></el-table-column>
                        <el-table-column prop="operation" label="操作" width="180">
                            <template slot-scope="scope">
                                <div class="big-box">
                                    <div class="disable">禁用</div>
                                </div>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
                <!-- 分页 -->
                <el-pagination background layout="prev, pager, next" :total="100" :pager-count="5"></el-pagination>
            </div>
        </div>
    </div>
</template>

<script>
import BreadCrumb from "../public/BreadCrumb";
export default {
    name: 'PageDeleteProductType',
    components: {BreadCrumb},
    data: function() {	
        return {
            breadData: [{
            id: 1,
            name: '后端页面',
            urls: '/index',
            icon: 'icon-home'
          },{
            id: 2,
            name: '删除产品类型',
            urls: '/index/PageDeleteProductType',
            icon: 'icon-home'
          }],
          options: [{
          value: 'zhinan',
          label: '指南',
          children: [{
            value: 'shejiyuanze',
            label: '设计原则',
            children: [{
              value: 'yizhi',
              label: '一致'
            }, {
              value: 'fankui',
              label: '反馈'
            }, {
              value: 'xiaolv',
              label: '效率'
            }, {
              value: 'kekong',
              label: '可控'
            }]
          }, {
            value: 'daohang',
            label: '导航',
            children: [{
              value: 'cexiangdaohang',
              label: '侧向导航'
            }, {
              value: 'dingbudaohang',
              label: '顶部导航'
            }]
          }]
        }, {
          value: 'zujian',
          label: '组件',
          children: [{
            value: 'basic',
            label: 'Basic',
            children: [{
              value: 'layout',
              label: 'Layout 布局'
            }, {
              value: 'color',
              label: 'Color 色彩'
            }, {
              value: 'typography',
              label: 'Typography 字体'
            }, {
              value: 'icon',
              label: 'Icon 图标'
            }, {
              value: 'button',
              label: 'Button 按钮'
            }]
          }, {
            value: 'form',
            label: 'Form',
            children: [{
              value: 'radio',
              label: 'Radio 单选框'
            }, {
              value: 'checkbox',
              label: 'Checkbox 多选框'
            }, {
              value: 'input',
              label: 'Input 输入框'
            }, {
              value: 'input-number',
              label: 'InputNumber 计数器'
            }, {
              value: 'select',
              label: 'Select 选择器'
            }, {
              value: 'cascader',
              label: 'Cascader 级联选择器'
            }, {
              value: 'switch',
              label: 'Switch 开关'
            }, {
              value: 'slider',
              label: 'Slider 滑块'
            }, {
              value: 'time-picker',
              label: 'TimePicker 时间选择器'
            }, {
              value: 'date-picker',
              label: 'DatePicker 日期选择器'
            }, {
              value: 'datetime-picker',
              label: 'DateTimePicker 日期时间选择器'
            }, {
              value: 'upload',
              label: 'Upload 上传'
            }, {
              value: 'rate',
              label: 'Rate 评分'
            }, {
              value: 'form',
              label: 'Form 表单'
            }]
          }, {
            value: 'data',
            label: 'Data',
            children: [{
              value: 'table',
              label: 'Table 表格'
            }, {
              value: 'tag',
              label: 'Tag 标签'
            }, {
              value: 'progress',
              label: 'Progress 进度条'
            }, {
              value: 'tree',
              label: 'Tree 树形控件'
            }, {
              value: 'pagination',
              label: 'Pagination 分页'
            }, {
              value: 'badge',
              label: 'Badge 标记'
            }]
          }, {
            value: 'notice',
            label: 'Notice',
            children: [{
              value: 'alert',
              label: 'Alert 警告'
            }, {
              value: 'loading',
              label: 'Loading 加载'
            }, {
              value: 'message',
              label: 'Message 消息提示'
            }, {
              value: 'message-box',
              label: 'MessageBox 弹框'
            }, {
              value: 'notification',
              label: 'Notification 通知'
            }]
          }, {
            value: 'navigation',
            label: 'Navigation',
            children: [{
              value: 'menu',
              label: 'NavMenu 导航菜单'
            }, {
              value: 'tabs',
              label: 'Tabs 标签页'
            }, {
              value: 'breadcrumb',
              label: 'Breadcrumb 面包屑'
            }, {
              value: 'dropdown',
              label: 'Dropdown 下拉菜单'
            }, {
              value: 'steps',
              label: 'Steps 步骤条'
            }]
          }, {
            value: 'others',
            label: 'Others',
            children: [{
              value: 'dialog',
              label: 'Dialog 对话框'
            }, {
              value: 'tooltip',
              label: 'Tooltip 文字提示'
            }, {
              value: 'popover',
              label: 'Popover 弹出框'
            }, {
              value: 'card',
              label: 'Card 卡片'
            }, {
              value: 'carousel',
              label: 'Carousel 走马灯'
            }, {
              value: 'collapse',
              label: 'Collapse 折叠面板'
            }]
          }]
        }, {
          value: 'ziyuan',
          label: '资源',
          children: [{
            value: 'axure',
            label: 'Axure Components'
          }, {
            value: 'sketch',
            label: 'Sketch Templates'
          }, {
            value: 'jiaohu',
            label: '组件交互文档'
          }]
        }],
        selectedOptions: [],
        tableData:[
            {
                id:22,
                firstDirectory:'汽车',
                secondDirectory:'轮胎',
                ThreeDirectory:'方向盘',
                name:'润滑油',
                picture:'../../assets/image/koala1.jpg',
                number:555,
                state:'启用',
                setTime:'2018/10/10'
            }
        ],
        value:"",
        }
    },
    methods: {
        handleChange(value) {
        console.log(value);
      }
    }
}
</script>

<style scoped>
    
    .bread{
        margin: 10px;
    }
    .content{
        background: white;
        margin-left: 10px;
        margin-right: 10px;
        height: calc(100vh - 87px);
        width: calc(100vw - 221px);
        border-radius: 2px;
    }
    .title{
        text-align: left;
        padding: 10px;
        padding-left: 20px;
        font-size: 14px;
        border-bottom: 1px solid #f2f2f2;
    }
    .content_contain{
        padding: 30px 55px;
        box-sizing: border-box;
        
    }
    .sle-til{
        display: flex;
        border-bottom: 1px solid #bfbfbf;
    }
    .sle-til>div{
        width: 110px;
        height: 35px;
        line-height: 35px;
        text-align: center;
        border: 1px solid #bfbfbf; 
        color: #999999;
        margin-right: 20px;
        margin-bottom: 20px;
    }
    .choice{
        display: flex;justify-content: space-between;margin-top: 35px;
    }
    .lianji{width: 240px;height: 30px;line-height: 30px;}
    .search{display: flex;justify-content: space-between;}
    .search>div{margin-right: 20px;}
    .tables{margin-top: 15px;}
    .brands{}
    .brand{width: 145px;height: 30px;background: #15bafe;display: flex;justify-content: space-between;border: 1px solid #15bafe;}
    .electric{width: 210px;height: 30px;background: #15bafe;display: flex;justify-content: space-between;border: 1px solid #15bafe;}
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0}
    .brands>div{float: left;margin:9px;line-height: 30px;}
    .brand>div:first-child{text-align: center;width: 70%;}
    .brand>div:last-child{text-align: center;width: 30%;background: #fff;}
    .electric>div:first-child{text-align: center;width: 50%;}
    .electric>div:last-child{text-align: center;width: 50%;background: #fff;}
    .box{width: 240px;height: 170px;margin: 20px;}
    .box>img{width: 100%;height: 100%;}
    .disable{width: 85px;height: 35px;background: #ff5858;margin: 0 auto;text-align: center;line-height: 35px;color: #fff;}
    .big-box{width: 100%;}
</style>
<style lang="less">
.lianji{
  .el-input{
    // width: 100%;
    height: 30px;
    line-height: 30px;
    .el-input__inner{height: 30px;}
  }
}
.search{
    .el-input{
      height: 30px;
      .el-input__inner{height: 30px;}
    }
}
.time{
  .el-select{
    .el-input{
      .el-input__inner{height: 30px;}
    }
  }
}    
    
    .el-input__icon{line-height:30px;}
    .el-table th{
        background-color: #15bafe;
    }
    .el-table thead{
        color: #fff;
    }
    .el-table th>.cell{
        text-align: center;
    }
    .el-pagination{margin-top:35px;}
</style>
