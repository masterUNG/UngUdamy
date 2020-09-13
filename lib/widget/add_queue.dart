import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ungudamy/models/dateday_model.dart';
import 'package:ungudamy/utility/my_style.dart';
import 'package:ungudamy/utility/normal_dialog.dart';

class AddQueue extends StatefulWidget {
  @override
  _AddQueueState createState() => _AddQueueState();
}

class _AddQueueState extends State<AddQueue> {
  String chooseDate = 'Please Choose Date',
      chooseStart = 'Please Choose start Hour';

  String chooseEnd = 'Please Choose End Hour';
  bool dateDayBol = true, startBol = true, endBol = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Queue'),
        backgroundColor: MyStyle().primaryColor,
      ),
      body: Stack(
        children: [
          buildRaisedButton(),
          Center(
            child: Column(
              children: [
                buildDateDay(),
                buildStartHour(),
                buildEndHour(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRaisedButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
            onPressed: () {
              if (dateDayBol || startBol || endBol) {
                normalDialog(context, 'Please Choose Day, Start, End');
              } else {
                insertQueueToFirebase();
              }
            },
            icon: Icon(Icons.cloud_upload),
            label: Text('Save Queue'),
          ),
        ),
      ],
    );
  }

  Widget buildDateDay() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(chooseDate),
          IconButton(
            icon: Icon(Icons.card_travel),
            onPressed: () async {
              dateDayBol = false;
              DateTime result = await dialogChooseDay();
              setState(() {
                chooseDate = DateFormat('dd-MM-yyyy').format(result);
              });
            },
          )
        ],
      );

  Widget buildStartHour() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(chooseStart),
          IconButton(
            icon: Icon(Icons.straighten),
            onPressed: () async {
              startBol = false;
              TimeOfDay result = await chooseHour();
              DateTime dateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  result.hour,
                  result.minute);
              setState(() {
                // chooseStart = '${result.hour}:${result.minute}';
                chooseStart = DateFormat('HH:mm').format(dateTime);
              });
            },
          )
        ],
      );

  Widget buildEndHour() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(chooseEnd),
          IconButton(
            icon: Icon(Icons.straighten),
            onPressed: () async {
              endBol = false;
              TimeOfDay result = await chooseHour();
              DateTime dateTime = DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  result.hour,
                  result.minute);
              setState(() {
                chooseEnd = DateFormat('HH:mm').format(dateTime);
              });
            },
          )
        ],
      );
  Future<DateTime> dialogChooseDay() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
    );
  }

  Future<TimeOfDay> chooseHour() async {
    return await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );
  }

  Future<Null> insertQueueToFirebase() async {
    DateDayModel model =
        DateDayModel(dateDay: chooseDate, hour: '$chooseStart-$chooseEnd');
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uidTeacher = event.uid;
        await FirebaseFirestore.instance
            .collection('Product')
            .doc('Queue')
            .collection(uidTeacher)
            .add(model.toJson())
            .then(
              (value) => Navigator.pop(context),
            );
      });
    });
  }
}
