// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class FirstRoute extends StatefulWidget {
  @override
  FirstRouteState createState() => FirstRouteState();
}

class FirstRouteState extends State<FirstRoute> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First route')),
      body: Center(
          child: FlatButton(onPressed: () {}, child: const Text('Open Route'))),
    );
  }
}
