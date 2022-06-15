import React, {useMemo, useState} from "react";
import './styles/App.css'
import PostList from "./components/PostList";
import PostForm from "./components/PostForm";
import PostFilter from "./components/PostFilter";
function App() {
  const [posts, setPosts] = useState([
    {id: 1, title: 'Javascript', body: 'Description 5'},
    {id: 2, title: 'Javascript 1', body: 'Description 4'},
    {id: 3, title: 'Javascript 2', body: 'Description 3'},
    {id: 4, title: 'Javascript 3', body: 'Description 2'},
    {id: 5, title: 'Javascript 4', body: 'Description 1'}
  ])
  // const [title, setTitle] = useState('');
  // const bodyInputRef = useRef();
  const createPost = function (post) {
    setPosts([...posts, post])
  }
  const removePost = (post) => {
    setPosts(posts.filter(p => p.id!==post.id))
  }
  const [filter, setFilter] = useState({sort: '', query: ''})
  const sortedPosts = useMemo(() => {
    if (filter.sort) {
      return [...posts].sort((a, b) => a[filter.sort].localeCompare(b[filter.sort]))
    }
    return posts
  }, [filter.sort, posts])
  const sortedAndSearchedPosts = useMemo(() => {
    return sortedPosts.filter(p => p.title.includes(filter.query) || p.body.includes(filter.query))
  }, [filter.query, sortedPosts])
  return (
    <div className="App">
      <PostForm create={createPost}/>
      <hr style={{margin: "15px 0"}}/>
      <PostFilter filter={filter} setFilter={setFilter}/>
      {sortedAndSearchedPosts.length!==0?
          <PostList remove={removePost} posts={sortedAndSearchedPosts} title={"Посты про JS"}/>
          :
          <h1 style={{textAlign: "center"}}>Посты не найдены</h1>
      }
    </div>
  );
}

export default App;
