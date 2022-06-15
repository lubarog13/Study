import React, {useState} from 'react';
import MyInput from "./UI/input/MyInput";
import MyButton from "./UI/button/MyButton";

const PostForm = ({create}) => {
    const [post, setPost] = useState({title: '', body: ''})
    const addPost = (e) => {
        e.preventDefault()
        // setPosts([...posts, {id: Date.now(), title: title, body: bodyInputRef.current.value}])
        // setTitle('')
        // bodyInputRef.current.value = ''
        const newPost = {...post, id: Date.now()}
        setPost({title: '', body: ''})
        create(newPost)
    }
    return (
            <form>
                <MyInput value={post.title} onChange={e => setPost({...post, title: e.target.value})} type="text" placeholder="Название поста"/>
                <MyInput type="text" value={post.body} onChange={e => setPost({...post, body: e.target.value})} placeholder="Описание поста"/>
                <MyButton onClick={e => addPost(e)} type="button">Создать пост</MyButton>
            </form>
    );
};

export default PostForm;