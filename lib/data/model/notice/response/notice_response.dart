class NoticeResponse {
  final int id;
  final String title;
  final String content;
  final String name;
  final String image;
  final String role;
  final DateTime createdAt;
  final DateTime lastModifiedAt;

  NoticeResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.name,
    required this.image,
    required this.role,
    required this.createdAt,
    required this.lastModifiedAt,
  });

  NoticeResponse.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        name = json['name'],
        image = json['image'],
        role = json['role'],
        createdAt = DateTime.parse(json['createdAt']),
        lastModifiedAt = DateTime.parse(json['lastModifiedAt']);
}
