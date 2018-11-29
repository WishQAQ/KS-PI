<template>
    <div>
      <p>我是test页面</p>
      <BreadCrumb :breadData="breadData"></BreadCrumb>
    </div>
</template>

<script>
  import BreadCrumb from '@/components/public/BreadCrumb'
    export default {
      name: "Test",
      data() {
        return {
          breadData:[{
            id: 1,
            name: '首页',
            urls: '/index',
            icon: 'icon-shouye'
          },{
            id: 2,
            name: '搜索',
            urls: '/index/test',
            icon: 'icon-shouye'
          }]
        }
      },
      components: {
        BreadCrumb
      }
    }
</script>

<style scoped>

</style>
