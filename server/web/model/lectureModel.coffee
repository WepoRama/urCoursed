
uLecture.service 'lectureModel', ($resource) ->
    Teacher = $resource '/api/teacher/:teacher',
        teacher: '@teacher'
    Lecture = $resource '/api/lecture/:lecture',
        lecture: '@lecture'
    LectureComments = $resource '/api/lecture/:lecture/comment/:comment', {
            lecture: '@lecture'
            comment: '@comment'
        }, {
            add: {method: 'POST'}
        }
    @isLoggedIn = () -> userLoggedIn
    @isTeacher = () -> userLoggedIn && (
        userProfile.displayName == 'Daniel Brandur Sigurgeirsson' ||
        userProfile.displayName == 'Haraldur Karlsson' ||
        userProfile.displayName == 'Elin Gylfadottir')
    @addLecture = (data) ->
        data.author = userProfile.displayName
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
                author: userProfile.displayName
                lecture: lecture
                text: comment }
        stuff.$add()
        stuff
