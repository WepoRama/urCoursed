
uLecture.controller('lectureController', function($scope, $location, $routeParams, lectureModel) {
  lectureModel.lectures(function(l) {
    return $scope.lectures = l;
  });
  $scope.addLecture = function() {
    lectureModel.addLecture({
      url: $routeParams.url,
      name: $routeParams.name
    });
    return $location.path('/manageLectures/');
  };
  return 1;
});

uLecture.controller('commentController', function($scope, $location, $routeParams, lectureModel) {
  var lecture;
  lecture = $routeParams.lectureId;
  lectureModel.comments(lecture, function(l) {
    return $scope.comments = l;
  });
  return $scope.addComment = function() {
    lectureModel.addComment({
      comment: $scope.comment
    });
    return $location.path('/comments/' + lecture);
  };
});

/*
uLecture.controller 'addLectureController',
    ($scope, $location, $routeParams,lectureModel) ->
       lecture = $routeParams.lectureId
       lectureModel.comments lecture, (l) -> $scope.comments = l
*/
