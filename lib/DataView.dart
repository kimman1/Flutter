//@dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manage/DetailView.dart';
import 'package:manage/FirstRoute.dart';
import 'package:manage/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manage/people.dart';

class DataView extends StatefulWidget {
  var reload_flag;
  DataViewState createState() => DataViewState();
  //DataView({Key key, @required this.reload_flag}) : super(key: key);
}

class DataViewState extends State<DataView> {
  // ignore: deprecated_member_use
  //List<PeopleOne> listPeople = new List();
  // ignore: deprecated_member_use
  List<User> listUser = new List<User>.empty(growable: true);
  void getCharactersfromApi() async {
    CharacterApi.getCharacters().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        listUser = list.map((model) => User.fromJSON(model)).toList();
      });
    });
  }

  @override
  initState() {
    super.initState();
    getCharactersfromApi();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Grid View')),
        body: Container(
          color: Colors.pink,
          child: ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Column(
                    children: [
                      Container(
                          width: 300,
                          height: 200,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.amber,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(listUser[index].name.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.purpleAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                )),
                          )),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailView(
                                  idParameter: this.listUser[index].id,
                                )))
                  },
                );
              }),
        ));
  }
}

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse("https://gorest.co.in/public/v2/users"));
  }
}
