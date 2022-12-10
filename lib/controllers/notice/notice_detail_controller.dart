import 'package:get/get.dart';
import 'package:pyc/data/model/notice/response/notice_response.dart';
import 'package:pyc/data/repository/notice_repository.dart';

class NoticeDetailController extends GetxController {
  final NoticeRepository noticeRepository;
  final int targetId;
  final bool autoFocus;
  NoticeDetailController({
    required this.noticeRepository,
    required this.targetId,
    required this.autoFocus,
  });

  bool _isLoading = true;
  bool _isBottomSheetActice = false;
  int _id = 0;
  String _title = '';
  String _content = '';
  String _name = '';
  String _role = '';
  String? _image;
  DateTime _createdAt = DateTime.now();
  DateTime _lastModifiedAt = DateTime.now();

  @override
  void onInit() async {
    super.onInit();
    await fetch();
    _isLoading = false;
    update();
  }

  toggleBottomSheet() {
    _isBottomSheetActice = !_isBottomSheetActice;
    update();
  }

  Future<void> refetch() async {
    _isLoading = true;
    update();

    await fetch();
    _isLoading = false;
    update();
  }

  Future<void> fetch() async {
    NoticeResponse resp = await noticeRepository.findOneById(targetId);
    _id = resp.id;
    _title = resp.title;
    _content = resp.content;
    _name = resp.creator.name;
    _image = resp.creator.image;
    _role = resp.creator.role;
    _createdAt = resp.createdAt;
    _lastModifiedAt = resp.lastModifiedAt;
  }

  bool get isLoading => _isLoading;
  bool get isBottomSheetActice => _isBottomSheetActice;
  int get id => _id;
  String get title => _title;
  String get content => _content;
  String get name => _name;
  String? get image => _image;
  String get role => _role;
  DateTime get createdAt => _createdAt;
  DateTime get lastModifiedAt => _lastModifiedAt;
}
