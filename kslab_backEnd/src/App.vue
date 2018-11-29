<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
}
  /*弹出框基础样式*/
  .el-dialog__wrapper{
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .el-dialog{
    margin: 0 !important;
  }
</style>
