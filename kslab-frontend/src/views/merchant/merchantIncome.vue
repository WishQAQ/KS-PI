<template>
    <div class="merchant_income">
        <div></div>
        <commercial-info-header></commercial-info-header>
        <section>
            <div class="merchant_income_body">
                <div class="preview_account">
                    <div class="preview_month preview_account_item">
                        <div class="preview_month_content">
                            <span class="preview_content_title">
                                <i class="content_title_icon"></i>
                                <span class="content_title_txt">本月</span>
                            </span>
                            <span class="preview_content_price">¥{{totalIncome.month}}</span>
                        </div>
                    </div>
                    <div class="preview_week preview_account_item">
                        <div class="preview_week_content">
                            <span class="preview_content_title">
                                <i class="content_title_icon"></i>
                                <span class="content_title_txt">本周</span>
                            </span>
                            <span class="preview_content_price">¥{{totalIncome.week}}</span>
                        </div>
                    </div>
                    <div class="preview_yesterday preview_account_item">
                        <div class="preview_yesterday_content">
                            <span class="preview_content_title">
                                <i class="content_title_icon"></i>
                                <span class="content_title_txt">昨天</span>
                            </span>
                            <span class="preview_content_price">¥{{totalIncome.yesterday}}</span>
                    </div>
                    </div>
                    <div class="preview_today preview_account_item">
                        <div class="preview_today_content">
                            <span class="preview_content_title">
                                <i class="content_title_icon"></i>
                                <span class="content_title_txt">今天</span>
                            </span>
                            <span class="preview_content_price">¥{{totalIncome.today}}</span>
                        </div>
                    </div>
                    <div class="balance_account preview_account_item">
                        <p class="balance_account_num">¥{{totalIncome.balance}}</p>
                        <p class="balance_account_control">
                            <span class="balance_account_txt">总余额</span>
                            <span class="balance_account_button" @click="withdrawDeposit">
                                <i class="balance_icon"></i>
                                <span class="button_txt">提现</span>
                            </span>
                        </p>
                    </div>
                </div>
                <commercial-month v-show="switChover" @comMercialemit="emitMsg"></commercial-month>
                <commercial-income :dateDaild="date" v-show="!switChover" @onClickIncome="emitTrue"></commercial-income>
                <div class="balance_serial" @click="showBalance">
                    <button class="balance_serial_btn">收支总流水</button>
                    <span class="el-icon-back" :class="{iconBackDown:iconBack}"></span>
                </div>
                <div class="balance_serial_list" :class="{show:isShow}">
                    <el-table
                            :data="tableData"
                            style="width: 100%">
                        <el-table-column
                                label="日期"
                                width="279">
                                <template slot-scope="scope">
                                    {{scope.row.created_at?scope.row.created_at.slice(0,11):''}}
                                </template>
                        </el-table-column>
                        <el-table-column
                                prop="message"
                                label="详细信息"
                                width="428">
                        </el-table-column>
                        <el-table-column
                                label="金额"
                                width="286">
                                <template slot-scope="scope">
                                    <span class="balance_serial_money" :class="{down:scope.row.amount<=0}">¥{{ scope.row.amount }}</span>
                                    <i class="balance_serial_icon" :class="{decline:scope.row.amount<=0}"></i>
                                </template>
                        </el-table-column>
                        <el-table-column
                                prop="balance"
                                label="余额">
                        </el-table-column>
                    </el-table>
                    <div class="comment_pagination" v-if="balanceSerial.total">
                        <el-pagination
                                small
                                background
                                layout="prev, pager, next"
                                :page-count="Math.ceil(balanceSerial.total/pageSize)"
                                @current-change="currentPage"
                                @prev-click="prevPage"
                                @next-click="nextPage">
                        </el-pagination>
                    </div>
                </div>
                <div class="withdraw_deposit modalBox" v-if="showWithdraw">
                    <div class="modalBox_title">
                        <p><img src="/static/img/logo/logo_block.png" alt=""></p>
                        <div class="modelDelete" @click="cancelClick">
                            <p></p>
                            <p></p>
                        </div>
                    </div>
                    <div class="withdraw_deposit_body">
                        <div class="bank_select">
                            <span class="withdraw_deposit_title">
                                提款到
                            </span>
                            <div class="bank_list_box">
                                <span class="bank_select_list">
                                    <span class="bank_select_item" :class="{active:isSelect}" @click="bankSelect">
                                        <img src="/static/img/icon/icbc.png" alt="">
                                        <i class="select_box"></i>
                                    </span>
                                    <span class="bank_select_item">
                                        <img src="/static/img/icon/ccb.png" alt="">
                                    </span>
                                    <span class="bank_select_item">
                                        <img src="/static/img/icon/icbc.png" alt="">
                                    </span>
                                    <span class="bank_select_item">
                                        <img src="/static/img/icon/ccb.png" alt="">
                                    </span>
                                    <span class="bank_select_item">
                                        <img src="/static/img/icon/icbc.png" alt="">
                                    </span>
                                    <span class="bank_select_item">
                                        <img src="/static/img/icon/ccb.png" alt="">
                                    </span>
                                </span>
                            </div>
                            <p class="bank_card_info">
                                <input type="text" placeholder="请输入银行账号" class="bank_card_num">
                                <input type="text" placeholder="收款人姓名" class="bank_card_name">
                            </p>
                        </div>
                        <div class="extract_money">
                            <span class="withdraw_deposit_title">
                                提取金额
                            </span>
                            <span class="extract_money_input">
                                <input type="text" placeholder="输入提取金额...">
                                元
                            </span>
                            <span class="current_balance">
                                <span class="current_balance_txt">当前余额</span>
                                <span class="current_balance_num">
                                    <span class="current_balance_symbol">¥</span>896
                                </span>
                            </span>
                        </div>
                    </div>
                    <div class="withdraw_deposit_confirm_box">
                        <span class="withdraw_deposit_cancel" :class="{active:!isActive}" @mouseenter="changeActive($event)" @click="cancelClick">取消</span>
                        <span class="withdraw_deposit_confirm" :class="{active:isActive}" @mouseenter="changeActive($event)" @click="confirm">确定</span>
                    </div>
                </div>
            </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
    </div>
