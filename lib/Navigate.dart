import 'package:flutter/material.dart';


class NavigateToPage {
  void PushnavigateToAnotherPage(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  void PopnavigateToAnotherPage(BuildContext context) {
    Navigator.of(context).pop(context);
  }
}
