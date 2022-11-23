import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class IndexNoticeController extends GetxController {
  final NoticeRepository noticeRepository;
  final _offset = 0;
  final _limit = 3;

  IndexNoticeController({required this.noticeRepository});

  bool _isLoading = true;
  NoticeListResponse _notices = NoticeListResponse(rows: [], count: 0);

  @override
  @mustCallSuper
  @override
  void onInit() async {
    super.onInit();
    try {
      _notices = await noticeRepository.findNotices(_offset, _limit);
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

  NoticeListResponse get notices => _notices;
  bool get isLoading => _isLoading;
}
