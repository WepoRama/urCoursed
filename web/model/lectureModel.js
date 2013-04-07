// Generated by CoffeeScript 1.6.2
var commentses;

commentses = [
  {
    comment: 'comment',
    author: 'me'
  }, {
    comment: 'comment this too',
    author: 'me'
  }
];

uLecture.service('lectureModel', function() {
  this.nickName = function(store) {
    return store('nickses');
  };
  this.lectures = function(store) {
    var Lecture, lecture;

    Lecture = $resource('/api/lectures');
    return lecture = Lecture.get({}, function() {
      lecture.stuff = 1;
      return lecture.$save;
    });
  };
  this.lecturesNevermind = function(store) {
    return store([
      {
        id: 1,
        url: '/url/is/not',
        name: 'not viewable',
        author: 'me'
      }, {
        id: 2,
        url: '/url/is/not/either',
        name: 'not this either',
        author: 'me'
      }
    ]);
  };
  this.comments = function($resource, lecture, store) {
    var Comments, comments;

    Comments = $resource('/api/comments', {
      alt: 'json',
      callback: 'JSON_CALLBACK'
    }, {
      query: {
        method: 'JSONP'
      }
    });
    return comments = Comments.query({}, function() {
      comments.stuff = true;
      return comments.$save;
    });
  };
  return this.addComment = function(comment) {
    comment.author = 'me';
    return comments.push(comment);
  };
});
