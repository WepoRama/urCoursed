commentses= [ {
        comment: 'comment'
        author: 'me'
    }
    {
        comment: 'comment this too'
        author: 'me'
    }
]

uLecture.service 'lectureModel', ($resource) ->
    Comments = $resource '/api/:resource' ,
        {resource: '@resource', alt: 'json', callback: 'JSON_CALLBACK'},
        {query: {method: 'JSONP'}}
    this.nickName = (store) ->
        store 'nickses'
    this.lectures = (store) ->
        Lecture = $resource '/api/lectures'
        lecture = Lecture.get {}, () ->
            lecture.stuff = 1
            lecture.$save
    this.lecturesNevermind = (store) ->
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
        #store comments
        #ignore lecture for now
        #store commentses
        #Comments = $resource 'http://crested-haralkar.dotcloud.com/api/comments',
        ###
        Comments = $resource '/api/comments' ,
            {alt: 'json', callback: 'JSON_CALLBACK'},
            {query: {method: 'JSONP'}}
        ###
        comments = Comments.query {resource: 'comments'}, () ->
            comments.stuff = true
            comments.$save
        # ##
    @addComment = ( comment ) ->
        comment.author = 'me'
        comments.push comment
