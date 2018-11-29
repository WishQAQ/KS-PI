<template>
  <el-dialog title="扫描二维码" width="290px" :visible.sync="qrCodeVisible">
    <div id="qrcode_active" class="img_qrcode"></div>
    <div slot="footer" class="dialog-footer">
      <el-button @click="qrCodeVisible = false">取 消</el-button>
      <el-button type="primary" @click="qrCodeVisible = false">确 定</el-button>
    </div>
  </el-dialog>
</template>

<script>
  import QRCode from 'qrcodejs2'

  export default {
    name: "qrCode",
    props: ['content'],
    components: {
      QRCode
    },
    data() {
      return {
        qrCodeVisible: false
      }
    },
    created() {

    },
    mounted() {

      //let qrcodes = document.getElementById('qrcode_active');//清除二维码
      /*console.log(qrcodes)
      if(qrcodes === null) {

      }else{
        qrcodes.innerHTML = '';
      }*/
      console.log(11111)

    },
    watch: {
      qrCodeVisible: function(newValue,oldValue){
        console.log(newValue)
        console.log(this.content)
        let qrcodes = document.getElementById('qrcode_active');//清除二维码
        console.log(qrcodes);
        if(qrcodes === null) {

        }else{
          qrcodes.innerHTML = '';
        }
          this.$nextTick (function () {
            this.handleQrCode(this.content);
          })
        }
      },
      methods: {
        /***
         * 初始化二维码
         */
      handleQrCode(str) {
        let c = document.getElementById('qrcode_active')
        console.log(c)
        let qrcode = new QRCode('qrcode_active', {
          width: 200,
          height: 200,
          text: str,//this.qrUrl
        });
        console.log(qrcode)
      }
    }
  }
</script>

<style scoped lang="less">
  .img_qrcode{
    width: 100%;
    height: 200px;
    text-align: -webkit-center;
  }
</style>
