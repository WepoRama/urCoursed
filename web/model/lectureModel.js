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
  this.comments = function(lecture, store) {
    return store(comments);
  };
  return this.addComment = function(comment) {
    comment.author = 'me';
    return comments.push(comment);
  };
});
