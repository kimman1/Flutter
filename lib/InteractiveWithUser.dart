import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manage/user.dart';

class InteractiveWithUser {
  List<User> listResponse = new List<User>.empty(growable: true);
  static String token =
      "4d2ff55965f388c9c5b293a7c6cd6af39f95ce6e9984dc95789659c3ff25ea79";
  static final String ApiURL = "https://gorest.co.in/public/v2/users";
  Future<String> CreateUser(User user) async {
    var bodyvalue = user.toJSOn();
    var bodydata = json.encode(bodyvalue);
    final http.Response response = await http.post(
        Uri.parse('https://gorest.co.in/public/v2/users/?access-token=$token'),
        headers: {"Content-Type": "application/json"},
        body: bodydata);
    if (response.statusCode == 201) {
      Iterable list = json.decode(response.body);
      listResponse = list.map((model) => User.fromJSON(model)).toList();
      print(listResponse.length);
      return listResponse[0].id;
    } else if (response.statusCode == 422) {
      print("Check parameter");
      return "parameter error";
    } else {
      return "Failed";
    }
  }
}
