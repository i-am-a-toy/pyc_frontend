import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeController extends GetxController {
  final NoticeRepository noticeRepository;
  final List<SortType> _items = [SortType.desc, SortType.asc];
  final _initOffset = 0;
  final _initLimit = 20;

  NoticeController({required this.noticeRepository});

  bool _isLoading = true;
  NoticeListResponse _notices = NoticeListResponse(rows: [], count: 0);
  SortType _sortType = SortType.desc;

  NoticeListResponse get notices => _notices;
  bool get isLoading => _isLoading;
  List<String> get items => _items.map((e) => e.displayName).toList();
  SortType get sortType => _sortType;

  @override
  @mustCallSuper
  @override
  void onInit() async {
    super.onInit();
    try {
      _notices = await noticeRepository.findNotices(
        _initOffset,
        _initLimit,
      );
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  void sort(SortType sortType) async {
    try {
      _sortType = sortType;
      _notices = await noticeRepository.findNotices(
        _initOffset,
        _initLimit,
        sort: sortType,
      );
      _isLoading = false;
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
}
