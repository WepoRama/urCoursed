
uLecture.service 'lectureModel', ($resource) ->
    Lists = $resource '/api/:resource/:detail' ,
        {
            resource: '@resource'
            detail: '@detail'
            alt: 'json'
            callback: 'JSON_CALLBACK'
        },
        {query: {method: 'JSONP'}}
    LectureComments = $resource '/api/lecture/:lecture/comment/:comment', {
        #                        /api/lecture/1       /comment/1
            lecture: '@lecture'
            comment: '@comment'
        }, {
            add: {method: 'PUT'}
        }

    @lectures = (course) ->
        lecture = Lists.query {
                resource: 'lectures'
                detail: course
            }, () -> lecture.$save
    @comments = (lecture, store) ->
        comments = Lists.query {
            resource: 'comments'
            detail: lecture
        }, () -> comments.$save
    @commentCRUD = ( lecture, comment ) ->
        comments = LectureComments.get { lecture: lecture , comment: comment}, ()->
            comments.comments.push comment
            comments.$save
    @addComment = ( data ) ->
        newComment = LectureComments.save { lecture: data.lecture, comment: 'new' }, {
                data:{text: data.newComment
                author: 'me'}
        }, ()->
            comments.data
            comments.$save
    1
            
        #comments.push comment
    ###
    @addLecture = ( lecture ) ->
        lecture.author = 'me'
        newLecture = NewLecture.push 
        comments.push comment
    ###
