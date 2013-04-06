window.localStorage.setItem 'history', JSON.stringify([])

uLectureConfig = ($routeProvider) ->
    $routeProvider
        .when ''
            controller: 'lectureController'
            templateUrl: 'view/lecture.html'
        .when '/add'
            controller: 'addController'
            templateUrl: 'view/add.html'
        .when '/comments/:lectureId'
            controller: 'commentController'
            templateUrl: 'view/comments.html'
    1
        
uLecture = angular.module('uLecture', []).
    config( uLectureConfig )
1
