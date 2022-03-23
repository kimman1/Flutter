import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manage/Model/JsonErrorReturn.dart';
import 'package:manage/user.dart';

class InteractiveWithUser {
  List<User> listResponse = new List<User>.empty(growable: true);
  static String token =
      "4d2ff55965f388c9c5b293a7c6cd6af39f95ce6e9984dc95789659c3ff25ea79";
  static final String ApiURL = "https://gorest.co.in/public/v2/users";
  //region Create User
  Future<String> CreateUser(User user) async {
    var bodyvalue = user.toJSOn();
    var bodydata = json.encode(bodyvalue);
    final http.Response response = await http.post(
        Uri.parse('https://gorest.co.in/public/v2/users/?access-token=$token'),
        headers: {"Content-Type": "application/json"},
        body: bodydata);
    if (response.statusCode == 201) {
      return "New UserID: " +
          User.fromJSON(jsonDecode(response.body)).id.toString();
    } else if (response.statusCode == 422) {
      String returnResponseString = "";
      Iterable l = json.decode(response.body);
      List<JsonErrorReturn> listResponse = List<JsonErrorReturn>.from(
          l.map((model) => JsonErrorReturn.fromJSON(model)));
      for (JsonErrorReturn i in listResponse) {
        returnResponseString += (i.field + ":" + i.message + '\n');
      }
      return returnResponseString;
    } else {
      return "Failed";
    }
  }

  //End region Create User
  //region Edit User
  Future<String> EditUser(User user) async {
    User userSendAPI = new User();
    userSendAPI.name = user.name;
    userSendAPI.email = user.email;
    userSendAPI.gender = user.gender;
    userSendAPI.status = user.status;
    var bodyvalue = userSendAPI.toJSOn();
    var bodydata = json.encode(bodyvalue);
    var userID = user.id;
    final http.Response response = await http.put(
        Uri.parse(
            'https://gorest.co.in/public/v2/users/$userID?access-token=$token'),
        headers: {"Content-Type": "application/json"},
        body: bodydata);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return "Edit Successfully";
    }
    return "Failed";
  }
  //End region Edit User
}
