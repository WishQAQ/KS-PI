<template>
  <div class="opinion">

    <div class="opinion_box width_1200">

      <div class="opinion_banner"><img src="/static/img/opinion_banner.png" alt=""></div>

      <div class="opinion_select">

        <el-select v-model="value" placeholder="选择发生的问题" @change="onclickPrpos()">
          <el-option
            v-for="item in options"
            :key="item.id"
            :label="item.name"
            :value="item.id">
          </el-option>
        </el-select>

      </div>

      <div class="opinion_ue">
        <quill-editor
          v-model="content"
          ref="myQuillEditors"
          :options="editorOption"
          @blur="onEditorBlur($event)" @focus="onEditorFocus($event)"
          @change="onEditorChange($event)">
        </quill-editor>
      </div>


      <div class="opinion_qq">
        <p>(选填，方便我们与你联系，保密不公开)</p>
        <div class="opinion_input">
          <el-input v-model="input1">
            <template slot="prepend">email</template>
          </el-input>
        </div>
      </div>

      <div class="opinion_btn">
        <button type="submit" @click="onclickSubmit">提交</button>
      </div>

    </div>

  </div>
</template>

<script>

  export default {
    name: "opinion",
    components: {},
    data() {
      return {
        options: null,
        value: '',
        input1: '',  //email内容
        content: null,
        editorOption: {
          modules: {
            toolbar: [
              ['bold', 'italic', 'underline', 'strike'],
              ['blockquote', 'code-block']
            ]
          }
        },
        routerName: '',
        articleDataGather: '',
        arrayDetails: '',
        article_details_title: [{
          praise: '',
          state: 0
        }],
        articleReviews: '',   //文章评论
        outerVisible: null,
        innerVisible: false,
        thiscc: 1,
        isAutoTrue: false,
        isAuto: true,
        commentLength: '',  //回复评论参数
        commentFont: ''   //富文本编辑内容
      }
    },
    methods: {
      onEditorBlur() {//失去焦点事件
      },
      onEditorFocus() {//获得焦点事件
      },
      onEditorChange(event) {//内容改变事件
        this.commentFont = event.html
      },
      onclickPrpos() {
        console.log(this.value)
      },
      onclickSubmit() {
        const param = {
          type_id: this.value,
          content: this.commentFont,
          email: this.input1
        };
        this.HttpClient.post('/footer/opinions', param)
          .then(res => {
            if (res.data.code === 200) {
              this.$message.success('提交成功');
              this.value = '';
              this.commentFont = '';
              this.input1 = '';
              const quill = this.$refs['myQuillEditors'].quill;
              quill.container.querySelector('.ql-editor').innerHTML = ''
            } else {
              this.$message.error(res.data.msg);
            }
          });
      }
    },
    created() {
      this.HttpClient.post('/footer/opinions/type')
        .then(res => {
          if (res.data.code === 200) {
            this.options = res.data.data;
          }
        });
    }
  }
</script>

<style src="../../assets/css/opinion.css"></style>
