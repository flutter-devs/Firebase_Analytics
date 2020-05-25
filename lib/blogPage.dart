import 'package:analytics_demo/fileUpload.dart';
import 'package:analytics_demo/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogHome extends StatefulWidget {
  @override
  BlogHomeState createState() => new BlogHomeState();
}

class BlogHomeState extends State<BlogHome> {
  List<Posts> postKiList = [];
  String id;

  void initState() {
    DatabaseReference postref =
        FirebaseDatabase.instance.reference().child("picd");
    postref.once().then((DataSnapshot snap) {
      var k = snap.value.keys;
      var d = snap.value;

      postKiList.clear();
      for (var individualKey in k) {
        Posts posts = new Posts(
          d[individualKey]['image'],
          d[individualKey]['description'],
          d[individualKey]['date'],
          d[individualKey]['time'],
        );
        postKiList.add(posts);
      }
      setState(() {
        print('Length : $postKiList.length');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Blogs"),
      ),
      body: new Container(
        child: postKiList.length == 0
            ? new Text("No Blog Post Available")
            : new ListView.builder(
                itemCount: postKiList.length,
                itemBuilder: (_, index) {
                  return PostUi(
                      postKiList[index].image,
                      postKiList[index].description,
                      postKiList[index].date,
                      postKiList[index].time);
                },
              ),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.pink,
        child: new Container(
          color: Colors.pink,
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.add_a_photo),
                iconSize: 40,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new UploadPhotoPage();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget PostUi(String image, String description, String date, String time) {
    return new Card(
      elevation: 30,
      margin: EdgeInsets.all(15),
      child: new Container(
        padding: new EdgeInsets.all(14),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                new Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            new Image.network(image, fit: BoxFit.cover),
            SizedBox(
              height: 10,
            ),
            new Text(
              description,
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
