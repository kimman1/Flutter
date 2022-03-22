//@dart=2.9
import 'dart:convert';
import 'dart:developer';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage/DataView.dart';
import 'package:manage/FirstRoute.dart';
import 'package:manage/Navigate.dart';
import 'package:manage/user.dart';
import 'package:http/http.dart' as http;
import 'Navigate.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AfterDeleteWidget extends StatefulWidget {
  var id;

  AfterDeleteWidget({Key key, @required this.id}) : super(key: key);
  _AfterDeleteWidgetState createState() => _AfterDeleteWidgetState();
}

class _AfterDeleteWidgetState extends State<AfterDeleteWidget> {
  SnackBar CustomSnackBar(message) => SnackBar(
        backgroundColor: Colors.amber,
        content: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(milliseconds: 500),
      );
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(message),
    );
  }

  Future<String> _dataFromJson;
  Future<bool> _deleteStatus;
  @override
  void initState() {
    super.initState();
    InteractiveWithData inter = new InteractiveWithData();
    _dataFromJson = inter.deleteUser(widget.id);
    //_deleteStatus = inter.deleteUserToast(widget.id);
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dataFromJson,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData) {
            NavigateToPage navi = new NavigateToPage();
            if (snapshot.data.toString() == "Success") {
              return (Container(
                child: AlertDialog(
                  title: Text('Done'),
                  content: Text('Add Success'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Return main Page'),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                    FlatButton(
                      child: Text('Delete More ?'),
                      onPressed: () {
                        // Navigator.pop(context);
                        // Navigator.popUntil(
                        //     context, ModalRoute.withName('/main'));
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        navi.PushnavigateToAnotherPage(context, DataView());
                      },
                    ),
                  ],
                ),
              ));
            } else {
              return (Container(
                child: AlertDialog(
                  title: Text('Failded'),
                  content: Text(snapshot.data),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.pop(context);
                        navi.PushnavigateToAnotherPage(context, DataView());
                      },
                    ),
                  ],
                ),
              ));
            }
          }
          return Container();
        });
  }
}

class DetailView extends StatefulWidget {
  var idParameter;

  DetailView({Key key, @required this.idParameter}) : super(key: key);
  DetailViewState createState() => DetailViewState();
}

class DetailViewState extends State<DetailView> {
  SnackBar CustomSnackBar(message) => SnackBar(
        backgroundColor: Colors.amber,
        content: Text(
          message,
          style: TextStyle(color: Colors.black),
        ),
        duration: Duration(milliseconds: 500),
      );
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(message),
    );
  }

  var globalKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    String Tilte = "Detail View for user " + widget.idParameter;
    return (Scaffold(
      appBar: AppBar(title: Text(Tilte)),
      body: Column(
        children: [
          Row(children: [
            Container(
              width: 100,
              decoration: new BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.circular(15.5),
              ),
              child: TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Create',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                style: TextButton.styleFrom(primary: Colors.blue),
                onPressed: () {},
              ),
            ),
            Container(
              width: 100,
              decoration: new BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.circular(15.5),
              ),
              child: TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                style: TextButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  setState(() {
                    showSnackBar(context, 'hello');
                  });

                  //AfterDelete(id: widget.idParameter);
                },
              ),
            ),
            Container(
              width: 100,
              decoration: new BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.circular(15.5),
              ),
              child: TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Delete',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                style: TextButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AfterDeleteWidget(
                                  id: widget.idParameter,
                                )));
                  });

                  //AfterDelete(id: widget.idParameter);
                },
              ),
            ),
            Container(
              width: 100,
              decoration: new BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.circular(15.5),
              ),
              child: TextButton(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Back',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                style: TextButton.styleFrom(primary: Colors.blue),
                onPressed: () {
                  NavigateToPage navi = new NavigateToPage();
                  navi.PopnavigateToAnotherPage(context);
                  navi.PushnavigateToAnotherPage(context, DataView());
                },
              ),
            )
          ]),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Name",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Email",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Gender",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Status",
            ),
          )
        ],
      ),
    ));
    // TODO: implement build
    throw UnimplementedError();
  }
}

// class AfterDeleteUser extends StatefulWidget {
//   var id;
//   BuildContext scaffoldcontext;
//   AfterDeleteUserState createState() => AfterDeleteUserState();
//   AfterDeleteUser({Key key, @required this.id}) : super(key: key);
// }

class InteractiveWithData {
  static String token =
      "4d2ff55965f388c9c5b293a7c6cd6af39f95ce6e9984dc95789659c3ff25ea79";
  Future<String> deleteUser(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://gorest.co.in/public/v2/users/$id?access-token=$token'),
    );
    if (response.statusCode.toString() == "200" ||
        response.statusCode.toString() == "204") {
      return "Success";
    }
    return "Failed " + response.statusCode.toString();
  }

  Future<bool> deleteUserToast(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('https://gorest.co.in/public/v2/users/$id?access-token=$token'),
    );
    if (response.statusCode.toString() == "200" ||
        response.statusCode.toString() == "204") {
      return true;
    } else {
      return false;
    }
  }
}
