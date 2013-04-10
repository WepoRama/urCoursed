
uLecture.service 'lectureModel', ($resource) ->
    Lecture = $resource '/api/lecture/:lecture',
        lecture: '@lecture'
    @addLecture = (data) ->
        data.author = 'me'
        lecture = new Lecture {data}
        lecture.$save()
    @lectures = (course) ->
        #'course will ignore for now
        lecture = Lecture.get { }, () ->
    ###
    #    move used func above this line
    ###
    Lists = $resource '/api/:resource/:detail' ,
        {
            resource: '@resource'
            detail: '@detail'
            alt: 'json'
            callback: 'JSON_CALLBACK'
        },
        {query: {method: 'JSONP'}}
    #LectureComments = $resource '/api/lecture/:lecture/comment/:comment', {
    LectureComments = $resource '/api/lecture/:lecture', {
        #                        /api/lecture/1       /comment/1
            lecture: '@lecture'
            #comment: '@comment'
        }, {
            add: {method: 'POST'}
        }

    @XXlectures = (course) ->
        lecture = Lists.query {
                resource: 'lectures'
                detail: course
            }, () -> lecture.$save()
    @comments = (lecture, store) ->
        comments = Lists.query {
            resource: 'comments'
            detail: lecture
        }, () -> comments.$save()
    @commentCRUD = ( lecture, comment ) ->
        #comments = LectureComments.get { lecture: lecture , comment: comment}, ()->
        comments = LectureComments.get { lecture: lecture }, ()->
            comments.$save()
    @addComment = ( data ) ->
        stuff = LectureComments.save {lecture: 'newComm' },
            #stuff.newComment =
            data: {author: 'me'
            text: 'stuff'}, ()->
                stuff.$save()
        #data.promise.data.push { text: data.newComment author: 'me'}
        #comments = LectureComments.get { lecture: lecture }, ()-> comments.newComment = data.newComment; comments.$save
    @addCommentSingle = ( data ) ->
        addComments = LectureComments.save
                data:{text: data.newComment
                author: 'me'},
                { lecture: lecture , comment: comment}, ()->
        data.promise.get()

        #comments.push comment
    ###
    @addLecture = ( lecture ) ->
        lecture.author = 'me'
        newLecture = NewLecture.push 
        comments.push comment
    ###
