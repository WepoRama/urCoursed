
uLecture.controller 'lectureController',
    ($scope, $location, $routeParams,lectureModel) ->
        $scope.lectures = lectureModel.lectures 1
uLecture.controller 'commentController',
    ($scope, $location, $routeParams,$resource, lectureModel) ->
        lecture = $routeParams.lectureId
        name = $routeParams.lectureName
        $scope.isTeacher = () -> true
        $scope.name = name
        #$scope.comments = lectureModel.comments $resource, lecture, (l) -> #$scope.comments = l
        $scope.comments = lectureModel.getComments lecture
        $scope.addComment = () ->
            $scope.comments = lectureModel.addComment lecture, $scope.comment
            name = name + 'f'
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
