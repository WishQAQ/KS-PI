/*const data = [{
  id: 1,
  name: '重庆',
  children: [{
    id: 11,
    name: '大足'
  },{
    id: 12,
    name: '渝北'
  },{
    id: 13,
    name: '万州'
  }]
},{
  id: 2,
  name: '四川',
  children: [{
    id: 21,
    name: '成都'
  },{
    id: 22,
    name: '双福'
  },{
    id: 23,
    name: '西北'
  }]
}];
const options = data.find(function (obj) {
  return obj.id === 2
});
console.log(options)*/
/*var str = "this is test string <img src=\"http:baidu.com/test.jpg\" width='50' > 1 and the end <img src=\"所有地址也能匹配.jpg\" /> 33! <img src=\"/uploads/attached/image/20120426/20120426225658_92565.png\" alt=\"\" />"
var imgReg = /<img.*?(?:>|\/>)/gi;
var srcReg = /src=[\'\"]?([^\'\"]*)[\'\"]?/i;
var arr = str.match(imgReg);  // arr 为包含所有img标签的数组
console.log(arr)


let imgArray = [];
for (var i = 0; i < arr.length; i++) {
  var src = arr[i].match(srcReg);
  imgArray.push(src[1]);
  //获取图片地址
  console.log('图片地址'+(i+1)+'：'+src[1]);
}
console.log(imgArray)
arr.map((item,index) =>{
  str = str.replace(item,'')
});
console.log(str)*/

/*let message = [];
let array = ['1','2','3'];
array.map((item) =>{
  message.push(item)
})
console.log(message)*/

/*let array;
let chatMessageList = [5,2,3,1,4]
array = chatMessageList.sort((a, b) =>{
  return parseInt(a) - parseInt(b)
});
console.log(array)*/

const data = {
  name: 1,
  id: 2
};
for(let item in data) {
  console.log(item)
  console.log(data[item])
}



