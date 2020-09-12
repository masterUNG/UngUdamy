import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungudamy/models/type_model.dart';
import 'package:ungudamy/utility/my_style.dart';

class HomeStudent extends StatefulWidget {
  @override
  _HomeStudentState createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  List<TypeModel> typeModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllTeacher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: typeModels.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : buildListView(),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: typeModels.length,
      itemBuilder: (context, index) => Column(
        children: [
          Container(width: 150,height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: typeModels[index].pathImage,
                placeholder: (context, url) => MyStyle().showProgress(),
                errorWidget: (context, url, error) => MyStyle().errorImage(),
              ),
            ),
          ),
          Text(typeModels[index].name),
        ],
      ),
    );
  }

  Future<Null> readAllTeacher() async {
    Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('Type')
          .snapshots()
          .listen((event) {
        for (var snapshot in event.docs) {
          TypeModel model = TypeModel.fromJson(snapshot.data());

          if (model.type == 'Teacher') {
            // print('nameTeacher = ${model.name}');
            setState(() {
              typeModels.add(model);
            });
          }
        }
      });
    });
  }
}
