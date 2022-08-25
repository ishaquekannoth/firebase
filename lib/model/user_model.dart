class UserModel {
  String name;
  String lastName;
  String profession;
  int? id;
  String? image;
  String email;

  UserModel(
      {required this.name,
      required this.lastName,
      required this.profession,
      required this.email,
      this.id,
      this.image});

  factory UserModel.fromMap(map) {
    return UserModel(
        name: map['name'],
        lastName: map['lastName'],
        profession: map['profession'],
        image: map['image'],email:map['email']);
  }
  Map<String, dynamic> toMapped() {
    return {
      "name": name,
      "lastName": lastName,
      "profession": profession,
      "image": image,
      "email":email
    };
  }
}
