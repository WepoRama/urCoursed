#window.localStorage.setItem 'history', JSON.stringify([])

uLectureConfig = ($routeProvider) ->
    $routeProvider
        .when '//',
            controller: 'lectureController'
            templateUrl: 'view/lecture.html'
        .when '',
            controller: 'lectureController'
            templateUrl: 'view/lecture.html'
        .when '/lectures/',
            controller: 'lectureController'
            templateUrl: 'view/lecture.html'
        .when '/add',
            controller: 'addController'
            templateUrl: 'view/add.html'
        .when '/comments/:lectureId/:lectureName',
            controller: 'commentController'
            templateUrl: 'view/comments.html'
    1
        
uLecture = angular.module('uLecture', ['ngResource']).
    config( uLectureConfig )
1
