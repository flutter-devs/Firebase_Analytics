import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:analytics_demo/homepage.dart';
import 'package:analytics_demo/ui.dart';

class ui extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ui();
  }
}

class _ui extends State<ui> {
  bool isSwitched = false;
  double _value = 0;
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: new Text("Are you a Cat Person or a dog person ?"),
            content: new Text(""),
            actions: <Widget>[
              Center(
                  // usually buttons at the bottom of the dialog
                  child: Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Cat Person"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FirebaseAnalytics().setUserProperty(
                          name: "dog_or_cat", value: "cat_person");
                    },
                  ),
                  new FlatButton(
                    child: new Text("Dog Person"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      FirebaseAnalytics().setUserProperty(
                          name: "dog_or_cat", value: "dog_person");
                    },
                  ),
                ],
              ))
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text("Tap your Favorite"), backgroundColor: Colors.pink),
            
        drawer: new Drawer(),
        body: SafeArea(
            child: Container(
                child: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              _showDialog();
            },
            child: Text(
              "Select Category",
            ),
            color: Colors.lightBlue[100],
          ),
          SizedBox(
            height: 10,
          ),
          ButtonTheme(
            child: RaisedButton(
                elevation: 20,
                color: Colors.grey[100],
              onPressed: () {FirebaseAnalytics().logEvent(name: 'A Product',parameters:null);},
                child: Image.asset(
                  'assets/ice2.png',
                  height: 200,
                  width: 200,
                )),
          ),
          SizedBox(height: 20),
          Center(
            child: Text('PRODUCT A'),
          ),
          SizedBox(
            height: 40,
          ),
          ButtonTheme(
            child: RaisedButton(
                elevation: 20,
                color: Colors.white,
                onPressed: () {FirebaseAnalytics().logEvent(name: 'B_Product',parameters:null);},
                child: Image.asset(
                  'assets/co.png',
                  height: 200,
                  width: 200,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text('PRODUCT B'),
          ),
          SizedBox(
            height: 20,
          ),
          SliderTheme(
  data: SliderTheme.of(context).copyWith(
    
    activeTrackColor: Colors.red[700],
    inactiveTrackColor: Colors.red[100],
    trackShape: RoundedRectSliderTrackShape(),
    trackHeight: 4.0,
    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
    thumbColor: Colors.redAccent,
    overlayColor: Colors.red.withAlpha(32),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
    tickMarkShape: RoundSliderTickMarkShape(),
    activeTickMarkColor: Colors.red[700],
    inactiveTickMarkColor: Colors.red[100],
    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
    valueIndicatorColor: Colors.redAccent,
    valueIndicatorTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  child: Slider(
    value: _value,
    min: 0,
    max: 100,
    divisions: 10,
    label: '$_value',
    
    onChanged: (value) {
      setState(
        () {
        
          _value = value;
         

        },
      );
     
    },
onChangeEnd: (_value) {
    print('no change');
    FirebaseAnalytics().logEvent(name: 'Slider_Change',parameters: {'Value':_value});
  },
  ),

),

        ]))));
  }
}
