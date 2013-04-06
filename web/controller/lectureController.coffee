
uLecture.controller 'lectureController',
    ($scope, $location, $routeParams,lectureModel) ->
        #$scope.$apply () -> $scope.nick = l
        #$scope.nick = lectureModel.nickName ()->
        #lectureModel.nickName (l) -> $scope.nick = l
        #lectureModel.lectures $resource, (l) -> $scope.lectures = l
        lectureModel.lectures (l) -> $scope.lectures = l

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
       $scope.name = name
       lectureModel.comments $resource, lecture, (l) -> $scope.comments = l
       $scope.addComment = () ->
            lectureModel.addComment
                comment: $scope.comment
            $location.path('/comments/'+lecture+'/'+name)
###
uLecture.controller 'addLectureController',
    ($scope, $location, $routeParams,lectureModel) ->
       lecture = $routeParams.lectureId
       lectureModel.comments lecture, (l) -> $scope.comments = l
###
