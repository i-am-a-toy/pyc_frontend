import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice_comment/response/notice_comment_list_response.dart';
import 'package:pyc/data/model/notice_comment/response/notice_comment_response.dart';
import 'package:pyc/data/repository/notice_comment_repository.dart';
import 'package:pyc/screens/notice/notice_update_comment_screen.dart';

class NoticeCommentController extends GetxController {
  final int noticeId;
  final NoticeCommentRepository noticeCommentRepository;
  final _initLimit = kDefaultValue ~/ 2;
  NoticeCommentController({
    required this.noticeCommentRepository,
    required this.noticeId,
  });

  bool _isLoading = true;
  bool _isCommentLoading = false;
  bool _hasMore = true;
  List<NoticeCommentResponse> _comments = [];
  int _count = 0;
  int _initOffset = 0;

  @override
  void onInit() async {
    super.onInit();
    try {
      final resp = await fetch(noticeId, _initOffset);
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
      _isCommentLoading = true;
      update();

      _initOffset += kDefaultValue ~/ 2;
      final resp = await fetch(noticeId, _initOffset);

      _comments = [...resp.rows, ...comments];
      _count = resp.count;
      _isCommentLoading = false;

      await Future.delayed(const Duration(milliseconds: 300));
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  Future<NoticeCommentListResponse> fetch(
    int noticeId,
    int offset,
  ) async {
    _hasMore = true;
    final noticeComments = await noticeCommentRepository.findComments(
      noticeId: noticeId,
      offset: offset,
      limit: _initLimit,
    );
    noticeComments.rows.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    if (noticeComments.rows.length < kDefaultValue ~/ 2) _hasMore = false;
    return noticeComments;
  }

  Future<void> save(int noticeId, String comment) async {
    try {
      await noticeCommentRepository.saveComment(noticeId: noticeId, comment: comment);
      _initOffset = 0;
      final resp = await fetch(noticeId, _initOffset);
      _comments = resp.rows;
      _count = resp.count;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  void goUpdateScreen(int id, String comment) {
    Get.toNamed(
      NoticeUpdateCommentScreen.routeName,
      arguments: {
        'id': id,
        'comment': comment,
      },
    );
  }

  Future<void> updateComment(int id, String changed) async {
    try {
      await noticeCommentRepository.updateComment(id: id, comment: changed);
    } catch (e) {
      _handingError(e);
    }
  }

  Future<void> deleteSlideEvent(BuildContext context, int id) async {
    await Slidable.of(context)?.dismiss(
      curve: Curves.fastOutSlowIn,
      ResizeRequest(const Duration(milliseconds: 300), () async {
        await _delete(id);
      }),
    );
  }

  Future<void> _delete(int id) async {
    try {
      await noticeCommentRepository.deleteComment(id: id);
      _initOffset = 0;
      final resp = await fetch(noticeId, _initOffset);
      _comments = resp.rows;
      _count = resp.count;
      update();
    } catch (e) {
      _handingError(e);
    }
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

  bool get isLoding => _isLoading;
  bool get isCommentLoading => _isCommentLoading;
  bool get hasMore => _hasMore;
  int get count => _count;
  List<NoticeCommentResponse> get comments => _comments;
}
