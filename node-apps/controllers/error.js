exports.default = (req, res, next) => {
    //res.status('404').sendFile(path.join(__dirname, 'views', 'page_404.html'))
    res.status('404').render('page_404', {docTitle: 'Error'})
}