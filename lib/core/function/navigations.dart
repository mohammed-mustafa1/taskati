import 'package:flutter/material.dart';

pushTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

extension NavigationExtension on BuildContext {
  push(Widget screen) {
    Navigator.push(this, MaterialPageRoute(builder: (_) => screen));
  }

  pushReplacement(Widget screen) {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => screen));
  }

  pop() {
    Navigator.pop(this);
  }
}
