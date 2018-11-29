<template>
    <div class="body shopping_cart">
        <section>
            <div class="mod_shopping_cart">
                <div class="shopping_cart_title">
                    <i class="icon icon_cart"></i>
                    <span class="shopping_cart_tab">我的购物车</span>
                    <span class="shopping_cart_art">SHOPPING CART</span>
                </div>
                <div class="shopping_cart_list">
                    <el-table
                            ref="shoppingCartList"
                            :data="tableData3"
                            tooltip-effect="dark"
                            style="width: 100%"
                            @selection-change="handleSelectionChange"
                            @select="handleSelect"
                            @select-all="handleSelectAll">
                        <el-table-column
                                type="selection"
                                width="102"
                                align="center">
                        </el-table-column>
                        <el-table-column
                                label="商品"
                                width="468"
                                align="center">
                            <template slot-scope="scope">
                                <span class="cart_product_thumbnail">
                                    <img :src="scope.row.show_picture+'?imageView2/1/w/100/h/100'" alt="" width="100px" height="100px">
                                </span>
                                <div class="cart_product_detail">
                                    <p class="cart_detail_title" :title="scope.row.title">{{scope.row.title.length>30?scope.row.title.slice(0,30)+"...":scope.row.title}}</p>
                                    <p class="cart_detail_merchant">
                                        <i class="icon icon-ziyuan31"></i>
                                        <router-link to="/" class="merchant_link">{{scope.row.company_name}}</router-link>
                                    </p>
                                    <el-button icon="el-icon-service">联系商家</el-button>
                                </div>
                            </template>
                        </el-table-column>
                        <el-table-column
                                prop="price"
                                label="单价"
                                width="200"
                                align="right">
                                <template slot-scope="scope">¥<span class="unit_price">{{scope.row.price}}</span></template>
                        </el-table-column>
                        <el-table-column label="数量" width="156" align="center">
                            <template   slot-scope="scope">
                                <el-input-number v-model="scope.row.quantity" @change="handleChange(scope.row.quantity,scope.row.stock,scope.row.cart_id)" :min="1" label="描述文字"></el-input-number>
                                <p class="product_stock" v-if="scope.row.quantity>scope.row.stock">(库存:{{scope.row.stock}})</p>
                            </template>
                        </el-table-column>
                        <el-table-column label="小计" width="154" align="center">
                            <template slot-scope="scope">
                                <i class="icon icon_price"></i>
                                <span class="subtotal">{{parseFloat(scope.row.quantity*scope.row.price).toFixed(2)}}</span>
                            </template>
                        </el-table-column>
                        <el-table-column label="操作" width="120" align="center">
                            <template slot-scope="scope"><i class="el-icon-delete" @click="removeProduct(scope.$index,scope.row)" style="font-size:16px;"></i></template>
                        </el-table-column>
                        <div slot="empty">
                            <div>
                                <i class="icon icon_emptyCart" style="margin-right:10px"></i>
                                <span class="empty_txt">您的购物车是空的，去选选您心仪的商品吧</span>
                            </div>
                        </div>
                    </el-table>
                </div>
                <div class="shopping_cart_total">
                    <label>
                        <span aria-checked="mixed" class="el-checkbox__input" :class="{'is-checked':isChecked,'is-disabled':isDisabled}" @click.prevent="toggleChecked">
                            <span class="el-checkbox__inner"></span>
                            <input type="checkbox" aria-hidden="true" class="el-checkbox__original" value="">
                        </span>
                        <span class="checkbox_txt">全选</span>
                    </label>
                    <span class="remove_select" @click="removeSelect">删除选中商品</span>
                    <div class="floatRight">
                        <span class="selected_txt">已选择<span class="selected_num">{{this.totalSelects}}</span>件商品</span>
                        <span class="selected_product_price">商品总价<span class="product_total_price">¥{{parseFloat(totalPrice).toFixed(2)}}</span></span>
                        <a href="javascript:;" class="close_an_account" :class="{active:isActive}" @click="goPay">去结算</a>
                    </div>
                </div>
                <div class="fixed" v-show="fixedShow">
                    <div class="shopping_cart_total">
                        <label>
                            <span aria-checked="mixed" class="el-checkbox__input" :class="{'is-checked':isChecked,'is-disabled':isDisabled}" @click.prevent="toggleChecked">
                                <span class="el-checkbox__inner"></span>
                                <input type="checkbox" aria-hidden="true" class="el-checkbox__original" value="">
                            </span>
                            <span class="checkbox_txt">全选</span>
                        </label>
                        <span class="remove_select" @click="removeSelect">删除选中商品</span>
                        <div class="floatRight">
                            <span class="selected_txt">已选择<span class="selected_num">{{this.totalSelects}}</span>件商品</span>
                            <span class="selected_product_price">商品总价<span class="product_total_price">¥{{parseFloat(totalPrice).toFixed(2)}}</span></span>
                            <a href="javascript:;" class="close_an_account" :class="{active:isActive}" @click="goPay(totalPrice)">去结算</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <aside>
            <floating-div></floating-div>
        </aside>
        <delete-modal ref="delete" @confirm="confirmDelete"></delete-modal>
    </div>
