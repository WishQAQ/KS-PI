import * as axios from "axios";
import cfg from '../../config/app';

export class HttpClient {

  static get(url, param, hearders){
    return this.http("GET", url, param, hearders);
  }

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
            /*console.log(token)*/
            const instance=axios.create({
                withCredentials: false,
                baseURL:cfg.urls + cfg.api,
                headers: {'Authorization': token? 'Bearer '+token : ''}
            });
            let form = new FormData();
            let key=Object.keys(param);
            key.map(item=>{
                form.append(item, param[item]);
            });
            instance.post(url, form).then(res =>{
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
    let token = window.localStorage.getItem('token');
    // console.log(token);
    headers['Authorization'] = token? 'Bearer '+token : '';
    //响应拦截
    axios.interceptors.response.use(function (response) {
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
