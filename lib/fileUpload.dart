import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:analytics_demo/blogPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UploadPhotoPage();
  }
}

class _UploadPhotoPage extends State<UploadPhotoPage> {
  File sampleImage;
  final formKey = new GlobalKey<FormState>();
  String _myVal;
  String url;

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      final StorageReference postImageRef =
          FirebaseStorage.instance.ref().child("pics");
      var timekey = new DateTime.now();
      final StorageUploadTask uploadTask =
          postImageRef.child(timekey.toString() + ".jpg").putFile(sampleImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print("Image Url=" + url);
      gotoHomepage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {
    var dbtimekey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbtimekey);
    String time = formatTime.format(dbtimekey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "image": url,
      "description": _myVal,
      "date": date,
      "time": time
    };
    ref.child("picd").push().set(data);
  }

  void gotoHomepage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new BlogHome();
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("Upload Image"),
        centerTitle: true,
      ),
      body: new Center(
        child: sampleImage == null ? Text("select an image") : enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget enableUpload() {
    return new Container(
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            Image.file(
              sampleImage,
              height: 330,
              width: 660,
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Description'),
              validator: (value) {
                return value.isEmpty ? 'Content description is required' : null;
              },
              onSaved: (value) {
                return _myVal = value;
              },
            ),
            RaisedButton(
              elevation: 20,
              child: Text("add new post"),
              textColor: Colors.white,
              color: Colors.pink,
              onPressed: uploadStatusImage,
            )
          ],
        ),
      ),
    );
  }
}
