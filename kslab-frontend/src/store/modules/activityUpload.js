export default {
  state: {
    activityUploadData: {}
  },
  getters: {
    showActivityUploadData (state) {
      return state.activityUploadData
    }
  },
  actions: {
    getActivityUploadData ({commit, state}, activityUploadData) {
      commit('getDetail', activityUploadData)
    }
  },
  mutations: {
    getDetail (state, activityUploadData) {
      /*console.log(state.serviceUploadData,serviceUploadData)
      console.log(Object.assign(state.serviceUploadData,serviceUploadData))*/
      state.activityUploadData= Object.assign({},state.activityUploadData,activityUploadData);
    }
  }
}
