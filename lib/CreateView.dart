import 'package:flutter/material.dart';
import 'package:manage/CreateViewSuccess.dart';
import 'package:manage/InteractiveWithUser.dart';
import 'package:manage/Navigate.dart';
import 'package:manage/user.dart';

class CreateView extends StatefulWidget {
  CreateViewState createState() => CreateViewState();
}

class CreateViewState extends State<CreateView> {
  TextEditingController NameController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController GenderController = new TextEditingController();
  TextEditingController StatusController = new TextEditingController();
  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create new User')),
      body: Column(
        children: [
          TextField(
            controller: NameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Name",
            ),
          ),
          TextField(
            controller: EmailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Email",
            ),
          ),
          TextField(
            controller: GenderController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Gender",
            ),
          ),
          TextField(
            controller: StatusController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter Status",
            ),
          ),
          TextButton(
              onPressed: () {
                User userPush = new User();
                userPush.name = NameController.text;
                userPush.gender = GenderController.text;
                userPush.email = EmailController.text;
                userPush.status = StatusController.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreateViewSuccess(user: userPush)));
              },
              child: Text('Submit'))
        ],
      ),
    );
  }
}
