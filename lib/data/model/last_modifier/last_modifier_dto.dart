class LastModifier {
  final String name;
  final String role;
  final String? image;

  LastModifier({required this.name, required this.role, required this.image});

  LastModifier.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        role = json['role'],
        image = json['image'];
}
