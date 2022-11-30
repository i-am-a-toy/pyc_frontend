import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeController extends GetxController {
  final NoticeRepository noticeRepository;
  final List<SortType> _items = [SortType.desc, SortType.asc];
  final ScrollController _scrollController = ScrollController();
  NoticeController({required this.noticeRepository});

  bool _isLoading = true;
  int _initOffset = 0;
  int _initLimit = kDefaultValue.toInt();
  NoticeListResponse _notices = NoticeListResponse(rows: [], count: 0);
  bool _isMaxPosition = false;
  bool _hasMore = true;
  SortType _sortType = SortType.desc;

  bool get isLoading => _isLoading;
  List<String> get items => _items.map((e) => e.displayName).toList();
  SortType get sortType => _sortType;
  NoticeListResponse get notices => _notices;
  bool get isMaxPosition => _isMaxPosition;
  bool get hasMore => _hasMore;
  ScrollController get scrollController => _scrollController;

  @override
  @mustCallSuper
  @override
  void onInit() async {
    super.onInit();
    // controller init
    _scrollController.addListener(_listener);

    try {
      _notices = _notices = await _fetch(_initOffset, _initLimit);
      if (_notices.rows.length < kDefaultValue) _hasMore = false;
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  void sort(SortType sortType) async {
    // fetch loading
    _isLoading = true;
    update();

    try {
      _sortType = sortType;
      _notices = _notices = await _fetch(_initOffset, _initLimit);
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  Future<void> refetch() async {
    // fetch loading
    _isLoading = true;
    update();

    try {
      _initOffset = 0;
      _initLimit = 20;
      _sortType = SortType.desc;
      _notices = await _fetch(_initOffset, _initLimit);
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  Future<NoticeListResponse> _fetch(int offset, int limit) async {
    return await noticeRepository.findNotices(
      _initOffset,
      _initLimit,
      sort: _sortType,
    );
  }

  Future<void> _listener() async {
    /// 만약 스크롤이 끝까지 내려가면 해당 이벤트에서 데이터를 얻어온다.
    /// 맨 마지막을 내리기 전 offset에 default를 더해서 조금 더 빠르게 Loading하기 위해 offset에 값을 더함
    if (_scrollController.position.maxScrollExtent <
        _scrollController.offset + kDefaultValue / 2) {
      // change MaxPosition
      _isMaxPosition = true;
      update();

      _initOffset += kDefaultValue.toInt();
      _initLimit += kDefaultValue.toInt();

      // fetch & append
      final resp = await _fetch(_initLimit, _initOffset);
      _notices.rows.insertAll(_notices.rows.length - 1, resp.rows);

      // 더이상 Data가 없을 경우
      if (resp.rows.length < kDefaultValue.toInt()) _hasMore = false;
      update();
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
