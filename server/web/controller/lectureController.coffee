
uLecture.controller 'lectureController',
    ($scope, $location, $routeParams,lectureModel) ->
        #$scope.$apply () -> $scope.nick = l
        $scope.lectures = lectureModel.lectures 1

        $scope.addLecture = () ->
            lectureModel.addLecture
                url: $routeParams.url
                name: $routeParams.name
            $location.path('/manageLectures/')
        1
uLecture.controller 'commentController',
    ($scope, $location, $routeParams,$resource, lectureModel) ->
        lecture = $routeParams.lectureId
        name = $routeParams.lectureName
        $scope.isTeacher = () -> true
        $scope.name = name
        #$scope.comments = lectureModel.comments $resource, lecture, (l) -> #$scope.comments = l
        $scope.comments = lectureModel.commentCRUD lecture, 'all'
        $scope.addComment = () ->
            lectureModel.addComment
                promise: $scope.comments
                newComment: $scope.comment
                lecture: $routeParams.lectureId
            $location.path('/comments/'+lecture+'/'+name)
        1

###
uLecture.controller 'addLectureController',
    ($scope, $location, $routeParams,lectureModel) ->
       lecture = $routeParams.lectureId
       lectureModel.comments lecture, (l) -> $scope.comments = l
###
