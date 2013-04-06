var uLecture, uLectureConfig;

window.localStorage.setItem('history', JSON.stringify([]));

uLectureConfig = function($routeProvider) {
  $routeProvider.when('', {
    controller: 'lectureController',
    templateUrl: 'view/lecture.html'
  }).when('/add', {
    controller: 'addController',
    templateUrl: 'view/add.html'
  }).when('/comments/:lectureId', {
    controller: 'commentController',
    templateUrl: 'view/comments.html'
  });
  return 1;
};

uLecture = angular.module('uLecture', []).config(uLectureConfig);

1;
