commentses= [ {
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
        ###
        Lecture = $resource 'http://chattycat2-haralkar.dotcloud.com/api/lectures'
        lecture = Lecture.get {}, () ->
            lecture.stuff = 1
            lecture.$save
        ###
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
    @comments = ($resource, lecture, store) ->
        #ignore lecture for now
        #store commentses
        Comments = $resource 'http://chattycat2-haralkar.dotcloud.com/api/comments'
        comments = Comments.get {}, () ->
            comments.$save
        ###
        ###
    @addComment = ( comment ) ->
        comment.author = 'me'
        comments.push comment