</template>

<style src="@/assets/css/modalBox.css"></style>
<script>

    import FloatingDiv from '@/components/floating'
    import CommercialInfoHeader from '@/components/commercialInfoHeader'
    import CommercialIncome from '@/views/merchant/commercialIncome'
    import CommercialMonth from '@/views/merchant/CommercialMonth'


    export default {
        name: "merchantIncome",
        data(){
            return {
                totalIncome:{},//收入总览
                balanceSerial:{},//收支流水
                pageSize:7,//流水显示条数
                year:'',//年
                month:'',//月
                day:'',//日
                showWithdraw:false,
                isSelect:false,
                isActive:true,
                isShow:false,
                tableData: [],//收支流水数据
                activePage:1,//收支流水当前页
                switChover:true,
                date:null,//收支详情表当前选择日期
                iconBack:false,
            }
        },
        components:{
            FloatingDiv,
            CommercialInfoHeader,
            CommercialIncome,
            CommercialMonth,
        },
        methods:{
            withdrawDeposit(){
                this.showWithdraw=true
            },
            cancelClick(){
                this.showWithdraw = false
            },
            confirm(){
                this.$message.success('您点击了确定按钮！');
                this.showWithdraw = false
            },
            bankSelect(){
                this.isSelect=true
            },
            changeActive(e){
                if(!$(e.currentTarget).is('.active')){
                    this.isActive=!this.isActive
                }
            },
            //收支流水
            showBalance(){
                this.isShow=!this.isShow;
                this.iconBack=!this.iconBack;
                if(this.tableData.length<=0){
                    this.getSerial()
                }
            },
            /****分页****/
            currentPage(val){
                this.activePage=val;
                this.getSerial(this.activePage)
            },
            prevPage(val){
                // this.$message.warning('当前页:'+val);
            },
            nextPage(val){
                // this.$message.warning('当前页:'+val);
            },
            //获取收支流水数据
            getSerial(){
                this.HttpClient.post('/web/user/incomeList',{size:this.pageSize,page:this.activePage})
                    .then(res=>{
                        console.log(res);
                        if(res.data.code===200){
                            this.balanceSerial=res.data.data;
                            this.tableData=res.data.data.data;
                        }
                    })
            },

            //收支详情月事件处理
            emitMsg(msg){
                this.date = msg;
                this.switChover = false;
            },
            //收支详情日事件处理
            emitTrue(msg){
                this.switChover = msg
            },
        },
        created(){
            this.HttpClient.post('/web/user/incomeNum')
                .then(res=>{
                    console.log(res);
                    if(res.data.code===200){
                        this.totalIncome=res.data.data;
                    }
                });
        }
    }
</script>

