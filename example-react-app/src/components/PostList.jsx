import React from 'react';
import PostItem from "./PostItem";

const PostList = (props) => {
    return (
        <div>
            <h1 style={{textAlign: "center"}}>{props.title}</h1>
            {
                props.posts.map((post, index) =>
                    <PostItem remove={props.remove} post={post} number={index+1} key={post.id}/>
                )
            }
        </div>
    );
};

export default PostList;