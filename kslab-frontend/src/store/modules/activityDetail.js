export default {
  state: {
    activityDetail: {}
  },
  getters: {
    showActivityDetail (state) {
      return state.user
    }
  },
  actions: {
    getActivityDetail ({commit, state}, activityDetail) {
      commit('getDetail', activityDetail)
    }
  },
  mutations: {
    getDetail (state, activityDetail) {
      state.activityDetail = {
        active_id: activityDetail.active_id
      }
    }
  }
}
