import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
 bool _autoValidate = false;
 String _name;
  String _email;
  String _mobile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController controllerEmail, controllerPass , controllerName;
  @override
  void initState() {
    super.initState();
    controllerEmail = TextEditingController();
    controllerPass = TextEditingController();
    controllerName = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    
    final emailField = TextFormField(
      
      style: style,
      controller: controllerEmail,
      validator: validateEmail,
      onSaved: (String val) {
            _email = val;
          },
      decoration: InputDecoration(
        
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          
    );
  
    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      controller: controllerPass,
      validator: (String arg) {
    if(arg.length < 5)
      return 'Password must be more than 5 character';
    else
      return null;
  },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    SizedBox(height: 10);
   final namefield = TextFormField(
      
      style: style,
      controller: controllerName,
      validator: validateName,
      onSaved: (String val) {
            _name = val;
          },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final signUpButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: signUpWithEmailPass,
        child: Text("SignUp",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Register"),
      ),
      
      body: new Center(
      child: new Form(key: _formKey,
              autovalidate: _autoValidate,
              child: 
      
      

        new Column(
          
          children: <Widget>[
             SizedBox(height : 20),
            emailField,
          SizedBox(height : 20),
           passwordField,
           SizedBox(height : 20), 
           namefield,
           SizedBox(height : 50),signUpButon],
         
        ),)
      ),
    );
  }
void _validateInputs() {
  if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
    _formKey.currentState.save();
  } else {
//    If all data are not valid then start auto validation.
    setState(() {
      _autoValidate = true;
    });
  }
}
  void signUpWithEmailPass() async {
    FirebaseUser user;
    try {
       
 _validateInputs();
 
      _formKey.currentState.save();
     
      user = (await auth.createUserWithEmailAndPassword(
          email: controllerEmail.text,
          password: controllerPass.text)) as FirebaseUser;
          
         
         
    } catch (e) {
      print(e);
    } finally {
      print('Register');
          FirebaseAnalytics().logEvent(name: 'Sign_Up',parameters:null);
      Toast.show("Registration Successful!", context);
      Navigator.pop(context);
    }
  }
}
String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  