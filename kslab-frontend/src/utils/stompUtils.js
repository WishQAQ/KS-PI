import Stomp from 'stompjs';
import * as cfg from "../../config/app";
import {HttpClient} from "./HttpUtils";
import store from '../store/store'
import moment from 'moment'
let stompClient;

export default class StompUtils {
  /***
   * 建立对话通道
   */
  static async connection(param) {
    let result;
    await HttpClient.post('/my/dialog/create',param).then(res =>{
      if(res.data.code === 200) {
        const messageData = {
          send: res.data.routeKey,
          subscribe: res.data.queueName,
          user: res.data.user
        };
        stompClient = Stomp.client(cfg.wsUrl);
        stompClient.connect('guest','guest', (frame) => {
          console.log(frame)
          console.log(result)
        });
        result = messageData;
      }else {
        console.log('建立通道失败')
      }
      console.log(result)

    });
    return result;
  }

  /***
   * 订阅服务端消息
   * @param subscribe
   * @param uid
   */
  static async subscribe(subscribe,uid) {
    let result;
    console.log('我是4444444')
    console.log(subscribe,uid)
    await stompClient.subscribe(subscribe, (msg) =>{ // 订阅服务端提供的某个topic
      console.log(msg.body); //msg.body存放的是服务端发送给我们的信息
      const param = {
        list_uid: uid,
        send_time: moment().valueOf(),
        content: msg.body
      };
      HttpClient.post('/my/message/info',{list_uid: uid}).then(res =>{
        console.log(res.data)
        if(res.data.code === 200) {
          store.dispatch('getMessageListData',res.data.data.data).then(res =>{
            console.log(store.state.chatList.chatMessageList)
          });
        }
      });
      /*HttpClient.post('/my/message/send',param).then(res =>{
        if(res.data.code === 200) {
          console.log('我是222222222')
          HttpClient.post('/my/message/info',{list_uid: uid}).then(res =>{
            console.log(res.data)
            if(res.data.code === 200) {
              store.dispatch('getMessageListData',res.data.data).then(res =>{
                console.log(store.state.chatList.chatMessageList)
              });
            }
          })
        }
      });*/

      result =  msg.body
    }, (err) =>{
      console.log('StompClient---error:',err)
    })
    return result;
  }

  /***
   * 发送消息
   * @param subscribe
   * @param message
   */
  static async send(subscribe,param) {
    console.log('我是1111111')
    console.log(subscribe)
    await HttpClient.post('/my/message/send',param).then(res =>{
      stompClient.send(subscribe,{"content-type":"text/plain"},param.content);
    });

  }

  /***
   * 结束连接
   */
  static disconnect() {
    console.log(1111111)
    stompClient.disconnect();
  }
}
