import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungudamy/models/type_model.dart';
import 'package:ungudamy/utility/my_style.dart';
import 'package:ungudamy/widget/edit_information_teacher.dart';

class InformationTeacher extends StatefulWidget {
  @override
  _InformationTeacherState createState() => _InformationTeacherState();
}

class _InformationTeacherState extends State<InformationTeacher> {
  TypeModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditInformationTeacher(),
          ),
        ).then((value) => readFirebase()),
        backgroundColor: MyStyle().primaryColor,
        child: Icon(Icons.edit),
      ),
      body: Center(
        child: model == null ? CircularProgressIndicator() : buildContent(),
      ),
    );
  }

  Column buildContent() {
    return Column(
      children: [
        buildImage(),
        buildTextName(),
        buildTextEducation(),
        buildTextAddress(),
        buildTextPhone(),
        buildTextWebsite(),
      ],
    );
  }

  ListTile buildTextName() => ListTile(
        leading: Icon(Icons.face),
        title: Text(model.name == null ? 'Name' : 'Name = ${model.name}'),
      );

  ListTile buildTextEducation() => ListTile(
        leading: Icon(Icons.android),
        title: Text(model.education == null
            ? 'Education ?'
            : 'Education = ${model.education}'),
      );

  ListTile buildTextAddress() => ListTile(
        leading: Icon(Icons.account_balance),
        title: Text(
            model.address == null ? 'Address ?' : 'Address = ${model.address}'),
      );

  ListTile buildTextPhone() => ListTile(
        leading: Icon(Icons.phone),
        title: Text(model.phone == null ? 'Phone ?' : 'Phome = ${model.phone}'),
      );

  ListTile buildTextWebsite() => ListTile(
        leading: Icon(Icons.web),
        title: Text(
            model.website == null ? 'Website ?' : 'Website = ${model.website}'),
      );

  Container buildImage() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: 180,
      height: 180,
      child: model.pathImage == null
          ? Image.asset('images/teacher.png')
          : CachedNetworkImage(
              imageUrl: model.pathImage,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) =>
                  Image.asset('images/teacher.png'),
            ),
    );
  }

  Future<Null> readFirebase() async {
    Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event.uid;
        print('uid on information Teacher ==>> $uid');
        await FirebaseFirestore.instance
            .collection('Type')
            .document(uid)
            .snapshots()
            .listen((event) {
          print('event ===>> ${event.data()}');
          setState(() {
            model = TypeModel.fromJson(event.data());
            // print('name = ${model.name}');
            // print('pathImage = ${model.pathImage}');
          });
        });
      });
    });
  }
}