</template>

<script>

    import FloatingDiv from '@/components/floating'
    import DeleteModal from '@/components/deleteModal'


    export default {
        name: "shoppingCart",
        data(){
            return {
                tableData3: [],//购物车数据
                multipleSelection: [],//选中商品列表
                totalSelects:0,//选中总数量
                totalPrice:0,//选中总价格
                isChecked:false,
                isActive:false,//是否有选中商品
                fixedShow:false,
                deleteIndex:null,
                isDisabled:false,
                id:'',//删除单个商品id
                ids:[],//删除多个商品id列表
            }
        },
        components:{
            FloatingDiv,
            DeleteModal
        },
        methods:{
            handleSelectionChange(val) {
                this.multipleSelection = val;
                this.isActive=val.length>0;
                this.aggregate();
            },
            handleChange(value,stock,id) {//商品数量变化
                this.aggregate();
                if(value>stock){
                    value=stock;
                }
                let token=window.localStorage.getItem('token');
                this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'shoppingCart/changeNumByInputValue',{
                    token: token,
                    cart_id:id,
                    quantity:value
                }).then((res)=>{
                    console.log(res);
                    if(res.data.code===200){

                    }else if(res.data.code===-1){
                        this.$message.error('操作失败,请重试!')
                    }
                    this.getCartList()
                }).catch((err)=>{
                    console.log(err);
                })
            },
            handleSelect(selection,row){//选中商品
                if(selection.length>0){
                    let arr=[];
                    for(let item of selection){
                        arr.push(item.cart_id);
                    }
                    this.ids=arr;
                }else{
                    this.ids.length=0
                }
                console.log(this.ids);
                if(selection.length===this.tableData3.length){
                    this.isChecked=true;
                }else if(selection.length>0){
                    this.isChecked=false;
                }else{
                    this.isChecked=false;
                }
            },
            handleSelectAll(selection){//选中所有商品
                if(selection.length>0){
                    let arr=[];
                    for(let item of selection){
                        arr.push(item.cart_id);
                    }
                    this.ids=arr;
                }else{
                    this.ids.length=0
                }
                this.isChecked=selection.length>0;
            },
            removeProduct(index,row){//删除当前商品
                this.$refs.delete.modelDelete=true;
                this.deleteIndex=index;
                this.id=row.cart_id;
            },
            confirmDelete(isSingle){//发起删除请求
                if(isSingle){
                    this.tableData3.splice(this.deleteIndex,1);
                    this.deleteProduct(this.id);
                }else{
                    this.multipleSelection.forEach(selectedItem => {
                        this.tableData3.splice(this.tableData3.indexOf(selectedItem),1);
                    });
                    this.multipleSelection.length=0;
                    this.isChecked=false;
                    if(this.ids.length>1) {
                        this.deleteProduct(this.ids)
                    }else{
                        this.deleteProduct(this.ids[0])
                    }
                }
            },
            toggleChecked(){//全选按钮事件
                if(!this.isDisabled){
                    if(this.isChecked){
                        this.isChecked=false;
                        this.$refs.shoppingCartList.clearSelection();
                    }else if(this.isIndeterminate){
                        this.isChecked=true;
                        this.$refs.shoppingCartList.toggleAllSelection();
                    }else{
                        this.isChecked=true;
                        this.$refs.shoppingCartList.toggleAllSelection();
                    }
                }
            },
            removeSelect(){//删除选中商品
                console.log(this.ids);
                if(this.ids.length>0){
                    this.$refs.delete.modelDelete = true;
                    this.$refs.delete.isSingle = false;
                }
            },
            goPay(totalPrice){//支付
                if(this.isActive){
                    console.log(this.multipleSelection);
                    let arr=[],
                        product={};
                    this.multipleSelection.forEach((item)=>{
                        arr.push(item.cart_id);
                        product[item.product_id]=item.quantity
                    });
                    console.log(product);
                    let token=window.localStorage.getItem('token');
                    this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'shoppingCart/balance',{
                        params: {
                            token:token,
                            cart_id:arr
                        }
                    }).then((res)=>{
                        console.log(res);
                        if(res.data.code===200) {
                            this.$router.push({
                                name: 'closeAccount',
                                query: {result: res.data,product}
                            })
                        }
                    }).catch((err)=>{
                        console.log(err);
                    })
                }
            },
            aggregate(){//总计
                if(this.multipleSelection.length>0) {
                    this.totalPrice=0;
                    this.totalSelects=0;
                    this.multipleSelection.forEach(selectedItem => {
                        this.totalPrice += selectedItem.price * selectedItem.quantity;
                        this.totalSelects +=selectedItem.quantity;
                    })
                }else{
                    this.totalPrice=0;
                    this.totalSelects=0;
                }
            },
            handleScroll(){//总计悬浮条位置
                let scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop;
                let times=Math.ceil(($(document).height()-$(window).height())/100);
                let num=parseInt(scrollTop/100);
                this.fixedShow=num<=times-3;
            },
            getCartList(){//获取购物车商品列表
                let token=window.localStorage.getItem('token');
                this.$ajax.get(this.request.axiosPort+this.request.axiosApi+'shopping/cart',{
                    params: {
                        token:token
                    }
                }).then((res)=>{
                    console.log(res);
                    let {code,msg,data} = res.data;
                    if(code===200) {
                        this.tableData3 = data;
                    }
                }).catch((err)=>{
                    console.log(err);
                })
            },
            deleteProduct(id){//删除商品
                let token=window.localStorage.getItem('token');
                this.$ajax.post(this.request.axiosPort+this.request.axiosApi+'shoppingCart/removeProducts',{
                    token: token,
                    cart_id:id,
                }).then((res)=>{
                    if(res.data.code===200){
                        this.$message.success('删除成功!');
                        this.getCartList()
                    }
                }).catch((err)=>{
                    console.log(err);
                })
            }
        },
        created(){
            this.getCartList()
        },
        mounted () {
            window.addEventListener('scroll', this.handleScroll);
            if(this.tableData3.length<=0){
                this.isDisabled=true;
            }
        },
        updated(){
            this.isDisabled=this.tableData3.length<=0;
        }
    }
