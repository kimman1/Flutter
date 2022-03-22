//@dart=2.9
class User {
  String id, name, email, gender, status;
  User({this.id, this.name, this.email, this.gender, this.status});

  User.fromJSON(Map json)
      : id = json["id"].toString(),
        name = json["name"].toString(),
        email = json["email"].toString(),
        gender = json["gender"].toString(),
        status = json["status"].toString();

  Map toJSOn() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
      'status': status
    };
  }
}
