class CreateCommentRequest {
  final String _comment;

  CreateCommentRequest(this._comment);

  Map<String, dynamic> toJson() {
    return {'comment': _comment};
  }
}
