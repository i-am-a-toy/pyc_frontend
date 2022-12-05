import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice_comment/notice_comment_list_response.dart';
import 'package:pyc/data/model/notice_comment/notice_comment_response.dart';
import 'package:pyc/data/repository/notice_comment_repository.dart';

class NoticeCommentController extends GetxController {
  final int noticeId;
  final NoticeCommentRepository noticeCommentRepository;
  final _initLimit = kDefaultValue ~/ 4;
  NoticeCommentController({
    required this.noticeCommentRepository,
    required this.noticeId,
  });

  bool _isLoading = true;
  int _initOffset = 0;
  bool _hasMore = true;
  List<NoticeCommentResponse> _comments = [];
  int _count = 0;

  bool get isLoding => _isLoading;
  bool get hasMore => _hasMore;
  int get count => _count;
  List<NoticeCommentResponse> get comments => _comments;

  @override
  void onInit() async {
    super.onInit();
    try {
      final resp = await fetch(noticeId, _initOffset, _initLimit);
      _comments = resp.rows;
      _count = resp.count;
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  Future<void> getMore() async {
    if (!_hasMore) return;
    try {
      _isLoading = true;
      update();

      _initOffset += kDefaultValue ~/ 4;
      final resp = await fetch(noticeId, _initOffset, _initLimit);

      _comments = [...resp.rows, ...comments];
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  Future<NoticeCommentListResponse> fetch(int noticeId, int offset, int limit) async {
    final noticeComments = await noticeCommentRepository.findComments(
      noticeId: noticeId,
      offset: offset,
      limit: limit,
    );
    noticeComments.rows.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    if (noticeComments.rows.length < kDefaultValue ~/ 4) _hasMore = false;
    return noticeComments;
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
