//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage/DataView.dart';
import 'package:manage/InteractiveData/InteractiveWithUser.dart';
import 'package:manage/Navigate.dart';
import 'package:manage/user.dart';

class EditViewSuccess extends StatefulWidget {
  User user;
  var id;
  EditViewSuccess({Key key, this.id, this.user}) : super(key: key);
  EditViewSuccessState createState() => EditViewSuccessState();
}

class EditViewSuccessState extends State<EditViewSuccess> {
  Future<String> _dataFromJson;
  @override
  void initState() {
    super.initState();
    InteractiveWithUser inter = new InteractiveWithUser();
    print(widget.user.name.toString());
    _dataFromJson = inter.EditUser(widget.user);
  }

  Widget build(BuildContext context) {
    NavigateToPage navi = new NavigateToPage();
    return FutureBuilder(
        future: _dataFromJson,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            if (snapshot.data.toString() == "Edit Successfully") {
              return (Container(
                child: AlertDialog(
                  title: Text('Done'),
                  content: Text(snapshot.data),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Return main Page'),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                    ),
                    FlatButton(
                      child: Text('Return data page ?'),
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
            }
          } else {
            return Text('data');
          }
          return Text('data');
        });
  }
}
