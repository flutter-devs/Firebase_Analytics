import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:analytics_demo/addPage.dart';
import 'package:analytics_demo/main.dart';
import 'package:analytics_demo/ui.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:analytics_demo/blogPage.dart';
import 'package:analytics_demo/updatePage.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:analytics_demo/register.dart';

class HomePage extends StatefulWidget  {
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
 final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 
 
  void delete(String d) async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    
    Firestore.instance
        .collection(uid)
        .document(d)
        .delete()
        .catchError((onError) {
      print(onError);
    });
    //Navigator.pop(context);
  }
var id;
var name;
var email;

    
Future getUID() async {
     FirebaseUser user = await auth.currentUser();
   String uid = user.uid;
 

   
  return uid;
  }
  
  Future gete() async {
     FirebaseUser user = await auth.currentUser();
   String uemail = user.email;
  

   
  return uemail;
  }
  
main() async{
  id = await getUID();
  email = await gete();
  return id;

}

main2() async{
  email = await gete();
  print('email');
  print(email);
  return email;
}
Future _signOut() async {
    await _firebaseAuth.signOut();
    MyApp();
  }

@override
  void initState() {
    super.initState();
    id = main();
    email = main2();
    
    print('INIT');
    print(id);
    print('NAMe');
    print(name);
    print(email);
  }
var sendgrid;
 
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return Scaffold(
     
        appBar: new AppBar(
          title: Text("To Do"),
          
          backgroundColor: Colors.pink,
          actions: <Widget>[
           
            IconButton(
              icon: Icon(Icons.add),
              
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new AddPage();
                }));
              },
            ),
          
          ],
          
        ),
        
        drawer: new Drawer(
          child: new Column(
            
          children: <Widget>[
            new UserAccountsDrawerHeader(
                decoration: BoxDecoration( image: DecorationImage(
              fit: BoxFit.fill,
              image:  AssetImage("assets/hea.png"))),
                accountName: new Text(
                  'Welcome,\n',
                  
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w800,color: Colors.deepPurple),
                ),
                
                accountEmail: new Text(
                  email.toString(),
                  style: new TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w500,color: Colors.black),
                )),
                SizedBox(height: 50),
                
                IconButton(icon: Icon(Icons.exit_to_app), onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()),)),
              ListTile(title: Text('Sign Out'),onTap:() {
Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
print('Log out');
FirebaseAnalytics().logEvent(name: 'Sign_Out',parameters: null);
              }),
                SizedBox(height: 180,),
          ListTile(title: Text('                        Version 1.0.0 © ')),
               
               Image.asset(
                        "assets/gif.gif",
                     
                    
                
                      ),           ]
        ),),
        

    
        body: Center(
          
          child: Container(
            
              padding: const EdgeInsets.all(10.0),
           
                
            
            child:
            
               
                
                StreamBuilder<QuerySnapshot>(
               
                stream: Firestore.instance.collection(id.toString()).snapshots(),
               
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    
                    print("ID IS");
                    print(id.toString());
                  if (snapshot.hasError) {
                    
                    return new Text('Error: ${snapshot.error}');
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading...');
                    default:
                      return new ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return new Card(
                            elevation: 30,
                            margin: EdgeInsets.all(15),
                            child: new Container(
                              padding: new EdgeInsets.all(14),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          new Text(
                                            document['Task Name'],
                                            style: TextStyle(fontSize: 30),
                                          ),
                                        ],
                                      ),
                                      new Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Text("Description :"),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      new Text(document['Task Description'].toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Text("Time :"),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      new Text(document['contact'].toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Text("Priority:"),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      new Text(document['Task Priority'].toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Text("Deadline :"),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      new Text(document['Deadline'].toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: <Widget>[
                                  RaisedButton(
                                    child: Text("Update",
                                     style: TextStyle(color: Colors.white),),
                                    elevation: 47,
                                    color: Colors.green,
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        String s_name;
                                        String s_id;
                                        String s_age;
                                        String s_contact;
                                        String s_subject;
                                        s_name = document['Task Name'].toString();
                                        s_id = document['Task Priority'].toString();
                                        s_age = document['Deadline'].toString();
                                        s_contact =
                                            document['contact'].toString();
                                        s_subject =
                                            document['Task Description'].toString();

                                        return new UpdatePage(
                                            s_name,
                                            s_id,
                                            s_age,
                                            s_contact,
                                            s_subject,
                                            document.documentID);
                                      }));
                                    },
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  RaisedButton(
                                    color: Colors.red,
                                    child: Text("Delete",
                                   style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      
                                      delete(document.documentID);
                                    },
                                  ),
                                  SizedBox(width: 30,),
                                   Icon(Icons.done_outline,color: Colors.green),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Icon(Icons.alarm)
                                ],
                              ),
                                ]) ),
                          );
                        }).toList(),
                      );
                  }
                },
              )),
        ));
    //         void update() async {
    //   Firestore.instance
    //       .collection('bandnames')
    //       .document(widget.data.documentID)
    //       .setData({
    //     'name': nameFieldController.text,
    //     'votes': int.parse(voteFieldController.text)
    //   });
    //   Navigator.pop(context);
    // }
 
  }

  Widget CourseUi(
      String cname, String cid, String rating, String contributors) {
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
                  contributors + " Contributors",
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.center,
                ),
                new Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            new Text(cname),
            SizedBox(
              height: 20,
            ),
            new ListTile(
              trailing: Text(rating),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                "hiiiiiiiiiiiiiiiii",
                style: TextStyle(color: Colors.pink),
              ),
              // color: Colors.green,
              //             child: new RaisedButton(
              //   elevation: 30,
              //   color: Colors.green,
              //   child: Text("View",style: TextStyle(color: Colors.white),),
              //   onPressed: (){
              //print("hiiiiiiiiiiiiiii");
              //   },
              // ),
            )
          ],
        ),
      ),
    );
 
  }
 
}