<style scoped>
    .merchant_income{
        background:#f2f2f2;
        padding:30px 0;
    }
    .merchant_income_body{
        max-width:1200px;
      min-width: 960px;
        margin:0 auto;
    }
    .merchant_income_body .preview_account{
        display:flex;
        justify-content:space-between;
    }
    .merchant_income_body .preview_account_item{
        width:228px;
        height:91px;
        line-height:91px;
        background:#fff;
        font-size: 21px;
        font-weight: normal;
        font-stretch: normal;
        letter-spacing: 0;
        color: #222222;
    }

    .preview_month_content{
      display: flex;
      align-items: center;
    }

    .merchant_income_body .balance_account{
        color:#fff;
        background:#15bafe;
    }
    .preview_content_title{
        margin-left:32px;
    }
    .preview_content_title .content_title_icon{
        display:inline-block;
        width:33px;
        height:35px;
        vertical-align:middle;
    }
    .preview_content_title .content_title_txt{
        color:#656565;
        font-size:16px;
        margin-left:22px;
        margin-right:19px;
    }
    .preview_month_content .content_title_icon{
        background:url('/static/img/icon/previewMonth.png') center center no-repeat;
    }
    .preview_week_content{
      display: flex;
      align-items: center;
    }
    .preview_week_content .content_title_icon{
        background:url('/static/img/icon/previewWeek.png') center center no-repeat;
    }
    .preview_yesterday_content .content_title_icon{
        background:url('/static/img/icon/previewYesterday.png') center center no-repeat;
    }
    .preview_today_content .content_title_icon{
        background:url('/static/img/icon/previewToday.png') center center no-repeat;
    }

    .preview_yesterday_content,
    .preview_today_content{
      display: flex;
      align-items: center;
    }
    /*余额*/
    .balance_account{
        padding:19px 29px 0 29px;
        line-height:1!important;
    }
    .balance_account .balance_account_num{
        font-size:34px;
        margin-bottom:14px;
    }
    .balance_account .balance_account_control{
        font-size: 14px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .balance_account .balance_account_control .balance_icon{
        display:inline-block;
        width:14px;
        height:16px;
        vertical-align:middle;
        background:url('/static/img/icon/balance_icon.png') center center no-repeat;
    }
    .balance_account .balance_account_control .balance_account_button{
        cursor:pointer;
    }
    /*提现框*/
    .withdraw_deposit{
        position:fixed;
        top:50%;
        left:50%;
        margin-left: -305px;
        margin-top: -200px;
        width:610px;
        height:400px;
        background:#fff;
    }
    .modalBox_title{
         border-bottom:1px solid #f4f4f4;
    }
    .withdraw_deposit_body{
        width:551px;
        margin-top:40px;
        margin-left:26px;
    }
    .withdraw_deposit_body .withdraw_deposit_title{
        position:relative;
        display:inline-block;
        width:70px;
        height:30px;
        color:#fff;
        font-size:14px;
        line-height:30px;
        text-align:center;
        padding-left:5px;
        background:#15bafe;
    }
    .withdraw_deposit_body .withdraw_deposit_title:after{
        position:absolute;
        top:0;
        right:-20px;
        display:inline-block;
        content:'';
        width:0;
        height:0;
        border: 15px solid transparent;
        border-right-width: 10px;
        border-left: 10px solid #15bafe;
    }
    .withdraw_deposit_body .bank_list_box{
        display:inline-block;
        margin-left:16px;
        vertical-align:top;
    }
    .withdraw_deposit_body .bank_select_list{
        display:flex;
        justify-content: space-between;
        flex-wrap:wrap;
        width:461px;
    }
    .withdraw_deposit_body .bank_select_list .bank_select_item{
        position:relative;
        display:block;
        width:145px;
        height:40px;
        cursor:pointer;
        text-align:center;
        margin-bottom:8px;
        padding-top:6px;
        border: solid 1px #e5e5e5;
    }
    .withdraw_deposit_body .bank_select_list .bank_select_item.active{
        border-color:#15bafe;
    }
    .withdraw_deposit_body .bank_select_list .select_box{
        position:absolute;
        bottom:0;
        right:0;
        display:block;
        width:13px;
        height:13px;
        background:url('/static/img/icon/select.png') center center no-repeat;
    }
    .withdraw_deposit_body .bank_select_list .bank_select_item.active .select_box{
        background:url('/static/img/icon/selected.png') center center no-repeat;
    }
    .withdraw_deposit_body .bank_select_list .bank_select_item img{
        width:95px;
        height:26px;
    }
    .withdraw_deposit_body .bank_card_info{
        text-align:right;
    }
    .withdraw_deposit_body input{
        height:30px;
        background:#f2f2f2;
        border:none;
        padding-left:10px;
        box-sizing:border-box;
    }
    .withdraw_deposit_body input::-webkit-input-placeholder {
         /* placeholder颜色  */
         color: #999;
        /* placeholder字体大小  */
         font-size: 12px;
        /* placeholder位置  */
          text-align: left;
    }
    .withdraw_deposit_body .bank_card_info .bank_card_num{
        width:320px;
        margin-right:26px;
    }
    .withdraw_deposit_body .bank_card_info .bank_card_name{
        width:112px;
    }
    /****提取金额****/
    .withdraw_deposit_body .extract_money{
        position:relative;
        margin-top:24px;
    }
    .withdraw_deposit_body .extract_money .extract_money_input{
        margin-left:16px;
        color:#999;
    }
    .withdraw_deposit_body .extract_money .extract_money_input input{
        width:245px;
    }
    .withdraw_deposit_body .extract_money .current_balance{
        display:inline-block;
        height:30px;
        line-height:30px;
        position:absolute;
        right:0;
        bottom:0;
        color:#999;
        font-size:14px;
    }
    .withdraw_deposit_body .extract_money .current_balance_num{
        margin-left:20px;
        color:#15bafe;
        font-size:20px;
    }
    .withdraw_deposit_body .extract_money .current_balance_num .current_balance_symbol{
        font-size:14px;
    }
    /*************************操作按钮***************************/
    .withdraw_deposit_confirm_box{
        margin-top:70px;
        margin-right:33px;
        text-align:right;
    }
    .withdraw_deposit_confirm_box span{
        font-size: 16px;
        letter-spacing: 0;
        color: #15bafe;
        cursor:pointer;
        padding:5px 24px;
        border:1px solid #15bafe;
        border-radius:5px;
    }
    .withdraw_deposit_confirm_box span.withdraw_deposit_confirm{
        margin-left:12px;
    }
    .withdraw_deposit_confirm_box span.active{
        color:#fff;
        background:#15bafe;
    }
    /******************************************收支总流水*********************************************/
    .balance_serial{
        width:150px;
        margin-top:21px;
        cursor:pointer;
      display: flex;
      align-items: center;
    }
    .balance_serial .balance_serial_btn{
        width:110px;
        height:40px;
        color:#fff;
        cursor:pointer;
        background:#15bafe;
        border:none;
      margin-right: 2px;
    }
    .balance_serial .el-icon-back{
        display:inline-block;
        width:40px;
        height:40px;
        line-height:40px;
        text-align:center;
        font-size:16px;
        color:#fff;
        cursor:pointer;
        background:#15bafe;
        transform:rotate(180deg);
      transition: all .3s;
    }
    
    .iconBackDown{
      transform:rotate(270deg) !important;
    }
    
    .balance_serial_list{
        height:0;
        margin-top:25px;
        background:#fff;
        overflow:hidden;
        transition:height .5s ease-in-out;
    }
    .balance_serial_list.show{
        height:481px;
    }
    .balance_serial_list .comment_pagination{
        text-align:center;
        margin-top:26px;
        padding-bottom:30px;
    }
</style>
<style>
    .balance_serial_list .el-table__header{
        background:#f2f2f2;
    }
    .balance_serial_list .el-table thead tr th:first-child{
        border-top-left-radius:20px;
    }
    .balance_serial_list .el-table thead tr th:nth-child(4){
        border-top-right-radius:20px;
    }
    .balance_serial_list .el-table thead tr{
        background: linear-gradient(to left,#239df4,#2ab1f7,#239df4);
    }
    .balance_serial_list .el-table th{
        background:transparent;
    }
    .balance_serial_list .el-table th>.cell{
        color:#fff;
    }
    .balance_serial_list .el-table .cell{
        font-size:14px;
        color:#999;
    }
    .balance_serial_list .el-table th>.cell:before{
        display:inline-block;
        content:'';
        width:0;
        height:0;
        border: 7px solid #fff;
        border-right-width:1.5px;
        border-left-width:1.5px;
        margin-right:12px;
        margin-bottom:3px;
        vertical-align:middle;
    }
    .balance_serial_list .el-table_1_column_4 .cell:before{
        content:'¥'
    }
    .balance_serial_list .balance_serial_money{
        display:inline-block;
        padding:0 12px;
        color:#15bafe;
        border:1px solid #15bafe;
        border-radius:3px;
    }
    .balance_serial_list .balance_serial_money.down{
        color:#f55959;
        border-color:#f55959;
    }
    .balance_serial_list  .balance_serial_icon{
        display:inline-block;
        width:17px;
        height:17px;
        background:url('/static/img/icon/rise.png') center center no-repeat;
    }
    .balance_serial_list  .balance_serial_icon.decline{
        background:url('/static/img/icon/decline.png') center center no-repeat;
    }
    /*******分页********/
    .comment_pagination .el-pagination.is-background .btn-next, .el-pagination.is-background .btn-prev, .el-pagination.is-background .el-pager li{
        color:#999;
        min-width:22px;
        background:#fff;
    }
    .comment_pagination .el-pager li{
        height:20px;
        line-height:20px;
    }
    .comment_pagination .el-pagination button, .el-pagination span:not([class*=suffix]){
        height:20px;
        line-height:20px;
    }
    .comment_pagination .el-pagination.is-background .el-pager li:not(.disabled).active{
        background:#15bafe;
    }
    .comment_pagination .el-pagination.is-background .el-pager li:not(.disabled):hover{
        color:#15bafe;
    }
    .comment_pagination .el-pagination.is-background .el-pager li:not(.disabled).active{
        color:#fff;
    }
</style>
