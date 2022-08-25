
class UserModel {
  String name;
  String lastName;
  String profession;
  int? id;
  String? image;

  UserModel(
      {required this.name,
      required this.lastName,
      required this.profession,
      this.id,
      this.image});

  factory UserModel.fromMap(map) {
    return UserModel(
        name: map['name'],
        lastName: map['lastName'],
        profession: map['profession'],
        image: map['image']);
  }
  Map<String,dynamic>toMap(){
    return{
      name:name,
      lastName:lastName,
      profession:profession,
      image!: image
    };
  }
}
