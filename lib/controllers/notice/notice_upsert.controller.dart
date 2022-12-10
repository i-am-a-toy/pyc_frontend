import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice/request/create_notice_request.dart';
import 'package:pyc/data/model/notice/request/update_notice_request.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeUpserController extends GetxController {
  final NoticeRepository repository;
  NoticeUpserController({required this.repository});
  String _title = '';
  String _content = '';

  String get title => _title;
  String get content => _content;

  void updateTitle(String title) {
    // 공지사항 Title에서의 개행은 띄어쓰기로 변환
    _title = title.trim().replaceAll('\n', ' ');
  }

  void updateContent(String content) {
    _content = content.trim();
  }

  Future<void> write() async {
    CreateNoticeRequest req = CreateNoticeRequest(_title, _content);
    try {
      //save
      await repository.save(req);
    } catch (e) {
      _handingError(e);
    }
  }

  Future<void> modifiy(int id) async {
    UpdateNoticeRequest req = UpdateNoticeRequest(_title, _content);
    try {
      //save
      await repository.update(id, req);
    } catch (e) {
      _handingError(e);
    }
  }

  void _handingError(Object e) {
    if (e is DioError) {
      // timeout Message
      if (e.type == DioErrorType.connectTimeout) {
        showSnackbar('요청 실패', '서버와의 연결이 지연되고 있습니다.\n잠시 후 다시 시도해주세요.');
        return;
      }

      // sever exception Message
      showSnackbar('요청 실패', e.message);
      return;
    }

    // Internal Service Error or Flutter Error
    showSnackbar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
  }
}
