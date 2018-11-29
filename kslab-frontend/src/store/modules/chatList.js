export default {
  state: {
    chatMessageList: [],
    chatUserList: [],
    numbers: 0,
  },
  getters: {
    showMessageListData (state) {
      return state.chatMessageList
    },
    showChatUserList(state) {
      return state.chatUserList;
    }
  },
  actions: {
    getMessageListData ({commit, state}, chatMessageList) {
      commit('getChatDetail', chatMessageList)
    },
    getChatUserListData ({commit, state}, chatUserList) {
      commit('getUserList', chatUserList);
    },
    getChatUserFlag ({commit, state}, numbers) {
      commit('getNumbers', numbers);
    }
  },
  mutations: {
    getChatDetail (state, chatMessageList) {
      let array;
      array = chatMessageList.sort((a, b) =>{
        return parseInt(a.send_time) - parseInt(b.send_time)
      });
      state.chatMessageList= array;
    },
    getUserList (state, chatUserList) {
      state.chatUserList = chatUserList;
    },
    getNumbers (state, numbers) {
      state.numbers = numbers;
    }
  }
}
