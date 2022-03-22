//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataView.dart';
import 'InteractiveWithUser.dart';
import 'Navigate.dart';

class CreateViewSuccess extends StatefulWidget {
  var user;
  CreateViewSuccess({Key key, @required this.user}) : super(key: key);
  CreateViewSuccessState createState() => CreateViewSuccessState();
}

class CreateViewSuccessState extends State<CreateViewSuccess> {
  Future<String> _dataFromJson;
  @override
  void initState() {
    super.initState();
    InteractiveWithUser inter = new InteractiveWithUser();
    _dataFromJson = inter.CreateUser(widget.user);
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
            return (Container(
                child: AlertDialog(
                    title: Text(snapshot.data),
                    content: Text('Add Success'),
                    actions: <Widget>[
                  FlatButton(
                    child: Text('Return main Page'),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  )
                ])));

            // if (snapshot.data.toString() == "Success") {
            //   return (Container(
            //     child: AlertDialog(
            //       title: Text('Done'),
            //       content: Text('Add Success'),
            //       actions: <Widget>[
            //         FlatButton(
            //           child: Text('Return main Page'),
            //           onPressed: () {
            //             Navigator.of(context)
            //                 .popUntil((route) => route.isFirst);
            //           },
            //         ),
            //         FlatButton(
            //           child: Text('Delete More ?'),
            //           onPressed: () {
            //             Navigator.pop(context);
            //             Navigator.popUntil(
            //                 context, ModalRoute.withName('/main'));
            //             Navigator.of(context)
            //                 .popUntil((route) => route.isFirst);
            //             navi.PushnavigateToAnotherPage(context, DataView());
            //           },
            //         ),
            //       ],
            //     ),
            //   ));
            // } else {
            //   return (Container(
            //     child: AlertDialog(
            //       title: Text('Failded'),
            //       content: Text(snapshot.data),
            //       actions: <Widget>[
            //         FlatButton(
            //           child: Text('Ok'),
            //           onPressed: () {
            //             Navigator.pop(context);
            //             navi.PushnavigateToAnotherPage(context, DataView());
            //           },
            //         ),
            //       ],
            //     ),
            //   ));
            // }
          }
          return Container();
        });
  }
}
