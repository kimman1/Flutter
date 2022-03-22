//@dart=2.9
// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:manage/DataView.dart';
import 'FirstRoute.dart';
import 'Navigate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(title: 'demo app', home: MyHomePage()));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Scaffold(
            appBar: AppBar(
              title: Text('App Bar'),
              centerTitle: true,
            ),
            body: Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.5,
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Button area: $counter',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                  SizedBox(
                      child: Container(
                    color: Colors.amber,
                    child: Container(
                      color: Colors.blueAccent,
                      child: Wrap(
                        children: [
                          Container(
                              color: Colors.pink,
                              child: Wrap(
                                children: [
                                  FlatButton(
                                    child: Text('Increase Counter',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10)),
                                    onPressed: () {
                                      setState(() {
                                        counter++;
                                      });
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Descrease counter'),
                                    onPressed: () {
                                      setState(() {
                                        counter--;
                                      });
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Open First Route'),
                                    onPressed: () {
                                      setState(
                                        () {
                                          NavigateToPage navi =
                                              new NavigateToPage();
                                          navi.PopnavigateToAnotherPage(
                                              context);
                                          navi.PushnavigateToAnotherPage(
                                              context, FirstRoute());
                                        },
                                      );
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Open Data View'),
                                    onPressed: () {
                                      setState(() {
                                        NavigateToPage navi =
                                            new NavigateToPage();
                                        navi.PushnavigateToAnotherPage(
                                            context, DataView());
                                      });
                                    },
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ))));
  }
}
