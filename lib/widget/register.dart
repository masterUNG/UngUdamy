import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungudamy/utility/my_style.dart';
import 'package:ungudamy/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String type, name, user, password;

  Container buildRaisedButton() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: RaisedButton(
          color: MyStyle().darkColor,
          onPressed: () {
            if (name == null ||
                name.isEmpty ||
                user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'Please Fill Every Blank');
            } else if (type == null) {
              normalDialog(context, 'Please Choose Type of Member');
            } else {
              registerThread();
            }
          },
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Container buildTextFieldName() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Name :',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Container buildTextFieldUser() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(keyboardType: TextInputType.emailAddress,
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'User :',
            border: OutlineInputBorder(),
          ),
        ),
      );

  Container buildTextFieldPassword() => Container(
        margin: EdgeInsets.only(top: 16),
        width: 250,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password :',
            border: OutlineInputBorder(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              buildTextFieldName(),
              buildContainer(),
              buildTextFieldUser(),
              buildTextFieldPassword(),
              buildRaisedButton(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildContainer() => Container(
        width: 250,
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: 'Teacher',
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                ),
                Text('Teacher')
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Student',
                  groupValue: type,
                  onChanged: (value) {
                    setState(() {
                      type = value;
                    });
                  },
                ),
                Text('Student')
              ],
            ),
          ],
        ),
      );

  Future<Null> registerThread() async {
    Firebase.initializeApp().then((value) async {
      print('##### initialApp Success ######');

      FirebaseAuth auth = FirebaseAuth.instance;
      await auth
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        String uid = value.user.uid;
        // print('### Authen Success uid ==>> $uid ###');

        Map<String, dynamic> map = Map();
        map['Name'] = name;
        map['Type'] = type;

        FirebaseFirestore firestore = FirebaseFirestore.instance;

        await firestore.collection('Type').document(uid).setData(map).then(
              (value) => Navigator.pop(context),
            );
      }).catchError((response) {
        String string = response.message;
        normalDialog(context, string);
      });
    });
  }
}
