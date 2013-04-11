
uLecture.service 'lectureModel', ($resource) ->
    Lecture = $resource '/api/lecture/:lecture',
        lecture: '@lecture'
    LectureComments = $resource '/api/lecture/:lecture/comment/:comment', {
            lecture: '@lecture'
            comment: '@comment'
        }, {
            add: {method: 'POST'}
        }
    @addLecture = (data) ->
        data.author = helper.displayName
        lecture = new Lecture {data}
        lecture.$save()
    @lectures = (course) ->
        #'course will ignore for now
        lecture = Lecture.get { }, () ->
    @getComments = ( lecture, comment ) ->
        comments = LectureComments.get { lecture: lecture }, ()->
    @addComment = ( lecture, comment ) ->
        stuff = new LectureComments {lecture: lecture }
        stuff.data = {
                author: helper.displayName
                lecture: lecture
                text: comment }
        stuff.$add()
        stuff
