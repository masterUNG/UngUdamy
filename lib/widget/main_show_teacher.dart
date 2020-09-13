import 'package:flutter/material.dart';
import 'package:ungudamy/models/type_model.dart';

class MainShowTeacher extends StatefulWidget {
  final TypeModel model;
  MainShowTeacher({Key key, this.model}) : super(key: key);
  @override
  _MainShowTeacherState createState() => _MainShowTeacherState();
}

class _MainShowTeacherState extends State<MainShowTeacher> {
  TypeModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('รายละเอียด ของ ${model.name}'),
    );
  }
}
