class Review{
  final String _userName;
  final String _userComment;
  final int _userReview;

  Review(this._userName, this._userComment, this._userReview);

  String get userName => _userName;
  String get userComment => _userComment;
  int get userReview => _userReview;
}