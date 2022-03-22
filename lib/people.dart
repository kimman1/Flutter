//@dart=2.9
class PeopleOne {
  String id, name, address;
  PeopleOne({this.id, this.name, this.address});
  //constructure for class

  PeopleOne.fromJSON(Map json)
      : id = json["id"].toString(),
        name = json["title"],
        address = json["userId"].toString();
  Map toJson() {
    return {'id': id, 'title': name, 'userId': address};
  }
}
