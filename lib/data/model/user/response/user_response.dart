class UserResponse {
  int id;
  int churchId;
  int? cellId;
  String name;
  String image;
  int age;
  String role;
  String rank;
  String gender;
  String zipCode;
  String address;
  String birth;
  String contact;
  bool isLongAbsenced;

  UserResponse({
    required this.id,
    required this.churchId,
    required this.cellId,
    required this.name,
    required this.image,
    required this.age,
    required this.role,
    required this.rank,
    required this.gender,
    required this.zipCode,
    required this.address,
    required this.birth,
    required this.contact,
    required this.isLongAbsenced,
  });

  UserResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        churchId = json['churchId'],
        cellId = json['cellId'],
        name = json['name'],
        image = json['image'],
        age = json['age'],
        role = json['role'],
        rank = json['rank'],
        gender = json['gender'],
        zipCode = json['zipCode'],
        address = json['address'],
        birth = json['birth'],
        contact = json['contact'],
        isLongAbsenced = json['isLongAbsenced'];
}
