/// CreateNoteiceRequest
///
/// 공지사항을 생성할 때 서버로 요청을 보내는 RequestBody
/// 요청을 보낼 때 기본적으로 공백을 제거 후 요청하며 제목은 개행을 띄어쓰기로 변경
/// [title] 공지사항의 제목
/// [content] 공지사항의 본문
class CreateNoticeRequest {
  final String _title;
  final String _content;

  CreateNoticeRequest(this._title, this._content);

  Map<String, dynamic> toJson() {
    return {'title': _title.replaceAll('\n', ' '), 'content': _content.trim()};
  }
}
