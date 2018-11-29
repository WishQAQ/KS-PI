<template>
  <div class="commerEnd">
      <div class="titile_End">
          <p>提示</p>
          <img src="/static/img/icon/End.png" alt="">
      </div>
      <div class="commerEnd_body">
        <p>此操作会导致用户无法再购买，但已购用户可以继续使用？</p>
        {{rescvggg}}
      </div>
      <div class="commerEnd_right">
        <button type="button" name="button" class="buttonWird">取消</button>
        <button type="button" name="button" class="buttonBlue">确定</button>
      </div>
  </div>
</template>

<script>
export default {
  props:['type'],
  data(){
    return{
      EndFalse:''
    }
  },
  computed:{
     rescvggg:()=>{
       return this.EndFalse = this.type
     }
  }
}
</script>

<style lang="css">
.buttonBlue{
  color:#FFF;
  border:1px solid #15befe;
  background-color: #15befe;
  border-radius: 3px;
}
.buttonWird{
  color:#999999;
  border:1px solid #999999;
  background-color: #FFF;
  border-radius: 3px;
}
.commerEnd_right>button{
  padding: 3px 15px 3px 15px;
  margin-left: 15px;
}
.commerEnd_right{
  text-align: right;
  padding-right: 27px;
  margin-top: 35px;
}
.commerEnd{
  width: 300px;
  height:250px;
  position: absolute;
  top:50%;
  left:50%;
  margin-left: -150px;
  margin-top: -175px;
  z-index: 99;
  background-color: #FFF;
  box-shadow: 2px 2px 10px 2px #CCC;
}
.titile_End{
  height: 50px;
  text-align: center;
  background-color: #15bafe;
}
.titile_End>p{
  color:#FFF;
  font-size: 20px;
  position: relative;
  top:7px;
}
.titile_End>img{
  float: right;
  position: relative;
  top:-15px;
  right: 10px;
  cursor: pointer;
}
.commerEnd_body>p{
  color:#666666;
  font-size: 16px;
  padding: 15px;
  margin-top: 35px;
}
</style>
