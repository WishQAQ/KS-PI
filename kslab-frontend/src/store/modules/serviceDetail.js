export default {
  state: {
    serviceDetail: {}
  },
  getters: {
    showServiceDetail (state) {
      return state.user
    }
  },
  actions: {
    getServiceDetail ({commit, state}, serviceDetail) {
      commit('getDetail', serviceDetail)
    }
  },
  mutations: {
    getDetail (state, serviceDetail) {
      state.serviceDetail = {
        service_id: serviceDetail.service_id
      }
    }
  }
}
