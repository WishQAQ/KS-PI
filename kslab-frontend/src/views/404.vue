<template>
    <div class="notFound">
      <div class="notFound_info">
        <h2>抱歉，您访问的页面正在维修</h2>
        <p>SORRY , The page you are visiting is being repaired</p>
        <router-link to="home/index">返回主页</router-link>
      </div>
    </div>
</template>

<script>
    export default {
        name: "404"
    }
</script>

<style scoped>
  .notFound{
    text-align: center;
    background: url("/static/img/404.jpg") no-repeat;
    background-size: 100%;
    width: 100vw;
    height: 100vh;
  }
  .notFound_info{
    padding-top: 5vw;
  }
  .notFound_info h2{
    color: #15bafe;
    font-size: 1.6vw;
  }
  .notFound_info p{
    font-size: .8vw;
    color: #ccc;
    margin-bottom: 1.1vw;
    text-transform: uppercase;
  }
  .notFound_info a{
    font-size: .7vw;
    color: #fff;
    padding: .4vw 1vw;
    margin: 0 auto;
    border-radius: 5px;
    background-color: #15bafe;
  }
</style>
