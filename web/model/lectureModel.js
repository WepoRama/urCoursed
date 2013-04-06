var comments;

comments = [
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
    /*
            Lecture = $resource 'http://chattycat2-haralkar.dotcloud.com/api/lectures'
            lecture = Lecture.get {}, () ->
                lecture.stuff = 1
                lecture.$save
    */    return store([
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
  this.comments = function(lecture, store) {
    return store(comments);
    /*
            Comments = $resource 'http://chattycat2-haralkar.dotcloud.com/api/comments'
            comments = Comments.get {}, () ->
                comments.$save
    */
  };
  return this.addComment = function(comment) {
    comment.author = 'me';
    return comments.push(comment);
  };
});
