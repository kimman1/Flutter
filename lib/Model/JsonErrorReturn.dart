//@dart=2.9
class JsonErrorReturn {
  String field, message;
  JsonErrorReturn({this.field, this.message});

  JsonErrorReturn.fromJSON(Map<String, dynamic> json)
      : field = json["field"].toString(),
        message = json["message"].toString();

  // ignore: empty_constructor_bodies
  Map toJson() {
    return {'field': field, 'message': message};
  }
}
