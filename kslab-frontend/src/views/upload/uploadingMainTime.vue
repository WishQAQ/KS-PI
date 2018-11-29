<template>
    <div class="uploading_main_item uploading_main_time">
        <div class="main_head">
            <i class="icon icon_title"></i>
            <span class="main_txt">活动时间</span>
        </div>
        <div class="main_time_date">
            <select name="" id="">
                <option value="">长期</option>
                <option value="">定时</option>
            </select>
            <span class="time_date_activity">
                <span class="time_date_activity_txt">活动时间</span>
                <lay-date ref="activityDate"></lay-date>
            </span>
            <span class="time_date_activity">
                <span class="time_date_activity_txt">报名截止日期</span>
                <lay-date ref="deadLine"></lay-date>
            </span>
        </div>
    </div>
</template>

<script>

    import LayDate from '@/components/layDate'

    export default {
        name: "uploadingMainTime",
        components:{
            LayDate
        },
        mounted(){
            this.$refs.activityDate.output("activityDate");
            this.$refs.deadLine.output("deadline");
        }
    }
</script>

<style scoped>

</style>
