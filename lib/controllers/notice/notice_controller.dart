import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyc/common/constants/constants.dart';
import 'package:pyc/common/enum/sort_type.dart';
import 'package:pyc/common/utils/snackbar/snackbar.dart';
import 'package:pyc/data/model/notice/response/notice_list_response.dart';
import 'package:pyc/data/model/notice/response/notice_response.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeController extends GetxController {
  final NoticeRepository noticeRepository;
  NoticeController({required this.noticeRepository});

  /// [_items] 공지사항의 정렬 순서를 정하는 Enum
  final List<SortType> _items = [SortType.desc, SortType.asc];

  /// [_scrollController] 공지사항 List의 Scroll에 대한 이벤트를 정의하기 위한 Controlelr
  final ScrollController _scrollController = ScrollController();

  /// [_initLimit] 공지사항 List에 대해 페이징 처리에 대한 기본 limit값
  final int _initLimit = kDefaultValue.toInt();

  /// initial State
  int _initOffset = 0;
  bool _isLoading = true;
  List<NoticeResponse> _notices = [];
  int _count = 0;
  bool _hasMore = true;
  SortType _sortType = SortType.desc;

  @override
  @mustCallSuper
  void onInit() async {
    super.onInit();
    _scrollController.addListener(_listener);

    try {
      final response = await _fetch(_initOffset, _initLimit);
      _notices = response.rows;
      _count = response.count;
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  /// sort
  ///
  /// [SortType]을 받아 공지사항의 List의 정렬 순서를 변경하는 method
  /// 기존 정렬은 [SortType.desc]
  void sort(SortType sortType) async {
    _setInitListOptions();

    try {
      _sortType = sortType;
      final response = await _fetch(_initOffset, _initLimit);
      _notices = response.rows;
      _count = response.count;
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  /// refetch
  ///
  /// 공지사항에 대한 Refetch method, Scaffold에서 뒤로가기 혹은 공지사항이 update 되었을 때 호출
  Future<void> refetch() async {
    _setInitListOptions();

    try {
      final response = await _fetch(_initOffset, _initLimit);
      _notices = response.rows;
      _count = response.count;
      _isLoading = false;
      update();
    } catch (e) {
      _handingError(e);
    }
  }

  /// delete
  ///
  /// 공지사항의 id값을 받아 해당 공지사항을 삭제하는 method
  Future<void> delete(int id) async {
    await noticeRepository.delete(id);
  }

  /// getBack
  ///
  /// 공지사항의 Scaffold의 뒤로가기 버튼이 눌렸을 때 실행 될 method
  Future<void> getBack() async {
    refetch();
    Get.back();
  }

  /// _setInitListOptions
  ///
  /// 공지사항의 List를 Reset하기 위한 state들의 초기값을 설정
  void _setInitListOptions() {
    _isLoading = true;
    _initOffset = 0;
    _hasMore = true;
    _sortType = SortType.desc;
    update();
  }

  Future<NoticeListResponse> _fetch(int offset, int limit) async {
    final result = await noticeRepository.findNotices(
      _initOffset,
      _initLimit,
      sort: _sortType,
    );
    if (result.rows.length < kDefaultValue) _hasMore = false;
    return result;
  }

  /// _listener
  ///
  /// 공지사항 List Scroller에 대한 Listener method
  /// 리스트 스크롤에 대한 이벤트를 Listen하고 있으며 가장 밑에 위치할 경우 공지사항을 더 가져온다.
  /// 가져온 List는 현재 List에 뒤에 insert 해준다.
  Future<void> _listener() async {
    if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
      _hasMore = true;
      update();

      _initOffset += kDefaultValue.toInt();
      final resp = await _fetch(_initLimit, _initOffset);
      _notices.insertAll(_notices.length - 1, resp.rows);

      await Future.delayed(const Duration(milliseconds: 500));
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

  /// getter
  bool get isLoading => _isLoading;
  List<String> get items => _items.map((e) => e.displayName).toList();
  SortType get sortType => _sortType;
  List<NoticeResponse> get notices => _notices;
  int get count => _count;
  bool get hasMore => _hasMore;
  ScrollController get scrollController => _scrollController;
}
