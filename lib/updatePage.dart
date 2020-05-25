import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  String name;
  String id;
  String age;
  String contact;
  String sub;
  String did;
  UpdatePage(String s_name, String s_id, String s_age, String s_contact,
      String s_subject, String d) {
    name = s_name;
    id = s_id;
    age = s_age;
    contact = s_contact;
    sub = s_subject;
    did = d;
  }
  State<StatefulWidget> createState() {
    return _UpdatePage();
  }
}

class _UpdatePage extends State<UpdatePage> {
  String sname = "";
  String sid = "";
  String sage = "";
  String scontact = "";
  String ssubject = "";

  final nameController = new TextEditingController();

  final idController = new TextEditingController();

  final ageController = new TextEditingController();
  final contactController = new TextEditingController();

  final subjectController = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  void initState() {
    nameController.text = widget.name;
    idController.text = widget.id;
    ageController.text = widget.age;
    contactController.text = widget.contact;
    subjectController.text = widget.sub;
    id = main();
    super.initState();
  }
var id;
Future getUID() async {
     FirebaseUser user = await auth.currentUser();
   String uid = user.uid;
 

   
  return uid;
  }
main() async{
  id = await getUID();
  return id;
}
  void update() async {
    Firestore.instance.collection(id.toString()).document(widget.did).setData({
      "Task Name": nameController.text,
      "Task Priority": idController.text,
      "Deadline": ageController.text,
      "contact": contactController.text,
      "Task Description": subjectController.text
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.pink,
        title: Text("Update Information"),
      ),
      body: new ListView(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: nameController,
              onChanged: (String str) {
                sname = str.toString();
              },
              decoration: InputDecoration(
                  hintText: 'Student Name', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: idController,
              onChanged: (String str) {
                sid = str.toString();
              },
              decoration: InputDecoration(
                  hintText: 'Student Id', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: ageController,
              onChanged: (String str) {
                sage = str.toString();
              },
              decoration: InputDecoration(
                  hintText: 'Student age', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: contactController,
              onChanged: (String str) {
                scontact = str.toString();
              },
              decoration: InputDecoration(
                  hintText: 'Student Contact', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: subjectController,
              onChanged: (String str) {
                ssubject = str.toString();
              },
              decoration: InputDecoration(
                  hintText: 'Subject', border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(60.0),
            child: new FlatButton(
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.pink,
              onPressed: () {
                setState(() {
                  // print("***********************************");
                  // print(cname);
                  // print(cid);
                  //  print("***********************************");
                });

                update();
              },
            ),
          )
        ],
      ),
    );
  }
}
