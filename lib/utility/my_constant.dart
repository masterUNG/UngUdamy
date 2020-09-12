import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungudamy/widget/authen.dart';

class MyConstant {


  Column buildListTileSignOut(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.red[900]),
            child: ListTile(
              onTap: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                await auth.signOut().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Authen(),
                          ),
                          (route) => false),
                    );
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 36,
                color: Colors.white,
              ),
              title: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'SignOut From Current Account',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );


  MyConstant();
}
