//@dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:manage/DataView.dart';
import 'package:manage/Navigate.dart';
import 'package:http/http.dart' as http;
import 'package:manage/Widget%20Success/EditViewSuccess.dart';
import 'package:manage/user.dart';
import 'Navigate.dart';

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
  User user;

  DetailView({Key key, @required this.idParameter, @required this.user})
      : super(key: key);
  DetailViewState createState() => DetailViewState();
}

class DetailViewState extends State<DetailView> {
  TextEditingController NameController = new TextEditingController();
  TextEditingController StatusController = new TextEditingController();
  TextEditingController GenderController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
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
                    print(widget.user.id + '\n');
                    print(widget.user.name + '\n');
                    User userSendAPI = new User();
                    userSendAPI.email = EmailController.text;
                    userSendAPI.gender = GenderController.text;
                    userSendAPI.id = widget.user.id;
                    userSendAPI.name = NameController.text;
                    userSendAPI.status = StatusController.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditViewSuccess(user: userSendAPI)));
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
            controller: NameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.user.name,
            ),
          ),
          TextField(
            controller: EmailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.user.email,
            ),
          ),
          TextField(
            controller: GenderController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.user.gender,
            ),
          ),
          TextField(
            controller: StatusController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.user.status,
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
