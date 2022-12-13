class Creator {
  final String name;
  final String role;
  final String? image;

  Creator({required this.name, required this.role, required this.image});

  Creator.fromJSON(Map<String, dynamic> json)
      : name = json['name'],
        role = json['role'],
        image = json['image'];
}
