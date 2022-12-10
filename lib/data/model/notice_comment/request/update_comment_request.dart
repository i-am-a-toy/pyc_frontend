class UpdateCommentRequest {
  final String _comment;

  UpdateCommentRequest(this._comment);

  Map<String, dynamic> toJson() {
    return {'comment': _comment};
  }
}
