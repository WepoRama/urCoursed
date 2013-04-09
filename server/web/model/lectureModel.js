// Generated by CoffeeScript 1.6.2
uLecture.service('lectureModel', function($resource) {
  var Lecture, LectureComments, Lists;

  Lists = $resource('/api/:resource/:detail', {
    resource: '@resource',
    detail: '@detail',
    alt: 'json',
    callback: 'JSON_CALLBACK'
  }, {
    query: {
      method: 'JSONP'
    }
  });
  LectureComments = $resource('/api/lecture/:lecture', {
    lecture: '@lecture'
  }, {
    add: {
      method: 'POST'
    }
  });
  Lecture = $resource('/api/lecture/:lecture', {
    lecture: '@lecture'
  });
  this.lectures = function(course) {
    var lecture;

    return lecture = Lists.query({
      resource: 'lectures',
      detail: course
    }, function() {
      return lecture.$save();
    });
  };
  this.comments = function(lecture, store) {
    var comments;

    return comments = Lists.query({
      resource: 'comments',
      detail: lecture
    }, function() {
      return comments.$save();
    });
  };
  this.commentCRUD = function(lecture, comment) {
    var comments;

    return comments = LectureComments.get({
      lecture: lecture
    }, function() {
      return comments.$save();
    });
  };
  this.addComment = function(data) {
    var stuff;

    return stuff = LectureComments.save({
      lecture: 'newComm'
    }, {
      data: {
        author: 'me',
        text: 'stuff'
      }
    }, function() {
      return stuff.$save();
    });
  };
  this.addCommentSingle = function(data) {
    var addComments;

    addComments = LectureComments.save({
      data: {
        text: data.newComment,
        author: 'me'
      }
    }, {
      lecture: lecture,
      comment: comment
    }, function() {});
    data.promise.get();
    return 1;
  };
  1;
  return this.addLecture = function(data) {
    var lecture;

    lecture = new Lecture({
      data: data
    });
    return lecture.$save();
  };
  /*
  @addLecture = ( lecture ) ->
      lecture.author = 'me'
      newLecture = NewLecture.push 
      comments.push comment
  */

});
