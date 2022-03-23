import 'package:flutter/material.dart';
import 'package:manage/CreateViewSuccess.dart';
import 'package:manage/InteractiveData/InteractiveWithUser.dart';
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
  String dropDownValue = "active";
  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create new User')),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                child: Center(child: Text('Name: ')),
                width: 70,
              ),
              Flexible(
                child: TextField(
                    controller: NameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Name",
                    )),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                child: Center(
                  child: Text('Email: '),
                ),
                width: 70,
              ),
              Flexible(
                  child: TextField(
                controller: EmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Email",
                ),
              ))
            ],
          ),
          Row(
            children: [
              SizedBox(
                child: Center(
                  child: Text('Status: '),
                ),
                width: 70,
              ),
              DropdownButton<String>(
                hint: Text('Please choose a status'),
                value: dropDownValue,
                items: <String>['active', 'deactive'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (data) {
                  setState(() {
                    // ignore: avoid_print
                    print(data.toString());
                    dropDownValue = data.toString();
                  });
                },
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                child: Center(child: Text('Gender: ')),
                width: 70,
              ),
              Flexible(
                  child: TextField(
                controller: GenderController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Gender",
                ),
              ))
            ],
          ),
          TextButton(
              onPressed: () {
                User userPush = new User();
                userPush.name = NameController.text;
                userPush.gender = GenderController.text;
                userPush.email = EmailController.text;
                userPush.status = dropDownValue; //StatusController.text;
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
