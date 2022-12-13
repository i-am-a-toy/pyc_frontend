class CreateNoticeCommentRequest {
  final String _comment;

  CreateNoticeCommentRequest(this._comment);

  Map<String, dynamic> toJson() {
    return {'comment': _comment.trim()};
  }
}
