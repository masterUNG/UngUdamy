import 'package:flutter/material.dart';

class MyStyle {
  Color primaryColor = Color(0xff1b5e20);
  Color darkColor = Color(0xff003300);

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget errorImage() {
    return Container(
      width: 120,
      child: Image.asset('images/teacher.png'),
    );
  }

  MyStyle();
}
