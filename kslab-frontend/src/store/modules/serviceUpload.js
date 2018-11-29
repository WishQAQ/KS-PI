export default {
  state: {
    serviceUploadData: {}
  },
  getters: {
    showServiceUploadData (state) {
      return state.serviceUploadData
    }
  },
  actions: {
    getServiceUploadData ({commit, state}, serviceUploadData) {
      commit('getDetail', serviceUploadData)
    }
  },
  mutations: {
    getDetail (state, serviceUploadData) {
      /*console.log(state.serviceUploadData,serviceUploadData)
      console.log(Object.assign(state.serviceUploadData,serviceUploadData))*/
      state.serviceUploadData= Object.assign(state.serviceUploadData,serviceUploadData);
    }
  }
}
