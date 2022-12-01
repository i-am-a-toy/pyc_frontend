import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice_comment/notice_comment_list_response.dart';
import 'package:pyc/data/repository/notice_comment_repository.dart';

class NoticeCommentController extends GetxController {
  final int noticeId;
  final NoticeCommentRepository noticeCommentRepository;
  NoticeCommentController({
    required this.noticeCommentRepository,
    required this.noticeId,
  });

  bool _isLoading = true;
  int _initOffset = 0;
  int _initLimit = kDefaultValue.toInt();
  bool _hasMore = false;
  NoticeCommentListResponse _noticeComments = NoticeCommentListResponse(
    rows: [],
    count: 0,
  );

  bool get isLoding => _isLoading;
  bool get hasMore => _hasMore;
  NoticeCommentListResponse get noticeComments => _noticeComments;

  @override
  void onInit() async {
    super.onInit();
    try {
      await fetch(noticeId, _initOffset, _initLimit);
      if (_noticeComments.count > kDefaultValue.toInt()) _hasMore = true;
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  Future<void> fetch(int noticeId, int offset, int limit) async {
    _noticeComments = await noticeCommentRepository.findComments(
      noticeId: noticeId,
      offset: offset,
      limit: limit,
    );
  }

  void _handingError(Object e) {
    if (e is DioError) {
      _isLoading = false;
      update();
      // timeout Message
      if (e.type == DioErrorType.connectTimeout) {
        showSnackbar('요청 실패', '서버와의 연결이 지연되고 있습니다.\n잠시 후 다시 시도해주세요.');
      }

      // sever exception Message
      showSnackbar('요청 실패', e.message);
      return;
    }

    // Internal Service Error or Flutter Error
    showSnackbar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
  }
}
