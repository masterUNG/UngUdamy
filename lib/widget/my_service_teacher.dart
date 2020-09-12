import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungudamy/utility/my_constant.dart';
import 'package:ungudamy/utility/my_style.dart';
import 'package:ungudamy/widget/informaion_teacher.dart';
import 'package:ungudamy/widget/show_order_student.dart';
import 'package:ungudamy/widget/show_product.dart';

class MyServiceTeacher extends StatefulWidget {
  @override
  _MyServiceTeacherState createState() => _MyServiceTeacherState();
}

class _MyServiceTeacherState extends State<MyServiceTeacher> {
  String name, email, uid;
  Widget currentWidget = ShowOrderStudent();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Teacher'),
        backgroundColor: MyStyle().primaryColor,
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            buildMainDrawer(),
            MyConstant().buildListTileSignOut(context),
          ],
        ),
      ),body: currentWidget,
    );
  }

  Column buildMainDrawer() => Column(
        children: [
          buildUserAccountsDrawerHeader(),
          buildListTileShowOrder(),
          buildListTileShowInformation(),
          buildListTileShowProduct(),
        ],
      );

  ListTile buildListTileShowOrder() => ListTile(
        leading: Icon(
          Icons.home,
          size: 36,
        ),
        title: Text('Show Order'),
        subtitle: Text('Display Order From Student'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowOrderStudent();
          });
        },
      );

  ListTile buildListTileShowInformation() => ListTile(
        leading: Icon(
          Icons.person,
          size: 36,
        ),
        title: Text('Show Information'),
        subtitle: Text('Display Information'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = InformationTeacher();
          });
        },
      );

  ListTile buildListTileShowProduct() => ListTile(
        leading: Icon(
          Icons.fastfood,
          size: 36,
        ),
        title: Text('Show Product'),
        subtitle: Text('Display Product'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowProduct();
          });
        },
      );

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
      ),
      accountName: Text(name == null ? 'Name' : name),
      accountEmail: Text(email == null ? 'Email' : email),
      currentAccountPicture: Image.asset('images/logo.png'),
    );
  }

  Future<Null> readLogin() async {
    Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance.authStateChanges().listen((event) async {
        setState(() {
          email = event.email;
        });
        uid = event.uid;
        await FirebaseFirestore.instance
            .collection('Type')
            .document(uid)
            .snapshots()
            .listen((event) {
          setState(() {
            name = event.data()['Name'];
          });
        });
      });
    });
  }
}