</script>

<style src="@/assets/css/shoppingCart.css"></style>
<style scoped>
    .shopping_cart{
        min-height:69.8vh;
    }
    .mod_shopping_cart{
        width:1200px;
        margin:0 auto;
      padding: 30px 0;
        min-width:1200px;
    }
    .mod_shopping_cart .icon{
        width:20px;
        height:20px;
        text-align:center;
        vertical-align:middle;
    }
    .mod_shopping_cart .shopping_cart_tab{
        font-size:20px;
        vertical-align:middle;
        margin:0 10px 0;
    }
    .mod_shopping_cart .shopping_cart_art{
        color:#e5e5e5;
        font-size:24px;
        font-style:italic;
        vertical-align: middle;
    }
    .mod_shopping_cart .cart_detail_title{
        width:260px;
    }
    .mod_shopping_cart .merchant_link{
        text-decoration: underline;
        font-size: 14px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 20px;
        letter-spacing: 0;
        color: #898989;
    }
    .mod_shopping_cart .merchant_link:hover{
        color:#15bafe;
    }
    .shopping_cart_list .product_stock{
        position:absolute;
        bottom:20px;
        width:100%;
        color:red;
        text-align:center;
        padding-right:15px;
    }
</style>
<style>
    .shopping_cart_list .el-table_1_column_4{
        position:relative!important;
    }
</style>
