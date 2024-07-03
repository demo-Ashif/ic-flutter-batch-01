class UserModel {
  int id;
  String name;
  String email;
  String mobile;
  String photo;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.photo,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? mobile,
    String? photo,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        photo: photo ?? this.photo,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"] ?? '',
        photo: json["photo"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "photo": photo,
      };
}
