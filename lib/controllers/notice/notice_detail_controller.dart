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
  int _id = 0;
  String _title = '';
  String _content = '';
  String _name = '';
  String _image = '';
  String _role = '';
  DateTime _createdAt = DateTime.now();
  DateTime _lastModifiedAt = DateTime.now();

  @override
  void onInit() async {
    super.onInit();
    NoticeResponse resp = await noticeRepository.findOneById(targetId);
    _id = resp.id;
    _title = resp.title;
    _content = resp.content;
    _name = resp.name;
    _image = resp.image;
    _role = resp.role;
    _createdAt = resp.createdAt;
    _lastModifiedAt = resp.lastModifiedAt;
    _isLoading = false;
    update();
  }

  bool get isLoading => _isLoading;
  int get id => _id;
  String get title => _title;
  String get content => _content;
  String get name => _name;
  String get image => _image;
  String get role => _role;
  DateTime get createdAt => _createdAt;
  DateTime get lastModifiedAt => _lastModifiedAt;
}