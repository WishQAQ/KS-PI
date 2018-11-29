export default {
  state: {
    marketUploadData: {}
  },
  getters: {
    showMarketUploadData (state) {
      return state.marketUploadData
    }
  },
  actions: {
    getMarketUploadData ({commit, state}, marketUploadData) {
      commit('getDetail', marketUploadData)
    }
  },
  mutations: {
    getDetail (state, marketUploadData) {
      state.marketUploadData= Object.assign(state.marketUploadData,marketUploadData);
    }
  }
}
