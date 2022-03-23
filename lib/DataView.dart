//@dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:manage/CreateView.dart';
import 'package:manage/DetailView.dart';
import 'package:manage/Navigate.dart';
import 'package:manage/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DataView extends StatefulWidget {
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
    NavigateToPage navi = new NavigateToPage();
    User userSendToAPI = new User();
    return Scaffold(
        appBar: AppBar(title: Text('Grid View')),
        body: Center(
            child: Center(
          child: Container(
            color: Colors.pink,
            child: ListView.builder(
                itemCount: listUser.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                        style: const TextStyle(
                                          color: Colors.purpleAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        )),
                                  )),
                              const SizedBox(height: 250)
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () => {
                      setState(() {
                        userSendToAPI.id = listUser[index].id;
                        userSendToAPI.email = listUser[index].email;
                        userSendToAPI.gender = listUser[index].gender;
                        userSendToAPI.name = listUser[index].name;
                        userSendToAPI.status = listUser[index].status;
                      }),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailView(
                                    idParameter: this.listUser[index].id,
                                    user: userSendToAPI,
                                  )))
                    },
                  );
                }),
          ),
        )),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.redAccent,
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          closeManually: false,
          visible: true,
          children: [
            SpeedDialChild(
              child: Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.green,
              onTap: () => {
                //navi.PopnavigateToAnotherPage(context),
                navi.PushnavigateToAnotherPage(context, CreateView())
              }, //print('Pressed Read Later'),
              label: 'Add',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.black,
            )
          ],
        ));
  }
}

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse("https://gorest.co.in/public/v2/users"));
  }
}
