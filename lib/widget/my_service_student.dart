import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungudamy/utility/my_constant.dart';
import 'package:ungudamy/utility/my_style.dart';
import 'package:ungudamy/widget/authen.dart';
import 'package:ungudamy/widget/home_student.dart';

class MyServiceStudent extends StatefulWidget {
  @override
  _MyServiceStudentState createState() => _MyServiceStudentState();
}

class _MyServiceStudentState extends State<MyServiceStudent> {
  Widget currentWidget = HomeStudent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Student'),
        backgroundColor: MyStyle().primaryColor,
      ),
      drawer: Drawer(
        child: MyConstant().buildListTileSignOut(context),
      ),body: currentWidget,
    );
  }
}
