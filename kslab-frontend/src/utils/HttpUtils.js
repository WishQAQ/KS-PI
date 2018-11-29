import * as axios from "axios";
import cfg from '../../config/app';
import moment from "moment";

export class HttpClient {

  /****
   * get请求
   * @param url
   * @param param
   * @param hearders
   * @returns {*}
   */
  static get(url, param, hearders){
    return this.http("GET", url, param, hearders);
  }

  /******
   * post 请求
   * @param url
   * @param param
   * @param hearders
   * @returns {*}
   */
  static post(url, param, hearders){
    return this.http("POST", url, param, hearders);
  }

  /******
   * form表单post请求
   * @param url
   * @param param
   * @returns {Promise<any>}
   */
  static async form(url, param) {
    return await new Promise((resolve, reject) =>{
      let token = window.localStorage.getItem('token');
      const apiInfo = localStorage.getItem('apiInfo');
      const userAction = {
        access_time: moment().valueOf(),
        screen_size: apiInfo ? JSON.parse(apiInfo).screen_size : ''
      };
      let formData = new FormData();
      for(let item in param) {
        formData.append(item, param[item]);
      }
      /*console.log(token)*/
      const instance=axios.create({
        withCredentials: false,
        baseURL:cfg.urls + cfg.api,
        headers: {
          'Authorization': token? 'Bearer '+token : '',
          'AccessRecord' : JSON.stringify(userAction),
        }
      });
      instance.post(url, formData).then(res =>{
        if(res.status === 200) {
          resolve(res);
        }else {
          reject(res);
        }
      })
    });
  }

  static async code(url, param) {
    return await new Promise((resolve, reject) =>{
      let token = window.localStorage.getItem('token');
      const apiInfo = localStorage.getItem('apiInfo');
      const userAction = {
        access_time: moment().valueOf(),
        screen_size: apiInfo ? JSON.parse(apiInfo).screen_size : ''
      };
      const instance=axios.create({
        withCredentials: false,
        baseURL:cfg.urls + cfg.api,
        headers: {
          'Authorization': token? 'Bearer '+token : '',
          'AccessRecord' : JSON.stringify(userAction),
        },
        responseType: 'arraybuffer'
      });
      instance.get(url, param).then(res =>{
        if(res.status === 200) {
          resolve(res);
        }else {
          reject(res);
        }
      })
    });
  }

  /**
   * HttpClient工具类
   * @param type 请求方法 string
   * @param url 请求地址 string
   * @param param 请求参数 json
   * @param headers json
   * @returns {*}
   */
  static http(type, url, param={}, headers={}){
    //拼接api前缀
    url = cfg.urls + cfg.api + url;

    //添加auth_key
    let token = window.localStorage.getItem('token')
    /*console.log(token)*/
    headers['Authorization'] = token? 'Bearer '+token : '';
    const apiInfo = localStorage.getItem('apiInfo');
    const userAction = {
      access_time: moment().valueOf(),
      screen_size: apiInfo ? JSON.parse(apiInfo).screen_size : ''
    };
    headers['AccessRecord'] = JSON.stringify(userAction);
    // http request 拦截器，通过这个，我们就可以把Cookie传到后台
    /*axios.interceptors.request.use(
      config => {
        const cookieData = '1280*2220'; //获取Cookie
        config.data = JSON.stringify(config.data);
        config.headers = {
          'Content-Type':'application/x-www-form-urlencoded' //设置跨域头部
        };
        if (cookieData) {
          config.params = {'cookieData': cookieData} //后台接收的参数，后面我们将说明后台如何接收
        }
        return config;
      },
      err => {
        return Promise.reject(err);
      }
    );*/
    //响应拦截
    axios.interceptors.response.use(function (response) {
      //console.log(response)
      const resHeader = response.headers['cache-control'];
      if(resHeader.indexOf('AccessRecordsId') > -1) {
        const str = resHeader.split(',')[0];
        const accessRecordsId = str.split(':')[1];
        localStorage.setItem('accessRecordsId',accessRecordsId);
      }
      //登录超时或者未登录
      if (response.data.code == 401){
        // storejs.remove('userInfo');
        // location.reload(true);
        window.location.href='/login';
      }
      return response;
    }, function (error) {
      return Promise.reject(error);
    });

    return axios({
      method: type,
      url: url,
      params: param,
      headers:headers,
      async:true,
    });
  }
}
