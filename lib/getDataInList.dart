import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ListDataPage extends StatefulWidget {
  @override
  _StateListData createState() => _StateListData();
}

class _StateListData extends State<ListDataPage> {
  List<Stud> litems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    litems = List();
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .once()
        .then((DataSnapshot dataSnapshot) async {
      if (dataSnapshot.value != null) {
        Map<dynamic, dynamic> values = dataSnapshot.value;
        values.forEach((key, values) {
          String name = values["name"];
          String grn = values["grn"];
          setState(() {
            litems.add(new Stud(name, grn));
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("List of data"),
        ),
        body: Container(
          child: _getList(context),
        ));
  }

  Widget _getList(context) {
    return ListView.builder(
        itemCount: litems.length,
        itemBuilder: (context, pos) {
          return Dismissible(
            key: Key(litems[pos].grn),
            onDismissed: (direction) {
              litems.removeAt(pos);
            },
            child: Card(
              child: ListTile(
                title: Text(" Name : " + litems[pos].name),
                subtitle: Text(" GRN : " + litems[pos].grn),
                //leading: Image.asset('assets/user.png'),
              ),
            ),
          );
        });
  }
}

class Stud {
  String name;
  String grn;
  Stud(String name, String grn) {
    this.name = name;
    this.grn = grn;
  }
}
