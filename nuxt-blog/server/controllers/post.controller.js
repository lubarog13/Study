const Post = require('../models/post.model');

module.exports.create = async (req, res) => {
    const post = new Post({
        title: req.body.title,
        text: req.body.text,
        imageUrl: `/${req.file.filename}`,
    })

    try {
        await post.save();
        res.status(201).json(post);
    } catch(e) {
        res.status(400).json(e);
    }
};

module.exports.getAll = async (req, res) => {
    try {
        const posts = await Post.find().sort({date: -1})
        res.json(posts)
    } catch(e) {
        res.status(200).json(e)
    }
};

module.exports.getById = async (req, res) => {
    try {
        await Post.findById(req.params.id).populate('comments')
    } catch (e) {
        res.status(500).json(e)
    }
};

module.exports.update = async (req, res) => {
};

module.exports.remove = async (req, res) => {
};

module.exports.addView = async (req, res) => {
};