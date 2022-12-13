class UpdateNoticeCommentRequest {
  final String _comment;

  UpdateNoticeCommentRequest(this._comment);

  Map<String, dynamic> toJson() {
    return {'comment': _comment};
  }
}
