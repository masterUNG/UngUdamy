import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungudamy/models/dateday_model.dart';
import 'package:ungudamy/utility/my_style.dart';
import 'package:ungudamy/widget/add_queue.dart';

class ShowProduct extends StatefulWidget {
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  String uidTeacher;
  bool statusNoHaveData = true;
  List<DateDayModel> dateDayModels = List();
  List<String> documentNames = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readQueue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyStyle().primaryColor,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddQueue(),
          ),
        ).then(
          (value) => readQueue(),
        ),
        child: Icon(Icons.add),
      ),
      body: statusNoHaveData
          ? Text('No Data')
          : dateDayModels.length == 0
              ? MyStyle().showProgress()
              : buildListQueue(),
    );
  }

  Widget buildListQueue() => ListView.builder(
        itemCount: dateDayModels.length,
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(dateDayModels[index].dateDay),
                Text(dateDayModels[index].hour),
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Map<String, dynamic> map = Map();
                      map['Student'] = 'UidStudent123456';
                      Firebase.initializeApp().then((value) async {
                        await FirebaseFirestore.instance
                            .collection('Product')
                            .doc('Queue')
                            .collection(uidTeacher)
                            .doc(documentNames[index])
                            .update(map)
                            .then((value) => readQueue());
                      });
                    }),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    print('index = $index');
                    Firebase.initializeApp().then((value) async {
                      await FirebaseFirestore.instance
                          .collection('Product')
                          .doc('Queue')
                          .collection(uidTeacher)
                          .doc(documentNames[index])
                          .delete()
                          .then((value) => readQueue());
                    });
                  },
                )
              ],
            ),
          ),
        ),
      );

  Future<Null> readQueue() async {
    if (dateDayModels.length != 0) {
      dateDayModels.clear();
      documentNames.clear();
    }

    Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uidTeacher = event.uid;
        print('uidTeacher ==>> $uidTeacher');
        await FirebaseFirestore.instance
            .collection('Product')
            .doc('Queue')
            .collection(uidTeacher)
            .snapshots()
            .listen((event) {
          // print('event ==>> ${event.docs}');
          String string = event.docs.toString();
          // print('strint ==>> $string');
          if (string != '[]') {
            // Have Queue
            // print('Have Data');

            for (var snapshot in event.docs) {
              DateDayModel dateDayModel =
                  DateDayModel.fromJson(snapshot.data());
              String documentName = snapshot.documentID;
              print('documentName = $documentName');
              setState(() {
                statusNoHaveData = false;
                dateDayModels.add(dateDayModel);
                documentNames.add(documentName);
              });
            }
          }
        });
      });
    });
  }
}
