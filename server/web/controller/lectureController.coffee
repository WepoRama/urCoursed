
uLecture.controller 'lectureController',
    ($scope, $location, $routeParams,lectureModel) ->
        $scope.lectures = lectureModel.lectures 1
        $scope.play = (vidjo) ->
            $scope.vidjo = vidjo.replace /.*=/, ''
uLecture.controller 'commentController',
    ($scope, $location, $routeParams,$resource, lectureModel) ->
        lecture = $routeParams.lectureId
        name = $routeParams.lectureName
        $scope.isTeacher = () -> true
        $scope.name = name
        $scope.comments = lectureModel.getComments name
        $scope.addComment = () ->
            #if helper.
            $scope.comments = lectureModel.addComment name, $scope.comment
            $location.path('/comments/'+lecture+'/'+name)
uLecture.controller 'addLectureController',
    ($scope, $location, $routeParams,lectureModel) ->
        $scope.addLecture = () ->
            lectureModel.addLecture
                name: $scope.name
                url: $scope.url
            if $scope.more
                $location.path('/add/')
            else
                $location.path('/lectures/')
