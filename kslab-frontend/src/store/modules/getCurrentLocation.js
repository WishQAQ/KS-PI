export default {
  state: {
    myLocation: {}
  },
  getters: {
    showMyLocationData (state) {
      return state.myLocation
    }
  },
  actions: {
    getMyLocationData ({commit, state}, myLocation) {
      commit('getDetail', myLocation)
    }
  },
  mutations: {
    getDetail (state, myLocation) {
      /*console.log(state.serviceUploadData,serviceUploadData)
      console.log(Object.assign(state.serviceUploadData,serviceUploadData))*/
      state.myLocation= myLocation;
    }
  }
}
