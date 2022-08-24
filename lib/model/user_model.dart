import 'dart:html';

class UserModel {
  String name;
  int age;
  String profession;
  int? id;

  String? image;

  UserModel(
      {required this.name,
      required this.age,
      required this.profession,
      this.id,
      this.image});
}
