<template>
  <el-tooltip placement="bottom-start" popper-class="userModal_box" :visible-arrow="false">
    <div slot="content">
      <div class="userModal">
        <div class="userModal_banner"><img src="/static/img/others_banner.jpg" alt=""></div>
        <div class="userModal_text">
          <div class="userModal_avatar"><img src="/static/img/avatar/avatar.jpg" alt=""></div>
          <div class="userModal_info">
            <p>柯柯的椅子哭了</p>
            <span>知男而上强人所男左右为男男上加男</span>
          </div>
        </div>

        <div class="userModal_energy">
          <span class="userModal_energy_line"></span>
          <div class="userModal_energy_icon">
            <i class="icon icon-ziyuan39"></i>
            <div class="userModal_energy_name">
              <p>电量</p>
              <span>Electric</span>
            </div>
          </div>
          <div class="userModal_energy_schedule">
            <div class="userModal_schedule_bar"><span style="width: 37%;"></span></div>
            <div class="userModal_schedule_text">
              <p>0</p>
              <span>当前电量：37mAh</span>
              <p>100</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <span>追猪少年王德发</span>
  </el-tooltip>
</template>

<script>
    export default {
        name: "userModal"
    }
</script>

<style src="../assets/css/userModal.css"></style>
