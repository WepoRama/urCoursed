comments= [ {
        comment: 'comment'
        author: 'me'
    }
    {
        comment: 'comment this too'
        author: 'me'
    }
]

uLecture.service 'lectureModel', () ->
    this.nickName = (store) ->
        store 'nickses'
    this.lectures = (store) ->
        store [
            {
                id: 1
                url: '/url/is/not'
                name: 'not viewable'
                author: 'me'
            }
            {
                id: 2
                url: '/url/is/not/either'
                name: 'not this either'
                author: 'me'
            }
        ]
    @comments = (lecture, store) ->
        #ignore lecture for now
        store comments
    @addComment = ( comment ) ->
        comment.author = 'me'
        comments.push comment
