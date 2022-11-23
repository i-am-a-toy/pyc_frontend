import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeController extends GetxController {
  final NoticeRepository noticeRepository;
  final _initOffset = 0;
  final _initLimit = 20;

  NoticeController({required this.noticeRepository});

  bool _isLoading = true;
  String _sortType = 'DESC'; // TODO: 해당 데이터는 ENUM 처리르 해야 할 듯;
  NoticeListResponse _notices = NoticeListResponse(rows: [], count: 0);

  NoticeListResponse get notices => _notices;
  bool get isLoading => _isLoading;
  String get sortType => _sortType;

  @override
  @mustCallSuper
  @override
  void onInit() async {
    super.onInit();
    try {
      _notices = await noticeRepository.findNotices(_initOffset, _initLimit);
      _isLoading = false;
      update();
    } catch (e) {
      if (e is DioError) {
        showSnackbar('요청 실패', e.message);
        return;
      }
      showSnackbar('요청 실패', '서버에 문제가 있습니다.\n관리자에게 문의해주세요.');
    }
  }
}
