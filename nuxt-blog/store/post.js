const posts = [
  {title: 'Post 1', date: new Date(), views: 22, comments: [1, 2], _id: "1"},
  {title: 'Post 2', date: new Date(), views: 22, comments: [1, 2], _id: "2"}
];

export const actions = {
  async fetchAdminPosts({}) {
    return await new Promise(resolve => {
      setTimeout(() => {
        resolve(posts, 2)
      })
    })
  },
  async remove({}, id) {
    return new Promise(resolve => resolve())
  },
  async update({}, {id, text}) {
    return new Promise(resolve => resolve())
  },
  async create({}, {title, text}) {
    return new Promise(resolve => setTimeout( () => {
      resolve()
    }, 1000))
  },
  async fetchAdminById({}, id) {
    return await new Promise(resolve => {
      setTimeout(() => {
        resolve(posts.find(p => p._id === id))
      }, 1000)
    })
  }
}
