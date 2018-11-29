import moment from 'moment'
export default class FormatDate {
  static GetDate(date) {
    //console.log(date,this.commitDetail);
    let str = '';
    let res = moment(date).format('YYYY-MM-DD HH:mm:ss');
    const dates =  moment(res,'YYYY-MM-DD HH:mm:ss').valueOf();
    const years = moment().diff(moment(dates),'years');
    const months = moment().diff(moment(dates),'months');
    const days = moment().diff(moment(dates),'days');
    const hours = moment().diff(moment(dates),'hours');
    const minutes = moment().diff(moment(dates),'minutes');

    //console.log(years,' ',months,' ',days,' ',hours+ ' '+minutes)
    if(minutes === 0) {
      str = 0 + '分钟';
    }else if(minutes>0 && minutes<60){
      str = minutes + '分钟';
    }else if(minutes>=60 && minutes<60*24){
      str = hours + '小时';
    }else if(minutes>=60*24 && minutes<60*24*30){
      str = days + '天';
    }else if(minutes>=60*24*30 && minutes<60*24*30*12){
      str = months + '月'
    }else if(minutes>=60*24*30*12){
      str = years + '年'
    }
    return str;
  }
}
