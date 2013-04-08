
uLecture.service 'lectureModel', ($resource) ->
    Lists = $resource '/api/:resource/:detail' ,
        {
            resource: '@resource'
            detail: '@detail'
            alt: 'json'
            callback: 'JSON_CALLBACK'
        },
        {query: {method: 'JSONP'}}
    LectureComments = $resource '/api/lecture/:lecture/comment/:comment' ,
        lecture: '@lecture'
        comment: '@comment'

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
    @addComment = ( lecture, comment ) ->
        comments = LectureComments.get { lecture: lecture }, ()->
            comments.comments.push comment
            comments.$save
            
        #comments.push comment
    ###
    @addLecture = ( lecture ) ->
        lecture.author = 'me'
        newLecture = NewLecture.push 
        comments.push comment
    ###
